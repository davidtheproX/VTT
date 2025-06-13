#include "PDFManager.h"
#include "PDFGenerator.h"
#include "PDFViewer.h"
#include "QMLPDFGenerator.h"
#include "LoggingManager.h"
#include "PlatformDetection.h"
#include <QJsonDocument>
#include <QJsonParseError>
#include <QFileDialog>
#include <QStandardPaths>
#include <QDir>
#include <QDateTime>
#include <QFile>
#include <QTextStream>
#include <QGuiApplication>

PDFManager::PDFManager(QObject *parent)
    : QObject(parent)
    , m_generator(std::make_unique<PDFGenerator>(this))
    , m_qmlGenerator(std::make_unique<QMLPDFGenerator>(this))
    , m_viewer(std::make_unique<PDFViewer>(this))
    , m_isGenerating(false)
    , m_isViewerOpen(false)
{
    // Connect PDF generator signals
    connect(m_generator.get(), &PDFGenerator::pdfGenerated,
            this, &PDFManager::onPdfGenerationFinished);
    
    // Connect QML PDF generator signals
    connect(m_qmlGenerator.get(), &QMLPDFGenerator::pdfGenerated,
            this, &PDFManager::onPdfGenerationFinished);
    

    
    // Connect PDF viewer signals
    connect(m_viewer.get(), &PDFViewer::pdfClosed,
            this, &PDFManager::onPdfViewerClosed);
    connect(m_viewer.get(), &PDFViewer::error,
            this, &PDFManager::error);
    
    LoggingManager::instance()->debugGeneral("PDFManager initialized");
}

PDFManager::~PDFManager() = default;

bool PDFManager::isGenerating() const
{
    return m_isGenerating;
}

bool PDFManager::isViewerOpen() const
{
    return m_isViewerOpen;
}

QString PDFManager::currentPdfPath() const
{
    return m_currentPdfPath;
}

void PDFManager::generatePdfFromJson(const QString &jsonData, const QString &outputPath)
{
    if (m_isGenerating) {
        emit error("PDF generation already in progress");
        return;
    }
    
    if (jsonData.isEmpty()) {
        emit error("JSON data is empty");
        return;
    }
    
    LoggingManager::instance()->debugGeneral("=== PDF Generation Started ===");
    LoggingManager::instance()->debugGeneral(QString("JSON data length: %1").arg(jsonData.length()));
    LoggingManager::instance()->debugGeneral(QString("JSON data first 500 chars: %1").arg(jsonData.left(500)));
    
    // Validate JSON
    QJsonParseError parseError;
    QJsonDocument doc = QJsonDocument::fromJson(jsonData.toUtf8(), &parseError);
    if (parseError.error != QJsonParseError::NoError) {
        emit error(QString("Invalid JSON: %1").arg(parseError.errorString()));
        return;
    }
    
    LoggingManager::instance()->debugGeneral("JSON validation successful");
    QJsonObject jsonObj = doc.object();
    LoggingManager::instance()->debugGeneral(QString("JSON object keys: %1").arg(QStringList(jsonObj.keys()).join(", ")));
    
    // Use new diagnostic template with complex data structures
    QString templatePath = ":/qt/qml/VoiceAILLM/resources/templates/diagnostic_template.html";
    LoggingManager::instance()->debugGeneral(QString("Using template path: %1").arg(templatePath));
    
    generatePdfFromTemplate(templatePath, jsonObj, outputPath);
}

void PDFManager::generatePdfFromTemplate(const QString &templatePath, const QJsonObject &data, const QString &outputPath)
{
    if (m_isGenerating) {
        emit error("PDF generation already in progress");
        return;
    }
    
    setIsGenerating(true);
    
    // Generate output path if not provided
    QString finalOutputPath = outputPath;
    if (finalOutputPath.isEmpty()) {
        finalOutputPath = generateOutputPath("document");
    }
    
    LoggingManager::instance()->debugGeneral(QString("Using PDFGenerator template processing for: %1").arg(templatePath));
    
    // Use PDFGenerator's built-in template processing instead of our own
    m_generator->generateFromTemplate(templatePath, data, finalOutputPath);
    
    LoggingManager::instance()->debugGeneral(QString("Started PDF generation to: %1").arg(finalOutputPath));
}



