#include "QMLPDFGenerator.h"
#include <QApplication>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>
#include <QQmlContext>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QTimer>
#include <QOpenGLFunctions>
#include <QQuickRenderTarget>
#include <QTextStream>
#include <QDateTime>
#include <QOpenGLExtraFunctions>
#include <QThread>
#include <QColor>

QMLPDFGenerator::QMLPDFGenerator(QObject *parent)
    : QObject(parent)
    , m_qmlEngine(nullptr)
    , m_renderControl(nullptr)
    , m_quickWindow(nullptr)
    , m_offscreenSurface(nullptr)
    , m_openGLContext(nullptr)
    , m_isGenerating(false)
    , m_pageSize(QPageSize::A4)
    , m_orientation(QPageLayout::Portrait)
    , m_margins(QMarginsF(20, 20, 20, 20))
    , m_resolution(300)
    , m_renderSize(DEFAULT_RENDER_WIDTH, DEFAULT_RENDER_HEIGHT)
{
    initializeQML();
}

QMLPDFGenerator::~QMLPDFGenerator()
{
    if (m_quickWindow) {
        m_quickWindow->deleteLater();
    }
    if (m_renderControl) {
        m_renderControl->deleteLater();
    }
    if (m_qmlEngine) {
        m_qmlEngine->deleteLater();
    }
    if (m_openGLContext) {
        m_openGLContext->deleteLater();
    }
    if (m_offscreenSurface) {
        m_offscreenSurface->deleteLater();
    }
}

void QMLPDFGenerator::initializeQML()
{
    qDebug() << "QMLPDFGenerator: Initializing QML rendering infrastructure";
    
    // Create offscreen surface for OpenGL rendering
    m_offscreenSurface = new QOffscreenSurface();
    m_offscreenSurface->create();
    
    // Create OpenGL context
    m_openGLContext = new QOpenGLContext();
    m_openGLContext->create();
    m_openGLContext->makeCurrent(m_offscreenSurface);
    
    // Create render control
    m_renderControl = new QQuickRenderControl();
    
    // Create QML engine
    qDebug() << "QMLPDFGenerator: Creating QML engine...";
    m_qmlEngine = new QQmlEngine(this);
    qDebug() << "QMLPDFGenerator: QML engine created";
    qDebug() << "QMLPDFGenerator: QML engine valid:" << (m_qmlEngine != nullptr);
    
    if (m_qmlEngine) {
        qDebug() << "QMLPDFGenerator: QML engine network access manager:" << (m_qmlEngine->networkAccessManager() != nullptr);
    }
    
    // Create quick window with render control
    m_quickWindow = new QQuickWindow(m_renderControl);
    m_quickWindow->setColor(Qt::white);
    
    // Initialize render control (Qt6.9 API - no parameters)
    m_renderControl->initialize();
    
    qDebug() << "QMLPDFGenerator: QML infrastructure initialized successfully";
}

void QMLPDFGenerator::generateFromTemplate(const QString &templateName, const QJsonObject &data, const QString &outputPath)
{
    // Write debug messages to a file
    QFile debugFile("qml_debug.txt");
    debugFile.open(QIODevice::WriteOnly | QIODevice::Append);
    QTextStream debug(&debugFile);
    
    debug << "=== QML PDF Generation Started ===" << Qt::endl;
    debug << "Template: " << templateName << Qt::endl;
    debug << "Output: " << outputPath << Qt::endl;
    debug << "Time: " << QDateTime::currentDateTime().toString() << Qt::endl;
    
    qDebug() << "QMLPDFGenerator: Starting PDF generation for template:" << templateName;
    
    if (m_isGenerating) {
        debug << "ERROR: Already generating" << Qt::endl;
        emit pdfGenerated(outputPath, false, "PDF generation already in progress");
        return;
    }
    
    m_isGenerating = true;
    m_currentOutputPath = outputPath;
    
    emit generationProgress(10);
    
    // Test basic QML functionality first
    debug << "Testing basic QML functionality..." << Qt::endl;
    qDebug() << "QMLPDFGenerator: Testing basic QML functionality...";
    testBasicQML(debug);
    
    // Create template item
    debug << "Creating template item..." << Qt::endl;
    QQuickItem *templateItem = createTemplateItem(templateName, data, debug);
    if (!templateItem) {
        debug << "ERROR: Failed to create QML template item" << Qt::endl;
        qDebug() << "QMLPDFGenerator: Failed to create QML template item";
        finishGeneration(false, "Failed to create QML template item");
        return;
    }
    
    emit generationProgress(50);
    
    // Populate template with data
    populateTemplateWithData(templateItem, data);
    
    emit generationProgress(75);
    
    // Render to PDF
    renderQMLToPDF(templateItem, outputPath);
    
    templateItem->deleteLater();
    
    emit generationProgress(100);
    debug << "=== QML PDF Generation Completed ===" << Qt::endl;
    finishGeneration(true);
}

