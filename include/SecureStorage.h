#pragma once

#include <QObject>
#include <QString>
#include <QSettings>
#include <QStandardPaths>
#include <QCryptographicHash>
#include <QtQmlIntegration>

/**
 * Cross-Platform Secure Storage using Qt6.9
 * 
 * Automatically handles platform-specific secure storage:
 * - Windows: Registry with DPAPI encryption
 * - macOS/iOS: Keychain Services
 * - Android: SharedPreferences with Android Keystore
 * - Linux: Encrypted files
 * - HarmonyOS: Platform-specific secure storage
 */
class SecureStorage : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit SecureStorage(QObject *parent = nullptr);
    
    // Cross-platform secure storage operations
    Q_INVOKABLE bool store(const QString &key, const QString &value);
    Q_INVOKABLE QString retrieve(const QString &key, const QString &defaultValue = QString());
    Q_INVOKABLE bool remove(const QString &key);
    Q_INVOKABLE void clear();
    Q_INVOKABLE bool contains(const QString &key) const;
    Q_INVOKABLE QStringList allKeys() const;
    
    // OAuth and API key management
    Q_INVOKABLE bool storeOAuthToken(const QString &service, const QString &token);
    Q_INVOKABLE QString getOAuthToken(const QString &service);
    Q_INVOKABLE bool storeApiKey(const QString &apiName, const QString &apiKey);
    Q_INVOKABLE QString getApiKey(const QString &apiName);
    
    // Platform info
    Q_INVOKABLE QString getPlatformName() const;
    Q_INVOKABLE bool isSecureStorageAvailable() const;

signals:
    void storageError(const QString &error);
    void valueStored(const QString &key);
    void valueRemoved(const QString &key);

private:
    QString hashKey(const QString &key) const;
    void initializePlatformStorage();
    
    QSettings *m_settings;
    QString m_organizationName;
    QString m_applicationName;
    bool m_isAvailable;
}; 