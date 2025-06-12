#include "../include/WebEnginePDFGenerator.h"
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
#include <QStringConverter>
#include <QQmlContext>
#include <QQuickItem>
#include <QMetaObject>
#include <QVariant>

WebEnginePDFGenerator::WebEnginePDFGenerator(QObject *parent)
    : QObject(parent)
    , m_qmlEngine(nullptr)
    , m_webEngineComponent(nullptr)
    , m_webEngineRenderer(nullptr)
    , m_isGenerating(false)
    , m_renderProgress(0)
    , m_pageSize(QPageSize::A4)
    , m_orientation(QPageLayout::Portrait)
    , m_margins(QMarginsF(20, 20, 20, 20))
    , m_resolution(300)
    , m_viewportSize(794, 1123)  // A4 size at 96 DPI
    , m_renderTimeout(DEFAULT_RENDER_TIMEOUT)
    , m_settleTime(DEFAULT_SETTLE_TIME)
{
    qDebug() << "WebEnginePDFGenerator initialized";
    initializeWebEngineRenderer();
}

WebEnginePDFGenerator::~WebEnginePDFGenerator()
{
    if (m_isGenerating) {
        qWarning() << "WebEnginePDFGenerator destroyed while generation in progress";
    }
    cleanupWebEngineRenderer();
}

bool WebEnginePDFGenerator::isWebEngineAvailable() const
{
#ifdef HAVE_WEBENGINE_QML
    return m_qmlEngine != nullptr && m_webEngineComponent != nullptr;
#else
    return false;
#endif
}

void WebEnginePDFGenerator::generateFromHtml(const QString &htmlContent, const QString &outputPath)
{
    if (m_isGenerating) {
        emit pdfGenerated(outputPath, false, "PDF generation already in progress");
        return;
    }

    if (htmlContent.isEmpty()) {
        emit pdfGenerated(outputPath, false, "HTML content is empty");
        return;
    }

    if (!isWebEngineAvailable()) {
        emit pdfGenerated(outputPath, false, "WebEngine not available for PDF generation");
        return;
    }

    qDebug() << "WebEnginePDFGenerator: Starting HTML to PDF generation";
    qDebug() << "Output path:" << outputPath;
    qDebug() << "HTML content length:" << htmlContent.length();

    m_currentOutputPath = outputPath;
    m_currentHtmlContent = htmlContent;
    m_isGenerating = true;
    m_renderProgress = 0;

    emit generationProgress(5);
    startWebEngineRender(htmlContent);
}

void WebEnginePDFGenerator::generateFromTemplate(const QString &templatePath, const QJsonObject &data, const QString &outputPath)
{
    if (m_isGenerating) {
        emit pdfGenerated(outputPath, false, "PDF generation already in progress");
        return;
    }

    if (!isWebEngineAvailable()) {
        emit pdfGenerated(outputPath, false, "WebEngine not available for PDF generation");
        return;
    }

    qDebug() << "WebEnginePDFGenerator: Starting template to PDF generation";
    qDebug() << "Template path:" << templatePath;
    qDebug() << "Output path:" << outputPath;

    m_currentOutputPath = outputPath;
    m_isGenerating = true;
    m_renderProgress = 0;

    emit generationProgress(5);

    // Load template file
    QString templateContent = loadTemplateFile(templatePath);
    if (templateContent.isEmpty()) {
        finishGeneration(false, "Failed to load template file: " + templatePath);
        return;
    }

    emit generationProgress(20);

    // Fill template with data
    QString htmlContent = fillTemplateWithData(templateContent, data);
    if (htmlContent.isEmpty()) {
        finishGeneration(false, "Failed to process template data");
        return;
    }

    emit generationProgress(30);

    // Start WebEngine rendering
    m_currentHtmlContent = htmlContent;
    startWebEngineRender(htmlContent);
}

void WebEnginePDFGenerator::setPaperSize(QPageSize::PageSizeId pageSize)
{
    m_pageSize = pageSize;
}

void WebEnginePDFGenerator::setOrientation(QPageLayout::Orientation orientation)
{
    m_orientation = orientation;
}

void WebEnginePDFGenerator::setMargins(const QMarginsF &margins)
{
    m_margins = margins;
}

