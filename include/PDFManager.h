#pragma once

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QJsonArray>
#include <memory>

// Forward declarations
class PDFGenerator;
class PDFViewer;
class WebEnginePDFGenerator;
class QMLPDFGenerator;

class PDFManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isGenerating READ isGenerating NOTIFY isGeneratingChanged)
    Q_PROPERTY(bool isViewerOpen READ isViewerOpen NOTIFY isViewerOpenChanged)
    Q_PROPERTY(QString currentPdfPath READ currentPdfPath NOTIFY currentPdfPathChanged)

public:
    explicit PDFManager(QObject *parent = nullptr);
    ~PDFManager();

    // Properties
    bool isGenerating() const;
    bool isViewerOpen() const;
    QString currentPdfPath() const;

    // PDF Generation
    Q_INVOKABLE void generatePdfFromJson(const QString &jsonData, const QString &outputPath = QString());
    Q_INVOKABLE void generatePdfFromTemplate(const QString &templatePath, const QJsonObject &data, const QString &outputPath = QString());
    
    // WebEngine-enhanced PDF Generation (when available)
    Q_INVOKABLE void generatePdfFromJsonWebEngine(const QString &jsonData, const QString &outputPath = QString());
    Q_INVOKABLE void generatePdfFromTemplateWebEngine(const QString &templatePath, const QJsonObject &data, const QString &outputPath = QString());
    
    // QML-based PDF Generation (new alternative method)
    Q_INVOKABLE void generatePdfFromJsonQML(const QString &jsonData, const QString &outputPath = QString());
    Q_INVOKABLE void generatePdfFromTemplateQML(const QString &templateName, const QJsonObject &data, const QString &outputPath = QString());
    
    // Check if WebEngine is available for enhanced rendering
    Q_INVOKABLE bool isWebEngineAvailable() const;
    
    // PDF Viewing
    Q_INVOKABLE void openPdfFile();
    Q_INVOKABLE void openPdfFile(const QString &filePath);
    Q_INVOKABLE void closePdfViewer();
    
    // Template management
    Q_INVOKABLE QString loadTemplate(const QString &templatePath);
    Q_INVOKABLE QString fillTemplate(const QString &templateContent, const QJsonObject &data);
    
    // Utility functions
    Q_INVOKABLE bool isValidJson(const QString &jsonString);
    Q_INVOKABLE QJsonObject parseJsonString(const QString &jsonString);
    Q_INVOKABLE QString formatTableRows(const QJsonArray &rows);

signals:
    void isGeneratingChanged();
    void isViewerOpenChanged();
    void currentPdfPathChanged();
    void pdfGenerated(const QString &filePath, bool success);
    void pdfGenerationFailed(const QString &error);
    void pdfOpened(const QString &filePath);
    void pdfClosed();
    void error(const QString &message);

private slots:
    void onPdfGenerationFinished(const QString &filePath, bool success, const QString &error);
    void onPdfViewerClosed();

private:
    void setIsGenerating(bool generating);
    void setIsViewerOpen(bool open);
    void setCurrentPdfPath(const QString &path);
    
    QString generateOutputPath(const QString &baseName = QString());
    QString getDefaultTemplateContent();
    
    // Template processing helpers
    QString processConditionalBlocks(const QString &templateContent, const QJsonObject &data);
    QString processRepeatingBlocks(const QString &templateContent, const QJsonObject &data);
    QString processSystemsList(const QString &templateContent, const QJsonArray &systems);
    QString processFaultSystems(const QString &templateContent, const QJsonArray &faultSystems);
    QString processSystemDetails(const QString &templateContent, const QJsonArray &systemDetails);
    QString processBatteryTest(const QString &templateContent, const QJsonObject &batteryData);
    
    std::unique_ptr<PDFGenerator> m_generator;
#ifdef HAVE_WEBENGINE_QML
    std::unique_ptr<WebEnginePDFGenerator> m_webEngineGenerator;
#endif
    std::unique_ptr<QMLPDFGenerator> m_qmlGenerator;
    std::unique_ptr<PDFViewer> m_viewer;
    
    bool m_isGenerating;
    bool m_isViewerOpen;
    QString m_currentPdfPath;
    
    static constexpr const char* DEFAULT_OUTPUT_DIR = "generated_pdfs";
}; 