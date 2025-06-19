#ifndef NEXTGENCSVVIEWER_H
#define NEXTGENCSVVIEWER_H

#include <QObject>
#include <QAbstractTableModel>
#include <QUrl>
#include <QVariant>
#include <QStringList>
#include <QVector>
#include <QColor>
#include <QString>
#include <QVariantList>
#include <QVariantMap>
#include <QSet>
#include <QPointF>
#include <QTimer>

class NextGenCSVViewer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentFileName READ currentFileName NOTIFY currentFileNameChanged)
    Q_PROPERTY(bool isFileLoaded READ isFileLoaded NOTIFY isFileLoadedChanged)
    Q_PROPERTY(int totalRows READ totalRows NOTIFY totalRowsChanged)
    Q_PROPERTY(int totalColumns READ totalColumns NOTIFY totalColumnsChanged)
    Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusMessageChanged)
    Q_PROPERTY(bool isLoading READ isLoading NOTIFY isLoadingChanged)
    Q_PROPERTY(qreal xAxisMin READ xAxisMin NOTIFY axisRangeChanged)
    Q_PROPERTY(qreal xAxisMax READ xAxisMax NOTIFY axisRangeChanged)
    Q_PROPERTY(qreal yAxisMin READ yAxisMin NOTIFY axisRangeChanged)
    Q_PROPERTY(qreal yAxisMax READ yAxisMax NOTIFY axisRangeChanged)
    Q_PROPERTY(QVariantList seriesData READ seriesData NOTIFY seriesDataChanged)
    Q_PROPERTY(QVariantList seriesNames READ seriesNames NOTIFY seriesNamesChanged)
    Q_PROPERTY(QVariantList seriesColors READ seriesColors NOTIFY seriesColorsChanged)
    Q_PROPERTY(QVariantList seriesVisibility READ seriesVisibility NOTIFY seriesVisibilityChanged)
    Q_PROPERTY(bool isRealTimeDemoActive READ isRealTimeDemoActive NOTIFY realTimeDemoActiveChanged)

public:
    explicit NextGenCSVViewer(QObject *parent = nullptr);

    // Property getters
    QString currentFileName() const { return m_currentFileName; }
    bool isFileLoaded() const { return m_isFileLoaded; }
    int totalRows() const { return m_totalRows; }
    int totalColumns() const { return m_totalColumns; }
    QString statusMessage() const { return m_statusMessage; }
    bool isLoading() const { return m_isLoading; }
    qreal xAxisMin() const { return m_xAxisMin; }
    qreal xAxisMax() const { return m_xAxisMax; }
    qreal yAxisMin() const { return m_yAxisMin; }
    qreal yAxisMax() const { return m_yAxisMax; }
    QVariantList seriesData() const { return m_seriesData; }
    QVariantList seriesNames() const { return m_seriesNames; }
    QVariantList seriesColors() const { return m_seriesColors; }
    QVariantList seriesVisibility() const { return m_seriesVisibility; }
    bool isRealTimeDemoActive() const { return m_realTimeDemoActive; }

    // Data access methods for QML
    Q_INVOKABLE QVariantList getHeaders();
    Q_INVOKABLE QVariantList getDataRow(int row);
    Q_INVOKABLE QVariantList getDataColumn(int column);
    Q_INVOKABLE QVariant getDataValue(int row, int column);
    Q_INVOKABLE QVariantMap getDataSummary();
    Q_INVOKABLE QVariantList getSeriesDataPoints(int seriesIndex);
    Q_INVOKABLE void updateAxisRanges();
    Q_INVOKABLE void autoScaleAxes();

public slots:
    void loadFile(const QUrl &fileUrl);
    void resetChart();
    void toggleSeries(int seriesIndex, bool visible);
    void setSeriesColor(int seriesIndex, const QColor &color);
    void filterData(qreal minTime, qreal maxTime);
    void clearFilter();
    void exportChart(const QString &format);
    void exportData();
    void onChartHovered(int seriesIndex, qreal x, qreal y, bool state);
    void onChartZoomed(qreal minX, qreal maxX, qreal minY, qreal maxY);
    void highlightDataPoint(qreal time);
    void setAxisRange(qreal xMin, qreal xMax, qreal yMin, qreal yMax);

    // Real-time demo functionality
    void startRealTimeDemo();
    void stopRealTimeDemo();
    void pauseRealTimeDemo();
    void resumeRealTimeDemo();

signals:
    void currentFileNameChanged();
    void isFileLoadedChanged();
    void totalRowsChanged();
    void totalColumnsChanged();
    void statusMessageChanged();
    void isLoadingChanged();
    void axisRangeChanged();
    void seriesDataChanged();
    void seriesNamesChanged();
    void seriesColorsChanged();
    void seriesVisibilityChanged();
    void dataPointHovered(int seriesIndex, qreal x, qreal y);
    void zoomChanged(qreal minX, qreal maxX, qreal minY, qreal maxY);
    void timelineHighlighted(qreal time);
    void realTimeDemoActiveChanged();

private slots:
    void updateRealTimeData();

private:
    void parseCSVFile();
    void calculateAxisRanges();
    void generateSeriesData();
    void updateSeriesVisibility();
    QColor generateSeriesColor(int index);
    void generateRealTimeData();

    // Data storage
    QString m_currentFileName;
    QStringList m_headers;
    QVector<QStringList> m_data;
    bool m_isFileLoaded;
    bool m_isLoading;
    int m_totalRows;
    int m_totalColumns;
    QString m_statusMessage;

    // Chart data
    qreal m_xAxisMin;
    qreal m_xAxisMax;
    qreal m_yAxisMin;
    qreal m_yAxisMax;
    QVariantList m_seriesData;
    QVariantList m_seriesNames;
    QVariantList m_seriesColors;
    QVariantList m_seriesVisibility;

    // Filter settings
    qreal m_filterMinTime;
    qreal m_filterMaxTime;
    bool m_filterEnabled;

    // Real-time demo
    QTimer *m_realTimeTimer;
    bool m_realTimeDemoActive;
    int m_realTimeIndex;
    QVector<QList<QPointF>> m_realTimeSeriesData;
    static const int REAL_TIME_SERIES_COUNT = 16;
    static const int REAL_TIME_WINDOW_SIZE = 60;
};

#endif // NEXTGENCSVVIEWER_H 