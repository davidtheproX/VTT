#pragma once

#include <QObject>
#include <QString>
#include <QQuickItem>
#include <QPdfDocument>
#include <QPdfPageRenderer>
#include <QUrl>
#include <QtQmlIntegration>
#include <memory>

class PDFViewer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString filePath READ filePath WRITE setFilePath NOTIFY filePathChanged)
    Q_PROPERTY(int pageCount READ pageCount NOTIFY pageCountChanged)
    Q_PROPERTY(int currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)
    Q_PROPERTY(qreal zoom READ zoom WRITE setZoom NOTIFY zoomChanged)
    Q_PROPERTY(bool isValid READ isValid NOTIFY isValidChanged)
    Q_PROPERTY(QString title READ title NOTIFY titleChanged)

public:
    explicit PDFViewer(QObject *parent = nullptr);
    ~PDFViewer();

    // Properties
    QString filePath() const;
    void setFilePath(const QString &filePath);
    
    int pageCount() const;
    int currentPage() const;
    void setCurrentPage(int page);
    
    qreal zoom() const;
    void setZoom(qreal zoom);
    
    bool isValid() const;
    QString title() const;

    // PDF Operations
    Q_INVOKABLE bool loadPdf(const QString &filePath);
    Q_INVOKABLE void closePdf();
    Q_INVOKABLE void nextPage();
    Q_INVOKABLE void previousPage();
    Q_INVOKABLE void zoomIn();
    Q_INVOKABLE void zoomOut();
    Q_INVOKABLE void resetZoom();
    Q_INVOKABLE void fitToWidth();
    Q_INVOKABLE void fitToPage();
    
    // Get page as image for QML display
    Q_INVOKABLE QUrl getPageImageUrl(int page);
    Q_INVOKABLE QSize getPageSize(int page);

signals:
    void filePathChanged();
    void pageCountChanged();
    void currentPageChanged();
    void zoomChanged();
    void isValidChanged();
    void titleChanged();
    void pdfLoaded(bool success);
    void pdfClosed();
    void error(const QString &message);

private slots:
    void onDocumentStatusChanged();

private:
    void updateStatus();
    void renderCurrentPage();
    QString generatePageImagePath(int page);
    
    std::unique_ptr<QPdfDocument> m_document;
    std::unique_ptr<QPdfPageRenderer> m_renderer;
    
    QString m_filePath;
    int m_pageCount;
    int m_currentPage;
    qreal m_zoom;
    bool m_isValid;
    QString m_title;
    QString m_tempImageDir;
    
    static constexpr qreal DEFAULT_ZOOM = 1.0;
    static constexpr qreal MIN_ZOOM = 0.25;
    static constexpr qreal MAX_ZOOM = 5.0;
    static constexpr qreal ZOOM_STEP = 0.25;
}; 