void PDFManager::generatePdfFromJsonQML(const QString &jsonData, const QString &outputPath)
{
    if (m_isGenerating) {
        emit error("PDF generation already in progress");
        return;
    }
    
    if (!m_qmlGenerator) {
        emit error("QML PDF generator not available");
        return;
    }
    
    if (jsonData.isEmpty()) {
        emit error("JSON data is empty");
        return;
    }
    
    LoggingManager::instance()->debugGeneral("=== QML PDF Generation Started ===");
    LoggingManager::instance()->debugGeneral(QString("JSON data length: %1").arg(jsonData.length()));
    
    // Validate JSON
    QJsonParseError parseError;
    QJsonDocument doc = QJsonDocument::fromJson(jsonData.toUtf8(), &parseError);
    if (parseError.error != QJsonParseError::NoError) {
        emit error(QString("Invalid JSON: %1").arg(parseError.errorString()));
        return;
    }
    
    QJsonObject jsonObj = doc.object();
    generatePdfFromTemplateQML("diagnostic_template", jsonObj, outputPath);
}

void PDFManager::generatePdfFromTemplateQML(const QString &templateName, const QJsonObject &data, const QString &outputPath)
{
    if (m_isGenerating) {
        emit error("PDF generation already in progress");
        return;
    }
    
    if (!m_qmlGenerator) {
        emit error("QML PDF generator not available");
        return;
    }
    
    setIsGenerating(true);
    
    // Generate output path if not provided
    QString finalOutputPath = outputPath;
    if (finalOutputPath.isEmpty()) {
        finalOutputPath = generateOutputPath("qml_document");
    }
    
    LoggingManager::instance()->debugGeneral(QString("Using QML PDF generator for template: %1").arg(templateName));
    
    // Use QML generator for native Qt rendering
    m_qmlGenerator->generateFromTemplate(templateName, data, finalOutputPath);
    
    LoggingManager::instance()->debugGeneral(QString("Started QML PDF generation to: %1").arg(finalOutputPath));
}

void PDFManager::openPdfFile()
{
    QString filePath = QFileDialog::getOpenFileName(
        nullptr,
        "Open PDF File",
        QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation),
        "PDF Files (*.pdf);;All Files (*)"
    );
    
    if (!filePath.isEmpty()) {
        openPdfFile(filePath);
    }
}

void PDFManager::openPdfFile(const QString &filePath)
{
    if (filePath.isEmpty()) {
        emit error("File path is empty");
        return;
    }
    
    if (!QFile::exists(filePath)) {
        emit error(QString("File does not exist: %1").arg(filePath));
        return;
    }
    
    // For now, just emit the signal directly since we're using QML-based viewing
    setCurrentPdfPath(filePath);
    setIsViewerOpen(true);
    emit pdfOpened(filePath);
    LoggingManager::instance()->debugGeneral(QString("PDF opened: %1").arg(filePath));
}

void PDFManager::closePdfViewer()
{
    if (m_isViewerOpen) {
        m_viewer->closePdf();
        setIsViewerOpen(false);
        setCurrentPdfPath(QString());
        emit pdfClosed();
        LoggingManager::instance()->debugGeneral("PDF viewer closed");
    }
}

QString PDFManager::loadTemplate(const QString &templatePath)
{
    LoggingManager::instance()->debugGeneral(QString("Attempting to load template from: %1").arg(templatePath));
    
    QFile file(templatePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        LoggingManager::instance()->debugGeneral(QString("Failed to load template: %1 - Error: %2").arg(templatePath).arg(file.errorString()));
        return QString();
    }
    
    QTextStream stream(&file);
    QString content = stream.readAll();
    
    LoggingManager::instance()->debugGeneral(QString("Template loaded successfully, content length: %1").arg(content.length()));
    LoggingManager::instance()->debugGeneral(QString("Template first 200 chars: %1").arg(content.left(200)));
    
    return content;
}

