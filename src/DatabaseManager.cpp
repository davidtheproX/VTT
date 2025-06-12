#include "DatabaseManager.h"
#include <QFile>
#include <QTextStream>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject(parent)
    , m_isInitialized(false)
{
    // Database path will be set in initialize() after QApplication is created
}

DatabaseManager::~DatabaseManager() = default;

bool DatabaseManager::initialize()
{
    // Set database path now that QApplication is available
    if (m_databasePath.isEmpty()) {
        QString dataDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
        m_databasePath = QDir(dataDir).filePath(DATABASE_FILENAME);
    }
    
    if (!ensureDirectoryExists()) {
        emit error("Failed to create database directory");
        return false;
    }
    
    if (!loadDatabase()) {
        createDefaultDatabase();
        if (!saveDatabase()) {
            emit error("Failed to save default database");
            return false;
        }
    }
    
    m_isInitialized = true;
    emit isInitializedChanged();
    return true;
}

bool DatabaseManager::loadDatabase()
{
    QFile file(m_databasePath);
    if (!file.exists()) {
        return false;
    }
    
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        emit error("Failed to open database file: " + file.errorString());
        return false;
    }
    
    QTextStream stream(&file);
    QString content = stream.readAll();
    file.close();
    
    QJsonDocument doc = QJsonDocument::fromJson(content.toUtf8());
    if (doc.isNull() || !doc.isObject()) {
        emit error("Invalid database format");
        return false;
    }
    
    m_database = doc.object();
    
    // Verify database version
    QString version = m_database["version"].toString();
    if (version != DATABASE_VERSION) {
        qWarning() << "Database version mismatch. Expected:" << DATABASE_VERSION << "Got:" << version;
    }
    
    return true;
}

bool DatabaseManager::saveDatabase()
{
    QFile file(m_databasePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        emit error("Failed to open database file for writing: " + file.errorString());
        return false;
    }
    
    QJsonDocument doc(m_database);
    QTextStream stream(&file);
    stream << doc.toJson(QJsonDocument::Indented);
    file.close();
    
    return true;
}