void QMLPDFGenerator::testBasicQML(QTextStream &debug)
{
    debug << "Testing basic QML component creation..." << Qt::endl;
    qDebug() << "QMLPDFGenerator: Testing basic QML component creation...";
    
    QString simpleQML = R"(
import QtQuick

Rectangle {
    width: 100
    height: 100
    color: "red"
    
    Text {
        anchors.centerIn: parent
        text: "Test"
    }
}
)";
    
    QQmlComponent testComponent(m_qmlEngine);
    testComponent.setData(simpleQML.toUtf8(), QUrl("test://test.qml"));
    
    // Wait for the component to be ready
    if (testComponent.status() == QQmlComponent::Loading) {
        debug << "Component is loading, waiting for completion..." << Qt::endl;
        qDebug() << "QMLPDFGenerator: Component is loading, waiting for completion...";
        
        // Process events to allow loading to complete
        for (int i = 0; i < 10 && testComponent.status() == QQmlComponent::Loading; ++i) {
            QCoreApplication::processEvents();
            QThread::msleep(10); // Small delay
        }
    }
    
    debug << "Test component status: " << testComponent.status() << Qt::endl;
    qDebug() << "QMLPDFGenerator: Test component status:" << testComponent.status();
    
    if (testComponent.isError()) {
        debug << "Test component errors:" << Qt::endl;
        qDebug() << "QMLPDFGenerator: Test component errors:";
        auto errors = testComponent.errors();
        for (const auto &error : errors) {
            debug << "  - Line " << error.line() << ": " << error.description() << Qt::endl;
            qDebug() << "  - Line" << error.line() << ":" << error.description();
        }
        return;
    }
    
    if (testComponent.status() != QQmlComponent::Ready) {
        debug << "Test component is not ready, status: " << testComponent.status() << Qt::endl;
        debug << "Component error string: " << testComponent.errorString() << Qt::endl;
        qDebug() << "QMLPDFGenerator: Test component is not ready, status:" << testComponent.status();
        qDebug() << "QMLPDFGenerator: Component error string:" << testComponent.errorString();
        return;
    }
    
    QObject *testObject = testComponent.create();
    if (!testObject) {
        debug << "Failed to create test QML object" << Qt::endl;
        debug << "Component error string: " << testComponent.errorString() << Qt::endl;
        qDebug() << "QMLPDFGenerator: Failed to create test QML object";
        qDebug() << "QMLPDFGenerator: Component error string:" << testComponent.errorString();
        return;
    }
    
    debug << "Test QML object created successfully!" << Qt::endl;
    qDebug() << "QMLPDFGenerator: Test QML object created successfully!";
    testObject->deleteLater();
}

