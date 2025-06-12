#pragma once

#include <QObject>
#include <QString>
#include <QLoggingCategory>
#include <QTextStream>
#include <QFile>
#include <QMutex>
#include <memory>

Q_DECLARE_LOGGING_CATEGORY(voiceCategory)
Q_DECLARE_LOGGING_CATEGORY(llmCategory)
Q_DECLARE_LOGGING_CATEGORY(databaseCategory)
Q_DECLARE_LOGGING_CATEGORY(securityCategory)
Q_DECLARE_LOGGING_CATEGORY(uiCategory)

class LoggingManager : public QObject
{
    Q_OBJECT

public:
    enum LogLevel {
        Debug,
        Info,
        Warning,
        Critical,
        Fatal
    };
    Q_ENUM(LogLevel)

    static LoggingManager* instance();
    
    void initializeLogging();
    void setLogLevel(LogLevel level);
    void setLogToFile(bool enabled);
    void setLogToConsole(bool enabled);
    
    // Logging methods
    void logVoice(LogLevel level, const QString &message);
    void logLLM(LogLevel level, const QString &message);
    void logDatabase(LogLevel level, const QString &message);
    void logSecurity(LogLevel level, const QString &message);
    void logUI(LogLevel level, const QString &message);
    void logGeneral(LogLevel level, const QString &message);

    // Convenience methods
    void debugVoice(const QString &message) { logVoice(Debug, message); }
    void infoVoice(const QString &message) { logVoice(Info, message); }
    void warningVoice(const QString &message) { logVoice(Warning, message); }
    void criticalVoice(const QString &message) { logVoice(Critical, message); }
    
    void debugLLM(const QString &message) { logLLM(Debug, message); }
    void infoLLM(const QString &message) { logLLM(Info, message); }
    void warningLLM(const QString &message) { logLLM(Warning, message); }
    void criticalLLM(const QString &message) { logLLM(Critical, message); }
    
    void debugDatabase(const QString &message) { logDatabase(Debug, message); }
    void infoDatabase(const QString &message) { logDatabase(Info, message); }
    void warningDatabase(const QString &message) { logDatabase(Warning, message); }
    void criticalDatabase(const QString &message) { logDatabase(Critical, message); }
    
    void debugSecurity(const QString &message) { logSecurity(Debug, message); }
    void infoSecurity(const QString &message) { logSecurity(Info, message); }
    void warningSecurity(const QString &message) { logSecurity(Warning, message); }
    void criticalSecurity(const QString &message) { logSecurity(Critical, message); }
    
    void debugUI(const QString &message) { logUI(Debug, message); }
    void infoUI(const QString &message) { logUI(Info, message); }
    void warningUI(const QString &message) { logUI(Warning, message); }
    void criticalUI(const QString &message) { logUI(Critical, message); }
    
    void debugGeneral(const QString &message) { logGeneral(Debug, message); }
    void infoGeneral(const QString &message) { logGeneral(Info, message); }
    void warningGeneral(const QString &message) { logGeneral(Warning, message); }
    void criticalGeneral(const QString &message) { logGeneral(Critical, message); }

signals:
    void logMessageGenerated(LogLevel level, const QString &category, const QString &message);

private:
    explicit LoggingManager(QObject *parent = nullptr);
    
    static void messageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg);
    void writeToFile(const QString &message);
    void writeToConsole(const QString &message);
    QString formatMessage(LogLevel level, const QString &category, const QString &message) const;
    
    static LoggingManager* s_instance;
    
    LogLevel m_logLevel;
    bool m_logToFile;
    bool m_logToConsole;
    std::unique_ptr<QFile> m_logFile;
    std::unique_ptr<QTextStream> m_logStream;
    QMutex m_mutex;
    QString m_logFilePath;
}; 