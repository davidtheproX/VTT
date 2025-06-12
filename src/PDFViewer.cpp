#include "../include/PDFViewer.h"
#include <QPdfDocument>
#include <QPdfPageRenderer>
#include <QUrl>
#include <QStandardPaths>
#include <QDir>
#include <QFileInfo>
#include <QDebug>
#include <QTimer>
#include <QTemporaryDir>
#include <QImageWriter>

PDFViewer::PDFViewer(QObject *parent)
    : QObject(parent)
    , m_document(std::make_unique<QPdfDocument>(this))
    , m_renderer(std::make_unique<QPdfPageRenderer>(this))
    , m_pageCount(0)
    , m_currentPage(0)
    , m_zoom(DEFAULT_ZOOM)
    , m_isValid(false)
{
    // Connect document signals
    connect(m_document.get(), &QPdfDocument::statusChanged,
            this, &PDFViewer::onDocumentStatusChanged);
    connect(m_document.get(), &QPdfDocument::pageCountChanged,
            this, &PDFViewer::pageCountChanged);

    // Create temporary directory for page images
    QTemporaryDir tempDir;
    if (tempDir.isValid()) {
        m_tempImageDir = tempDir.path();
        tempDir.setAutoRemove(false); // Keep directory until viewer is destroyed
    } else {
        m_tempImageDir = QStandardPaths::writableLocation(QStandardPaths::TempLocation) + "/VoiceAILLM_PDF";
        QDir().mkpath(m_tempImageDir);
    }

    qDebug() << "PDFViewer initialized, temp dir:" << m_tempImageDir;
}

PDFViewer::~PDFViewer()
{
    closePdf();
    
    // Clean up temporary directory
    if (!m_tempImageDir.isEmpty()) {
        QDir tempDir(m_tempImageDir);
        tempDir.removeRecursively();
    }
}

QString PDFViewer::filePath() const
{
    return m_filePath;
}

void PDFViewer::setFilePath(const QString &filePath)
{
    if (m_filePath != filePath) {
        m_filePath = filePath;
        emit filePathChanged();
        
        if (!filePath.isEmpty()) {
            loadPdf(filePath);
        }
    }
}

int PDFViewer::pageCount() const
{
    return m_pageCount;
}

int PDFViewer::currentPage() const
{
    return m_currentPage;
}

void PDFViewer::setCurrentPage(int page)
{
    if (page >= 0 && page < m_pageCount && m_currentPage != page) {
        m_currentPage = page;
        emit currentPageChanged();
        renderCurrentPage();
    }
}

qreal PDFViewer::zoom() const
{
    return m_zoom;
}

void PDFViewer::setZoom(qreal zoom)
{
    qreal clampedZoom = qBound(MIN_ZOOM, zoom, MAX_ZOOM);
    if (qAbs(m_zoom - clampedZoom) > 0.01) {
        m_zoom = clampedZoom;
        emit zoomChanged();
        renderCurrentPage();
    }
}

bool PDFViewer::isValid() const
{
    return m_isValid;
}

QString PDFViewer::title() const
{
    return m_title;
}

bool PDFViewer::loadPdf(const QString &filePath)
{
    if (filePath.isEmpty()) {
        qWarning() << "PDFViewer: Empty file path";
        return false;
    }

    if (!QFileInfo::exists(filePath)) {
        qWarning() << "PDFViewer: File does not exist:" << filePath;
        emit error(QString("File does not exist: %1").arg(filePath));
        return false;
    }

    closePdf();

    m_filePath = filePath;
    m_document->load(filePath);
    
    qDebug() << "PDFViewer: Loading PDF:" << filePath;
    return true;
}

void PDFViewer::closePdf()
{
    if (m_document && m_document->status() != QPdfDocument::Status::Null) {
        m_document->close();
        m_pageCount = 0;
        m_currentPage = 0;
        m_isValid = false;
        m_title.clear();
        m_filePath.clear();
        
        // Clean up page images
        QDir tempDir(m_tempImageDir);
        QStringList filters;
        filters << "page_*.png";
        QStringList files = tempDir.entryList(filters, QDir::Files);
        for (const QString &file : files) {
            tempDir.remove(file);
        }
        
        emit filePathChanged();
        emit pageCountChanged();
        emit currentPageChanged();
        emit isValidChanged();
        emit titleChanged();
        emit pdfClosed();
        
        qDebug() << "PDFViewer: PDF closed";
    }
}

void PDFViewer::nextPage()
{
    if (m_currentPage < m_pageCount - 1) {
        setCurrentPage(m_currentPage + 1);
    }
}

void PDFViewer::previousPage()
{
    if (m_currentPage > 0) {
        setCurrentPage(m_currentPage - 1);
    }
}

void PDFViewer::zoomIn()
{
    setZoom(m_zoom + ZOOM_STEP);
}

void PDFViewer::zoomOut()
{
    setZoom(m_zoom - ZOOM_STEP);
}

void PDFViewer::resetZoom()
{
    setZoom(DEFAULT_ZOOM);
}

