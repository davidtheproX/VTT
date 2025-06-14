#include "SecureStorageManager.h"
#include "PlatformDetection.h"
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QCryptographicHash>
#include <QSettings>
#include <QDebug>
#include <QRandomGenerator>
#include <QByteArray>
#include <QEventLoop>

#if HAVE_QTKEYCHAIN
    #include <qt6keychain/keychain.h>
#endif

#ifdef PLATFORM_ANDROID
    #include <QJniObject>
    #include <QJniEnvironment>
#endif

SecureStorageManager::SecureStorageManager(QObject *parent)
    : QObject(parent)
    , m_secureStorageAvailable(false)
{
    initializeSecureStorage();
}

SecureStorageManager::~SecureStorageManager() = default;

void SecureStorageManager::initializeSecureStorage()
{
#ifdef PLATFORM_ANDROID
    // On Android, use Android Keystore directly via JNI
    m_secureStorageAvailable = initializeAndroidKeystore();
    if (m_secureStorageAvailable) {
        qDebug() << "SecureStorageManager: Android Keystore available - using hardware-backed security";
    } else {
        qDebug() << "SecureStorageManager: Android Keystore failed - falling back to encryption";
        initializeFallbackStorage();
    }
    qDebug() << "SecureStorageManager: Platform: Android";
#elif HAVE_QTKEYCHAIN
    m_secureStorageAvailable = true;
    qDebug() << "SecureStorageManager: Qt Keychain available - using secure storage";
    #ifdef QTKEYCHAIN_METHOD
        qDebug() << "SecureStorageManager: Qt Keychain detection method:" << QTKEYCHAIN_METHOD;
    #endif
    qDebug() << "SecureStorageManager: Platform:" << PLATFORM_NAME;
#else
    m_secureStorageAvailable = false;
    qDebug() << "SecureStorageManager: Qt Keychain not available - using fallback encryption";
    qDebug() << "SecureStorageManager: Platform:" << PLATFORM_NAME;
    initializeFallbackStorage();
#endif
}

