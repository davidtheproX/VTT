#include "NextGenCSVViewer.h"
#include <QFile>
#include <QTextStream>
#include <QUrl>
#include <QDebug>
#include <QStandardPaths>
#include <QDir>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtMath>
#include <algorithm>

NextGenCSVViewer::NextGenCSVViewer(QObject *parent)
    : QObject(parent)
    , m_isFileLoaded(false)
    , m_isLoading(false)
    , m_totalRows(0)
    , m_totalColumns(0)
    , m_xAxisMin(0.0)
    , m_xAxisMax(100.0)
    , m_yAxisMin(0.0)
    , m_yAxisMax(100.0)
    , m_filterMinTime(0.0)
    , m_filterMaxTime(0.0)
    , m_filterEnabled(false)
    , m_realTimeTimer(new QTimer(this))
    , m_realTimeDemoActive(false)
    , m_realTimeIndex(0)
{
    // Initialize real-time series data
    m_realTimeSeriesData.resize(REAL_TIME_SERIES_COUNT);
    
    // Connect real-time timer
    connect(m_realTimeTimer, &QTimer::timeout, this, &NextGenCSVViewer::updateRealTimeData);
    
    // Set status message
    m_statusMessage = "Ready - No file loaded";
}

QVariantList NextGenCSVViewer::getHeaders()
{
    QVariantList headers;
    for (const QString &header : m_headers) {
        headers.append(header);
    }
    return headers;
}

QVariantList NextGenCSVViewer::getDataRow(int row)
{
    QVariantList rowData;
    if (row >= 0 && row < m_data.size()) {
        for (const QString &value : m_data[row]) {
            rowData.append(value);
        }
    }
    return rowData;
}

QVariantList NextGenCSVViewer::getDataColumn(int column)
{
    QVariantList columnData;
    if (column >= 0 && column < m_totalColumns) {
        for (const QStringList &row : m_data) {
            if (column < row.size()) {
                columnData.append(row[column]);
            }
        }
    }
    return columnData;
}

QVariant NextGenCSVViewer::getDataValue(int row, int column)
{
    if (row >= 0 && row < m_data.size() && column >= 0 && column < m_data[row].size()) {
        return m_data[row][column];
    }
    return QVariant();
}

QVariantMap NextGenCSVViewer::getDataSummary()
{
    QVariantMap summary;
    summary["rows"] = m_totalRows;
    summary["columns"] = m_totalColumns;
    summary["headers"] = getHeaders();
    
    // Calculate basic statistics for numeric columns
    QVariantList columnStats;
    for (int col = 0; col < m_totalColumns; ++col) {
        QVariantMap colStat;
        colStat["name"] = col < m_headers.size() ? m_headers[col] : QString("Column %1").arg(col);
        
        double min = std::numeric_limits<double>::max();
        double max = std::numeric_limits<double>::lowest();
        double sum = 0;
        int count = 0;
        
        for (const auto &row : m_data) {
            if (col < row.size()) {
                bool ok;
                double value = row[col].toDouble(&ok);
                if (ok) {
                    min = qMin(min, value);
                    max = qMax(max, value);
                    sum += value;
                    count++;
                }
            }
        }
        
        if (count > 0) {
            colStat["min"] = min;
            colStat["max"] = max;
            colStat["avg"] = sum / count;
            colStat["isNumeric"] = true;
        } else {
            colStat["isNumeric"] = false;
        }
        
        columnStats.append(colStat);
    }
    
    summary["columnStats"] = columnStats;
    return summary;
}

QVariantList NextGenCSVViewer::getSeriesDataPoints(int seriesIndex)
{
    QVariantList points;
    if (seriesIndex >= 0 && seriesIndex < m_seriesData.size()) {
        points = m_seriesData[seriesIndex].toList();
    }
    return points;
}