void PDFViewer::fitToWidth()
{
    if (!m_isValid || m_currentPage < 0 || m_currentPage >= m_pageCount) {
        return;
    }

    // Get the page size in points
    QSizeF pageSize = m_document->pagePointSize(m_currentPage);
    
    // Use a reasonable default viewport width for fitting calculations
    // QML viewport can override this by calling setZoom() directly with calculated values
    const qreal targetWidth = 800.0;
    
    // Calculate zoom to fit width
    qreal widthZoom = targetWidth / pageSize.width();
    
    // Clamp to min/max zoom bounds
    qreal clampedZoom = qBound(MIN_ZOOM, widthZoom, MAX_ZOOM);
    
    setZoom(clampedZoom);
}

void PDFViewer::fitToPage()
{
    if (!m_isValid || m_currentPage < 0 || m_currentPage >= m_pageCount) {
        return;
    }

    // Get the page size in points
    QSizeF pageSize = m_document->pagePointSize(m_currentPage);
    
    // Use reasonable default viewport dimensions for fitting calculations
    // QML viewport can override this by calling setZoom() directly with calculated values
    const qreal targetWidth = 800.0;
    const qreal targetHeight = 600.0;
    
    // Calculate zoom to fit both dimensions
    qreal widthZoom = targetWidth / pageSize.width();
    qreal heightZoom = targetHeight / pageSize.height();
    
    // Use the smaller zoom to ensure the page fits completely
    qreal fitZoom = qMin(widthZoom, heightZoom);
    
    // Clamp to min/max zoom bounds
    qreal clampedZoom = qBound(MIN_ZOOM, fitZoom, MAX_ZOOM);
    
    setZoom(clampedZoom);
}

QUrl PDFViewer::getPageImageUrl(int page)
{
    if (!m_isValid || page < 0 || page >= m_pageCount) {
        return QUrl();
    }

    QString imagePath = generatePageImagePath(page);
    if (QFileInfo::exists(imagePath)) {
        return QUrl::fromLocalFile(imagePath);
    }

    // Render page if image doesn't exist
    QSize pageSize = m_document->pagePointSize(page).toSize();
    QSize renderSize = pageSize * m_zoom;
    
    // Qt6.9: requestPage returns request ID, handle asynchronously
    quint64 requestId = m_renderer->requestPage(page, renderSize);
    
    // For now, use a simpler synchronous approach via document
    QImage pageImage = m_document->render(page, renderSize);
    if (!pageImage.isNull()) {
        if (pageImage.save(imagePath, "PNG")) {
            return QUrl::fromLocalFile(imagePath);
        } else {
            qWarning() << "PDFViewer: Failed to save page image:" << imagePath;
        }
    } else {
        qWarning() << "PDFViewer: Failed to render page:" << page;
    }

    return QUrl();
}

QSize PDFViewer::getPageSize(int page)
{
    if (!m_isValid || page < 0 || page >= m_pageCount) {
        return QSize();
    }

    QSizeF pageSize = m_document->pagePointSize(page);
    return (pageSize * m_zoom).toSize();
}

void PDFViewer::onDocumentStatusChanged()
{
    updateStatus();
}

void PDFViewer::updateStatus()
{
    QPdfDocument::Status status = m_document->status();
    bool wasValid = m_isValid;
    
    switch (status) {
    case QPdfDocument::Status::Null:
        m_isValid = false;
        m_pageCount = 0;
        m_currentPage = 0;
        m_title.clear();
        break;
        
    case QPdfDocument::Status::Loading:
        m_isValid = false;
        break;
        
    case QPdfDocument::Status::Ready:
        m_isValid = true;
        m_pageCount = m_document->pageCount();
        m_currentPage = 0;
        m_title = m_document->metaData(QPdfDocument::MetaDataField::Title).toString();
        if (m_title.isEmpty()) {
            QFileInfo fileInfo(m_filePath);
            m_title = fileInfo.baseName();
        }
        
        // Set up renderer
        m_renderer->setDocument(m_document.get());
        
        emit pdfLoaded(true);
        renderCurrentPage();
        qDebug() << "PDFViewer: PDF loaded successfully, pages:" << m_pageCount;
        break;
        
    case QPdfDocument::Status::Error:
        m_isValid = false;
        m_pageCount = 0;
        m_currentPage = 0;
        m_title.clear();
        
        QString errorMsg = QString("Failed to load PDF: %1").arg(static_cast<int>(m_document->error()));
        emit error(errorMsg);
        emit pdfLoaded(false);
        qWarning() << "PDFViewer: PDF load error:" << errorMsg;
        break;
    }
    
    if (wasValid != m_isValid) {
        emit isValidChanged();
    }
    emit pageCountChanged();
    emit currentPageChanged();
    emit titleChanged();
}

void PDFViewer::renderCurrentPage()
{
    if (!m_isValid || m_currentPage < 0 || m_currentPage >= m_pageCount) {
        return;
    }

    // Generate page image for current page
    getPageImageUrl(m_currentPage);
}

QString PDFViewer::generatePageImagePath(int page)
{
    return QString("%1/page_%2_zoom_%3.png")
           .arg(m_tempImageDir)
           .arg(page, 4, 10, QChar('0'))
           .arg(QString::number(m_zoom, 'f', 2));
} 