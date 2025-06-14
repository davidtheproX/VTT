#include "SvgHandler.h"
#include <QFile>
#include <QDebug>
#include <QXmlStreamReader>
#include <QXmlStreamAttributes>
#include <QRegularExpression>

SvgHandler::SvgHandler(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , m_renderer(new QSvgRenderer(this))
    , m_scale(1.0)
    , m_offset(0, 0)
    , m_enableZoom(true)
    , m_enablePan(true)
    , m_isPanning(false)
{
    setAcceptedMouseButtons(Qt::AllButtons);
    setAcceptHoverEvents(true);
    setFlag(QQuickItem::ItemHasContents, true);
    
    connect(m_renderer, &QSvgRenderer::repaintNeeded, this, &SvgHandler::onRendererRepaintNeeded);
}

void SvgHandler::setSource(const QString &source)
{
    if (m_source != source) {
        m_source = source;
        loadSvg();
        emit sourceChanged();
    }
}

void SvgHandler::setScale(qreal scale)
{
    if (qFuzzyCompare(m_scale, scale))
        return;
    
    m_scale = qMax(0.1, qMin(10.0, scale)); // Limit scale range
    updateTransform();
    update();
    emit scaleChanged();
}

void SvgHandler::setOffset(const QPointF &offset)
{
    if (m_offset == offset)
        return;
    
    m_offset = offset;
    updateTransform();
    update();
    emit offsetChanged();
}

void SvgHandler::setHighlightedElement(const QString &element)
{
    if (m_highlightedElement != element) {
        m_highlightedElement = element;
        update();
        emit highlightedElementChanged();
    }
}

void SvgHandler::setEnableZoom(bool enable)
{
    if (m_enableZoom != enable) {
        m_enableZoom = enable;
        emit enableZoomChanged();
    }
}

void SvgHandler::setEnablePan(bool enable)
{
    if (m_enablePan != enable) {
        m_enablePan = enable;
        emit enablePanChanged();
    }
}

void SvgHandler::loadSvg()
{
    if (m_source.isEmpty()) {
        qDebug() << "SvgHandler: Empty source, clearing renderer";
        m_renderer->load(QByteArray());
        return;
    }
    
    qDebug() << "SvgHandler: Loading SVG from source:" << m_source;
    
    // First, let's check if the resource exists using QFile
    QFile testFile(m_source);
    qDebug() << "SvgHandler: QFile exists check for" << m_source << ":" << testFile.exists();
    qDebug() << "SvgHandler: QFile size check:" << testFile.size();
    
    // Try different resource path formats for better compatibility
    QStringList pathsToTry;
    pathsToTry << m_source;
    
    // If it's a QRC path, try alternative formats that work with QSvgRenderer
    if (m_source.startsWith("qrc:/qt/qml/VoiceAILLM/")) {
        QString altPath1 = m_source;
        altPath1.replace("qrc:/qt/qml/VoiceAILLM/", ":/VoiceAILLM/");
        pathsToTry << altPath1;
        
        QString altPath2 = m_source;
        altPath2.replace("qrc:/qt/qml/", ":/");
        pathsToTry << altPath2;
        
        QString altPath3 = m_source;
        altPath3.replace("qrc:/qt/qml/VoiceAILLM/", ":/");
        pathsToTry << altPath3;
    }
    if (m_source.startsWith("qrc:/")) {
        QString altPath = m_source;
        altPath.replace("qrc:", ":");
        pathsToTry << altPath;
    }
    
    bool loaded = false;
    for (const QString &path : pathsToTry) {
        qDebug() << "SvgHandler: Trying path:" << path;
        m_renderer->load(path);
        if (m_renderer->isValid()) {
            qDebug() << "SvgHandler: SVG loaded successfully from:" << path;
            loaded = true;
            break;
        } else {
            qDebug() << "SvgHandler: Failed to load from:" << path;
        }
    }
    
    if (loaded) {
        m_svgBounds = m_renderer->viewBoxF();
        qDebug() << "SvgHandler: SVG bounds:" << m_svgBounds;
        parseElements();
        zoomToFit();
    } else {
        qDebug() << "SvgHandler: Failed to load SVG from any attempted path";
    }
}

void SvgHandler::parseElements()
{
    m_elementBounds.clear();
    m_elementIds.clear();
    
    QFile file(m_source);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "SvgHandler: Failed to open file for parsing:" << m_source;
        return;
    }
    
    qDebug() << "SvgHandler: Successfully opened file for parsing, size:" << file.size() << "bytes";
    
    QXmlStreamReader xml(&file);
    QHash<QString, QString> elementContent;
    
    while (!xml.atEnd()) {
        xml.readNext();
        if (xml.isStartElement()) {
            QXmlStreamAttributes attrs = xml.attributes();
            QString id = attrs.value("id").toString();
            
            if (!id.isEmpty()) {
                m_elementIds.append(id);
                
                // Try to get bounds from various attributes
                QRectF bounds;
                QString tagName = xml.name().toString().toLower();
                
                if (tagName == "rect") {
                    bounds = QRectF(
                        attrs.value("x").toDouble(),
                        attrs.value("y").toDouble(),
                        attrs.value("width").toDouble(),
                        attrs.value("height").toDouble()
                    );
                } else if (tagName == "circle") {
                    qreal cx = attrs.value("cx").toDouble();
                    qreal cy = attrs.value("cy").toDouble();
                    qreal r = attrs.value("r").toDouble();
                    bounds = QRectF(cx - r, cy - r, 2 * r, 2 * r);
                } else if (tagName == "ellipse") {
                    qreal cx = attrs.value("cx").toDouble();
                    qreal cy = attrs.value("cy").toDouble();
                    qreal rx = attrs.value("rx").toDouble();
                    qreal ry = attrs.value("ry").toDouble();
                    bounds = QRectF(cx - rx, cy - ry, 2 * rx, 2 * ry);
                }
                // Add more shape types as needed
                
                if (bounds.isValid()) {
                    m_elementBounds[id] = bounds;
                }
            }
        }
    }
}