void NextGenCSVViewer::loadFile(const QUrl &fileUrl)
{
    if (m_isLoading) {
        return;
    }
    
    m_isLoading = true;
    emit isLoadingChanged();
    
    QString filePath = fileUrl.toLocalFile();
    m_currentFileName = QFileInfo(filePath).fileName();
    emit currentFileNameChanged();
    
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        m_statusMessage = QString("Error: Could not open file - %1").arg(file.errorString());
        emit statusMessageChanged();
        m_isLoading = false;
        emit isLoadingChanged();
        return;
    }
    
    // Clear previous data
    m_data.clear();
    m_headers.clear();
    m_seriesData.clear();
    m_seriesNames.clear();
    m_seriesColors.clear();
    m_seriesVisibility.clear();
    
    QTextStream stream(&file);
    bool firstLine = true;
    m_totalRows = 0;
    m_totalColumns = 0;
    
    // Parse CSV file
    while (!stream.atEnd()) {
        QString line = stream.readLine().trimmed();
        if (line.isEmpty()) continue;
        
        QStringList fields = line.split(',');
        
        if (firstLine) {
            m_headers = fields;
            m_totalColumns = fields.size();
            firstLine = false;
        } else {
            // Ensure all rows have the same number of columns
            while (fields.size() < m_totalColumns) {
                fields.append("");
            }
            m_data.append(fields);
            m_totalRows++;
        }
    }
    
    file.close();
    
    // Generate chart data
    generateSeriesData();
    calculateAxisRanges();
    
    m_isFileLoaded = true;
    m_statusMessage = QString("Loaded %1 rows, %2 columns").arg(m_totalRows).arg(m_totalColumns);
    
    emit isFileLoadedChanged();
    emit totalRowsChanged();
    emit totalColumnsChanged();
    emit statusMessageChanged();
    emit seriesDataChanged();
    emit seriesNamesChanged();
    emit seriesColorsChanged();
    emit seriesVisibilityChanged();
    emit axisRangeChanged();
    
    m_isLoading = false;
    emit isLoadingChanged();
}

void NextGenCSVViewer::generateSeriesData()
{
    if (m_data.isEmpty() || m_headers.isEmpty()) {
        return;
    }
    
    m_seriesData.clear();
    m_seriesNames.clear();
    m_seriesColors.clear();
    m_seriesVisibility.clear();
    
    // Find numeric columns (excluding first column which is typically time/index)
    QList<int> numericColumns;
    for (int col = 1; col < m_totalColumns; ++col) {
        bool isNumeric = true;
        int numericCount = 0;
        
        // Check first 10 rows to determine if column is numeric
        for (int row = 0; row < qMin(10, m_totalRows); ++row) {
            if (col < m_data[row].size()) {
                bool ok;
                m_data[row][col].toDouble(&ok);
                if (ok) {
                    numericCount++;
                }
            }
        }
        
        // Consider column numeric if >70% of checked values are numeric
        if (numericCount >= 7) {
            numericColumns.append(col);
        }
    }
    
    // Generate series for numeric columns
    for (int i = 0; i < numericColumns.size(); ++i) {
        int col = numericColumns[i];
        QString seriesName = col < m_headers.size() ? m_headers[col] : QString("Series %1").arg(i + 1);
        
        QVariantList seriesPoints;
        
        for (int row = 0; row < m_totalRows; ++row) {
            if (col < m_data[row].size()) {
                bool okX = true, okY = true;
                double x = row; // Use row index as X by default
                double y = m_data[row][col].toDouble(&okY);
                
                // Try to use first column as X if it's numeric
                if (m_data[row].size() > 0) {
                    double firstColValue = m_data[row][0].toDouble(&okX);
                    if (okX) {
                        x = firstColValue;
                    }
                }
                
                if (okY) {
                    QVariantMap point;
                    point["x"] = x;
                    point["y"] = y;
                    seriesPoints.append(point);
                }
            }
        }
        
        m_seriesData.append(seriesPoints);
        m_seriesNames.append(seriesName);
        m_seriesColors.append(generateSeriesColor(i));
        m_seriesVisibility.append(true);
    }
}

void NextGenCSVViewer::calculateAxisRanges()
{
    if (m_seriesData.isEmpty()) {
        m_xAxisMin = 0.0;
        m_xAxisMax = 100.0;
        m_yAxisMin = 0.0;
        m_yAxisMax = 100.0;
        return;
    }
    
    double minX = std::numeric_limits<double>::max();
    double maxX = std::numeric_limits<double>::lowest();
    double minY = std::numeric_limits<double>::max();
    double maxY = std::numeric_limits<double>::lowest();
    
    for (const QVariant &seriesVar : m_seriesData) {
        QVariantList series = seriesVar.toList();
        for (const QVariant &pointVar : series) {
            QVariantMap point = pointVar.toMap();
            double x = point["x"].toDouble();
            double y = point["y"].toDouble();
            
            minX = qMin(minX, x);
            maxX = qMax(maxX, x);
            minY = qMin(minY, y);
            maxY = qMax(maxY, y);
        }
    }
    
    // Add 5% padding to ranges
    double xRange = maxX - minX;
    double yRange = maxY - minY;
    
    if (xRange > 0) {
        m_xAxisMin = minX - xRange * 0.05;
        m_xAxisMax = maxX + xRange * 0.05;
    } else {
        m_xAxisMin = minX - 1.0;
        m_xAxisMax = maxX + 1.0;
    }
    
    if (yRange > 0) {
        m_yAxisMin = minY - yRange * 0.05;
        m_yAxisMax = maxY + yRange * 0.05;
    } else {
        m_yAxisMin = minY - 1.0;
        m_yAxisMax = maxY + 1.0;
    }
}

