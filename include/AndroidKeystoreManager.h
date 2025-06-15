#ifndef ANDROIDKEYSTOREMANAGER_H
#define ANDROIDKEYSTOREMANAGER_H

#include <QObject>
#include <QString>
#include <QByteArray>
#include "PlatformDetection.h"

#ifdef PLATFORM_ANDROID
#include <QJniObject>
#include <QJniEnvironment>
#endif

class AndroidKeystoreManager : public QObject
{
    Q_OBJECT

public:
    explicit AndroidKeystoreManager(QObject *parent = nullptr);
    ~AndroidKeystoreManager();

    // Main keystore operations
    bool storeSecret(const QString &alias, const QString &secret);
    QString retrieveSecret(const QString &alias);
    bool deleteSecret(const QString &alias);
    bool hasSecret(const QString &alias);

    // Keystore status
    bool isKeystoreAvailable() const;
    bool isInitialized() const { return m_initialized; }

    // Utility methods
    static bool isAndroidKeystoreSupported();
    QStringList listStoredAliases();

public slots:
    void initializeKeystore();
    void clearAllSecrets();

signals:
    void keystoreInitialized(bool success);
    void secretStored(const QString &alias, bool success);
    void secretRetrieved(const QString &alias, const QString &secret, bool success);
    void secretDeleted(const QString &alias, bool success);
    void keystoreError(const QString &error);

private:
    void initializeJNI();
    bool generateKeyPair(const QString &alias);
    QByteArray encryptData(const QString &alias, const QByteArray &data);
    QByteArray decryptData(const QString &alias, const QByteArray &encryptedData);
    
    // SharedPreferences operations
    bool storeEncryptedInPreferences(const QString &alias, const QByteArray &data);
    QByteArray retrieveEncryptedFromPreferences(const QString &alias);
    void deleteEncryptedFromPreferences(const QString &alias);

    // Android specific members
#ifdef PLATFORM_ANDROID
    QJniObject m_keystoreManager;
    QJniObject m_keyStore;
    QJniObject m_keyGenerator;
    QJniObject m_cipher;
#endif

    bool m_initialized;
    bool m_keystoreAvailable;
    QString m_keystoreType;

    // Constants
    static const QString KEYSTORE_PROVIDER;
    static const QString TRANSFORMATION;
    static const QString KEY_ALGORITHM;
    static const int KEY_SIZE;
};

#ifdef PLATFORM_ANDROID
// JNI helper functions
extern "C" {
    JNIEXPORT void JNICALL Java_com_voiceaillm_app_KeystoreHelper_onKeystoreResult(
        JNIEnv *env, jobject thiz, jstring operation, jstring alias, jboolean success, jstring error);
}
#endif

#endif // ANDROIDKEYSTOREMANAGER_H 