void DatabaseManager::createDefaultDatabase()
{
    m_database = QJsonObject();
    m_database["version"] = DATABASE_VERSION;
    
    // Create default prompts
    QJsonArray prompts;
    
    QJsonObject defaultPrompt1;
    defaultPrompt1["id"] = "default-assistant";
    defaultPrompt1["name"] = "Default Assistant";
    defaultPrompt1["content"] = "You are a helpful AI assistant. Be concise and informative.";
    defaultPrompt1["category"] = "General";
    defaultPrompt1["isActive"] = true;
    defaultPrompt1["createdAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    defaultPrompt1["modifiedAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    prompts.append(defaultPrompt1);
    
    QJsonObject defaultPrompt2;
    defaultPrompt2["id"] = "coding-assistant";
    defaultPrompt2["name"] = "Coding Assistant";
    defaultPrompt2["content"] = "You are an expert programmer. Help with coding questions, provide clean code examples, and explain technical concepts clearly.";
    defaultPrompt2["category"] = "Programming";
    defaultPrompt2["isActive"] = false;
    defaultPrompt2["createdAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    defaultPrompt2["modifiedAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    prompts.append(defaultPrompt2);
    
    QJsonObject defaultPrompt3;
    defaultPrompt3["id"] = "creative-writer";
    defaultPrompt3["name"] = "Creative Writer";
    defaultPrompt3["content"] = "You are a creative writer. Help with storytelling, creative writing, and content creation. Be imaginative and engaging.";
    defaultPrompt3["category"] = "Creative";
    defaultPrompt3["isActive"] = false;
    defaultPrompt3["createdAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    defaultPrompt3["modifiedAt"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    prompts.append(defaultPrompt3);
    
    m_database["prompts"] = prompts;
    
    // Create default settings
    QJsonObject settings;
    settings["theme"] = "light";
    settings["fontSize"] = 14;
    settings["autoSave"] = true;
    settings["streamingMode"] = true;
    settings["maxTokens"] = 2048;
    settings["temperature"] = 0.7;
    m_database["settings"] = settings;
    
    // Initialize empty chat history
    m_database["chatHistory"] = QJsonArray();
}

bool DatabaseManager::ensureDirectoryExists()
{
    QDir dir(QFileInfo(m_databasePath).absolutePath());
    if (!dir.exists()) {
        return dir.mkpath(".");
    }
    return true;
}

QJsonArray DatabaseManager::getAllPrompts() const
{
    return m_database["prompts"].toArray();
}

QJsonObject DatabaseManager::getPrompt(const QString &id) const
{
    QJsonArray prompts = m_database["prompts"].toArray();
    for (const auto &value : prompts) {
        QJsonObject prompt = value.toObject();
        if (prompt["id"].toString() == id) {
            return prompt;
        }
    }
    return QJsonObject();
}

bool DatabaseManager::addPrompt(const QJsonObject &prompt)
{
    QJsonArray prompts = m_database["prompts"].toArray();
    prompts.append(prompt);
    m_database["prompts"] = prompts;
    
    if (saveDatabase()) {
        emit promptsChanged();
        return true;
    }
    return false;
}

bool DatabaseManager::updatePrompt(const QString &id, const QJsonObject &prompt)
{
    QJsonArray prompts = m_database["prompts"].toArray();
    for (int i = 0; i < prompts.size(); ++i) {
        QJsonObject existingPrompt = prompts[i].toObject();
        if (existingPrompt["id"].toString() == id) {
            prompts[i] = prompt;
            m_database["prompts"] = prompts;
            
            if (saveDatabase()) {
                emit promptsChanged();
                return true;
            }
            return false;
        }
    }
    return false;
}

bool DatabaseManager::deletePrompt(const QString &id)
{
    QJsonArray prompts = m_database["prompts"].toArray();
    for (int i = 0; i < prompts.size(); ++i) {
        QJsonObject prompt = prompts[i].toObject();
        if (prompt["id"].toString() == id) {
            prompts.removeAt(i);
            m_database["prompts"] = prompts;
            
            if (saveDatabase()) {
                emit promptsChanged();
                return true;
            }
            return false;
        }
    }
    return false;
}

QJsonObject DatabaseManager::getSettings() const
{
    return m_database["settings"].toObject();
}

bool DatabaseManager::updateSettings(const QJsonObject &settings)
{
    m_database["settings"] = settings;
    
    if (saveDatabase()) {
        emit settingsChanged();
        return true;
    }
    return false;
}

QJsonArray DatabaseManager::getChatHistory() const
{
    return m_database["chatHistory"].toArray();
}

bool DatabaseManager::saveChatHistory(const QJsonArray &history)
{
    m_database["chatHistory"] = history;
    return saveDatabase();
}

bool DatabaseManager::clearChatHistory()
{
    m_database["chatHistory"] = QJsonArray();
    return saveDatabase();
}

void DatabaseManager::reload()
{
    loadDatabase();
    emit promptsChanged();
    emit settingsChanged();
}

void DatabaseManager::backup(const QString &backupPath)
{
    QFile source(m_databasePath);
    if (source.copy(backupPath)) {
        qDebug() << "Database backed up to:" << backupPath;
    } else {
        emit error("Failed to backup database: " + source.errorString());
    }
}

void DatabaseManager::restore(const QString &backupPath)
{
    QFile backup(backupPath);
    if (!backup.exists()) {
        emit error("Backup file does not exist");
        return;
    }
    
    // Save current database as temporary backup
    QString tempBackup = m_databasePath + ".temp";
    QFile current(m_databasePath);
    current.copy(tempBackup);
    
    // Try to restore from backup
    if (backup.copy(m_databasePath)) {
        if (loadDatabase()) {
            QFile::remove(tempBackup);
            emit promptsChanged();
            emit settingsChanged();
        } else {
            // Restore failed, revert to temporary backup
            QFile::remove(m_databasePath);
            QFile temp(tempBackup);
            temp.rename(m_databasePath);
            emit error("Failed to load restored database, reverted to original");
        }
    } else {
        emit error("Failed to restore database: " + backup.errorString());
    }
} 