QColor NextGenCSVViewer::generateSeriesColor(int index)
{
    // Generate colors using golden ratio for good distribution
    static const QList<QColor> predefinedColors = {
        QColor("#FF4444"), QColor("#44FF44"), QColor("#4444FF"), QColor("#FFAA44"),
        QColor("#AA44FF"), QColor("#44AAFF"), QColor("#FF8844"), QColor("#44FF88"),
        QColor("#8844FF"), QColor("#FFFF44"), QColor("#FF44AA"), QColor("#44FFAA"),
        QColor("#FF6644"), QColor("#66FF44"), QColor("#4466FF"), QColor("#AAFF44")
    };
    
    if (index < predefinedColors.size()) {
        return predefinedColors[index];
    }
    
    // Generate color using golden ratio
    double goldenRatio = 0.618033988749895;
    double hue = fmod(index * goldenRatio, 1.0);
    return QColor::fromHsvF(hue, 0.85, 0.9);
}

void NextGenCSVViewer::updateAxisRanges()
{
    calculateAxisRanges();
    emit axisRangeChanged();
}

void NextGenCSVViewer::autoScaleAxes()
{
    updateAxisRanges();
}

void NextGenCSVViewer::resetChart()
{
    updateAxisRanges();
    clearFilter();
    
    // Reset all series visibility
    for (int i = 0; i < m_seriesVisibility.size(); ++i) {
        m_seriesVisibility[i] = true;
    }
    emit seriesVisibilityChanged();
    
    qDebug() << "NextGen chart reset";
}

void NextGenCSVViewer::toggleSeries(int seriesIndex, bool visible)
{
    if (seriesIndex >= 0 && seriesIndex < m_seriesVisibility.size()) {
        m_seriesVisibility[seriesIndex] = visible;
        emit seriesVisibilityChanged();
        qDebug() << "NextGen toggle series:" << seriesIndex << visible;
    }
}

void NextGenCSVViewer::setSeriesColor(int seriesIndex, const QColor &color)
{
    if (seriesIndex >= 0 && seriesIndex < m_seriesColors.size()) {
        m_seriesColors[seriesIndex] = color;
        emit seriesColorsChanged();
        qDebug() << "NextGen set series color:" << seriesIndex << color;
    }
}

void NextGenCSVViewer::filterData(qreal minTime, qreal maxTime)
{
    m_filterMinTime = minTime;
    m_filterMaxTime = maxTime;
    m_filterEnabled = true;
    
    // TODO: Apply filter to series data
    emit seriesDataChanged();
    
    qDebug() << "NextGen filter data:" << minTime << maxTime;
}

void NextGenCSVViewer::clearFilter()
{
    m_filterEnabled = false;
    m_filterMinTime = 0.0;
    m_filterMaxTime = 0.0;
    
    // TODO: Remove filter from series data
    emit seriesDataChanged();
    
    qDebug() << "NextGen clear filter";
}

void NextGenCSVViewer::exportChart(const QString &format)
{
    // TODO: Implement chart export functionality
    qDebug() << "NextGen export chart:" << format;
}

void NextGenCSVViewer::exportData()
{
    // TODO: Implement data export functionality
    qDebug() << "NextGen export data";
}

void NextGenCSVViewer::onChartHovered(int seriesIndex, qreal x, qreal y, bool state)
{
    if (state) {
        emit dataPointHovered(seriesIndex, x, y);
    }
    qDebug() << "NextGen chart hovered:" << seriesIndex << x << y << state;
}

void NextGenCSVViewer::onChartZoomed(qreal minX, qreal maxX, qreal minY, qreal maxY)
{
    m_xAxisMin = minX;
    m_xAxisMax = maxX;
    m_yAxisMin = minY;
    m_yAxisMax = maxY;
    
    emit axisRangeChanged();
    emit zoomChanged(minX, maxX, minY, maxY);
    
    qDebug() << "NextGen chart zoomed:" << minX << maxX << minY << maxY;
}

void NextGenCSVViewer::highlightDataPoint(qreal time)
{
    emit timelineHighlighted(time);
    qDebug() << "NextGen highlight data point:" << time;
}

