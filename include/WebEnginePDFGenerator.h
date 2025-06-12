#pragma once

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QPdfWriter>
#include <QPainter>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQuickItem>
#include <QQuickRenderControl>
#include <QQuickView>
#include <QImage>
#include <memory>

#ifdef HAVE_WEBENGINE_QML
#include <QGuiApplication>
#include <QOffscreenSurface>
#include <QOpenGLContext>
#endif

class WebEnginePDFGenerator : public QObject
{
    Q_OBJECT

public:
    explicit WebEnginePDFGenerator(QObject *parent = nullptr);
    ~WebEnginePDFGenerator();

    // Generate PDF from HTML content using WebEngine
    void generateFromHtml(const QString &htmlContent, const QString &outputPath);
    
    // Generate PDF from template and JSON data using WebEngine
    void generateFromTemplate(const QString &templatePath, const QJsonObject &data, const QString &outputPath);
    
    // Configure PDF settings
    void setPaperSize(QPageSize::PageSizeId pageSize);
    void setOrientation(QPageLayout::Orientation orientation);
    void setMargins(const QMarginsF &margins);
    void setResolution(int dpi);
    
    // WebEngine specific settings
    void setViewportSize(const QSize &size);
    void setRenderTimeout(int timeoutMs);
    void setSettleTime(int settleMs);  // Time to wait for dynamic content

    // Status
    bool isGenerating() const { return m_isGenerating; }
    bool isWebEngineAvailable() const;

signals:
    void pdfGenerated(const QString &filePath, bool success, const QString &error);
    void generationProgress(int percentage);
    void webEngineRenderCompleted(const QImage &renderedImage);
    void webEngineRenderFailed(const QString &error);

private slots:
    void onWebEngineRenderCompleted(const QVariant &imageData);
    void onWebEngineRenderFailed(const QString &error);
    void onWebEngineProgressChanged(qreal progress);

private:
    void setupWebEngineRenderer();
    void cleanupWebEngineRenderer();
    QString loadTemplateFile(const QString &templatePath);
    QString fillTemplateWithData(const QString &templateContent, const QJsonObject &data);
    QString processComplexStructures(const QString &templateContent, const QJsonObject &data);
    void generatePdfFromImage(const QImage &renderedImage, const QString &outputPath);
    void setupPdfWriter(const QString &outputPath);
    void finishGeneration(bool success, const QString &error = QString());
    
    // WebEngine rendering setup
    void initializeWebEngineRenderer();
    bool createWebEngineComponent();
    void startWebEngineRender(const QString &htmlContent);
    
    std::unique_ptr<QPdfWriter> m_pdfWriter;
    std::unique_ptr<QPainter> m_painter;
    
    // WebEngine QML components
    QQmlEngine *m_qmlEngine;
    QQmlComponent *m_webEngineComponent;
    QQuickItem *m_webEngineRenderer;
    
    QString m_currentOutputPath;
    QString m_currentHtmlContent;
    bool m_isGenerating;
    int m_renderProgress;
    
    // PDF Settings
    QPageSize::PageSizeId m_pageSize;
    QPageLayout::Orientation m_orientation;
    QMarginsF m_margins;
    int m_resolution;
    
    // WebEngine Settings
    QSize m_viewportSize;
    int m_renderTimeout;
    int m_settleTime;
    
    static constexpr int DEFAULT_RENDER_TIMEOUT = 30000; // 30 seconds
    static constexpr int DEFAULT_SETTLE_TIME = 1000;     // 1 second
}; 