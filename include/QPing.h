#ifndef QPING_H
#define QPING_H

#include <QObject>
#include <QProcess>
#include <QString>
#include <QTimer>
#include <QSettings>

class QPing : public QObject
{
    Q_OBJECT

public:
    enum pingResult {
        pingSuccess,
        pingFailed,
        initFailed1,    // success string is empty
        initFailed2,    // failed string is empty
        notFound,       // something wrong
        timeout
    };

    explicit QPing(QObject *parent = nullptr);
    ~QPing();

    void setIniFile(const QString &iniFilePath);
    bool loadIniFile();
    pingResult ping(const QString &destIpAddress, int timeoutMs = 3000);

signals:
    void pingCompleted(const QString &address, bool success, int responseTime);

private slots:
    void onPingFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onPingTimeout();

private:
    QString getDefaultPingCommand();
    QStringList getDefaultPingArgs(const QString &address);
    
    QProcess *m_pingProcess;
    QTimer *m_timeoutTimer;
    QString m_iniFilePath;
    QSettings *m_settings;
    
    QString m_pingCommand;
    QStringList m_pingArgs;
    QString m_successString;
    QString m_failedString;
    
    QString m_currentAddress;
    qint64 m_startTime;
    bool m_pingCompleted;
};

#endif // QPING_H 