QQuickItem* QMLPDFGenerator::createTemplateItem(const QString &templateName, const QJsonObject &data, QTextStream &debug)
{
    debug << "Creating template item for: " << templateName << Qt::endl;
    qDebug() << "QMLPDFGenerator: Creating template item for:" << templateName;
    
    QString qmlTemplate = loadQMLTemplate(templateName);
    if (qmlTemplate.isEmpty()) {
        debug << "Template content is empty, cannot create item" << Qt::endl;
        qDebug() << "QMLPDFGenerator: Template content is empty, cannot create item";
        return nullptr;
    }
    
    debug << "Template loaded successfully, length: " << qmlTemplate.length() << Qt::endl;
    debug << "First 200 characters: " << qmlTemplate.left(200) << Qt::endl;
    qDebug() << "QMLPDFGenerator: Template loaded successfully, length:" << qmlTemplate.length();
    qDebug() << "QMLPDFGenerator: First 200 characters:" << qmlTemplate.left(200);
    
    // Create QML component from template
    QQmlComponent component(m_qmlEngine);
    component.setData(qmlTemplate.toUtf8(), QUrl("qrc:/pdf_template.qml"));
    
    debug << "Component created, checking for errors..." << Qt::endl;
    qDebug() << "QMLPDFGenerator: Component created, checking for errors...";
    
    if (component.isError()) {
        debug << "QML component has errors:" << Qt::endl;
        qDebug() << "QMLPDFGenerator: QML component has errors:";
        auto errors = component.errors();
        for (const auto &error : errors) {
            debug << "  - Line " << error.line() << ": " << error.description() << Qt::endl;
            qDebug() << "  - Line" << error.line() << ":" << error.description();
        }
        return nullptr;
    }
    
    debug << "Component is valid, creating object..." << Qt::endl;
    qDebug() << "QMLPDFGenerator: Component is valid, creating object...";
    
    // Create QML object
    QObject *object = component.create();
    if (!object) {
        debug << "Failed to create QML object from component" << Qt::endl;
        debug << "Component status: " << component.status() << Qt::endl;
        debug << "Component error string: " << component.errorString() << Qt::endl;
        qDebug() << "QMLPDFGenerator: Failed to create QML object from component";
        qDebug() << "QMLPDFGenerator: Component status:" << component.status();
        qDebug() << "QMLPDFGenerator: Component error string:" << component.errorString();
        return nullptr;
    }
    
    debug << "QML object created successfully" << Qt::endl;
    qDebug() << "QMLPDFGenerator: QML object created successfully";
    
    QQuickItem *item = qobject_cast<QQuickItem*>(object);
    if (!item) {
        debug << "QML object is not a QQuickItem, type: " << object->metaObject()->className() << Qt::endl;
        qDebug() << "QMLPDFGenerator: QML object is not a QQuickItem, type:" << object->metaObject()->className();
        object->deleteLater();
        return nullptr;
    }
    
    debug << "QQuickItem cast successful" << Qt::endl;
    qDebug() << "QMLPDFGenerator: QQuickItem cast successful";
    
    // Set parent to quick window's content item
    item->setParentItem(m_quickWindow->contentItem());
    item->setSize(m_renderSize);
    
    debug << "Item configured with size: " << m_renderSize.width() << "x" << m_renderSize.height() << Qt::endl;
    qDebug() << "QMLPDFGenerator: Item configured with size:" << m_renderSize;
    
    return item;
}

QString QMLPDFGenerator::loadQMLTemplate(const QString &templateName)
{
    qDebug() << "QMLPDFGenerator: Loading template:" << templateName;
    
    // Try multiple resource paths (cross-platform)
    QStringList possiblePaths = {
        QString(":/VoiceAILLM/resources/templates/%1.ui.qml").arg(templateName),
        QString(":/resources/templates/%1.ui.qml").arg(templateName),
        QString(":/templates/%1.ui.qml").arg(templateName),
        QString(":/%1.ui.qml").arg(templateName),
        QString(":/qt/qml/VoiceAILLM/resources/templates/%1.ui.qml").arg(templateName),
        QString(":/VoiceAILLM/resources/templates/%1.qml").arg(templateName),
        QString(":/resources/templates/%1.qml").arg(templateName),
        QString(":/templates/%1.qml").arg(templateName),
        QString(":/%1.qml").arg(templateName)
    };
    
    // First, let's list what resources are actually available
    QDir resourceDir(":/");
    qDebug() << "QMLPDFGenerator: Available resources in /:";
    for (const QString &entry : resourceDir.entryList()) {
        qDebug() << "  - " << entry;
    }
    
    QDir voiceResourceDir(":/VoiceAILLM");
    if (voiceResourceDir.exists()) {
        qDebug() << "QMLPDFGenerator: Available resources in /VoiceAILLM:";
        for (const QString &entry : voiceResourceDir.entryList()) {
            qDebug() << "  - " << entry;
        }
    }
    
    for (const QString &resourcePath : possiblePaths) {
        QFile resourceFile(resourcePath);
        qDebug() << "QMLPDFGenerator: Trying path:" << resourcePath;
        
        if (resourceFile.open(QIODevice::ReadOnly)) {
            QString content = QString::fromUtf8(resourceFile.readAll());
            qDebug() << "QMLPDFGenerator: SUCCESS! Loaded from resource:" << resourcePath;
            qDebug() << "QMLPDFGenerator: Template content length:" << content.length();
            return content;
        } else {
            qDebug() << "QMLPDFGenerator: Failed to open:" << resourcePath;
        }
    }
    
    // Try application directory as fallback (cross-platform)
    QString appDirPath = QCoreApplication::applicationDirPath();
    QString templatePath = QDir(appDirPath).filePath(QString("resources/templates/%1.ui.qml").arg(templateName));
    QFile templateFile(templatePath);
    
    if (templateFile.open(QIODevice::ReadOnly)) {
        QString content = QString::fromUtf8(templateFile.readAll());
        qDebug() << "QMLPDFGenerator: Loaded from app directory:" << templatePath;
        qDebug() << "QMLPDFGenerator: Template content length:" << content.length();
        return content;
    }
    
    // If no template found, use simple hardcoded QML for testing
    qDebug() << "QMLPDFGenerator: No template found, using simple fallback template";
    
    QString simpleTemplate = R"(
import QtQuick

Rectangle {
    id: root
    width: 840
    height: 1188
    color: "#e9ecf5"
    
    property string report_title: "Test PDF"
    property string company: "Test Company"
    
    Text {
        anchors.centerIn: parent
        text: "QML PDF Test\nTitle: " + root.report_title + "\nCompany: " + root.company
        font.pixelSize: 24
        color: "#000000"
        horizontalAlignment: Text.AlignHCenter
    }
}
)";
    
    qDebug() << "QMLPDFGenerator: Using simple template, length:" << simpleTemplate.length();
    return simpleTemplate;
}