void WebEnginePDFGenerator::setResolution(int dpi)
{
    m_resolution = dpi;
}

void WebEnginePDFGenerator::setViewportSize(const QSize &size)
{
    m_viewportSize = size;
}

void WebEnginePDFGenerator::setRenderTimeout(int timeoutMs)
{
    m_renderTimeout = timeoutMs;
}

void WebEnginePDFGenerator::setSettleTime(int settleMs)
{
    m_settleTime = settleMs;
}

void WebEnginePDFGenerator::initializeWebEngineRenderer()
{
#ifdef HAVE_WEBENGINE_QML
    qDebug() << "Initializing WebEngine QML renderer";
    
    try {
        m_qmlEngine = new QQmlEngine(this);
        
        if (!createWebEngineComponent()) {
            qWarning() << "Failed to create WebEngine QML component";
            cleanupWebEngineRenderer();
        } else {
            qDebug() << "WebEngine QML renderer initialized successfully";
        }
    } catch (const std::exception &e) {
        qWarning() << "Exception during WebEngine initialization:" << e.what();
        cleanupWebEngineRenderer();
    }
#else
    qDebug() << "WebEngine QML not available - falling back to standard rendering";
#endif
}

bool WebEnginePDFGenerator::createWebEngineComponent()
{
#ifdef HAVE_WEBENGINE_QML
    if (!m_qmlEngine) {
        qWarning() << "QML Engine not initialized";
        return false;
    }

    // Load the WebEngine renderer QML component
    QString qmlPath = "qrc:/qt/qml/VoiceAILLM/qml/WebEnginePDFRenderer.qml";
    
    qDebug() << "Loading WebEngine QML component from:" << qmlPath;
    
    m_webEngineComponent = new QQmlComponent(m_qmlEngine, QUrl(qmlPath), this);
    
    if (m_webEngineComponent->isError()) {
        qWarning() << "Failed to load WebEngine QML component:";
        foreach (const QQmlError &error, m_webEngineComponent->errors()) {
            qWarning() << "  " << error.toString();
        }
        return false;
    }
    
    if (m_webEngineComponent->status() != QQmlComponent::Ready) {
        qWarning() << "WebEngine QML component not ready, status:" << m_webEngineComponent->status();
        return false;
    }
    
    qDebug() << "WebEngine QML component loaded successfully";
    return true;
#else
    return false;
#endif
}

void WebEnginePDFGenerator::startWebEngineRender(const QString &htmlContent)
{
#ifdef HAVE_WEBENGINE_QML
    if (!m_webEngineComponent || !m_qmlEngine) {
        finishGeneration(false, "WebEngine QML component not available");
        return;
    }

    qDebug() << "Creating WebEngine renderer instance";
    
    // Create an instance of the WebEngine renderer
    QObject *rendererObject = m_webEngineComponent->create();
    if (!rendererObject) {
        finishGeneration(false, "Failed to create WebEngine renderer instance");
        return;
    }

    m_webEngineRenderer = qobject_cast<QQuickItem*>(rendererObject);
    if (!m_webEngineRenderer) {
        finishGeneration(false, "Created object is not a QQuickItem");
        rendererObject->deleteLater();
        return;
    }

    // Set renderer properties
    m_webEngineRenderer->setWidth(m_viewportSize.width());
    m_webEngineRenderer->setHeight(m_viewportSize.height());

    // Connect signals
    connect(m_webEngineRenderer, SIGNAL(renderCompleted(QVariant)),
            this, SLOT(onWebEngineRenderCompleted(QVariant)));
    connect(m_webEngineRenderer, SIGNAL(renderFailed(QString)),
            this, SLOT(onWebEngineRenderFailed(QString)));
    connect(m_webEngineRenderer, SIGNAL(progressChanged(qreal)),
            this, SLOT(onWebEngineProgressChanged(qreal)));

    emit generationProgress(40);

    // Start rendering
    qDebug() << "Starting WebEngine HTML rendering";
    QMetaObject::invokeMethod(m_webEngineRenderer, "renderHtml",
                              Q_ARG(QString, htmlContent));
#else
    finishGeneration(false, "WebEngine QML not available");
#endif
}

