#include "LoggingManager.h"
#include <QStandardPaths>
#include <QDir>
#include <QDateTime>
#include <QDebug>
#include <QMutexLocker>
#include <QCoreApplication>

// Define logging categories
Q_LOGGING_CATEGORY(voiceCategory, "voice")
Q_LOGGING_CATEGORY(llmCategory, "llm")
Q_LOGGING_CATEGORY(databaseCategory, "database")
Q_LOGGING_CATEGORY(securityCategory, "security")
Q_LOGGING_CATEGORY(uiCategory, "ui")

LoggingManager* LoggingManager::s_instance = nullptr;

LoggingManager::LoggingManager(QObject *parent)
    : QObject(parent)
    , m_logLevel(Info)
    , m_logToFile(true)
    , m_logToConsole(true)
{
    // Set up log file path
    QString dataDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(dataDir);
    
    QString timestamp = QDateTime::currentDateTime().toString("yyyy-MM-dd");
    m_logFilePath = QDir(dataDir).filePath(QString("voiceaillm_%1.log").arg(timestamp));
}

LoggingManager* LoggingManager::instance()
{
    if (!s_instance) {
        s_instance = new LoggingManager();
    }
    return s_instance;
}

void LoggingManager::initializeLogging()
{
    // Install custom message handler
    qInstallMessageHandler(messageHandler);
    
    // Initialize log file if enabled
    if (m_logToFile) {
        m_logFile = std::make_unique<QFile>(m_logFilePath);
        if (m_logFile->open(QIODevice::WriteOnly | QIODevice::Append)) {
            m_logStream = std::make_unique<QTextStream>(m_logFile.get());
            m_logStream->setEncoding(QStringConverter::Utf8);
            
            // Write startup message
            QString startupMsg = QString("\n=== VoiceAILLM Started at %1 ===\n")
                               .arg(QDateTime::currentDateTime().toString(Qt::ISODate));
            writeToFile(startupMsg);
        } else {
            qWarning() << "Failed to open log file:" << m_logFilePath;
            m_logToFile = false;
        }
    }
    
    qDebug() << "LoggingManager initialized - File logging:" << m_logToFile 
             << "Console logging:" << m_logToConsole;
}

void LoggingManager::setLogLevel(LogLevel level)
{
    QMutexLocker locker(&m_mutex);
    m_logLevel = level;
}

void LoggingManager::setLogToFile(bool enabled)
{
    QMutexLocker locker(&m_mutex);
    m_logToFile = enabled;
    
    if (!enabled && m_logFile) {
        m_logStream.reset();
        m_logFile.reset();
    } else if (enabled && !m_logFile) {
        m_logFile = std::make_unique<QFile>(m_logFilePath);
        if (m_logFile->open(QIODevice::WriteOnly | QIODevice::Append)) {
            m_logStream = std::make_unique<QTextStream>(m_logFile.get());
            m_logStream->setEncoding(QStringConverter::Utf8);
        }
    }
}

void LoggingManager::setLogToConsole(bool enabled)
{
    QMutexLocker locker(&m_mutex);
    m_logToConsole = enabled;
}

void LoggingManager::logVoice(LogLevel level, const QString &message)
{
    if (level < m_logLevel) return;
    
    QString formattedMsg = formatMessage(level, "VOICE", message);
    emit logMessageGenerated(level, "VOICE", message);
    
    if (m_logToFile) writeToFile(formattedMsg);
    if (m_logToConsole) writeToConsole(formattedMsg);
}

void LoggingManager::logLLM(LogLevel level, const QString &message)
{
    if (level < m_logLevel) return;
    
    QString formattedMsg = formatMessage(level, "LLM", message);
    emit logMessageGenerated(level, "LLM", message);
    
    if (m_logToFile) writeToFile(formattedMsg);
    if (m_logToConsole) writeToConsole(formattedMsg);
}

void LoggingManager::logDatabase(LogLevel level, const QString &message)
{
    if (level < m_logLevel) return;
    
    QString formattedMsg = formatMessage(level, "DATABASE", message);
    emit logMessageGenerated(level, "DATABASE", message);
    
    if (m_logToFile) writeToFile(formattedMsg);
    if (m_logToConsole) writeToConsole(formattedMsg);
}

void LoggingManager::logSecurity(LogLevel level, const QString &message)
{
    if (level < m_logLevel) return;
    
    QString formattedMsg = formatMessage(level, "SECURITY", message);
    emit logMessageGenerated(level, "SECURITY", message);
    
    if (m_logToFile) writeToFile(formattedMsg);
    if (m_logToConsole) writeToConsole(formattedMsg);
}

void LoggingManager::logUI(LogLevel level, const QString &message)
{
    if (level < m_logLevel) return;
    
    QString formattedMsg = formatMessage(level, "UI", message);
    emit logMessageGenerated(level, "UI", message);
    
    if (m_logToFile) writeToFile(formattedMsg);
    if (m_logToConsole) writeToConsole(formattedMsg);
}

void LoggingManager::logGeneral(LogLevel level, const QString &message)
{
    if (level < m_logLevel) return;
    
    QString formattedMsg = formatMessage(level, "GENERAL", message);
    emit logMessageGenerated(level, "GENERAL", message);
    
    if (m_logToFile) writeToFile(formattedMsg);
    if (m_logToConsole) writeToConsole(formattedMsg);
}

void LoggingManager::messageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    LoggingManager* manager = instance();
    if (!manager) return;
    
    LogLevel level;
    switch (type) {
    case QtDebugMsg:    level = Debug; break;
    case QtInfoMsg:     level = Info; break;
    case QtWarningMsg:  level = Warning; break;
    case QtCriticalMsg: level = Critical; break;
    case QtFatalMsg:    level = Fatal; break;
    }
    
    // Extract category from context
    QString category = "GENERAL";
    if (context.category && strlen(context.category) > 0) {
        QString cat = QString(context.category).toUpper();
        if (cat.contains("VOICE")) category = "VOICE";
        else if (cat.contains("LLM")) category = "LLM";
        else if (cat.contains("DATABASE")) category = "DATABASE";
        else if (cat.contains("SECURITY")) category = "SECURITY";
        else if (cat.contains("UI")) category = "UI";
    }
    
    QString formattedMsg = manager->formatMessage(level, category, msg);
    
    if (manager->m_logToFile) manager->writeToFile(formattedMsg);
    if (manager->m_logToConsole) manager->writeToConsole(formattedMsg);
    
    emit manager->logMessageGenerated(level, category, msg);
}

void LoggingManager::writeToFile(const QString &message)
{
    QMutexLocker locker(&m_mutex);
    if (m_logStream) {
        *m_logStream << message << Qt::endl;
        m_logStream->flush();
    }
}

void LoggingManager::writeToConsole(const QString &message)
{
    // Output to stderr for logging, stdout for normal output
    QTextStream stderrStream(stderr);
    stderrStream << message << Qt::endl;
}

QString LoggingManager::formatMessage(LogLevel level, const QString &category, const QString &message) const
{
    QString levelStr;
    switch (level) {
    case Debug:    levelStr = "DEBUG"; break;
    case Info:     levelStr = "INFO"; break;
    case Warning:  levelStr = "WARN"; break;
    case Critical: levelStr = "ERROR"; break;
    case Fatal:    levelStr = "FATAL"; break;
    }
    
    QString timestamp = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss.zzz");
    return QString("[%1] [%2] [%3] %4")
           .arg(timestamp)
           .arg(levelStr.leftJustified(5))
           .arg(category.leftJustified(8))
           .arg(message);
} 