void QMLPDFGenerator::populateTemplateWithData(QQuickItem *item, const QJsonObject &data)
{
    qDebug() << "QMLPDFGenerator: Populating template with data";
    
    if (!item) {
        qDebug() << "QMLPDFGenerator: Item is null, cannot populate data";
        return;
    }
    
    // Set properties directly on the QML item instead of using QQmlContext
    if (data.contains("title")) {
        item->setProperty("title", data["title"].toString());
    }
    if (data.contains("report_title")) {
        item->setProperty("report_title", data["report_title"].toString());
    }
    if (data.contains("company")) {
        item->setProperty("company", data["company"].toString());
    }
    if (data.contains("email")) {
        item->setProperty("email", data["email"].toString());
    }
    if (data.contains("tel")) {
        item->setProperty("tel", data["tel"].toString());
    }
    if (data.contains("website")) {
        item->setProperty("website", data["website"].toString());
    }
    if (data.contains("address")) {
        item->setProperty("address", data["address"].toString());
    }
    if (data.contains("vin")) {
        item->setProperty("vin", data["vin"].toString());
    }
    if (data.contains("mileage")) {
        item->setProperty("mileage", data["mileage"].toString());
    }
    if (data.contains("car_number")) {
        item->setProperty("car_number", data["car_number"].toString());
    }
    if (data.contains("report_time")) {
        item->setProperty("report_time", data["report_time"].toString());
    }
    if (data.contains("sn")) {
        item->setProperty("sn", data["sn"].toString());
    }
    if (data.contains("software_version")) {
        item->setProperty("software_version", data["software_version"].toString());
    }
    if (data.contains("systems_scanned")) {
        item->setProperty("systems_scanned", data["systems_scanned"].toString());
    }
    if (data.contains("systems_with_dtcs")) {
        item->setProperty("systems_with_dtcs", data["systems_with_dtcs"].toString());
    }
    if (data.contains("total_dtcs")) {
        item->setProperty("total_dtcs", data["total_dtcs"].toString());
    }
    
    // Set array data
    if (data.contains("systems")) {
        QVariantList systemsList;
        QJsonArray systemsArray = data["systems"].toArray();
        for (const auto &system : systemsArray) {
            systemsList.append(system.toObject().toVariantMap());
        }
        item->setProperty("systems", systemsList);
    }
    
    if (data.contains("fault_systems")) {
        QVariantList faultSystemsList;
        QJsonArray faultSystemsArray = data["fault_systems"].toArray();
        for (const auto &faultSystem : faultSystemsArray) {
            faultSystemsList.append(faultSystem.toObject().toVariantMap());
        }
        item->setProperty("fault_systems", faultSystemsList);
    }
    
    if (data.contains("system_details")) {
        QVariantList systemDetailsList;
        QJsonArray systemDetailsArray = data["system_details"].toArray();
        for (const auto &systemDetail : systemDetailsArray) {
            systemDetailsList.append(systemDetail.toObject().toVariantMap());
        }
        item->setProperty("system_details", systemDetailsList);
    }
    
    if (data.contains("battery_test")) {
        QVariantMap batteryTestData = data["battery_test"].toObject().toVariantMap();
        item->setProperty("battery_test", batteryTestData);
    }
    
    qDebug() << "QMLPDFGenerator: Template populated with data";
}

