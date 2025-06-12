#include "../include/PDFGenerator.h"
#include <QFile>
#include <QFileInfo>
#include <QTextStream>
#include <QRegularExpression>
#include <QJsonArray>
#include <QJsonValue>
#include <QDebug>
#include <QStandardPaths>
#include <QDir>
#include <QDateTime>
#include <QDate>
#include <QTextCursor>
#include <QStringConverter>

PDFGenerator::PDFGenerator(QObject *parent)
    : QObject(parent)
    , m_isGenerating(false)
    , m_pageSize(QPageSize::A4)
    , m_orientation(QPageLayout::Portrait)
    , m_margins(QMarginsF(20, 20, 20, 20))
    , m_resolution(300)
{
    qDebug() << "PDFGenerator initialized";
}

PDFGenerator::~PDFGenerator()
{
    if (m_isGenerating) {
        qWarning() << "PDFGenerator destroyed while generation in progress";
    }
}

void PDFGenerator::generateFromHtml(const QString &htmlContent, const QString &outputPath)
{
    if (m_isGenerating) {
        emit pdfGenerated(outputPath, false, "PDF generation already in progress");
        return;
    }

    if (htmlContent.isEmpty()) {
        emit pdfGenerated(outputPath, false, "HTML content is empty");
        return;
    }

    m_currentOutputPath = outputPath;
    m_currentHtmlContent = htmlContent;
    m_isGenerating = true;

    emit generationProgress(10);
    generatePdfFromHtml(htmlContent, outputPath);
}

void PDFGenerator::generateFromTemplate(const QString &templatePath, const QJsonObject &data, const QString &outputPath)
{
    if (m_isGenerating) {
        emit pdfGenerated(outputPath, false, "PDF generation already in progress");
        return;
    }

    m_currentOutputPath = outputPath;
    m_isGenerating = true;

    emit generationProgress(5);

    // Load template file
    QString templateContent = loadTemplateFile(templatePath);
    if (templateContent.isEmpty()) {
        m_isGenerating = false;
        emit pdfGenerated(outputPath, false, "Failed to load template file: " + templatePath);
        return;
    }

    emit generationProgress(20);

    // Fill template with data
    QString htmlContent = fillTemplateWithData(templateContent, data);
    if (htmlContent.isEmpty()) {
        m_isGenerating = false;
        emit pdfGenerated(outputPath, false, "Failed to process template data");
        return;
    }

    emit generationProgress(40);

    // Generate PDF
    generatePdfFromHtml(htmlContent, outputPath);
}

void PDFGenerator::setPaperSize(QPageSize::PageSizeId pageSize)
{
    m_pageSize = pageSize;
}

void PDFGenerator::setOrientation(QPageLayout::Orientation orientation)
{
    m_orientation = orientation;
}

void PDFGenerator::setMargins(const QMarginsF &margins)
{
    m_margins = margins;
}

void PDFGenerator::setResolution(int dpi)
{
    m_resolution = dpi;
}

void PDFGenerator::onGenerationFinished(bool success)
{
    m_isGenerating = false;
    
    if (success) {
        emit generationProgress(100);
        emit pdfGenerated(m_currentOutputPath, true, QString());
        qDebug() << "PDF generation completed successfully:" << m_currentOutputPath;
    } else {
        emit pdfGenerated(m_currentOutputPath, false, "PDF generation failed");
        qDebug() << "PDF generation failed";
    }
}

void PDFGenerator::setupPdfWriter()
{
    if (!m_pdfWriter) {
        m_pdfWriter = std::make_unique<QPdfWriter>(m_currentOutputPath);
    }
    
    // Configure page layout
    QPageLayout pageLayout(QPageSize(m_pageSize), m_orientation, m_margins);
    m_pdfWriter->setPageLayout(pageLayout);
    m_pdfWriter->setResolution(m_resolution);
    
    // Set metadata
    m_pdfWriter->setCreator("VoiceAI LLM");
    m_pdfWriter->setTitle("Generated PDF");
}

QString PDFGenerator::loadTemplateFile(const QString &templatePath)
{
    qDebug() << "PDFGenerator: Attempting to load template from:" << templatePath;
    
    QFile file(templatePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "PDFGenerator: Failed to open template file:" << templatePath << "Error:" << file.errorString();
        return QString();
    }

    QTextStream stream(&file);
    stream.setEncoding(QStringConverter::Utf8);
    QString content = stream.readAll();
    file.close();

    qDebug() << "PDFGenerator: Template loaded successfully, length:" << content.length();
    qDebug() << "PDFGenerator: Template first 300 chars:" << content.left(300);

    if (content.isEmpty()) {
        qWarning() << "PDFGenerator: Template file is empty:" << templatePath;
    }

    return content;
}