QString PDFManager::fillTemplate(const QString &templateContent, const QJsonObject &data)
{
    QString result = templateContent;
    
    LoggingManager::instance()->debugGeneral("Starting template processing...");
    
    // Simple template processing - just replace basic placeholders
    LoggingManager::instance()->debugGeneral("Using simple template processing");
    
    for (auto it = data.begin(); it != data.end(); ++it) {
        QString placeholder = QString("{{%1}}").arg(it.key());
        QString value;
        
        if (it.value().isString()) {
            value = it.value().toString();
            LoggingManager::instance()->debugGeneral(QString("Replacing %1 with: %2").arg(placeholder).arg(value));
        } else if (it.value().isDouble()) {
            value = QString::number(it.value().toDouble());
        } else if (it.value().isBool()) {
            value = it.value().toBool() ? "Yes" : "No";
        } else if (it.value().isArray()) {
            // Convert array to comma-separated string for simple display
            QStringList items;
            for (const auto &item : it.value().toArray()) {
                if (item.isString()) {
                    items << item.toString();
                }
            }
            value = items.join(", ");
        } else if (it.value().isObject()) {
            // Skip complex objects for now
            continue;
        }
        
        result.replace(placeholder, value);
    }
    
    // Fill default values
    QDateTime now = QDateTime::currentDateTime();
    result.replace("{{generation_date}}", now.toString("yyyy-MM-dd hh:mm:ss"));
    
    // Replace any remaining empty placeholders with empty string
    QRegularExpression placeholder_regex("\\{\\{[^}]+\\}\\}");
    result.replace(placeholder_regex, "");
    
    LoggingManager::instance()->debugGeneral("Simple template processing completed");
    
    return result;
}

bool PDFManager::isValidJson(const QString &jsonString)
{
    QJsonParseError parseError;
    QJsonDocument::fromJson(jsonString.toUtf8(), &parseError);
    return parseError.error == QJsonParseError::NoError;
}

QJsonObject PDFManager::parseJsonString(const QString &jsonString)
{
    QJsonParseError parseError;
    QJsonDocument doc = QJsonDocument::fromJson(jsonString.toUtf8(), &parseError);
    if (parseError.error == QJsonParseError::NoError && doc.isObject()) {
        return doc.object();
    }
    return QJsonObject();
}

QString PDFManager::formatTableRows(const QJsonArray &rows)
{
    QString result;
    
    for (const auto &rowValue : rows) {
        if (rowValue.isObject()) {
            QJsonObject row = rowValue.toObject();
            result += "<tr>";
            result += QString("<td>%1</td>").arg(row.value("item").toString());
            result += QString("<td>%1</td>").arg(row.value("description").toString());
            result += QString("<td>%1</td>").arg(row.value("quantity").toString());
            result += QString("<td>%1</td>").arg(row.value("price").toString());
            result += QString("<td>%1</td>").arg(row.value("total").toString());
            result += "</tr>";
        }
    }
    
    return result;
}

