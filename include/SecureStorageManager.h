#pragma once

#include <QObject>
#include <QString>
#include <QStringList>
#include <QtQmlIntegration>

// Forward declaration
class SecureStorage;

/**
 * Cross-Platform Secure Storage Manager using Qt6.9
 * 
 * Simplified wrapper around SecureStorage that provides
 * credential management for the VoiceAI LLM application.
 * Works on Windows, macOS, iOS, Android, Linux, and HarmonyOS.
 */
class SecureStorageManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit SecureStorageManager(QObject *parent = nullptr);
    ~SecureStorageManager();

    // Core credential operations
    Q_INVOKABLE void storeCredential(const QString &key, const QString &value);
    Q_INVOKABLE QString retrieveCredential(const QString &key);
    Q_INVOKABLE void deleteCredential(const QString &key);
    Q_INVOKABLE bool hasCredential(const QString &key);
    Q_INVOKABLE void clearAllCredentials();

    // Status
    Q_INVOKABLE bool isSecureStorageAvailable() const;
    Q_INVOKABLE QStringList getAllStoredKeys();

    // OAuth Token Management
    Q_INVOKABLE void storeOAuthToken(const QString &service, const QString &token);
    Q_INVOKABLE QString retrieveOAuthToken(const QString &service);
    Q_INVOKABLE void deleteOAuthToken(const QString &service);

    // API Key Management
    Q_INVOKABLE void storeApiKey(const QString &apiName, const QString &apiKey);
    Q_INVOKABLE QString retrieveApiKey(const QString &apiName);
    Q_INVOKABLE void deleteApiKey(const QString &apiName);

    // Convenience methods for common APIs
    Q_INVOKABLE void storeGoogleCloudApiKey(const QString &apiKey);
    Q_INVOKABLE QString retrieveGoogleCloudApiKey();
    Q_INVOKABLE void storeOpenAIApiKey(const QString &apiKey);
    Q_INVOKABLE QString retrieveOpenAIApiKey();

signals:
    void credentialStored(const QString &key, bool success);
    void credentialRetrieved(const QString &key, const QString &value, bool success);
    void credentialDeleted(const QString &key, bool success);
    void storageError(const QString &error);

private:
    SecureStorage *m_secureStorage;
    bool m_secureStorageAvailable;
}; 