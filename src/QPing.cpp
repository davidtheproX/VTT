#include "QPing.h"
#include <QDebug>
#include <QDateTime>
#include <QLocale>
#include <QStandardPaths>

QPing::QPing(QObject *parent)
    : QObject(parent)
    , m_pingProcess(nullptr)
    , m_timeoutTimer(new QTimer(this))
    , m_settings(nullptr)
    , m_startTime(0)
    , m_pingCompleted(false)
{
    m_timeoutTimer->setSingleShot(true);
    connect(m_timeoutTimer, &QTimer::timeout, this, &QPing::onPingTimeout);
}

QPing::~QPing()
{
    if (m_pingProcess) {
        m_pingProcess->kill();
        m_pingProcess->deleteLater();
    }
    if (m_settings) {
        delete m_settings;
    }
}

void QPing::setIniFile(const QString &iniFilePath)
{
    m_iniFilePath = iniFilePath;
}

bool QPing::loadIniFile()
{
    if (m_iniFilePath.isEmpty()) {
        // Use default settings for cross-platform compatibility
        m_pingCommand = getDefaultPingCommand();
        m_successString = "TTL=";  // Common success indicator
        m_failedString = "Request timed out";  // Common failure indicator
        return true;
    }

    if (m_settings) {
        delete m_settings;
    }
    
    m_settings = new QSettings(m_iniFilePath, QSettings::IniFormat);
    
    m_pingCommand = m_settings->value("ping/command", getDefaultPingCommand()).toString();
    m_successString = m_settings->value("ping/success_string", "TTL=").toString();
    m_failedString = m_settings->value("ping/failed_string", "Request timed out").toString();
    
    if (m_successString.isEmpty()) {
        return false; // initFailed1
    }
    
    if (m_failedString.isEmpty()) {
        return false; // initFailed2
    }
    
    return true;
}

QPing::pingResult QPing::ping(const QString &destIpAddress, int timeoutMs)
{
    if (m_pingProcess && m_pingProcess->state() != QProcess::NotRunning) {
        m_pingProcess->kill();
        m_pingProcess->waitForFinished(1000);
    }

    m_currentAddress = destIpAddress;
    m_startTime = QDateTime::currentMSecsSinceEpoch();
    m_pingCompleted = false;

    m_pingProcess = new QProcess(this);
    connect(m_pingProcess, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            this, &QPing::onPingFinished);

    QStringList args = getDefaultPingArgs(destIpAddress);
    
    qDebug() << "🏓 QPing: Starting ping to" << destIpAddress << "with command:" << m_pingCommand << args;
    
    m_timeoutTimer->start(timeoutMs);
    m_pingProcess->start(m_pingCommand, args);
    
    if (!m_pingProcess->waitForStarted(1000)) {
        qDebug() << "✗ QPing: Failed to start ping process";
        return pingFailed;
    }
    
    // Wait for completion
    if (!m_pingProcess->waitForFinished(timeoutMs)) {
        qDebug() << "✗ QPing: Ping process timeout";
        m_pingProcess->kill();
        return timeout;
    }
    
    // Process should be finished by now, but check the result
    if (!m_pingCompleted) {
        onPingFinished(m_pingProcess->exitCode(), m_pingProcess->exitStatus());
    }
    
    return m_pingCompleted ? pingSuccess : pingFailed;
}

void QPing::onPingFinished(int exitCode, QProcess::ExitStatus exitStatus)
{
    m_timeoutTimer->stop();
    
    if (!m_pingProcess) {
        return;
    }
    
    QString output = m_pingProcess->readAllStandardOutput();
    QString errorOutput = m_pingProcess->readAllStandardError();
    
    qint64 responseTime = QDateTime::currentMSecsSinceEpoch() - m_startTime;
    
    qDebug() << "🏓 QPing: Process finished with exit code:" << exitCode;
    qDebug() << "🏓 QPing: Output:" << output;
    
    bool success = false;
    
    if (exitStatus == QProcess::NormalExit && exitCode == 0) {
        // Check for success indicators in output
        if (output.contains(m_successString, Qt::CaseInsensitive) ||
            output.contains("TTL=", Qt::CaseInsensitive) ||
            output.contains("time=", Qt::CaseInsensitive) ||
            output.contains("bytes from", Qt::CaseInsensitive)) {
            success = true;
        }
    }
    
    m_pingCompleted = true;
    
    qDebug() << "🏓 QPing: Result for" << m_currentAddress << "- Success:" << success << "- Time:" << responseTime << "ms";
    
    emit pingCompleted(m_currentAddress, success, static_cast<int>(responseTime));
    
    m_pingProcess->deleteLater();
    m_pingProcess = nullptr;
}

void QPing::onPingTimeout()
{
    qDebug() << "✗ QPing: Timeout for" << m_currentAddress;
    
    if (m_pingProcess) {
        m_pingProcess->kill();
        m_pingProcess->deleteLater();
        m_pingProcess = nullptr;
    }
    
    qint64 responseTime = QDateTime::currentMSecsSinceEpoch() - m_startTime;
    emit pingCompleted(m_currentAddress, false, static_cast<int>(responseTime));
}

QString QPing::getDefaultPingCommand()
{
#ifdef Q_OS_WIN
    return "ping";
#elif defined(Q_OS_LINUX) || defined(Q_OS_MAC)
    return "ping";
#else
    return "ping";
#endif
}

QStringList QPing::getDefaultPingArgs(const QString &address)
{
    QStringList args;
    
#ifdef Q_OS_WIN
    args << "-n" << "1" << "-w" << "3000" << address;
#elif defined(Q_OS_LINUX)
    args << "-c" << "1" << "-W" << "3" << address;
#elif defined(Q_OS_MAC)
    args << "-c" << "1" << "-t" << "3" << address;
#else
    // Default fallback
    args << "-c" << "1" << address;
#endif
    
    return args;
} 