QString PDFManager::processConditionalBlocks(const QString &templateContent, const QJsonObject &data)
{
    QString result = templateContent;
    
    // Process {{#if condition}} blocks
    QRegularExpression ifRegex(R"(\{\{#if\s+(\w+)\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
    QRegularExpressionMatchIterator iterator = ifRegex.globalMatch(result);
    
    while (iterator.hasNext()) {
        QRegularExpressionMatch match = iterator.next();
        QString fullMatch = match.captured(0);
        QString condition = match.captured(1);
        QString content = match.captured(2);
        
        // Check if condition is true in data
        bool shouldInclude = false;
        if (data.contains(condition)) {
            QJsonValue value = data[condition];
            if (value.isBool()) {
                shouldInclude = value.toBool();
            } else if (value.isArray()) {
                shouldInclude = !value.toArray().isEmpty();
            } else if (value.isObject()) {
                shouldInclude = !value.toObject().isEmpty();
            } else if (value.isString()) {
                shouldInclude = !value.toString().isEmpty();
            } else if (value.isDouble()) {
                shouldInclude = value.toDouble() != 0;
            }
        }
        
        QString replacement = shouldInclude ? content : "";
        result.replace(fullMatch, replacement);
    }
    
    return result;
}

QString PDFManager::processRepeatingBlocks(const QString &templateContent, const QJsonObject &data)
{
    QString result = templateContent;
    
    // Process {{#systems}} blocks
    if (data.contains("systems") && data["systems"].isArray()) {
        result = processSystemsList(result, data["systems"].toArray());
    }
    
    // Process {{#fault_systems}} blocks
    if (data.contains("fault_systems") && data["fault_systems"].isArray()) {
        result = processFaultSystems(result, data["fault_systems"].toArray());
    }
    
    // Process {{#system_details}} blocks
    if (data.contains("system_details") && data["system_details"].isArray()) {
        result = processSystemDetails(result, data["system_details"].toArray());
    }
    
    // Process {{#battery_test}} blocks
    if (data.contains("battery_test") && data["battery_test"].isObject()) {
        result = processBatteryTest(result, data["battery_test"].toObject());
    }
    
    return result;
}

QString PDFManager::processSystemsList(const QString &templateContent, const QJsonArray &systems)
{
    QString result = templateContent;
    
    // Find {{#systems}} ... {{/systems}} blocks
    QRegularExpression systemsRegex(R"(\{\{#systems\}\}(.*?)\{\{/systems\}\})", QRegularExpression::DotMatchesEverythingOption);
    QRegularExpressionMatchIterator iterator = systemsRegex.globalMatch(result);
    
    while (iterator.hasNext()) {
        QRegularExpressionMatch match = iterator.next();
        QString fullMatch = match.captured(0);
        QString template_block = match.captured(1);
        
        QString replacement;
        for (const auto &systemValue : systems) {
            if (systemValue.isObject()) {
                QJsonObject system = systemValue.toObject();
                QString systemRow = template_block;
                
                // Replace placeholders in the template block
                systemRow.replace("{{number}}", system.value("number").toString());
                systemRow.replace("{{name}}", system.value("name").toString());
                systemRow.replace("{{state}}", system.value("state").toString());
                
                // Handle conditional status-fail class
                bool hasFault = system.value("has_fault").toBool();
                if (hasFault) {
                    systemRow.replace("{{#if has_fault}}status-fail{{/if}}", "status-fail");
                } else {
                    systemRow.replace("{{#if has_fault}}status-fail{{/if}}", "");
                }
                
                replacement += systemRow;
            }
        }
        
        result.replace(fullMatch, replacement);
    }
    
    return result;
}

QString PDFManager::processFaultSystems(const QString &templateContent, const QJsonArray &faultSystems)
{
    QString result = templateContent;
    
    // Find {{#fault_systems}} ... {{/fault_systems}} blocks
    QRegularExpression faultSystemsRegex(R"(\{\{#fault_systems\}\}(.*?)\{\{/fault_systems\}\})", QRegularExpression::DotMatchesEverythingOption);
    QRegularExpressionMatchIterator iterator = faultSystemsRegex.globalMatch(result);
    
    while (iterator.hasNext()) {
        QRegularExpressionMatch match = iterator.next();
        QString fullMatch = match.captured(0);
        QString template_block = match.captured(1);
        
        QString replacement;
        for (const auto &faultSystemValue : faultSystems) {
            if (faultSystemValue.isObject()) {
                QJsonObject faultSystem = faultSystemValue.toObject();
                QString systemBlock = template_block;
                
                // Replace system-level placeholders
                systemBlock.replace("{{system_name}}", faultSystem.value("system_name").toString());
                systemBlock.replace("{{fault_count}}", faultSystem.value("fault_count").toString());
                
                // Process faults array within this system
                if (faultSystem.contains("faults") && faultSystem["faults"].isArray()) {
                    QJsonArray faults = faultSystem["faults"].toArray();
                    QRegularExpression faultsRegex(R"(\{\{#faults\}\}(.*?)\{\{/faults\}\})", QRegularExpression::DotMatchesEverythingOption);
                    QRegularExpressionMatch faultsMatch = faultsRegex.match(systemBlock);
                    
                    if (faultsMatch.hasMatch()) {
                        QString faultTemplate = faultsMatch.captured(1);
                        QString faultRows;
                        
                        for (const auto &faultValue : faults) {
                            if (faultValue.isObject()) {
                                QJsonObject fault = faultValue.toObject();
                                QString faultRow = faultTemplate;
                                
                                faultRow.replace("{{number}}", fault.value("number").toString());
                                faultRow.replace("{{dtc}}", fault.value("dtc").toString());
                                faultRow.replace("{{description}}", fault.value("description").toString());
                                faultRow.replace("{{status}}", fault.value("status").toString());
                                
                                faultRows += faultRow;
                            }
                        }
                        
                        systemBlock.replace(faultsMatch.captured(0), faultRows);
                    }
                }
                
                replacement += systemBlock;
            }
        }
        
        result.replace(fullMatch, replacement);
    }
    
    return result;
}

QString PDFManager::processSystemDetails(const QString &templateContent, const QJsonArray &systemDetails)
{
    QString result = templateContent;
    
    // Find {{#system_details}} ... {{/system_details}} blocks
    QRegularExpression systemDetailsRegex(R"(\{\{#system_details\}\}(.*?)\{\{/system_details\}\})", QRegularExpression::DotMatchesEverythingOption);
    QRegularExpressionMatchIterator iterator = systemDetailsRegex.globalMatch(result);
    
    while (iterator.hasNext()) {
        QRegularExpressionMatch match = iterator.next();
        QString fullMatch = match.captured(0);
        QString template_block = match.captured(1);
        
        QString replacement;
        for (const auto &systemValue : systemDetails) {
            if (systemValue.isObject()) {
                QJsonObject system = systemValue.toObject();
                QString systemBlock = template_block;
                
                // Replace system name
                systemBlock.replace("{{system_name}}", system.value("system_name").toString());
                
                // Process ECU info if present
                if (system.contains("ecu_info") && system["ecu_info"].isArray()) {
                    // Handle ECU info pairs
                    QJsonArray ecuInfo = system["ecu_info"].toArray();
                    // Process ecu_info_pairs, info_pair patterns
                    // This would need more complex processing for nested structures
                }
                
                // Process data stream if present
                if (system.contains("data_stream") && system["data_stream"].isArray()) {
                    QJsonArray dataStream = system["data_stream"].toArray();
                    QRegularExpression dataStreamRegex(R"(\{\{#data_stream\}\}(.*?)\{\{/data_stream\}\})", QRegularExpression::DotMatchesEverythingOption);
                    QRegularExpressionMatch dsMatch = dataStreamRegex.match(systemBlock);
                    
                    if (dsMatch.hasMatch()) {
                        QString dsTemplate = dsMatch.captured(1);
                        QString dsRows;
                        
                        for (const auto &dsValue : dataStream) {
                            if (dsValue.isObject()) {
                                QJsonObject ds = dsValue.toObject();
                                QString dsRow = dsTemplate;
                                
                                dsRow.replace("{{number}}", ds.value("number").toString());
                                dsRow.replace("{{name}}", ds.value("name").toString());
                                dsRow.replace("{{value}}", ds.value("value").toString());
                                dsRow.replace("{{unit}}", ds.value("unit").toString());
                                
                                dsRows += dsRow;
                            }
                        }
                        
                        systemBlock.replace(dsMatch.captured(0), dsRows);
                    }
                }
                
                replacement += systemBlock;
            }
        }
        
        result.replace(fullMatch, replacement);
    }
    
    return result;
}

QString PDFManager::processBatteryTest(const QString &templateContent, const QJsonObject &batteryData)
{
    QString result = templateContent;
    
    // Process battery info pairs
    if (batteryData.contains("battery_info_pairs") && batteryData["battery_info_pairs"].isArray()) {
        QJsonArray batteryInfoPairs = batteryData["battery_info_pairs"].toArray();
        // Similar processing for battery info pairs
    }
    
    // Process cell voltages
    if (batteryData.contains("cell_voltages") && batteryData["cell_voltages"].isArray()) {
        QJsonArray cellVoltages = batteryData["cell_voltages"].toArray();
        QRegularExpression cellVoltagesRegex(R"(\{\{#cell_voltages\}\}(.*?)\{\{/cell_voltages\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch cvMatch = cellVoltagesRegex.match(result);
        
        if (cvMatch.hasMatch()) {
            QString cvTemplate = cvMatch.captured(1);
            QString cvRows;
            
            for (const auto &cvValue : cellVoltages) {
                if (cvValue.isObject()) {
                    QJsonObject cv = cvValue.toObject();
                    QString cvRow = cvTemplate;
                    
                    cvRow.replace("{{module}}", cv.value("module").toString());
                    cvRow.replace("{{cell1}}", cv.value("cell1").toString());
                    cvRow.replace("{{cell2}}", cv.value("cell2").toString());
                    cvRow.replace("{{cell3}}", cv.value("cell3").toString());
                    
                    cvRows += cvRow;
                }
            }
            
            result.replace(cvMatch.captured(0), cvRows);
        }
    }
    
    return result;
}

void PDFManager::onPdfGenerationFinished(const QString &filePath, bool success, const QString &error)
{
    setIsGenerating(false);
    
    LoggingManager::instance()->debugGeneral(QString("PDF generation finished - Success: %1, Path: %2").arg(success).arg(filePath));
    
    if (success) {
        // Verify the file actually exists
        if (QFile::exists(filePath)) {
            setCurrentPdfPath(filePath);
            emit pdfGenerated(filePath, true);
            LoggingManager::instance()->debugGeneral(QString("PDF generated successfully and verified: %1").arg(filePath));
        } else {
            LoggingManager::instance()->debugGeneral(QString("PDF generation reported success but file not found: %1").arg(filePath));
            emit pdfGenerated(filePath, false);
            emit pdfGenerationFailed("PDF file not found after generation");
        }
    } else {
        emit pdfGenerated(filePath, false);
        emit pdfGenerationFailed(error);
        LoggingManager::instance()->debugGeneral(QString("PDF generation failed: %1").arg(error));
    }
}

void PDFManager::onPdfViewerClosed()
{
    setIsViewerOpen(false);
    setCurrentPdfPath(QString());
    emit pdfClosed();
}

void PDFManager::setIsGenerating(bool generating)
{
    if (m_isGenerating != generating) {
        m_isGenerating = generating;
        emit isGeneratingChanged();
    }
}

void PDFManager::setIsViewerOpen(bool open)
{
    if (m_isViewerOpen != open) {
        m_isViewerOpen = open;
        emit isViewerOpenChanged();
    }
}

void PDFManager::setCurrentPdfPath(const QString &path)
{
    if (m_currentPdfPath != path) {
        m_currentPdfPath = path;
        emit currentPdfPathChanged();
    }
}

QString PDFManager::generateOutputPath(const QString &baseName)
{
    QString outputDir = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    outputDir = QDir(outputDir).filePath(DEFAULT_OUTPUT_DIR);
    
    // Create directory if it doesn't exist
    QDir().mkpath(outputDir);
    
    QString timestamp = QDateTime::currentDateTime().toString("yyyyMMdd_hhmmss");
    QString fileName = QString("%1_%2.pdf").arg(baseName.isEmpty() ? "diagnostic_report" : baseName, timestamp);
    
    QString fullPath = QDir(outputDir).filePath(fileName);
    LoggingManager::instance()->debugGeneral(QString("Generated output path: %1").arg(fullPath));
    
    return fullPath;
}

QString PDFManager::getDefaultTemplateContent()
{
    return R"(
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generated Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 20px; }
        .section { margin: 20px 0; }
        .field { margin: 10px 0; }
        .label { font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <h1>{{document_title}}</h1>
    </div>
    <div class="section">
        <div class="field"><span class="label">Name:</span> {{name}}</div>
        <div class="field"><span class="label">Date:</span> {{generation_date}}</div>
    </div>
</body>
</html>
)";
} 