QString PDFGenerator::fillTemplateWithData(const QString &templateContent, const QJsonObject &data)
{
    QString result = templateContent;
    
    qDebug() << "PDFGenerator: Starting template data fill";
    qDebug() << "PDFGenerator: Template length:" << templateContent.length();
    qDebug() << "PDFGenerator: JSON data keys:" << data.keys();

    // Replace simple placeholders like {{key}}
    QRegularExpression placeholderRegex(R"(\{\{(\w+)\}\})");
    QRegularExpressionMatchIterator iterator = placeholderRegex.globalMatch(templateContent);
    
    int replacementCount = 0;
    while (iterator.hasNext()) {
        QRegularExpressionMatch match = iterator.next();
        QString placeholder = match.captured(0);
        QString key = match.captured(1);
        
        if (data.contains(key)) {
            QJsonValue value = data[key];
            QString replacement;
            
            if (value.isString()) {
                replacement = escapeHtml(value.toString());
            } else if (value.isDouble()) {
                replacement = QString::number(value.toDouble());
            } else if (value.isBool()) {
                replacement = value.toBool() ? "Yes" : "No";
            } else if (value.isArray()) {
                // Handle arrays as comma-separated values
                QJsonArray array = value.toArray();
                QStringList items;
                for (const QJsonValue &item : array) {
                    items << escapeHtml(item.toString());
                }
                replacement = items.join(", ");
            }
            
            qDebug() << "PDFGenerator: Replacing" << placeholder << "with:" << replacement;
            result.replace(placeholder, replacement);
            replacementCount++;
        } else {
            qDebug() << "PDFGenerator: Key not found in data:" << key;
        }
    }
    
    qDebug() << "PDFGenerator: Made" << replacementCount << "replacements";

    // Handle complex array structures
    result = processComplexStructures(result, data);

    // Handle special table rows placeholder
    if (result.contains("{{TABLE_ROWS}}")) {
        QString tableRows = formatTableRows(data);
        result.replace("{{TABLE_ROWS}}", tableRows);
    }

    // Handle date placeholders
    if (result.contains("{{CURRENT_DATE}}")) {
        result.replace("{{CURRENT_DATE}}", QDate::currentDate().toString(Qt::ISODate));
    }
    
    if (result.contains("{{CURRENT_DATETIME}}")) {
        result.replace("{{CURRENT_DATETIME}}", QDateTime::currentDateTime().toString(Qt::ISODate));
    }

    return result;
}

QString PDFGenerator::formatTableRows(const QJsonObject &data)
{
    QString tableRows;
    
    // Look for arrays in the data to create table rows
    for (auto it = data.begin(); it != data.end(); ++it) {
        if (it.value().isArray()) {
            QJsonArray array = it.value().toArray();
            for (const QJsonValue &item : array) {
                if (item.isObject()) {
                    QJsonObject obj = item.toObject();
                    tableRows += "<tr>";
                    
                    // Create table cells for each property in the object
                    for (auto objIt = obj.begin(); objIt != obj.end(); ++objIt) {
                        QString cellValue = escapeHtml(objIt.value().toString());
                        tableRows += QString("<td>%1</td>").arg(cellValue);
                    }
                    
                    tableRows += "</tr>\n";
                }
            }
            break; // Use the first array found
        }
    }
    
    // If no array found, create a simple row with key-value pairs
    if (tableRows.isEmpty()) {
        for (auto it = data.begin(); it != data.end(); ++it) {
            if (!it.value().isArray() && !it.value().isObject()) {
                tableRows += "<tr>";
                tableRows += QString("<td>%1</td>").arg(escapeHtml(it.key()));
                tableRows += QString("<td>%1</td>").arg(escapeHtml(it.value().toString()));
                tableRows += "</tr>\n";
            }
        }
    }
    
    return tableRows;
}

QString PDFGenerator::escapeHtml(const QString &text)
{
    QString escaped = text;
    escaped.replace("&", "&amp;");
    escaped.replace("<", "&lt;");
    escaped.replace(">", "&gt;");
    escaped.replace("\"", "&quot;");
    escaped.replace("'", "&#39;");
    return escaped;
}

