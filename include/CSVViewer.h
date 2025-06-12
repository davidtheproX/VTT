#ifndef CSVVIEWER_H
#define CSVVIEWER_H

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

class CSVViewer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentFileName READ currentFileName NOTIFY currentFileNameChanged)
    Q_PROPERTY(bool isFileLoaded READ isFileLoaded NOTIFY isFileLoadedChanged)
    Q_PROPERTY(int totalRows READ totalRows NOTIFY totalRowsChanged)
    Q_PROPERTY(int totalColumns READ totalColumns NOTIFY totalColumnsChanged)
    Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusMessageChanged)
    Q_PROPERTY(bool isLoading READ isLoading NOTIFY isLoadingChanged)

public:
    explicit CSVViewer(QObject *parent = nullptr);

    // Property getters
    QString currentFileName() const { return m_currentFileName; }
    bool isFileLoaded() const { return m_isFileLoaded; }
    int totalRows() const { return m_totalRows; }
    int totalColumns() const { return m_totalColumns; }
    QString statusMessage() const { return m_statusMessage; }
    bool isLoading() const { return m_isLoading; }

    // Data access methods for QML
    Q_INVOKABLE QVariantList getHeaders();
    Q_INVOKABLE QVariantList getDataRow(int row);
    Q_INVOKABLE QVariantList getDataColumn(int column);
    Q_INVOKABLE QVariant getDataValue(int row, int column);
    Q_INVOKABLE QVariantMap getDataSummary();

public slots:
    void loadFile(const QUrl &fileUrl);
    void resetChart();
    void toggleSeries(const QString &seriesName, bool visible);
    void setSeriesColor(const QString &seriesName, const QColor &color);
    void filterData(qreal minTime, qreal maxTime);
    void clearFilter();
    void exportChart(const QString &format);
    void exportData();
    void onChartHovered(const QString &seriesName, qreal x, qreal y, bool state);
    void onChartZoomed(qreal minX, qreal maxX, qreal minY, qreal maxY);
    void highlightDataPoint(qreal time);
    void savePreset(const QString &name);
    void loadPreset(const QString &name);
    QStringList getAvailablePresets();

signals:
    void currentFileNameChanged();
    void isFileLoadedChanged();
    void totalRowsChanged();
    void totalColumnsChanged();
    void statusMessageChanged();
    void isLoadingChanged();
    void fileLoaded();
    void loadError(const QString &message);

private:
    void setCurrentFileName(const QString &fileName);
    void setIsFileLoaded(bool loaded);
    void setTotalRows(int rows);
    void setTotalColumns(int columns);
    void setStatusMessage(const QString &message);
    void setIsLoading(bool loading);
    bool parseCSVFile(const QString &filePath);
    QStringList parseCSVLine(const QString &line);
    
    // Enhanced parsing methods for complex CSV formats
    int findDataStartLine(const QStringList &lines);
    bool isAutomotiveDiagnosticFormat(const QStringList &lines);
    QStringList parseAutomotiveHeaders(const QStringList &lines, int dataStartLine);
    QVector<QVariant> parseAutomotiveDataRow(const QString &line, int expectedColumns);

    QString m_currentFileName;
    bool m_isFileLoaded;
    int m_totalRows;
    int m_totalColumns;
    QString m_statusMessage;
    bool m_isLoading;
    
    QVector<QVector<QVariant>> m_data;
    QStringList m_headers;
};

#endif // CSVVIEWER_H 