void QMLPDFGenerator::renderQMLToPDF(QQuickItem *rootItem, const QString &outputPath)
{
    qDebug() << "QMLPDFGenerator: Starting PDF rendering";
    
    if (!rootItem) {
        qDebug() << "QMLPDFGenerator: Root item is null, cannot render";
        return;
    }
    
    // Setup PDF writer
    setupPdfWriter(outputPath);
    
    qDebug() << "QMLPDFGenerator: PDF writer setup completed";
    
    // Use a much larger window size for high resolution capture
    QSize windowSize = QSize(1680, 2376); // Even larger: 2x original A4 size
    
    // Create a visible QQuickWindow for rendering (more reliable than offscreen)
    QQuickWindow *renderWindow = new QQuickWindow();
    renderWindow->setColor(QColor("#e9ecf5")); // Match QML background
    
    // Set window size to ensure proper capture resolution
    renderWindow->resize(windowSize);
    renderWindow->setMinimumSize(windowSize);
    renderWindow->setMaximumSize(windowSize);
    
    qDebug() << "QMLPDFGenerator: Window created with size:" << windowSize;
    
    // Set up the root item in the window - make it fill the entire window
    rootItem->setParentItem(renderWindow->contentItem());
    rootItem->setSize(QSizeF(windowSize));
    rootItem->setPosition(QPointF(0, 0));
    rootItem->setVisible(true);
    
    qDebug() << "QMLPDFGenerator: Root item configured - size:" << rootItem->size() << "position:" << rootItem->position() << "visible:" << rootItem->isVisible();
    
    // Process events to ensure the window is ready
    QCoreApplication::processEvents();
    
    // Show the window NORMALLY (not minimized) to ensure proper capture
    renderWindow->show();
    renderWindow->raise();
    renderWindow->update();
    
    qDebug() << "QMLPDFGenerator: Window shown, actual size:" << renderWindow->size() << "content item size:" << renderWindow->contentItem()->size();
    
    // Wait longer for the window to be fully rendered
    for (int i = 0; i < 20; ++i) {
        QCoreApplication::processEvents();
        QThread::msleep(50); // Longer delays
    }
    
    qDebug() << "QMLPDFGenerator: About to capture window";
    
    // Capture the window content
    QImage renderedImage = renderWindow->grabWindow();
    
    qDebug() << "QMLPDFGenerator: Image captured!";
    qDebug() << "  - Captured image size:" << renderedImage.size();
    qDebug() << "  - Captured image format:" << renderedImage.format();
    qDebug() << "  - Captured image null:" << renderedImage.isNull();
    qDebug() << "  - Window actual size:" << renderWindow->size();
    
    // Clean up the window
    renderWindow->close();
    renderWindow->deleteLater();
    
    // Draw the image to PDF with DIRECT device coordinate approach
    if (m_painter && !renderedImage.isNull()) {
        try {
            // Use the PAINTER'S DEVICE SIZE directly instead of page layout calculations
            QSize deviceSize = QSize(m_painter->device()->width(), m_painter->device()->height());
            QRect fullDeviceRect(0, 0, deviceSize.width(), deviceSize.height());
            
            qDebug() << "QMLPDFGenerator: ===== DIRECT DEVICE DRAWING =====";
            qDebug() << "  - Painter device size:" << deviceSize;
            qDebug() << "  - Drawing to full device rect:" << fullDeviceRect;
            qDebug() << "  - Original captured image:" << renderedImage.size();
            
            // Scale image to fill the ENTIRE device area
            QImage scaledImage = renderedImage.scaled(deviceSize, Qt::IgnoreAspectRatio, Qt::SmoothTransformation);
            
            qDebug() << "  - Scaled image size:" << scaledImage.size();
            qDebug() << "  - Scale factors: x=" << (double)deviceSize.width() / renderedImage.width() 
                     << " y=" << (double)deviceSize.height() / renderedImage.height();
            
            // Draw the image to fill the ENTIRE device coordinate space
            m_painter->drawImage(fullDeviceRect, scaledImage);
            qDebug() << "QMLPDFGenerator: Image drawn to FULL device area successfully";
            qDebug() << "============================================";
            
        } catch (...) {
            qDebug() << "QMLPDFGenerator: Exception while drawing to PDF";
            return;
        }
    } else {
        qDebug() << "QMLPDFGenerator: Cannot draw image - painter valid:" << (m_painter != nullptr) << "image null:" << renderedImage.isNull();
    }
    
    // Finish PDF with error checking
    try {
        m_painter->end();
        m_pdfWriter.reset();
        qDebug() << "QMLPDFGenerator: PDF finalized successfully";
    } catch (...) {
        qDebug() << "QMLPDFGenerator: Exception while finalizing PDF";
        return;
    }
    
    qDebug() << "QMLPDFGenerator: PDF rendering completed successfully";
}