#ifdef PLATFORM_ANDROID
bool SecureStorageManager::initializeAndroidKeystore()
{
    try {
        // Get Android context
        QJniObject activity = QJniObject::callStaticObjectMethod(
            "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
        
        if (!activity.isValid()) {
            qWarning() << "SecureStorageManager: Cannot get Android activity";
            return false;
        }

        // Initialize KeyStore
        QJniObject keyStore = QJniObject::callStaticObjectMethod(
            "java/security/KeyStore", "getInstance", "(Ljava/lang/String;)Ljava/security/KeyStore;",
            QJniObject::fromString("AndroidKeyStore").object<jstring>());
        
        if (!keyStore.isValid()) {
            qWarning() << "SecureStorageManager: Cannot get AndroidKeyStore instance";
            return false;
        }

        // Load the keystore
        keyStore.callMethod<void>("load", "(Ljava/security/KeyStore$LoadStoreParameter;)V", nullptr);
        
        m_androidKeyStore = keyStore;
        qDebug() << "SecureStorageManager: Android Keystore initialized successfully";
        return true;
        
    } catch (...) {
        qWarning() << "SecureStorageManager: Exception during Android Keystore initialization";
        return false;
    }
}

bool SecureStorageManager::storeInAndroidKeystore(const QString &key, const QString &value)
{
    if (!m_androidKeyStore.isValid()) {
        return false;
    }
    
    try {
        // Generate or get existing key
        if (!generateAndroidKey(key)) {
            qWarning() << "SecureStorageManager: Failed to generate Android key for" << key;
            return false;
        }
        
        // Encrypt and store the value
        QByteArray encrypted = encryptWithAndroidKey(key, value.toUtf8());
        if (encrypted.isEmpty()) {
            qWarning() << "SecureStorageManager: Failed to encrypt value for" << key;
            return false;
        }
        
        // Store encrypted data in SharedPreferences
        return storeEncryptedInPreferences(key, encrypted);
        
    } catch (...) {
        qWarning() << "SecureStorageManager: Exception storing in Android Keystore";
        return false;
    }
}

QString SecureStorageManager::retrieveFromAndroidKeystore(const QString &key)
{
    if (!m_androidKeyStore.isValid()) {
        return QString();
    }
    
    try {
        // Retrieve encrypted data from SharedPreferences
        QByteArray encrypted = retrieveEncryptedFromPreferences(key);
        if (encrypted.isEmpty()) {
            return QString();
        }
        
        // Decrypt the data
        QByteArray decrypted = decryptWithAndroidKey(key, encrypted);
        return QString::fromUtf8(decrypted);
        
    } catch (...) {
        qWarning() << "SecureStorageManager: Exception retrieving from Android Keystore";
        return QString();
    }
}

bool SecureStorageManager::generateAndroidKey(const QString &alias)
{
    try {
        // Check if key already exists
        if (m_androidKeyStore.callMethod<jboolean>("containsAlias", "(Ljava/lang/String;)Z",
                                                   QJniObject::fromString(alias).object<jstring>())) {
            return true; // Key already exists
        }
        
        // Generate new key
        QJniObject keyGenerator = QJniObject::callStaticObjectMethod(
            "javax/crypto/KeyGenerator", "getInstance", 
            "(Ljava/lang/String;Ljava/lang/String;)Ljavax/crypto/KeyGenerator;",
            QJniObject::fromString("AES").object<jstring>(),
            QJniObject::fromString("AndroidKeyStore").object<jstring>());
        
        if (!keyGenerator.isValid()) {
            return false;
        }
        
        // Initialize key generator
        QJniObject keyGenParameterSpec = createKeyGenParameterSpec(alias);
        keyGenerator.callMethod<void>("init", "(Ljava/security/spec/AlgorithmParameterSpec;)V",
                                     keyGenParameterSpec.object());
        
        // Generate the key
        keyGenerator.callMethod<jobject>("generateKey", "()Ljavax/crypto/SecretKey;");
        
        return true;
        
    } catch (...) {
        qWarning() << "SecureStorageManager: Exception generating Android key";
        return false;
    }
}

QJniObject SecureStorageManager::createKeyGenParameterSpec(const QString &alias)
{
    // Create KeyGenParameterSpec.Builder
    QJniObject builder = QJniObject("android/security/keystore/KeyGenParameterSpec$Builder",
                                   "(Ljava/lang/String;I)V",
                                   QJniObject::fromString(alias).object<jstring>(),
                                   3); // KeyProperties.PURPOSE_ENCRYPT | KeyProperties.PURPOSE_DECRYPT
    
    // Set block modes and encryption paddings
    QJniObject blockModes = QJniObject::fromString("GCM");
    QJniObject encryptionPaddings = QJniObject::fromString("NoPadding");
    
    builder.callObjectMethod("setBlockModes", "([Ljava/lang/String;)Landroid/security/keystore/KeyGenParameterSpec$Builder;",
                            createStringArray(QStringList() << "GCM").object());
    
    builder.callObjectMethod("setEncryptionPaddings", "([Ljava/lang/String;)Landroid/security/keystore/KeyGenParameterSpec$Builder;",
                            createStringArray(QStringList() << "NoPadding").object());
    
    // Build the spec
    return builder.callObjectMethod("build", "()Landroid/security/keystore/KeyGenParameterSpec;");
}

QJniObject SecureStorageManager::createStringArray(const QStringList &strings)
{
    QJniEnvironment env;
    jobjectArray array = env->NewObjectArray(strings.size(), env->FindClass("java/lang/String"), nullptr);
    
    for (int i = 0; i < strings.size(); ++i) {
        QJniObject javaString = QJniObject::fromString(strings[i]);
        env->SetObjectArrayElement(array, i, javaString.object<jstring>());
    }
    
    return QJniObject(array);
}
#endif

void SecureStorageManager::initializeFallbackStorage()
{
    // Initialize fallback storage path
    QString dataDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(dataDir);
    m_fallbackStoragePath = QDir(dataDir).filePath("secure_storage.json");
    
    // Load existing fallback storage
    QFile file(m_fallbackStoragePath);
    if (file.exists() && file.open(QIODevice::ReadOnly)) {
        QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
        if (!doc.isNull()) {
            m_fallbackStorage = doc.object();
        }
        file.close();
    }
}

bool SecureStorageManager::isSecureStorageAvailable() const
{
    return m_secureStorageAvailable;
}

void SecureStorageManager::storeCredential(const QString &key, const QString &value)
{
    if (value.isEmpty()) {
        deleteCredential(key);
        return;
    }

#if HAVE_QTKEYCHAIN
    if (m_secureStorageAvailable) {
        auto writeJob = std::make_unique<QKeychain::WritePasswordJob>(SERVICE_NAME);
        writeJob->setKey(key);
        writeJob->setTextData(value);
        
        connect(writeJob.get(), &QKeychain::Job::finished, this, [this, key](QKeychain::Job *job) {
            bool success = (job->error() == QKeychain::NoError);
            if (!success) {
                qWarning() << "Failed to store credential:" << job->errorString();
                emit error(QString("Failed to store %1: %2").arg(key, job->errorString()));
            } else {
                qDebug() << "Successfully stored credential:" << key;
            }
            emit credentialStored(key, success);
        });
        
        writeJob->start();
        writeJob.release(); // Qt will manage the lifetime
        return;
    }
#endif

    // Fallback to encrypted storage
    storeFallback(key, value);
    emit credentialStored(key, true);
}

QString SecureStorageManager::getCredential(const QString &key) const
{
#if HAVE_QTKEYCHAIN
    if (m_secureStorageAvailable) {
        auto readJob = std::make_unique<QKeychain::ReadPasswordJob>(SERVICE_NAME);
        readJob->setKey(key);
        
        // For synchronous operation, we'll use a blocking approach
        QEventLoop loop;
        QString result;
        bool success = false;
        
        QObject::connect(readJob.get(), &QKeychain::Job::finished, 
            [&result, &success, &loop, this, key](QKeychain::Job *job) {
            if (job->error() == QKeychain::NoError) {
                auto *readJobPtr = qobject_cast<QKeychain::ReadPasswordJob*>(job);
                if (readJobPtr) {
                    result = readJobPtr->textData();
                    success = true;
                }
            } else if (job->error() != QKeychain::EntryNotFound) {
                qWarning() << "Failed to read credential:" << job->errorString();
                emit const_cast<SecureStorageManager*>(this)->error(
                    QString("Failed to read %1: %2").arg(key, job->errorString()));
            }
            loop.quit();
        });
        
        readJob->start();
        loop.exec();
        readJob.release();
        
        emit const_cast<SecureStorageManager*>(this)->credentialRetrieved(key, result, success);
        return result;
    }
#endif

    // Fallback to encrypted storage
    QString result = getFallback(key);
    emit const_cast<SecureStorageManager*>(this)->credentialRetrieved(key, result, !result.isEmpty());
    return result;
}

void SecureStorageManager::deleteCredential(const QString &key)
{
#if HAVE_QTKEYCHAIN
    if (m_secureStorageAvailable) {
        auto deleteJob = std::make_unique<QKeychain::DeletePasswordJob>(SERVICE_NAME);
        deleteJob->setKey(key);
        
        connect(deleteJob.get(), &QKeychain::Job::finished, this, [this, key](QKeychain::Job *job) {
            bool success = (job->error() == QKeychain::NoError || job->error() == QKeychain::EntryNotFound);
            if (!success) {
                qWarning() << "Failed to delete credential:" << job->errorString();
                emit error(QString("Failed to delete %1: %2").arg(key, job->errorString()));
            } else {
                qDebug() << "Successfully deleted credential:" << key;
            }
            emit credentialDeleted(key, success);
        });
        
        deleteJob->start();
        deleteJob.release();
        return;
    }
#endif

    // Fallback storage
    deleteFallback(key);
    emit credentialDeleted(key, true);
}

bool SecureStorageManager::hasCredential(const QString &key) const
{
    return !getCredential(key).isEmpty();
}

void SecureStorageManager::storeSettings(const QString &key, const QVariant &value)
{
    QSettings settings(APP_NAME, APP_NAME);
    settings.setValue(key, value);
    settings.sync();
}

QVariant SecureStorageManager::getSettings(const QString &key, const QVariant &defaultValue) const
{
    QSettings settings(APP_NAME, APP_NAME);
    return settings.value(key, defaultValue);
}

// Fallback encryption methods
QString SecureStorageManager::generateEncryptionKey() const
{
    // Generate a machine-specific key based on available system information
    QByteArray data;
    data.append(QStandardPaths::writableLocation(QStandardPaths::HomeLocation).toUtf8());
    data.append(APP_NAME);
    
    // Add some randomness that persists per installation
    QSettings settings(APP_NAME, APP_NAME);
    QString machineId = settings.value("machine_id").toString();
    if (machineId.isEmpty()) {
        machineId = QString::number(QRandomGenerator::global()->generate64());
        settings.setValue("machine_id", machineId);
        settings.sync();
    }
    data.append(machineId.toUtf8());
    
    return QCryptographicHash::hash(data, QCryptographicHash::Sha256).toHex();
}

QString SecureStorageManager::encryptData(const QString &data) const
{
    // Simple XOR encryption with generated key (not cryptographically secure, but better than plaintext)
    QString key = generateEncryptionKey();
    QByteArray dataBytes = data.toUtf8();
    QByteArray keyBytes = key.toUtf8();
    
    QByteArray encrypted;
    for (int i = 0; i < dataBytes.size(); ++i) {
        encrypted.append(dataBytes[i] ^ keyBytes[i % keyBytes.size()]);
    }
    
    return encrypted.toBase64();
}

QString SecureStorageManager::decryptData(const QString &encryptedData) const
{
    try {
        QString key = generateEncryptionKey();
        QByteArray encrypted = QByteArray::fromBase64(encryptedData.toUtf8());
        QByteArray keyBytes = key.toUtf8();
        
        QByteArray decrypted;
        for (int i = 0; i < encrypted.size(); ++i) {
            decrypted.append(encrypted[i] ^ keyBytes[i % keyBytes.size()]);
        }
        
        return QString::fromUtf8(decrypted);
    } catch (...) {
        qWarning() << "Failed to decrypt data - returning empty string";
        return QString();
    }
}

void SecureStorageManager::storeFallback(const QString &key, const QString &value)
{
    QString encryptedValue = encryptData(value);
    m_fallbackStorage[key] = encryptedValue;
    
    // Save to file
    QFile file(m_fallbackStoragePath);
    if (file.open(QIODevice::WriteOnly)) {
        QJsonDocument doc(m_fallbackStorage);
        file.write(doc.toJson());
        file.close();
    } else {
        qWarning() << "Failed to save fallback storage:" << file.errorString();
    }
}

QString SecureStorageManager::getFallback(const QString &key) const
{
    if (!m_fallbackStorage.contains(key)) {
        return QString();
    }
    
    QString encryptedValue = m_fallbackStorage[key].toString();
    return decryptData(encryptedValue);
}

void SecureStorageManager::deleteFallback(const QString &key)
{
    if (m_fallbackStorage.contains(key)) {
        m_fallbackStorage.remove(key);
        
        // Save to file
        QFile file(m_fallbackStoragePath);
        if (file.open(QIODevice::WriteOnly)) {
            QJsonDocument doc(m_fallbackStorage);
            file.write(doc.toJson());
            file.close();
        }
    }
}

#if HAVE_QTKEYCHAIN
void SecureStorageManager::onJobFinished(QKeychain::Job *job)
{
    // This slot is used by Qt's MOC system for signal handling
    // The actual job handling is done in the lambda functions connected
    // to specific job types in the store/get/delete methods above
    Q_UNUSED(job);
}
#endif 