void SvgHandler::paint(QPainter *painter)
{
    if (!m_renderer->isValid())
        return;
    
    painter->save();
    painter->setRenderHint(QPainter::Antialiasing, true);
    painter->setRenderHint(QPainter::SmoothPixmapTransform, true);
    
    // Apply transform
    painter->setTransform(m_transform);
    
    // Render SVG
    m_renderer->render(painter, m_svgBounds);
    
    // Highlight element if specified
    if (!m_highlightedElement.isEmpty() && m_elementBounds.contains(m_highlightedElement)) {
        painter->setPen(QPen(QColor(255, 0, 0, 180), 2.0 / m_scale));
        painter->setBrush(QBrush(QColor(255, 0, 0, 50)));
        painter->drawRect(m_elementBounds[m_highlightedElement]);
    }
    
    // Highlight hovered element
    if (!m_hoveredElement.isEmpty() && m_elementBounds.contains(m_hoveredElement)) {
        painter->setPen(QPen(QColor(0, 0, 255, 180), 1.0 / m_scale));
        painter->setBrush(QBrush(QColor(0, 0, 255, 30)));
        painter->drawRect(m_elementBounds[m_hoveredElement]);
    }
    
    painter->restore();
}

void SvgHandler::mousePressEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {
        QPointF svgPos = mapToSvg(event->position());
        QString elementId = findElementAt(svgPos);
        
        if (!elementId.isEmpty()) {
            emit elementClicked(elementId, svgPos);
        } else {
            emit svgClicked(svgPos);
        }
        
        if (m_enablePan) {
            m_isPanning = true;
            m_lastPanPoint = event->position();
        }
    }
}

void SvgHandler::mouseMoveEvent(QMouseEvent *event)
{
    if (m_isPanning && m_enablePan) {
        QPointF delta = event->position() - m_lastPanPoint;
        setOffset(m_offset + delta);
        m_lastPanPoint = event->position();
    }
}

void SvgHandler::mouseReleaseEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {
        m_isPanning = false;
    }
}

void SvgHandler::wheelEvent(QWheelEvent *event)
{
    if (m_enableZoom) {
        const qreal scaleFactor = event->angleDelta().y() > 0 ? 1.15 : 1.0 / 1.15;
        
        // Zoom towards mouse position
        QPointF mousePos = event->position();
        QPointF svgPos = mapToSvg(mousePos);
        
        setScale(m_scale * scaleFactor);
        
        // Adjust offset to keep the same point under mouse
        QPointF newScreenPos = mapFromSvg(svgPos);
        setOffset(m_offset + (mousePos - newScreenPos));
    }
}

void SvgHandler::hoverMoveEvent(QHoverEvent *event)
{
    QPointF svgPos = mapToSvg(event->position());
    QString elementId = findElementAt(svgPos);
    
    if (elementId != m_hoveredElement) {
        m_hoveredElement = elementId;
        update();
        
        if (!elementId.isEmpty()) {
            emit elementHovered(elementId, svgPos);
        }
    }
}

QString SvgHandler::findElementAt(const QPointF &position) const
{
    for (auto it = m_elementBounds.constBegin(); it != m_elementBounds.constEnd(); ++it) {
        if (it.value().contains(position)) {
            return it.key();
        }
    }
    return QString();
}

void SvgHandler::updateTransform()
{
    m_transform = QTransform();
    m_transform.translate(m_offset.x(), m_offset.y());
    m_transform.scale(m_scale, m_scale);
    
    emit viewChanged(m_scale, m_offset);
}

QPointF SvgHandler::mapToSvg(const QPointF &point) const
{
    return m_transform.inverted().map(point);
}

QPointF SvgHandler::mapFromSvg(const QPointF &point) const
{
    return m_transform.map(point);
}

void SvgHandler::zoomToFit()
{
    if (!m_renderer->isValid())
        return;
    
    QRectF bounds = m_renderer->viewBoxF();
    if (bounds.isEmpty())
        return;
    
    qreal scaleX = width() / bounds.width();
    qreal scaleY = height() / bounds.height();
    qreal scale = qMin(scaleX, scaleY) * 0.9; // 90% to add padding
    
    setScale(scale);
    
    // Center the SVG
    QPointF center = bounds.center();
    QPointF screenCenter(width() / 2.0, height() / 2.0);
    setOffset(screenCenter - mapFromSvg(center) + m_offset);
}

void SvgHandler::zoomIn()
{
    setScale(m_scale * 1.2);
}

void SvgHandler::zoomOut()
{
    setScale(m_scale / 1.2);
}

void SvgHandler::resetView()
{
    setScale(1.0);
    setOffset(QPointF(0, 0));
}

QStringList SvgHandler::getElementIds() const
{
    return m_elementIds;
}

QRectF SvgHandler::getElementBounds(const QString &elementId) const
{
    return m_elementBounds.value(elementId);
}

void SvgHandler::setElementProperty(const QString &elementId, const QString &property, const QVariant &value)
{
    // This would require modifying the SVG DOM, which is complex
    // For now, we'll just trigger an update
    Q_UNUSED(elementId)
    Q_UNUSED(property)
    Q_UNUSED(value)
    
    // Implementation would involve XML manipulation
    update();
}

void SvgHandler::onRendererRepaintNeeded()
{
    update();
}