void WebEnginePDFGenerator::onWebEngineRenderCompleted(const QVariant &imageData)
{
    qDebug() << "WebEngine render completed, generating PDF";
    
    emit generationProgress(80);
    
    // Extract QImage from the variant
    QImage renderedImage;
    if (imageData.canConvert<QImage>()) {
        renderedImage = imageData.value<QImage>();
    } else {
        // Try to get the image from QQuickItemGrabResult
        QObject *grabResult = imageData.value<QObject*>();
        if (grabResult) {
            QVariant imageProperty = grabResult->property("image");
            if (imageProperty.canConvert<QImage>()) {
                renderedImage = imageProperty.value<QImage>();
            }
        }
    }
    
    if (renderedImage.isNull()) {
        finishGeneration(false, "Failed to extract rendered image from WebEngine");
        return;
    }
    
    qDebug() << "Rendered image size:" << renderedImage.size();
    qDebug() << "Rendered image format:" << renderedImage.format();
    
    emit generationProgress(90);
    
    // Generate PDF from the rendered image
    generatePdfFromImage(renderedImage, m_currentOutputPath);
}

void WebEnginePDFGenerator::onWebEngineRenderFailed(const QString &error)
{
    qWarning() << "WebEngine render failed:" << error;
    finishGeneration(false, "WebEngine render failed: " + error);
}

void WebEnginePDFGenerator::onWebEngineProgressChanged(qreal progress)
{
    int totalProgress = 40 + (int)(progress * 40.0); // WebEngine takes 40-80% of total progress
    if (totalProgress != m_renderProgress) {
        m_renderProgress = totalProgress;
        emit generationProgress(totalProgress);
    }
}

void WebEnginePDFGenerator::generatePdfFromImage(const QImage &renderedImage, const QString &outputPath)
{
    try {
        // Ensure output directory exists
        QFileInfo fileInfo(outputPath);
        QDir dir = fileInfo.absoluteDir();
        if (!dir.exists()) {
            if (!dir.mkpath(".")) {
                finishGeneration(false, "Failed to create output directory");
                return;
            }
        }

        // Setup PDF writer
        setupPdfWriter(outputPath);
        if (!m_pdfWriter) {
            finishGeneration(false, "Failed to setup PDF writer");
            return;
        }

        // Create painter
        m_painter = std::make_unique<QPainter>(m_pdfWriter.get());
        if (!m_painter->isActive()) {
            finishGeneration(false, "Failed to create active painter for PDF");
            return;
        }

        emit generationProgress(95);

        // Calculate scaling to fit the page
        QRect pageRect = m_pdfWriter->pageLayout().fullRectPixels(m_resolution);
        QRect imageRect = renderedImage.rect();
        
        qDebug() << "PDF page rect:" << pageRect;
        qDebug() << "Image rect:" << imageRect;
        
        // Scale the image to fit the page while maintaining aspect ratio
        QSize scaledSize = imageRect.size().scaled(pageRect.size(), Qt::KeepAspectRatio);
        QRect targetRect = QRect(QPoint(0, 0), scaledSize);
        
        // Center the image on the page
        targetRect.moveCenter(pageRect.center());
        
        qDebug() << "Target rect:" << targetRect;
        
        // Draw the rendered image to PDF
        m_painter->drawImage(targetRect, renderedImage, imageRect);
        
        // Clean up
        m_painter->end();
        m_painter.reset();
        m_pdfWriter.reset();

        finishGeneration(true);

    } catch (const std::exception &e) {
        qWarning() << "Exception in PDF generation from image:" << e.what();
        finishGeneration(false, QString("Exception: %1").arg(e.what()));
    } catch (...) {
        qWarning() << "Unknown exception in PDF generation from image";
        finishGeneration(false, "Unknown exception during PDF generation");
    }
}

void WebEnginePDFGenerator::setupPdfWriter(const QString &outputPath)
{
    m_pdfWriter = std::make_unique<QPdfWriter>(outputPath);
    
    // Configure page layout
    QPageLayout pageLayout(QPageSize(m_pageSize), m_orientation, m_margins);
    m_pdfWriter->setPageLayout(pageLayout);
    m_pdfWriter->setResolution(m_resolution);
    
    // Set metadata
    m_pdfWriter->setCreator("VoiceAI LLM - WebEngine PDF Generator");
    m_pdfWriter->setTitle("Generated PDF via WebEngine");
    
    qDebug() << "PDF Writer configured - Resolution:" << m_resolution << "DPI";
    qDebug() << "Page size:" << QPageSize(m_pageSize).name();
    qDebug() << "Orientation:" << (m_orientation == QPageLayout::Portrait ? "Portrait" : "Landscape");
}

