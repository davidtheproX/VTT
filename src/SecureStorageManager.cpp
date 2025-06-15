#include "SecureStorageManager.h"
#include "SecureStorage.h"
#include <QDebug>

SecureStorageManager::SecureStorageManager(QObject *parent)
    : QObject(parent)
    , m_secureStorage(new SecureStorage(this))
    , m_secureStorageAvailable(true)
{
    qDebug() << "SecureStorageManager: Using Qt6.9 cross-platform secure storage";
    qDebug() << "Platform:" << m_secureStorage->getPlatformName();
    
    // Connect signals
    connect(m_secureStorage, &SecureStorage::storageError,
            this, &SecureStorageManager::storageError);
    connect(m_secureStorage, &SecureStorage::valueStored,
            this, [this](const QString &key) {
                emit credentialStored(key, true);
            });
    connect(m_secureStorage, &SecureStorage::valueRemoved,
            this, [this](const QString &key) {
                emit credentialDeleted(key, true);
            });
    
    m_secureStorageAvailable = m_secureStorage->isSecureStorageAvailable();
}

SecureStorageManager::~SecureStorageManager() = default;

bool SecureStorageManager::isSecureStorageAvailable() const
{
    return m_secureStorageAvailable;
}

void SecureStorageManager::storeCredential(const QString &key, const QString &value)
{
    if (!m_secureStorageAvailable) {
        qWarning() << "SecureStorageManager: Secure storage not available";
        emit credentialStored(key, false);
        return;
    }
    
    qDebug() << "SecureStorageManager: Storing credential for key:" << key;
    bool success = m_secureStorage->store(key, value);
    
    if (!success) {
        qWarning() << "SecureStorageManager: Failed to store credential for key:" << key;
        emit credentialStored(key, false);
    }
    // Success signal is emitted by SecureStorage::valueStored
}

QString SecureStorageManager::retrieveCredential(const QString &key)
{
    if (!m_secureStorageAvailable) {
        qWarning() << "SecureStorageManager: Secure storage not available";
        emit credentialRetrieved(key, QString(), false);
        return QString();
    }
    
    qDebug() << "SecureStorageManager: Retrieving credential for key:" << key;
    QString value = m_secureStorage->retrieve(key);
    
    bool success = !value.isEmpty();
    emit credentialRetrieved(key, value, success);
    
    return value;
}

void SecureStorageManager::deleteCredential(const QString &key)
{
    if (!m_secureStorageAvailable) {
        qWarning() << "SecureStorageManager: Secure storage not available";
        emit credentialDeleted(key, false);
        return;
    }
    
    qDebug() << "SecureStorageManager: Deleting credential for key:" << key;
    bool success = m_secureStorage->remove(key);
    
    if (!success) {
        qWarning() << "SecureStorageManager: Failed to delete credential for key:" << key;
        emit credentialDeleted(key, false);
    }
    // Success signal is emitted by SecureStorage::valueRemoved
}

bool SecureStorageManager::hasCredential(const QString &key)
{
    if (!m_secureStorageAvailable) {
        return false;
    }
    
    return m_secureStorage->contains(key);
}

void SecureStorageManager::clearAllCredentials()
{
    if (!m_secureStorageAvailable) {
        qWarning() << "SecureStorageManager: Secure storage not available";
        return;
    }
    
    qDebug() << "SecureStorageManager: Clearing all credentials";
    m_secureStorage->clear();
}

// OAuth Token Management
void SecureStorageManager::storeOAuthToken(const QString &service, const QString &token)
{
    QString key = QString("oauth_token_%1").arg(service);
    storeCredential(key, token);
}

QString SecureStorageManager::retrieveOAuthToken(const QString &service)
{
    QString key = QString("oauth_token_%1").arg(service);
    return retrieveCredential(key);
}

void SecureStorageManager::deleteOAuthToken(const QString &service)
{
    QString key = QString("oauth_token_%1").arg(service);
    deleteCredential(key);
}

// API Key Management  
void SecureStorageManager::storeApiKey(const QString &apiName, const QString &apiKey)
{
    QString key = QString("api_key_%1").arg(apiName);
    storeCredential(key, apiKey);
}

QString SecureStorageManager::retrieveApiKey(const QString &apiName)
{
    QString key = QString("api_key_%1").arg(apiName);
    return retrieveCredential(key);
}

void SecureStorageManager::deleteApiKey(const QString &apiName)
{
    QString key = QString("api_key_%1").arg(apiName);
    deleteCredential(key);
}

// Convenience methods for common use cases
void SecureStorageManager::storeGoogleCloudApiKey(const QString &apiKey)
{
    storeApiKey("google_cloud", apiKey);
}

QString SecureStorageManager::retrieveGoogleCloudApiKey()
{
    return retrieveApiKey("google_cloud");
}

void SecureStorageManager::storeOpenAIApiKey(const QString &apiKey)
{
    storeApiKey("openai", apiKey);
}

QString SecureStorageManager::retrieveOpenAIApiKey()
{
    return retrieveApiKey("openai");
}

QStringList SecureStorageManager::getAllStoredKeys()
{
    if (!m_secureStorageAvailable) {
        return QStringList();
    }
    
    return m_secureStorage->allKeys();
} 