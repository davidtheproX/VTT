#include "CSVViewer.h"
#include <QUrl>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QFileInfo>
#include <QStandardPaths>
#include <QJsonObject>
#include <QJsonArray>

CSVViewer::CSVViewer(QObject *parent)
    : QObject(parent)
    , m_isFileLoaded(false)
    , m_totalRows(0)
    , m_totalColumns(0)
    , m_isLoading(false)
{
}

void CSVViewer::loadFile(const QUrl &fileUrl)
{
    QString filePath = fileUrl.toLocalFile();
    qDebug() << "Loading CSV file:" << filePath;
    
    setIsLoading(true);
    setStatusMessage("Loading file...");
    
    QFileInfo fileInfo(filePath);
    setCurrentFileName(fileInfo.fileName());
    
    if (parseCSVFile(filePath)) {
        setIsFileLoaded(true);
        setStatusMessage("File loaded successfully");
        emit fileLoaded();
    } else {
        setIsFileLoaded(false);
        setStatusMessage("Failed to load file");
        emit loadError("Failed to parse CSV file");
    }
    
    setIsLoading(false);
}

bool CSVViewer::parseCSVFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open file:" << filePath;
        return false;
    }
    
    QTextStream in(&file);
    QVector<QVector<QVariant>> data;
    QStringList headers;
    
    // Detect CSV format and find actual data start
    QStringList allLines;
    while (!in.atEnd()) {
        allLines.append(in.readLine());
    }
    
    int dataStartLine = findDataStartLine(allLines);
    qDebug() << "Data starts at line:" << dataStartLine;
    
    // Parse headers
    if (dataStartLine > 0 && dataStartLine < allLines.size()) {
        // For complex automotive files, try to extract meaningful column names
        if (isAutomotiveDiagnosticFormat(allLines)) {
            headers = parseAutomotiveHeaders(allLines, dataStartLine);
        } else {
            // Standard CSV parsing
            QString headerLine = allLines[dataStartLine - 1];
            headers = parseCSVLine(headerLine);
        }
        
        setTotalColumns(headers.size());
        m_headers = headers;
        
        // Parse data lines
        for (int i = dataStartLine; i < allLines.size(); ++i) {
            QString line = allLines[i].trimmed();
            if (line.isEmpty()) continue;
            
            QVector<QVariant> row;
            if (isAutomotiveDiagnosticFormat(allLines)) {
                row = parseAutomotiveDataRow(line, headers.size());
            } else {
                QStringList values = parseCSVLine(line);
                for (int j = 0; j < values.size() && j < headers.size(); ++j) {
                    // Try to parse as number first
                    bool ok;
                    double numValue = values[j].toDouble(&ok);
                    if (ok && !values[j].isEmpty()) {
                        row.append(numValue);
                    } else {
                        row.append(values[j]);
                    }
                }
            }
            
            // Ensure row has correct number of columns
            while (row.size() < headers.size()) {
                row.append(QVariant());
            }
            if (row.size() > headers.size()) {
                row = row.mid(0, headers.size());
            }
            
            data.append(row);
        }
    } else {
        // Fallback: treat first line as headers
        if (!allLines.isEmpty()) {
            headers = parseCSVLine(allLines[0]);
            setTotalColumns(headers.size());
            m_headers = headers;
            
            for (int i = 1; i < allLines.size(); ++i) {
                QString line = allLines[i].trimmed();
                if (line.isEmpty()) continue;
                
                QStringList values = parseCSVLine(line);
                QVector<QVariant> row;
                for (int j = 0; j < values.size() && j < headers.size(); ++j) {
                    bool ok;
                    double numValue = values[j].toDouble(&ok);
                    if (ok && !values[j].isEmpty()) {
                        row.append(numValue);
                    } else {
                        row.append(values[j]);
                    }
                }
                
                while (row.size() < headers.size()) {
                    row.append(QVariant());
                }
                data.append(row);
            }
        }
    }
    
    setTotalRows(data.size());
    m_data = data;
    
    qDebug() << "Loaded CSV:" << m_totalRows << "rows," << m_totalColumns << "columns";
    qDebug() << "Headers:" << m_headers;
    return true;
}