QString PDFGenerator::processComplexStructures(const QString &templateContent, const QJsonObject &data)
{
    QString result = templateContent;
    
    qDebug() << "PDFGenerator: Processing complex structures";
    
    // Process systems array {{#systems}}...{{/systems}}
    if (data.contains("systems") && data["systems"].isArray()) {
        QRegularExpression systemsRegex(R"(\{\{#systems\}\}(.*?)\{\{/systems\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch match = systemsRegex.match(result);
        
        if (match.hasMatch()) {
            QString systemTemplate = match.captured(1);
            QString systemsHtml;
            QJsonArray systems = data["systems"].toArray();
            
            qDebug() << "PDFGenerator: Processing" << systems.size() << "systems";
            
            for (const QJsonValue &systemValue : systems) {
                if (systemValue.isObject()) {
                    QJsonObject system = systemValue.toObject();
                    QString systemHtml = systemTemplate;
                    
                    // Replace placeholders in system template
                    for (auto it = system.begin(); it != system.end(); ++it) {
                        QString placeholder = QString("{{%1}}").arg(it.key());
                        QString value = it.value().toString();
                        systemHtml.replace(placeholder, escapeHtml(value));
                    }
                    
                    // Handle conditional logic for has_faults
                    if (system.contains("has_faults") && system["has_faults"].toBool()) {
                        QRegularExpression hasErrorRegex(R"(\{\{#if has_faults\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
                        QRegularExpressionMatch hasErrorMatch = hasErrorRegex.match(systemHtml);
                        if (hasErrorMatch.hasMatch()) {
                            systemHtml.replace(hasErrorMatch.captured(0), hasErrorMatch.captured(1));
                        }
                    } else {
                        QRegularExpression hasErrorRegex(R"(\{\{#if has_faults\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
                        systemHtml.replace(hasErrorRegex, "");
                    }
                    
                    systemsHtml += systemHtml;
                }
            }
            
            result.replace(match.captured(0), systemsHtml);
        }
    }
    
    // Process fault_systems array {{#fault_systems}}...{{/fault_systems}}
    if (data.contains("fault_systems") && data["fault_systems"].isArray()) {
        QRegularExpression faultSystemsRegex(R"(\{\{#fault_systems\}\}(.*?)\{\{/fault_systems\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch match = faultSystemsRegex.match(result);
        
        if (match.hasMatch()) {
            QString faultSystemTemplate = match.captured(1);
            QString faultSystemsHtml;
            QJsonArray faultSystems = data["fault_systems"].toArray();
            
            qDebug() << "PDFGenerator: Processing" << faultSystems.size() << "fault systems";
            
            for (const QJsonValue &faultSystemValue : faultSystems) {
                if (faultSystemValue.isObject()) {
                    QJsonObject faultSystem = faultSystemValue.toObject();
                    QString faultSystemHtml = faultSystemTemplate;
                    
                    // Replace basic placeholders
                    for (auto it = faultSystem.begin(); it != faultSystem.end(); ++it) {
                        if (!it.value().isArray()) {
                            QString placeholder = QString("{{%1}}").arg(it.key());
                            QString value = it.value().toString();
                            faultSystemHtml.replace(placeholder, escapeHtml(value));
                        }
                    }
                    
                    // Process faults array within fault system
                    if (faultSystem.contains("faults") && faultSystem["faults"].isArray()) {
                        QRegularExpression faultsRegex(R"(\{\{#faults\}\}(.*?)\{\{/faults\}\})", QRegularExpression::DotMatchesEverythingOption);
                        QRegularExpressionMatch faultsMatch = faultsRegex.match(faultSystemHtml);
                        
                        if (faultsMatch.hasMatch()) {
                            QString faultTemplate = faultsMatch.captured(1);
                            QString faultsHtml;
                            QJsonArray faults = faultSystem["faults"].toArray();
                            
                            for (const QJsonValue &faultValue : faults) {
                                if (faultValue.isObject()) {
                                    QJsonObject fault = faultValue.toObject();
                                    QString faultHtml = faultTemplate;
                                    
                                    for (auto it = fault.begin(); it != fault.end(); ++it) {
                                        QString placeholder = QString("{{%1}}").arg(it.key());
                                        QString value = it.value().toString();
                                        faultHtml.replace(placeholder, escapeHtml(value));
                                    }
                                    
                                    faultsHtml += faultHtml;
                                }
                            }
                            
                            faultSystemHtml.replace(faultsMatch.captured(0), faultsHtml);
                        }
                    }
                    
                    faultSystemsHtml += faultSystemHtml;
                }
            }
            
            result.replace(match.captured(0), faultSystemsHtml);
        }
    }
    
    // Process system_details array {{#system_details}}...{{/system_details}}
    if (data.contains("system_details") && data["system_details"].isArray()) {
        QRegularExpression systemDetailsRegex(R"(\{\{#system_details\}\}(.*?)\{\{/system_details\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch match = systemDetailsRegex.match(result);
        
        if (match.hasMatch()) {
            QString systemDetailTemplate = match.captured(1);
            QString systemDetailsHtml;
            QJsonArray systemDetails = data["system_details"].toArray();
            
            qDebug() << "PDFGenerator: Processing" << systemDetails.size() << "system details";
            
            for (const QJsonValue &systemDetailValue : systemDetails) {
                if (systemDetailValue.isObject()) {
                    QJsonObject systemDetail = systemDetailValue.toObject();
                    QString systemDetailHtml = systemDetailTemplate;
                    
                    // Replace basic placeholders
                    for (auto it = systemDetail.begin(); it != systemDetail.end(); ++it) {
                        if (!it.value().isArray() && !it.value().isObject()) {
                            QString placeholder = QString("{{%1}}").arg(it.key());
                            QString value = it.value().toString();
                            systemDetailHtml.replace(placeholder, escapeHtml(value));
                        }
                    }
                    
                    // Process ecu_info object
                    if (systemDetail.contains("ecu_info") && systemDetail["ecu_info"].isObject()) {
                        QJsonObject ecuInfo = systemDetail["ecu_info"].toObject();
                        for (auto it = ecuInfo.begin(); it != ecuInfo.end(); ++it) {
                            QString placeholder = QString("{{ecu_info.%1}}").arg(it.key());
                            QString value = it.value().toString();
                            systemDetailHtml.replace(placeholder, escapeHtml(value));
                        }
                    }
                    
                    // Process data_stream array within system detail
                    if (systemDetail.contains("data_stream") && systemDetail["data_stream"].isArray()) {
                        QRegularExpression dataStreamRegex(R"(\{\{#data_stream\}\}(.*?)\{\{/data_stream\}\})", QRegularExpression::DotMatchesEverythingOption);
                        QRegularExpressionMatch dataStreamMatch = dataStreamRegex.match(systemDetailHtml);
                        
                        if (dataStreamMatch.hasMatch()) {
                            QString dataStreamTemplate = dataStreamMatch.captured(1);
                            QString dataStreamHtml;
                            QJsonArray dataStreams = systemDetail["data_stream"].toArray();
                            
                            for (const QJsonValue &dataStreamValue : dataStreams) {
                                if (dataStreamValue.isObject()) {
                                    QJsonObject dataStream = dataStreamValue.toObject();
                                    QString dataStreamItemHtml = dataStreamTemplate;
                                    
                                    for (auto it = dataStream.begin(); it != dataStream.end(); ++it) {
                                        QString placeholder = QString("{{%1}}").arg(it.key());
                                        QString value = it.value().toString();
                                        dataStreamItemHtml.replace(placeholder, escapeHtml(value));
                                    }
                                    
                                    dataStreamHtml += dataStreamItemHtml;
                                }
                            }
                            
                            systemDetailHtml.replace(dataStreamMatch.captured(0), dataStreamHtml);
                        }
                    }
                    
                    systemDetailsHtml += systemDetailHtml;
                }
            }
            
            result.replace(match.captured(0), systemDetailsHtml);
        }
    }
    
    // Process battery_test object {{#if battery_test}}...{{/if}}
    if (data.contains("battery_test") && data["battery_test"].isObject()) {
        // Handle conditional blocks for battery_test
        QRegularExpression batteryTestIfRegex(R"(\{\{#if battery_test\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch batteryMatch = batteryTestIfRegex.match(result);
        
        if (batteryMatch.hasMatch()) {
            QString batteryTestTemplate = batteryMatch.captured(1);
            QJsonObject batteryTest = data["battery_test"].toObject();
            
            qDebug() << "PDFGenerator: Processing battery test data";
            
            // Replace battery_test object properties
            for (auto it = batteryTest.begin(); it != batteryTest.end(); ++it) {
                if (!it.value().isArray()) {
                    QString placeholder = QString("{{battery_test.%1}}").arg(it.key());
                    QString value = it.value().toString();
                    batteryTestTemplate.replace(placeholder, escapeHtml(value));
                }
            }
            
            // Process cell_voltages array within battery_test
            if (batteryTest.contains("cell_voltages") && batteryTest["cell_voltages"].isArray()) {
                QRegularExpression cellVoltagesRegex(R"(\{\{#battery_test\.cell_voltages\}\}(.*?)\{\{/battery_test\.cell_voltages\}\})", QRegularExpression::DotMatchesEverythingOption);
                QRegularExpressionMatch cellVoltagesMatch = cellVoltagesRegex.match(batteryTestTemplate);
                
                if (cellVoltagesMatch.hasMatch()) {
                    QString cellVoltageTemplate = cellVoltagesMatch.captured(1);
                    QString cellVoltagesHtml;
                    QJsonArray cellVoltages = batteryTest["cell_voltages"].toArray();
                    
                    for (const QJsonValue &cellVoltageValue : cellVoltages) {
                        if (cellVoltageValue.isObject()) {
                            QJsonObject cellVoltage = cellVoltageValue.toObject();
                            QString cellVoltageHtml = cellVoltageTemplate;
                            
                            for (auto it = cellVoltage.begin(); it != cellVoltage.end(); ++it) {
                                QString placeholder = QString("{{%1}}").arg(it.key());
                                QString value = it.value().toString();
                                cellVoltageHtml.replace(placeholder, escapeHtml(value));
                            }
                            
                            cellVoltagesHtml += cellVoltageHtml;
                        }
                    }
                    
                    batteryTestTemplate.replace(cellVoltagesMatch.captured(0), cellVoltagesHtml);
                }
            }
            
            result.replace(batteryMatch.captured(0), batteryTestTemplate);
        }
    } else {
        // Remove battery_test conditional block if no data
        QRegularExpression batteryTestIfRegex(R"(\{\{#if battery_test\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
        result.replace(batteryTestIfRegex, "");
    }
    
    // Process other conditional blocks for ecu_info and data_stream
    // Handle {{#if ecu_info}}...{{/if}}
    QRegularExpression ecuInfoIfRegex(R"(\{\{#if ecu_info\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
    QRegularExpressionMatchIterator ecuInfoMatches = ecuInfoIfRegex.globalMatch(result);
    while (ecuInfoMatches.hasNext()) {
        QRegularExpressionMatch match = ecuInfoMatches.next();
        // For now, always show ecu_info sections as they're processed above
        result.replace(match.captured(0), match.captured(1));
    }
    
    // Handle {{#if data_stream}}...{{/if}}
    QRegularExpression dataStreamIfRegex(R"(\{\{#if data_stream\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
    QRegularExpressionMatchIterator dataStreamMatches = dataStreamIfRegex.globalMatch(result);
    while (dataStreamMatches.hasNext()) {
        QRegularExpressionMatch match = dataStreamMatches.next();
        // For now, always show data_stream sections as they're processed above
        result.replace(match.captured(0), match.captured(1));
    }
    
    qDebug() << "PDFGenerator: Complex structures processing completed";
    return result;
}

void PDFGenerator::generatePdfFromHtml(const QString &htmlContent, const QString &outputPath)
{
    try {
        // Ensure output directory exists
        QFileInfo fileInfo(outputPath);
        QDir dir = fileInfo.absoluteDir();
        if (!dir.exists()) {
            if (!dir.mkpath(".")) {
                onGenerationFinished(false);
                return;
            }
        }

        emit generationProgress(60);

        // Setup PDF writer
        setupPdfWriter();
        
        emit generationProgress(70);

        // Create and configure text document
        m_document = std::make_unique<QTextDocument>();
        m_document->setHtml(htmlContent);
        m_document->setPageSize(m_pdfWriter->pageLayout().fullRectPixels(m_resolution).size());

        emit generationProgress(80);

        // Create painter and render document
        m_painter = std::make_unique<QPainter>(m_pdfWriter.get());
        if (!m_painter->isActive()) {
            qWarning() << "Failed to create active painter for PDF";
            onGenerationFinished(false);
            return;
        }

        emit generationProgress(90);

        // Render the document
        m_document->drawContents(m_painter.get());
        
        // Clean up
        m_painter->end();
        m_painter.reset();
        m_document.reset();
        m_pdfWriter.reset();

        onGenerationFinished(true);

    } catch (const std::exception &e) {
        qWarning() << "Exception in PDF generation:" << e.what();
        onGenerationFinished(false);
    } catch (...) {
        qWarning() << "Unknown exception in PDF generation";
        onGenerationFinished(false);
    }
} 