void NextGenCSVViewer::setAxisRange(qreal xMin, qreal xMax, qreal yMin, qreal yMax)
{
    m_xAxisMin = xMin;
    m_xAxisMax = xMax;
    m_yAxisMin = yMin;
    m_yAxisMax = yMax;
    emit axisRangeChanged();
}

void NextGenCSVViewer::startRealTimeDemo()
{
    if (m_realTimeDemoActive) {
#ifdef QT_DEBUG
        qDebug() << "NextGen real-time demo already active, ignoring";
#endif
        return;
    }
    
#ifdef QT_DEBUG
    qDebug() << "=== STARTING NextGen Real-Time Demo ===";
#endif
    
    m_realTimeDemoActive = true;
    m_realTimeIndex = 0;
    emit realTimeDemoActiveChanged();
    
    // Clear previous data
    for (auto &series : m_realTimeSeriesData) {
        series.clear();
    }
#ifdef QT_DEBUG
    qDebug() << "Cleared previous real-time series data";
#endif
    
    // Initialize series
    m_seriesData.clear();
    m_seriesNames.clear();
    m_seriesColors.clear();
    m_seriesVisibility.clear();
    
    QStringList seriesNames = {
        "Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta",
        "Iota", "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi"
    };
    
#ifdef QT_DEBUG
    qDebug() << "Initializing" << REAL_TIME_SERIES_COUNT << "series";
#endif
    for (int i = 0; i < REAL_TIME_SERIES_COUNT; ++i) {
        // Create series with initial point so it's not empty
        QVariantList initialSeriesPoints;
        QVariantMap initialPoint;
        initialPoint["x"] = 0.0;
        initialPoint["y"] = 100.0 + i * 10.0;
        initialSeriesPoints.append(initialPoint);
        
        m_seriesData.append(initialSeriesPoints);
        m_seriesNames.append(seriesNames[i]);
        m_seriesColors.append(generateSeriesColor(i));
        m_seriesVisibility.append(true);
#ifdef QT_DEBUG
        qDebug() << "  Series" << i << ":" << seriesNames[i] << "initialized with" << initialSeriesPoints.size() << "points";
#endif
    }
    
#ifdef QT_DEBUG
    qDebug() << "Final series counts: seriesData=" << m_seriesData.size() 
             << "seriesNames=" << m_seriesNames.size()
             << "seriesColors=" << m_seriesColors.size()
             << "seriesVisibility=" << m_seriesVisibility.size();
#endif
    
    // Set demo axis ranges
    m_xAxisMin = 0.0;
    m_xAxisMax = REAL_TIME_WINDOW_SIZE;
    m_yAxisMin = 0.0;
    m_yAxisMax = 300.0;
#ifdef QT_DEBUG
    qDebug() << "Set axis ranges: X=[" << m_xAxisMin << "," << m_xAxisMax << "] Y=[" << m_yAxisMin << "," << m_yAxisMax << "]";
#endif
    
    // Start timer (1ms like Qt version)
    m_realTimeTimer->start(1);
#ifdef QT_DEBUG
    qDebug() << "Started real-time timer with 1ms interval";
#endif
    
    m_statusMessage = "Real-time demo running (16 series)";
    m_currentFileName = "Real-Time Demo";
    m_isFileLoaded = true;
    
#ifdef QT_DEBUG
    qDebug() << "Emitting all change signals...";
#endif
    emit currentFileNameChanged();
    emit isFileLoadedChanged();
    emit statusMessageChanged();
    emit seriesDataChanged();
    emit seriesNamesChanged();
    emit seriesColorsChanged();
    emit seriesVisibilityChanged();
    emit axisRangeChanged();
    
#ifdef QT_DEBUG
    qDebug() << "=== NextGen real-time demo started successfully ===";
#endif
}

void NextGenCSVViewer::stopRealTimeDemo()
{
    if (!m_realTimeDemoActive) {
        return;
    }
    
    m_realTimeDemoActive = false;
    m_realTimeTimer->stop();
    emit realTimeDemoActiveChanged();
    
    m_statusMessage = "Real-time demo stopped";
    emit statusMessageChanged();
    
#ifdef QT_DEBUG
    qDebug() << "NextGen real-time demo stopped";
#endif
}

void NextGenCSVViewer::pauseRealTimeDemo()
{
    if (m_realTimeDemoActive) {
        m_realTimeTimer->stop();
        m_statusMessage = "Real-time demo paused";
        emit statusMessageChanged();
    }
}

void NextGenCSVViewer::resumeRealTimeDemo()
{
    if (m_realTimeDemoActive) {
        m_realTimeTimer->start(1);
        m_statusMessage = "Real-time demo running (16 series)";
        emit statusMessageChanged();
    }
}