int CSVViewer::findDataStartLine(const QStringList &lines)
{
    // Look for patterns that indicate actual data rows
    for (int i = 0; i < lines.size(); ++i) {
        QString line = lines[i].trimmed();
        
        // Skip empty lines
        if (line.isEmpty()) continue;
        
        // Skip obvious metadata lines
        if (line.startsWith("VIN ") || line.startsWith("Model ") || 
            line.startsWith("Log ") || line.startsWith("IIDControl ")) {
            continue;
        }
        
        // Look for lines that start with quoted values (actual data)
        if (line.startsWith("\"") && line.contains(",")) {
            // Check if this looks like a data row (has numeric values)
            QStringList parts = parseCSVLine(line);
            bool hasNumericData = false;
            for (const QString &part : parts) {
                bool ok;
                part.toDouble(&ok);
                if (ok && !part.isEmpty()) {
                    hasNumericData = true;
                    break;
                }
            }
            if (hasNumericData) {
                return i;
            }
        }
    }
    
    // Fallback: assume data starts after first 5 lines or at line with most commas
    int maxCommas = 0;
    int bestLine = 0;
    
    for (int i = 0; i < qMin(lines.size(), 20); ++i) {
        int commas = lines[i].count(',');
        if (commas > maxCommas) {
            maxCommas = commas;
            bestLine = i;
        }
    }
    
    return qMax(bestLine, 1); // Never return 0, always skip at least first line
}

bool CSVViewer::isAutomotiveDiagnosticFormat(const QStringList &lines)
{
    // Check for automotive diagnostic indicators
    for (const QString &line : lines.mid(0, qMin(lines.size(), 10))) {
        if (line.contains("Live Value Name") || line.contains("Engine RPM") ||
            line.contains("Boost") || line.contains("Fuel Rail") ||
            line.contains("IIDControl") || line.contains("VIN ")) {
            return true;
        }
    }
    return false;
}

QStringList CSVViewer::parseAutomotiveHeaders(const QStringList &lines, int dataStartLine)
{
    QStringList headers;
    
    // For automotive diagnostic files, extract sensor names from the data
    // Look at the first few data rows to find unique sensor names
    QSet<QString> sensorNames;
    
    for (int i = dataStartLine; i < qMin(dataStartLine + 10, lines.size()); ++i) {
        QString line = lines[i];
        QStringList parts = parseCSVLine(line);
        
        // Automotive format: "Sensor Name", timestamp, state, value, empty, empty, empty, ...
        for (int j = 0; j < parts.size(); j += 7) { // Skip by groups of 7 (name,time,state,value,,,)
            if (j < parts.size() && !parts[j].isEmpty() && parts[j] != "Event name") {
                QString sensorName = parts[j].trimmed();
                if (sensorName.startsWith("\"") && sensorName.endsWith("\"")) {
                    sensorName = sensorName.mid(1, sensorName.length() - 2);
                }
                if (!sensorName.isEmpty()) {
                    sensorNames.insert(sensorName);
                }
            }
        }
    }
    
    // Create simplified headers for plotting
    headers.append("Time");  // First column will be time
    for (const QString &sensor : sensorNames) {
        if (sensor != "Event name") {
            headers.append(sensor);
        }
    }
    
    // If we didn't find good sensor names, create generic headers
    if (headers.size() <= 1) {
        headers.clear();
        headers.append("Time");
        headers.append("Engine_RPM");
        headers.append("Boost_Pressure");
        headers.append("Fuel_Rail_Pressure");
        headers.append("Fuel_Temperature");
        headers.append("Speed");
    }
    
    return headers;
}

QVector<QVariant> CSVViewer::parseAutomotiveDataRow(const QString &line, int expectedColumns)
{
    QVector<QVariant> row;
    QStringList parts = parseCSVLine(line);
    
    // Extract time and sensor values from automotive format
    QMap<QString, double> sensorValues;
    double timestamp = 0;
    
    // Parse groups of: "Sensor Name", timestamp, state, value, empty, empty, empty
    for (int i = 0; i < parts.size(); i += 7) {
        if (i + 3 < parts.size()) {
            QString sensorName = parts[i];
            if (sensorName.startsWith("\"") && sensorName.endsWith("\"")) {
                sensorName = sensorName.mid(1, sensorName.length() - 2);
            }
            
            bool timeOk, valueOk;
            double time = parts[i + 1].toDouble(&timeOk);
            double value = parts[i + 3].toDouble(&valueOk);
            
            if (timeOk) {
                timestamp = qMax(timestamp, time);  // Use latest timestamp
            }
            
            if (valueOk && !sensorName.isEmpty() && sensorName != "Event name") {
                sensorValues[sensorName] = value;
            }
        }
    }
    
    // Build row with time first, then sensor values
    row.append(timestamp);
    
    // Add sensor values (this is simplified - in practice you'd want to maintain consistent order)
    for (auto it = sensorValues.begin(); it != sensorValues.end(); ++it) {
        row.append(it.value());
    }
    
    // Pad to expected columns
    while (row.size() < expectedColumns) {
        row.append(0.0);
    }
    
    return row;
}

