#pragma once

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QPdfWriter>
#include <QPainter>
#include <QPageLayout>
#include <QQuickItem>
#include <QQuickRenderControl>
#include <QQuickWindow>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QOffscreenSurface>
#include <QOpenGLContext>
#include <QOpenGLFramebufferObject>
#include <memory>
#include <QTextStream>

class QMLPDFGenerator : public QObject
{
    Q_OBJECT

public:
    explicit QMLPDFGenerator(QObject *parent = nullptr);
    ~QMLPDFGenerator();

    // Generate PDF from QML template and JSON data
    void generateFromTemplate(const QString &templateName, const QJsonObject &data, const QString &outputPath);
    
    // Configure PDF settings
    void setPaperSize(QPageSize::PageSizeId pageSize);
    void setOrientation(QPageLayout::Orientation orientation);
    void setMargins(const QMarginsF &margins);
    void setResolution(int dpi);
    void setRenderSize(const QSize &size);

signals:
    void pdfGenerated(const QString &filePath, bool success, const QString &error);
    void generationProgress(int percentage);

private:
    void initializeQML();
    bool initializeQMLEngine();
    void setupPdfWriter(const QString &outputPath);
    void renderQMLToPDF(QQuickItem *rootItem, const QString &outputPath);
    void testBasicQML(QTextStream &debug);
    QQuickItem* createTemplateItem(const QString &templateName, const QJsonObject &data, QTextStream &debug);
    QString loadQMLTemplate(const QString &templateName);
    void populateTemplateWithData(QQuickItem *item, const QJsonObject &data);
    void finishGeneration(bool success, const QString &error = QString());
    
    // Data population helpers
    void populateBasicInfo(QQuickItem *item, const QJsonObject &data);
    void populateSystemsList(QQuickItem *item, const QJsonArray &systems);
    void populateFaultSystems(QQuickItem *item, const QJsonArray &faultSystems);
    void populateSystemDetails(QQuickItem *item, const QJsonArray &systemDetails);
    void populateBatteryTest(QQuickItem *item, const QJsonObject &batteryData);
    
    std::unique_ptr<QPdfWriter> m_pdfWriter;
    std::unique_ptr<QPainter> m_painter;
    
    // QML rendering infrastructure
    QQmlEngine *m_qmlEngine;
    QQuickRenderControl *m_renderControl;
    QQuickWindow *m_quickWindow;
    QOffscreenSurface *m_offscreenSurface;
    QOpenGLContext *m_openGLContext;
    std::unique_ptr<QOpenGLFramebufferObject> m_framebuffer;
    
    QString m_currentOutputPath;
    bool m_isGenerating;
    
    // PDF Settings
    QPageSize::PageSizeId m_pageSize;
    QPageLayout::Orientation m_orientation;
    QMarginsF m_margins;
    int m_resolution;
    QSize m_renderSize;
    
    static constexpr int DEFAULT_RENDER_WIDTH = 210 * 4;  // A4 width in mm * 4 (roughly 300 DPI)
    static constexpr int DEFAULT_RENDER_HEIGHT = 297 * 4; // A4 height in mm * 4
}; 