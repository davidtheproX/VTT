#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QJsonArray>
#include <memory>

class DatabaseManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isInitialized READ isInitialized NOTIFY isInitializedChanged)
    Q_PROPERTY(QString databasePath READ databasePath NOTIFY databasePathChanged)

public:
    explicit DatabaseManager(QObject *parent = nullptr);
    ~DatabaseManager();

    bool initialize();
    bool isInitialized() const { return m_isInitialized; }
    QString databasePath() const { return m_databasePath; }

    // Prompt management
    Q_INVOKABLE QJsonArray getAllPrompts() const;
    Q_INVOKABLE QJsonObject getPrompt(const QString &id) const;
    Q_INVOKABLE bool addPrompt(const QJsonObject &prompt);
    Q_INVOKABLE bool updatePrompt(const QString &id, const QJsonObject &prompt);
    Q_INVOKABLE bool deletePrompt(const QString &id);

    // Settings management
    Q_INVOKABLE QJsonObject getSettings() const;
    Q_INVOKABLE bool updateSettings(const QJsonObject &settings);
    
    // Chat history
    Q_INVOKABLE QJsonArray getChatHistory() const;
    Q_INVOKABLE bool saveChatHistory(const QJsonArray &history);
    Q_INVOKABLE bool clearChatHistory();

public slots:
    void reload();
    void backup(const QString &backupPath);
    void restore(const QString &backupPath);

signals:
    void isInitializedChanged();
    void databasePathChanged();
    void promptsChanged();
    void settingsChanged();
    void error(const QString &errorMessage);

private:
    bool loadDatabase();
    bool saveDatabase();
    void createDefaultDatabase();
    bool ensureDirectoryExists();
    
    QString m_databasePath;
    bool m_isInitialized;
    QJsonObject m_database;
    
    static constexpr const char* DATABASE_VERSION = "1.0";
    static constexpr const char* DATABASE_FILENAME = "voiceaillm.db";
};

#endif // DATABASEMANAGER_H 