QStringList CSVViewer::parseCSVLine(const QString &line)
{
    QStringList result;
    QString current;
    bool inQuotes = false;
    
    for (int i = 0; i < line.length(); ++i) {
        QChar c = line[i];
        
        if (c == '"') {
            inQuotes = !inQuotes;
        } else if (c == ',' && !inQuotes) {
            result.append(current.trimmed());
            current.clear();
        } else {
            current.append(c);
        }
    }
    
    result.append(current.trimmed());
    return result;
}

QVariantList CSVViewer::getHeaders()
{
    QVariantList result;
    for (const QString &header : m_headers) {
        result.append(header);
    }
    return result;
}

QVariantList CSVViewer::getDataRow(int row)
{
    QVariantList result;
    if (row >= 0 && row < m_data.size()) {
        for (const QVariant &value : m_data[row]) {
            result.append(value);
        }
    }
    return result;
}

QVariantList CSVViewer::getDataColumn(int column)
{
    QVariantList result;
    if (column >= 0 && column < m_totalColumns) {
        for (const auto &row : m_data) {
            if (column < row.size()) {
                result.append(row[column]);
            }
        }
    }
    return result;
}

QVariant CSVViewer::getDataValue(int row, int column)
{
    if (row >= 0 && row < m_data.size() && column >= 0 && column < m_data[row].size()) {
        return m_data[row][column];
    }
    return QVariant();
}

QVariantMap CSVViewer::getDataSummary()
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

void CSVViewer::resetChart()
{
    qDebug() << "Reset chart";
}

void CSVViewer::toggleSeries(const QString &seriesName, bool visible)
{
    qDebug() << "Toggle series:" << seriesName << visible;
}

void CSVViewer::setSeriesColor(const QString &seriesName, const QColor &color)
{
    qDebug() << "Set series color:" << seriesName << color;
}

void CSVViewer::filterData(qreal minTime, qreal maxTime)
{
    qDebug() << "Filter data:" << minTime << maxTime;
}

void CSVViewer::clearFilter()
{
    qDebug() << "Clear filter";
}

void CSVViewer::exportChart(const QString &format)
{
    qDebug() << "Export chart:" << format;
}

void CSVViewer::exportData()
{
    qDebug() << "Export data";
}

void CSVViewer::onChartHovered(const QString &seriesName, qreal x, qreal y, bool state)
{
    qDebug() << "Chart hovered:" << seriesName << x << y << state;
}

void CSVViewer::onChartZoomed(qreal minX, qreal maxX, qreal minY, qreal maxY)
{
    qDebug() << "Chart zoomed:" << minX << maxX << minY << maxY;
}

void CSVViewer::highlightDataPoint(qreal time)
{
    qDebug() << "Highlight data point:" << time;
}

void CSVViewer::savePreset(const QString &name)
{
    qDebug() << "Save preset:" << name;
}

void CSVViewer::loadPreset(const QString &name)
{
    qDebug() << "Load preset:" << name;
}

QStringList CSVViewer::getAvailablePresets()
{
    return QStringList{"Default", "Automotive", "Performance"};
}

void CSVViewer::setCurrentFileName(const QString &fileName)
{
    if (m_currentFileName != fileName) {
        m_currentFileName = fileName;
        emit currentFileNameChanged();
    }
}

void CSVViewer::setIsFileLoaded(bool loaded)
{
    if (m_isFileLoaded != loaded) {
        m_isFileLoaded = loaded;
        emit isFileLoadedChanged();
    }
}

void CSVViewer::setTotalRows(int rows)
{
    if (m_totalRows != rows) {
        m_totalRows = rows;
        emit totalRowsChanged();
    }
}

void CSVViewer::setTotalColumns(int columns)
{
    if (m_totalColumns != columns) {
        m_totalColumns = columns;
        emit totalColumnsChanged();
    }
}

void CSVViewer::setStatusMessage(const QString &message)
{
    if (m_statusMessage != message) {
        m_statusMessage = message;
        emit statusMessageChanged();
    }
}

void CSVViewer::setIsLoading(bool loading)
{
    if (m_isLoading != loading) {
        m_isLoading = loading;
        emit isLoadingChanged();
    }
} 