#pragma once

#include <QObject>
#include <QString>
#include <QVariant>
#include <QJsonObject>
#include <memory>

#if HAVE_QTKEYCHAIN
// Forward declaration to avoid including the header in this file
namespace QKeychain {
    class Job;
    class ReadPasswordJob;
    class WritePasswordJob;
    class DeletePasswordJob;
}
#endif

class SecureStorageManager : public QObject
{
    Q_OBJECT

public:
    explicit SecureStorageManager(QObject *parent = nullptr);
    ~SecureStorageManager();

    // Secure credential storage
    void storeCredential(const QString &key, const QString &value);
    QString getCredential(const QString &key) const;
    void deleteCredential(const QString &key);
    bool hasCredential(const QString &key) const;

    // Check if secure storage is available
    bool isSecureStorageAvailable() const;

    // Store/retrieve non-sensitive settings
    void storeSettings(const QString &key, const QVariant &value);
    QVariant getSettings(const QString &key, const QVariant &defaultValue = QVariant()) const;

signals:
    void credentialStored(const QString &key, bool success);
    void credentialRetrieved(const QString &key, const QString &value, bool success);
    void credentialDeleted(const QString &key, bool success);
    void error(const QString &message);

private slots:
#if HAVE_QTKEYCHAIN
    void onJobFinished(QKeychain::Job *job);
#endif

private:
    void initializeSecureStorage();
    QString generateEncryptionKey() const;
    QString encryptData(const QString &data) const;
    QString decryptData(const QString &encryptedData) const;

    // Fallback storage for when QtKeychain is not available
    void storeFallback(const QString &key, const QString &value);
    QString getFallback(const QString &key) const;
    void deleteFallback(const QString &key);

    static constexpr const char* APP_NAME = "VoiceAILLM";
    static constexpr const char* SERVICE_NAME = "VoiceAILLM_Credentials";
    
    mutable QJsonObject m_fallbackStorage;
    mutable QString m_fallbackStoragePath;
    bool m_secureStorageAvailable;
    
#if HAVE_QTKEYCHAIN
    mutable std::unique_ptr<QKeychain::ReadPasswordJob> m_readJob;
    mutable std::unique_ptr<QKeychain::WritePasswordJob> m_writeJob;
    mutable std::unique_ptr<QKeychain::DeletePasswordJob> m_deleteJob;
#endif
}; 