void NextGenCSVViewer::updateRealTimeData()
{
    if (!m_realTimeDemoActive) {
        return;
    }
    
    m_realTimeIndex++;
    double p = m_realTimeIndex * 0.1;
    
    // Generate data using exact Qt formulas
    QVector<double> values(REAL_TIME_SERIES_COUNT);
    values[0] = 20 + qCos(p * 129241) * 10 + 1 / (qCos(p) * qCos(p) + 0.01);
    values[1] = 150 + 100 * qSin(p / 27.7) * qSin(p / 10.1);
    values[2] = 150 + 100 * qCos(p / 6.7) * qCos(p / 11.9);
    values[3] = 80 + 60 * qSin(p / 15.3) * qCos(p / 8.2);
    values[4] = 120 + 80 * qCos(p / 12.4) * qSin(p / 20.1);
    values[5] = 90 + 70 * qSin(p / 18.7) + 20 * qCos(p * 3.1);
    values[6] = 160 + 90 * qCos(p / 9.8) * qCos(p / 14.3);
    values[7] = 110 + 85 * qSin(p / 22.5) * qSin(p / 7.9);
    values[8] = 140 + 95 * qCos(p / 16.2) + 15 * qSin(p * 2.4);
    values[9] = 75 + 65 * qSin(p / 11.7) * qCos(p / 19.8);
    values[10] = 185 + 110 * qCos(p / 13.9) * qSin(p / 6.4);
    values[11] = 95 + 75 * qSin(p / 21.3) + 25 * qCos(p * 1.8);
    values[12] = 130 + 88 * qCos(p / 8.6) * qCos(p / 17.2);
    values[13] = 105 + 78 * qSin(p / 14.8) * qSin(p / 9.5);
    values[14] = 170 + 100 * qCos(p / 10.4) + 30 * qSin(p * 2.9);
    values[15] = 85 + 68 * qSin(p / 24.1) * qCos(p / 5.7);
    
    // Debug: Log values periodically
    static int debugCounter = 0;
#ifdef QT_DEBUG
    if (debugCounter % 1000 == 0) {
        qDebug() << "=== UPDATE Real-Time Data (index:" << m_realTimeIndex << ") ===";
        qDebug() << "Generated values[0-3]:" << values[0] << values[1] << values[2] << values[3];
        qDebug() << "Current m_seriesData.size():" << m_seriesData.size();
    }
#endif
    
    // Update series data
    for (int i = 0; i < REAL_TIME_SERIES_COUNT; ++i) {
        QPointF newPoint(m_realTimeIndex, values[i]);
        m_realTimeSeriesData[i].append(newPoint);
        
        // Maintain sliding window
        if (m_realTimeSeriesData[i].size() > REAL_TIME_WINDOW_SIZE) {
            m_realTimeSeriesData[i].removeFirst();
        }
        
        // Convert to QVariantList for QML - use QVariantMap approach with explicit conversion
        QVariantList seriesPoints;
        for (const QPointF &point : m_realTimeSeriesData[i]) {
            QVariantMap pointObj;
            pointObj["x"] = point.x();
            pointObj["y"] = point.y();
            seriesPoints.append(pointObj);
        }
        
        if (i < m_seriesData.size()) {
            m_seriesData[i] = seriesPoints;
            
#ifdef QT_DEBUG
            // Debug: Log series info periodically with detailed structure
            if (debugCounter % 1000 == 0 && i < 4) {
                qDebug() << "  Series" << i << "has" << seriesPoints.size() << "points";
                if (!seriesPoints.isEmpty()) {
                    auto firstPoint = seriesPoints[0];
                    qDebug() << "    First point type:" << firstPoint.typeName() << "value:" << firstPoint;
                    if (firstPoint.canConvert<QVariantMap>()) {
                        auto map = firstPoint.toMap();
                        qDebug() << "    First point as map: x=" << map["x"] << "y=" << map["y"];
                    }
                }
            }
#endif
        } else {
#ifdef QT_DEBUG
            if (debugCounter % 1000 == 0) {
                qDebug() << "  WARNING: Series" << i << "index >= m_seriesData.size()" << m_seriesData.size();
            }
#endif
        }
    }
    debugCounter++;
    
    // Update X axis range for sliding window
    if (m_realTimeIndex > REAL_TIME_WINDOW_SIZE) {
        m_xAxisMin = m_realTimeIndex - REAL_TIME_WINDOW_SIZE;
        m_xAxisMax = m_realTimeIndex;
        emit axisRangeChanged();
    }
    
    emit seriesDataChanged();
} 