void WebEnginePDFGenerator::finishGeneration(bool success, const QString &error)
{
    m_isGenerating = false;
    
    // Cleanup WebEngine renderer
    if (m_webEngineRenderer) {
        m_webEngineRenderer->deleteLater();
        m_webEngineRenderer = nullptr;
    }
    
    if (success) {
        emit generationProgress(100);
        emit pdfGenerated(m_currentOutputPath, true, QString());
        qDebug() << "WebEngine PDF generation completed successfully:" << m_currentOutputPath;
    } else {
        emit pdfGenerated(m_currentOutputPath, false, error);
        qDebug() << "WebEngine PDF generation failed:" << error;
    }
    
    // Clear current state
    m_currentOutputPath.clear();
    m_currentHtmlContent.clear();
    m_renderProgress = 0;
}

void WebEnginePDFGenerator::cleanupWebEngineRenderer()
{
    if (m_webEngineRenderer) {
        m_webEngineRenderer->deleteLater();
        m_webEngineRenderer = nullptr;
    }
    
    if (m_webEngineComponent) {
        m_webEngineComponent->deleteLater();
        m_webEngineComponent = nullptr;
    }
    
    // Note: Don't delete m_qmlEngine as it's owned by this object's parent relationship
}

QString WebEnginePDFGenerator::loadTemplateFile(const QString &templatePath)
{
    qDebug() << "WebEnginePDFGenerator: Loading template from:" << templatePath;
    
    QFile file(templatePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open template file:" << templatePath << "Error:" << file.errorString();
        return QString();
    }

    QTextStream stream(&file);
    stream.setEncoding(QStringConverter::Utf8);
    QString content = stream.readAll();
    file.close();

    qDebug() << "Template loaded successfully, length:" << content.length();

    if (content.isEmpty()) {
        qWarning() << "Template file is empty:" << templatePath;
    }

    return content;
}

QString WebEnginePDFGenerator::fillTemplateWithData(const QString &templateContent, const QJsonObject &data)
{
    qDebug() << "WebEnginePDFGenerator: Processing template with data";
    
    if (templateContent.isEmpty()) {
        qWarning() << "Template content is empty";
        return QString();
    }
    
    // Use the same template processing logic as the original PDFGenerator
    QString result = processComplexStructures(templateContent, data);
    
    qDebug() << "Template processing completed, result length:" << result.length();
    return result;
}

