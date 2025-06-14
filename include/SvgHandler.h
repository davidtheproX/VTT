#pragma once

#include <QQuickPaintedItem>
#include <QSvgRenderer>
#include <QPainter>
#include <QMouseEvent>
#include <QWheelEvent>
#include <QXmlStreamReader>
#include <QHash>
#include <QRectF>
#include <QPointF>
#include <QQmlEngine>

class SvgHandler : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(qreal scale READ scale WRITE setScale NOTIFY scaleChanged)
    Q_PROPERTY(QPointF offset READ offset WRITE setOffset NOTIFY offsetChanged)
    Q_PROPERTY(QString highlightedElement READ highlightedElement WRITE setHighlightedElement NOTIFY highlightedElementChanged)
    Q_PROPERTY(bool enableZoom READ enableZoom WRITE setEnableZoom NOTIFY enableZoomChanged)
    Q_PROPERTY(bool enablePan READ enablePan WRITE setEnablePan NOTIFY enablePanChanged)
    
public:
    explicit SvgHandler(QQuickItem *parent = nullptr);
    
    // Property getters
    QString source() const { return m_source; }
    qreal scale() const { return m_scale; }
    QPointF offset() const { return m_offset; }
    QString highlightedElement() const { return m_highlightedElement; }
    bool enableZoom() const { return m_enableZoom; }
    bool enablePan() const { return m_enablePan; }
    
    // Property setters
    void setSource(const QString &source);
    void setScale(qreal scale);
    void setOffset(const QPointF &offset);
    void setHighlightedElement(const QString &element);
    void setEnableZoom(bool enable);
    void setEnablePan(bool enable);
    
    // QML callable methods
    Q_INVOKABLE void zoomToFit();
    Q_INVOKABLE void zoomIn();
    Q_INVOKABLE void zoomOut();
    Q_INVOKABLE void resetView();
    Q_INVOKABLE QStringList getElementIds() const;
    Q_INVOKABLE QRectF getElementBounds(const QString &elementId) const;
    Q_INVOKABLE void setElementProperty(const QString &elementId, const QString &property, const QVariant &value);
    Q_INVOKABLE QPointF mapToSvg(const QPointF &point) const;
    Q_INVOKABLE QPointF mapFromSvg(const QPointF &point) const;
    
protected:
    void paint(QPainter *painter) override;
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;
    void wheelEvent(QWheelEvent *event) override;
    void hoverMoveEvent(QHoverEvent *event) override;
    
signals:
    void sourceChanged();
    void scaleChanged();
    void offsetChanged();
    void highlightedElementChanged();
    void enableZoomChanged();
    void enablePanChanged();
    
    // Interaction signals
    void elementClicked(const QString &elementId, const QPointF &position);
    void elementHovered(const QString &elementId, const QPointF &position);
    void elementDoubleClicked(const QString &elementId, const QPointF &position);
    void svgClicked(const QPointF &position);
    void viewChanged(qreal scale, const QPointF &offset);
    
private slots:
    void onRendererRepaintNeeded();
    
private:
    void loadSvg();
    void parseElements();
    QString findElementAt(const QPointF &position) const;
    QRectF calculateElementBounds(const QString &elementId) const;
    void updateTransform();
    
    QSvgRenderer *m_renderer;
    QString m_source;
    qreal m_scale;
    QPointF m_offset;
    QString m_highlightedElement;
    bool m_enableZoom;
    bool m_enablePan;
    
    // Interaction state
    bool m_isPanning;
    QPointF m_lastPanPoint;
    QHash<QString, QRectF> m_elementBounds;
    QStringList m_elementIds;
    QString m_hoveredElement;
    
    // Transform matrix for coordinate mapping
    QTransform m_transform;
    QRectF m_svgBounds;
};