void QMLPDFGenerator::setupPdfWriter(const QString &outputPath)
{
    m_pdfWriter = std::make_unique<QPdfWriter>(outputPath);
    
    // Use NORMAL resolution but zero margins 
    m_pdfWriter->setResolution(300); // Standard high resolution
    
    // Configure PDF settings with ZERO margins
    QMarginsF zeroMargins(0, 0, 0, 0);
    QPageLayout pageLayout(m_pageSize, m_orientation, zeroMargins);
    m_pdfWriter->setPageLayout(pageLayout);
    
    qDebug() << "QMLPDFGenerator: PDF setup - Page size:" << QPageSize(m_pageSize).size(QPageSize::Point) 
             << "Margins:" << zeroMargins << "Resolution:" << 300;
    
    m_pdfWriter->setTitle("QML Generated PDF");
    m_pdfWriter->setCreator("Voice AI LLM");
    
    // Setup painter
    m_painter = std::make_unique<QPainter>(m_pdfWriter.get());
    if (!m_painter->isActive()) {
        qDebug() << "QMLPDFGenerator: Failed to create PDF painter";
        return;
    }
    
    // Debug: Print coordinate system info
    QRect pageRectPoints = m_pdfWriter->pageLayout().paintRect(QPageLayout::Point).toRect();
    QSize fullPageSizePoints = QPageSize(m_pageSize).size(QPageSize::Point).toSize();
    
    qDebug() << "QMLPDFGenerator: ===== PDF COORDINATE SYSTEMS =====";
    qDebug() << "QMLPDFGenerator: Full page size (Points):" << fullPageSizePoints;
    qDebug() << "QMLPDFGenerator: Usable area (Points):" << pageRectPoints;
    qDebug() << "QMLPDFGenerator: Painter device size:" << m_painter->device()->width() << "x" << m_painter->device()->height();
    qDebug() << "QMLPDFGenerator: =====================================";
}

void QMLPDFGenerator::finishGeneration(bool success, const QString &error)
{
    m_isGenerating = false;
    
    if (success) {
        qDebug() << "QMLPDFGenerator: PDF generation completed successfully";
        emit pdfGenerated(m_currentOutputPath, true, QString());
    } else {
        qDebug() << "QMLPDFGenerator: PDF generation failed:" << error;
        emit pdfGenerated(m_currentOutputPath, false, error);
    }
}

void QMLPDFGenerator::setPaperSize(QPageSize::PageSizeId pageSize)
{
    m_pageSize = pageSize;
}

void QMLPDFGenerator::setOrientation(QPageLayout::Orientation orientation)
{
    m_orientation = orientation;
}

void QMLPDFGenerator::setMargins(const QMarginsF &margins)
{
    m_margins = margins;
}

void QMLPDFGenerator::setResolution(int dpi)
{
    m_resolution = dpi;
}

void QMLPDFGenerator::setRenderSize(const QSize &size)
{
    m_renderSize = size;
}