QString WebEnginePDFGenerator::processComplexStructures(const QString &templateContent, const QJsonObject &data)
{
    QString result = templateContent;
    
    qDebug() << "Processing complex template structures...";
    
    // Process systems array with conditional logic
    if (data.contains("systems") && data["systems"].isArray()) {
        QJsonArray systems = data["systems"].toArray();
        QRegularExpression systemsRegex(R"(\{\{#systems\}\}(.*?)\{\{/systems\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch match = systemsRegex.match(result);
        
        if (match.hasMatch()) {
            QString systemTemplate = match.captured(1);
            QString systemsHtml;
            
            for (const auto &systemValue : systems) {
                if (systemValue.isObject()) {
                    QJsonObject system = systemValue.toObject();
                    QString systemRow = systemTemplate;
                    
                    // Replace system placeholders
                    for (auto it = system.begin(); it != system.end(); ++it) {
                        QString placeholder = QString("{{%1}}").arg(it.key());
                        QString value = it.value().toString();
                        systemRow.replace(placeholder, value);
                    }
                    
                    // Handle has_faults conditional
                    bool hasFaults = system["has_faults"].toBool();
                    QRegularExpression hasFaultsRegex(R"(\{\{#if has_faults\}\}(.*?)\{\{/if\}\})", QRegularExpression::DotMatchesEverythingOption);
                    if (hasFaults) {
                        systemRow.replace(hasFaultsRegex, "\\1");
                    } else {
                        systemRow.replace(hasFaultsRegex, "");
                    }
                    
                    systemsHtml += systemRow;
                }
            }
            
            result.replace(match.captured(0), systemsHtml);
        }
    }
    
    // Process fault_systems array with nested faults
    if (data.contains("fault_systems") && data["fault_systems"].isArray()) {
        QJsonArray faultSystems = data["fault_systems"].toArray();
        QRegularExpression faultSystemsRegex(R"(\{\{#fault_systems\}\}(.*?)\{\{/fault_systems\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch match = faultSystemsRegex.match(result);
        
        if (match.hasMatch()) {
            QString faultSystemTemplate = match.captured(1);
            QString faultSystemsHtml;
            
            for (const auto &faultSystemValue : faultSystems) {
                if (faultSystemValue.isObject()) {
                    QJsonObject faultSystem = faultSystemValue.toObject();
                    QString faultSystemRow = faultSystemTemplate;
                    
                    // Replace fault system placeholders
                    for (auto it = faultSystem.begin(); it != faultSystem.end(); ++it) {
                        if (it.key() != "faults") { // Handle faults separately
                            QString placeholder = QString("{{%1}}").arg(it.key());
                            QString value = it.value().toString();
                            faultSystemRow.replace(placeholder, value);
                        }
                    }
                    
                    // Process nested faults array
                    if (faultSystem.contains("faults") && faultSystem["faults"].isArray()) {
                        QJsonArray faults = faultSystem["faults"].toArray();
                        QRegularExpression faultsRegex(R"(\{\{#faults\}\}(.*?)\{\{/faults\}\})", QRegularExpression::DotMatchesEverythingOption);
                        QRegularExpressionMatch faultsMatch = faultsRegex.match(faultSystemRow);
                        
                        if (faultsMatch.hasMatch()) {
                            QString faultTemplate = faultsMatch.captured(1);
                            QString faultsHtml;
                            
                            for (const auto &faultValue : faults) {
                                if (faultValue.isObject()) {
                                    QJsonObject fault = faultValue.toObject();
                                    QString faultRow = faultTemplate;
                                    
                                    // Replace fault placeholders
                                    for (auto faultIt = fault.begin(); faultIt != fault.end(); ++faultIt) {
                                        QString placeholder = QString("{{%1}}").arg(faultIt.key());
                                        QString value = faultIt.value().toString();
                                        faultRow.replace(placeholder, value);
                                    }
                                    
                                    faultsHtml += faultRow;
                                }
                            }
                            
                            faultSystemRow.replace(faultsMatch.captured(0), faultsHtml);
                        }
                    }
                    
                    faultSystemsHtml += faultSystemRow;
                }
            }
            
            result.replace(match.captured(0), faultSystemsHtml);
        }
    }
    
    // Process system_details array with nested data_stream
    if (data.contains("system_details") && data["system_details"].isArray()) {
        QJsonArray systemDetails = data["system_details"].toArray();
        QRegularExpression systemDetailsRegex(R"(\{\{#system_details\}\}(.*?)\{\{/system_details\}\})", QRegularExpression::DotMatchesEverythingOption);
        QRegularExpressionMatch match = systemDetailsRegex.match(result);
        
        if (match.hasMatch()) {
            QString systemDetailTemplate = match.captured(1);
            QString systemDetailsHtml;
            
            for (const auto &systemDetailValue : systemDetails) {
                if (systemDetailValue.isObject()) {
                    QJsonObject systemDetail = systemDetailValue.toObject();
                    QString systemDetailRow = systemDetailTemplate;
                    
                    // Replace system detail placeholders
                    for (auto it = systemDetail.begin(); it != systemDetail.end(); ++it) {
                        if (it.key() == "ecu_info" && it.value().isObject()) {
                            // Handle ECU info object
                            QJsonObject ecuInfo = it.value().toObject();
                            for (auto ecuIt = ecuInfo.begin(); ecuIt != ecuInfo.end(); ++ecuIt) {
                                QString placeholder = QString("{{ecu_info.%1}}").arg(ecuIt.key());
                                QString value = ecuIt.value().toString();
                                systemDetailRow.replace(placeholder, value);
                            }
                        } else if (it.key() == "data_stream" && it.value().isArray()) {
                            // Handle data stream array separately
                            continue;
                        } else {
                            QString placeholder = QString("{{%1}}").arg(it.key());
                            QString value = it.value().toString();
                            systemDetailRow.replace(placeholder, value);
                        }
                    }
                    
                    // Process data_stream array
                    if (systemDetail.contains("data_stream") && systemDetail["data_stream"].isArray()) {
                        QJsonArray dataStream = systemDetail["data_stream"].toArray();
                        QRegularExpression dataStreamRegex(R"(\{\{#data_stream\}\}(.*?)\{\{/data_stream\}\})", QRegularExpression::DotMatchesEverythingOption);
                        QRegularExpressionMatch dataMatch = dataStreamRegex.match(systemDetailRow);
                        
                        if (dataMatch.hasMatch()) {
                            QString dataTemplate = dataMatch.captured(1);
                            QString dataStreamHtml;
                            
                            for (const auto &dataValue : dataStream) {
                                if (dataValue.isObject()) {
                                    QJsonObject dataItem = dataValue.toObject();
                                    QString dataRow = dataTemplate;
                                    
                                    // Replace data stream placeholders
                                    for (auto dataIt = dataItem.begin(); dataIt != dataItem.end(); ++dataIt) {
                                        QString placeholder = QString("{{%1}}").arg(dataIt.key());
                                        QString value = dataIt.value().toString();
                                        dataRow.replace(placeholder, value);
                                    }
                                    
                                    dataStreamHtml += dataRow;
                                }
                            }
                            
                            systemDetailRow.replace(dataMatch.captured(0), dataStreamHtml);
                        }
                    }
                    
                    systemDetailsHtml += systemDetailRow;
                }
            }
            
            result.replace(match.captured(0), systemDetailsHtml);
        }
    }
    
    // Process battery_test object with cell_voltages array
    if (data.contains("battery_test") && data["battery_test"].isObject()) {
        QJsonObject batteryTest = data["battery_test"].toObject();
        
        // Handle simple battery test fields
        for (auto it = batteryTest.begin(); it != batteryTest.end(); ++it) {
            if (it.key() != "cell_voltages") { // Handle cell_voltages separately
                QString placeholder = QString("{{battery_test.%1}}").arg(it.key());
                QString value = it.value().toString();
                result.replace(placeholder, value);
            }
        }
        
        // Handle cell_voltages array
        if (batteryTest.contains("cell_voltages") && batteryTest["cell_voltages"].isArray()) {
            QJsonArray cellVoltages = batteryTest["cell_voltages"].toArray();
            QRegularExpression cellVoltagesRegex(R"(\{\{#battery_test\.cell_voltages\}\}(.*?)\{\{/battery_test\.cell_voltages\}\})", QRegularExpression::DotMatchesEverythingOption);
            QRegularExpressionMatch match = cellVoltagesRegex.match(result);
            
            if (match.hasMatch()) {
                QString cellTemplate = match.captured(1);
                QString cellsHtml;
                
                for (const auto &cellValue : cellVoltages) {
                    if (cellValue.isObject()) {
                        QJsonObject cell = cellValue.toObject();
                        QString cellRow = cellTemplate;
                        
                        // Replace cell voltage placeholders
                        for (auto cellIt = cell.begin(); cellIt != cell.end(); ++cellIt) {
                            QString placeholder = QString("{{%1}}").arg(cellIt.key());
                            QString value = cellIt.value().toString();
                            cellRow.replace(placeholder, value);
                        }
                        
                        cellsHtml += cellRow;
                    }
                }
                
                result.replace(match.captured(0), cellsHtml);
            }
        }
    }
    
    // Replace simple placeholders
    for (auto it = data.begin(); it != data.end(); ++it) {
        QString placeholder = QString("{{%1}}").arg(it.key());
        QString value;
        
        if (it.value().isString()) {
            value = it.value().toString();
        } else if (it.value().isDouble()) {
            value = QString::number(it.value().toDouble());
        } else if (it.value().isBool()) {
            value = it.value().toBool() ? "Yes" : "No";
        } else if (it.value().isArray() || it.value().isObject()) {
            // Skip complex structures, they're handled above
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
    
    qDebug() << "Complex template processing completed";
    
    return result;
} 