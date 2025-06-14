#include "AndroidKeystoreManager.h"
#include <QDebug>
#include <QCoreApplication>
#include <QThread>

#ifdef PLATFORM_ANDROID
#include <QJniObject>
#include <QJniEnvironment>
#endif

// Constants
const QString AndroidKeystoreManager::KEYSTORE_PROVIDER = "AndroidKeyStore";
const QString AndroidKeystoreManager::TRANSFORMATION = "AES/GCM/NoPadding";
const QString AndroidKeystoreManager::KEY_ALGORITHM = "AES";
const int AndroidKeystoreManager::KEY_SIZE = 256;

AndroidKeystoreManager::AndroidKeystoreManager(QObject *parent)
    : QObject(parent)
    , m_initialized(false)
    , m_keystoreAvailable(false)
    , m_keystoreType(KEYSTORE_PROVIDER)
{
    qDebug() << "AndroidKeystoreManager: Initializing Android Keystore manager";
    initializeKeystore();
}

AndroidKeystoreManager::~AndroidKeystoreManager()
{
    qDebug() << "AndroidKeystoreManager: Destroying keystore manager";
}

bool AndroidKeystoreManager::isAndroidKeystoreSupported()
{
#ifdef PLATFORM_ANDROID
    return true;
#else
    return false;
#endif
}

void AndroidKeystoreManager::initializeKeystore()
{
#ifdef PLATFORM_ANDROID
    qDebug() << "AndroidKeystoreManager: Initializing hardware-backed Android Keystore";
    
    try {
        initializeJNI();
        
        if (m_keyStore.isValid()) {
            m_keystoreAvailable = true;
            m_initialized = true;
            
            qDebug() << "AndroidKeystoreManager: Successfully initialized Android Keystore";
            qDebug() << "  - Hardware-backed security: ENABLED";
            qDebug() << "  - Keystore type:" << m_keystoreType;
            qDebug() << "  - Encryption algorithm:" << KEY_ALGORITHM;
            qDebug() << "  - Key size:" << KEY_SIZE << "bits";
            
            emit keystoreInitialized(true);
        } else {
            qWarning() << "AndroidKeystoreManager: Failed to initialize Android Keystore";
            m_keystoreAvailable = false;
            m_initialized = false;
            emit keystoreInitialized(false);
        }
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception during keystore initialization";
        m_keystoreAvailable = false;
        m_initialized = false;
        emit keystoreInitialized(false);
    }
#else
    qDebug() << "AndroidKeystoreManager: Not running on Android platform";
    m_keystoreAvailable = false;
    m_initialized = false;
    emit keystoreInitialized(false);
#endif
}

#ifdef PLATFORM_ANDROID
void AndroidKeystoreManager::initializeJNI()
{
    try {
        // Get KeyStore instance
        QJniObject keyStore = QJniObject::callStaticObjectMethod(
            "java/security/KeyStore", "getInstance",
            "(Ljava/lang/String;)Ljava/security/KeyStore;",
            QJniObject::fromString(KEYSTORE_PROVIDER).object<jstring>());
        
        if (!keyStore.isValid()) {
            qWarning() << "AndroidKeystoreManager: Failed to get KeyStore instance";
            return;
        }
        
        // Load the keystore
        keyStore.callMethod<void>("load", "(Ljava/security/KeyStore$LoadStoreParameter;)V", nullptr);
        
        // Initialize KeyGenerator
        QJniObject keyGenerator = QJniObject::callStaticObjectMethod(
            "javax/crypto/KeyGenerator", "getInstance",
            "(Ljava/lang/String;Ljava/lang/String;)Ljavax/crypto/KeyGenerator;",
            QJniObject::fromString(KEY_ALGORITHM).object<jstring>(),
            QJniObject::fromString(KEYSTORE_PROVIDER).object<jstring>());
        
        // Initialize Cipher
        QJniObject cipher = QJniObject::callStaticObjectMethod(
            "javax/crypto/Cipher", "getInstance",
            "(Ljava/lang/String;)Ljavax/crypto/Cipher;",
            QJniObject::fromString(TRANSFORMATION).object<jstring>());
        
        // Store JNI objects
        m_keyStore = keyStore;
        m_keyGenerator = keyGenerator;
        m_cipher = cipher;
        
        qDebug() << "AndroidKeystoreManager: JNI objects initialized successfully";
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception during JNI initialization";
        m_keyStore = QJniObject();
        m_keyGenerator = QJniObject();
        m_cipher = QJniObject();
    }
}
#endif

bool AndroidKeystoreManager::isKeystoreAvailable() const
{
    return m_keystoreAvailable;
}

bool AndroidKeystoreManager::storeSecret(const QString &alias, const QString &secret)
{
    if (!m_initialized || !m_keystoreAvailable) {
        qWarning() << "AndroidKeystoreManager: Keystore not initialized";
        emit keystoreError("Keystore not initialized");
        return false;
    }
    
    if (alias.isEmpty() || secret.isEmpty()) {
        qWarning() << "AndroidKeystoreManager: Invalid alias or secret";
        emit keystoreError("Invalid alias or secret");
        return false;
    }
    
    qDebug() << "AndroidKeystoreManager: Storing secret with alias:" << alias;
    
#ifdef PLATFORM_ANDROID
    try {
        // Generate or get existing key
        if (!generateKeyPair(alias)) {
            qWarning() << "AndroidKeystoreManager: Failed to generate key for alias:" << alias;
            emit secretStored(alias, false);
            return false;
        }
        
        // Encrypt the secret
        QByteArray encrypted = encryptData(alias, secret.toUtf8());
        if (encrypted.isEmpty()) {
            qWarning() << "AndroidKeystoreManager: Failed to encrypt secret for alias:" << alias;
            emit secretStored(alias, false);
            return false;
        }
        
        // Store encrypted data using Android SharedPreferences
        bool stored = storeEncryptedInPreferences(alias, encrypted);
        if (stored) {
            qDebug() << "AndroidKeystoreManager: Successfully stored secret for alias:" << alias;
            emit secretStored(alias, true);
            return true;
        } else {
            qWarning() << "AndroidKeystoreManager: Failed to store encrypted data for alias:" << alias;
            emit secretStored(alias, false);
            return false;
        }
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception storing secret for alias:" << alias;
        emit secretStored(alias, false);
        return false;
    }
#else
    emit secretStored(alias, false);
    return false;
#endif
}

QString AndroidKeystoreManager::retrieveSecret(const QString &alias)
{
    if (!m_initialized || !m_keystoreAvailable) {
        qWarning() << "AndroidKeystoreManager: Keystore not initialized";
        emit keystoreError("Keystore not initialized");
        return QString();
    }
    
    if (alias.isEmpty()) {
        qWarning() << "AndroidKeystoreManager: Invalid alias";
        emit keystoreError("Invalid alias");
        return QString();
    }
    
    qDebug() << "AndroidKeystoreManager: Retrieving secret with alias:" << alias;
    
#ifdef PLATFORM_ANDROID
    try {
        // Check if the key exists
        if (!m_keyStore.callMethod<jboolean>("containsAlias",
                                            "(Ljava/lang/String;)Z",
                                            QJniObject::fromString(alias).object<jstring>())) {
            qDebug() << "AndroidKeystoreManager: No key found for alias:" << alias;
            emit secretRetrieved(alias, QString(), false);
            return QString();
        }
        
        // Retrieve encrypted data from SharedPreferences
        QByteArray encrypted = retrieveEncryptedFromPreferences(alias);
        if (encrypted.isEmpty()) {
            qDebug() << "AndroidKeystoreManager: No encrypted data found for alias:" << alias;
            emit secretRetrieved(alias, QString(), false);
            return QString();
        }
        
        // Decrypt the data
        QByteArray decrypted = decryptData(alias, encrypted);
        if (decrypted.isEmpty()) {
            qWarning() << "AndroidKeystoreManager: Failed to decrypt data for alias:" << alias;
            emit secretRetrieved(alias, QString(), false);
            return QString();
        }
        
        QString secret = QString::fromUtf8(decrypted);
        qDebug() << "AndroidKeystoreManager: Successfully retrieved secret for alias:" << alias;
        emit secretRetrieved(alias, secret, true);
        return secret;
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception retrieving secret for alias:" << alias;
        emit secretRetrieved(alias, QString(), false);
        return QString();
    }
#else
    emit secretRetrieved(alias, QString(), false);
    return QString();
#endif
}

bool AndroidKeystoreManager::deleteSecret(const QString &alias)
{
    if (!m_initialized || !m_keystoreAvailable) {
        qWarning() << "AndroidKeystoreManager: Keystore not initialized";
        emit keystoreError("Keystore not initialized");
        return false;
    }
    
    if (alias.isEmpty()) {
        qWarning() << "AndroidKeystoreManager: Invalid alias";
        emit keystoreError("Invalid alias");
        return false;
    }
    
    qDebug() << "AndroidKeystoreManager: Deleting secret with alias:" << alias;
    
#ifdef PLATFORM_ANDROID
    try {
        // Delete key from keystore
        if (m_keyStore.callMethod<jboolean>("containsAlias",
                                           "(Ljava/lang/String;)Z",
                                           QJniObject::fromString(alias).object<jstring>())) {
            m_keyStore.callMethod<void>("deleteEntry",
                                       "(Ljava/lang/String;)V",
                                       QJniObject::fromString(alias).object<jstring>());
        }
        
        // Delete encrypted data from SharedPreferences
        deleteEncryptedFromPreferences(alias);
        
        qDebug() << "AndroidKeystoreManager: Successfully deleted secret for alias:" << alias;
        emit secretDeleted(alias, true);
        return true;
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception deleting secret for alias:" << alias;
        emit secretDeleted(alias, false);
        return false;
    }
#else
    emit secretDeleted(alias, false);
    return false;
#endif
}

bool AndroidKeystoreManager::hasSecret(const QString &alias)
{
    if (!m_initialized || !m_keystoreAvailable || alias.isEmpty()) {
        return false;
    }
    
#ifdef PLATFORM_ANDROID
    try {
        // Check if key exists in keystore
        bool keyExists = m_keyStore.callMethod<jboolean>("containsAlias",
                                                         "(Ljava/lang/String;)Z",
                                                         QJniObject::fromString(alias).object<jstring>());
        
        // Check if encrypted data exists in SharedPreferences
        bool dataExists = !retrieveEncryptedFromPreferences(alias).isEmpty();
        
        return keyExists && dataExists;
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception checking secret existence for alias:" << alias;
        return false;
    }
#else
    return false;
#endif
}

QStringList AndroidKeystoreManager::listStoredAliases()
{
    QStringList aliases;
    
    if (!m_initialized || !m_keystoreAvailable) {
        return aliases;
    }
    
#ifdef PLATFORM_ANDROID
    try {
        // Get all aliases from keystore
        QJniObject enumeration = m_keyStore.callObjectMethod("aliases", "()Ljava/util/Enumeration;");
        
        if (enumeration.isValid()) {
            while (enumeration.callMethod<jboolean>("hasMoreElements", "()Z")) {
                QJniObject aliasObj = enumeration.callObjectMethod("nextElement", "()Ljava/lang/Object;");
                if (aliasObj.isValid()) {
                    QString alias = aliasObj.toString();
                    aliases.append(alias);
                }
            }
        }
        
        qDebug() << "AndroidKeystoreManager: Found" << aliases.size() << "stored aliases";
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception listing stored aliases";
    }
#endif
    
    return aliases;
}

void AndroidKeystoreManager::clearAllSecrets()
{
    qDebug() << "AndroidKeystoreManager: Clearing all secrets";
    
    QStringList aliases = listStoredAliases();
    for (const QString &alias : aliases) {
        deleteSecret(alias);
    }
    
    qDebug() << "AndroidKeystoreManager: Cleared" << aliases.size() << "secrets";
}

#ifdef PLATFORM_ANDROID
bool AndroidKeystoreManager::generateKeyPair(const QString &alias)
{
    try {
        // Check if key already exists
        if (m_keyStore.callMethod<jboolean>("containsAlias",
                                           "(Ljava/lang/String;)Z",
                                           QJniObject::fromString(alias).object<jstring>())) {
            qDebug() << "AndroidKeystoreManager: Key already exists for alias:" << alias;
            return true;
        }
        
        // Create KeyGenParameterSpec.Builder
        QJniObject builder = QJniObject("android/security/keystore/KeyGenParameterSpec$Builder",
                                       "(Ljava/lang/String;I)V",
                                       QJniObject::fromString(alias).object<jstring>(),
                                       3); // PURPOSE_ENCRYPT | PURPOSE_DECRYPT
        
        // Set key size
        builder.callObjectMethod("setKeySize",
                                "(I)Landroid/security/keystore/KeyGenParameterSpec$Builder;",
                                KEY_SIZE);
        
        // Set block modes
        QJniEnvironment env;
        jobjectArray blockModes = env->NewObjectArray(1, env->FindClass("java/lang/String"), nullptr);
        QJniObject gcmMode = QJniObject::fromString("GCM");
        env->SetObjectArrayElement(blockModes, 0, gcmMode.object<jstring>());
        
        builder.callObjectMethod("setBlockModes",
                                "([Ljava/lang/String;)Landroid/security/keystore/KeyGenParameterSpec$Builder;",
                                blockModes);
        
        // Set encryption paddings
        jobjectArray paddings = env->NewObjectArray(1, env->FindClass("java/lang/String"), nullptr);
        QJniObject noPadding = QJniObject::fromString("NoPadding");
        env->SetObjectArrayElement(paddings, 0, noPadding.object<jstring>());
        
        builder.callObjectMethod("setEncryptionPaddings",
                                "([Ljava/lang/String;)Landroid/security/keystore/KeyGenParameterSpec$Builder;",
                                paddings);
        
        // Build the spec
        QJniObject keyGenParameterSpec = builder.callObjectMethod("build",
                                                                  "()Landroid/security/keystore/KeyGenParameterSpec;");
        
        // Initialize key generator
        m_keyGenerator.callMethod<void>("init",
                                       "(Ljava/security/spec/AlgorithmParameterSpec;)V",
                                       keyGenParameterSpec.object());
        
        // Generate the key
        QJniObject secretKey = m_keyGenerator.callObjectMethod("generateKey",
                                                              "()Ljavax/crypto/SecretKey;");
        
        env->DeleteLocalRef(blockModes);
        env->DeleteLocalRef(paddings);
        
        if (secretKey.isValid()) {
            qDebug() << "AndroidKeystoreManager: Successfully generated key for alias:" << alias;
            return true;
        } else {
            qWarning() << "AndroidKeystoreManager: Failed to generate key for alias:" << alias;
            return false;
        }
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception generating key for alias:" << alias;
        return false;
    }
}

QByteArray AndroidKeystoreManager::encryptData(const QString &alias, const QByteArray &data)
{
    try {
        // Get the secret key
        QJniObject secretKey = m_keyStore.callObjectMethod("getKey",
                                                          "(Ljava/lang/String;[C)Ljava/security/Key;",
                                                          QJniObject::fromString(alias).object<jstring>(),
                                                          nullptr);
        
        if (!secretKey.isValid()) {
            qWarning() << "AndroidKeystoreManager: Failed to get key for encryption";
            return QByteArray();
        }
        
        // Initialize cipher for encryption
        m_cipher.callMethod<void>("init",
                                 "(ILjava/security/Key;)V",
                                 1, // Cipher.ENCRYPT_MODE
                                 secretKey.object());
        
        // Convert QByteArray to Java byte array
        QJniEnvironment env;
        jbyteArray jData = env->NewByteArray(data.size());
        env->SetByteArrayRegion(jData, 0, data.size(), reinterpret_cast<const jbyte*>(data.constData()));
        
        // Encrypt the data
        jbyteArray encryptedData = static_cast<jbyteArray>(
            m_cipher.callObjectMethod("doFinal", "([B)[B", jData).object());
        
        // Get IV
        QJniObject ivParams = m_cipher.callObjectMethod("getParameters", "()Ljava/security/AlgorithmParameters;");
        jbyteArray iv = static_cast<jbyteArray>(
            ivParams.callObjectMethod("getEncoded", "()[B").object());
        
        // Convert back to QByteArray and combine IV + encrypted data
        jsize encryptedSize = env->GetArrayLength(encryptedData);
        jsize ivSize = env->GetArrayLength(iv);
        
        QByteArray result;
        result.resize(4 + ivSize + encryptedSize); // 4 bytes for IV length
        
        // Store IV length
        qint32 ivLength = ivSize;
        memcpy(result.data(), &ivLength, 4);
        
        // Store IV
        jbyte* ivBytes = env->GetByteArrayElements(iv, nullptr);
        memcpy(result.data() + 4, ivBytes, ivSize);
        env->ReleaseByteArrayElements(iv, ivBytes, 0);
        
        // Store encrypted data
        jbyte* encryptedBytes = env->GetByteArrayElements(encryptedData, nullptr);
        memcpy(result.data() + 4 + ivSize, encryptedBytes, encryptedSize);
        env->ReleaseByteArrayElements(encryptedData, encryptedBytes, 0);
        
        env->DeleteLocalRef(jData);
        env->DeleteLocalRef(encryptedData);
        env->DeleteLocalRef(iv);
        
        return result;
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception during encryption";
        return QByteArray();
    }
}

QByteArray AndroidKeystoreManager::decryptData(const QString &alias, const QByteArray &encryptedData)
{
    try {
        if (encryptedData.size() < 4) {
            qWarning() << "AndroidKeystoreManager: Invalid encrypted data format";
            return QByteArray();
        }
        
        // Extract IV length
        qint32 ivLength;
        memcpy(&ivLength, encryptedData.constData(), 4);
        
        if (ivLength < 0 || ivLength > encryptedData.size() - 4) {
            qWarning() << "AndroidKeystoreManager: Invalid IV length";
            return QByteArray();
        }
        
        // Extract IV and encrypted data
        QByteArray iv = encryptedData.mid(4, ivLength);
        QByteArray cipherText = encryptedData.mid(4 + ivLength);
        
        // Get the secret key
        QJniObject secretKey = m_keyStore.callObjectMethod("getKey",
                                                          "(Ljava/lang/String;[C)Ljava/security/Key;",
                                                          QJniObject::fromString(alias).object<jstring>(),
                                                          nullptr);
        
        if (!secretKey.isValid()) {
            qWarning() << "AndroidKeystoreManager: Failed to get key for decryption";
            return QByteArray();
        }
        
        // Create GCMParameterSpec with IV
        QJniObject gcmParams = QJniObject("javax/crypto/spec/GCMParameterSpec",
                                         "(I[B)V",
                                         128, // 128-bit tag length
                                         iv.constData());
        
        // Initialize cipher for decryption
        m_cipher.callMethod<void>("init",
                                 "(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V",
                                 2, // Cipher.DECRYPT_MODE
                                 secretKey.object(),
                                 gcmParams.object());
        
        // Convert cipher text to Java byte array
        QJniEnvironment env;
        jbyteArray jCipherText = env->NewByteArray(cipherText.size());
        env->SetByteArrayRegion(jCipherText, 0, cipherText.size(),
                               reinterpret_cast<const jbyte*>(cipherText.constData()));
        
        // Decrypt the data
        jbyteArray decryptedData = static_cast<jbyteArray>(
            m_cipher.callObjectMethod("doFinal", "([B)[B", jCipherText).object());
        
        // Convert back to QByteArray
        jsize decryptedSize = env->GetArrayLength(decryptedData);
        jbyte* decryptedBytes = env->GetByteArrayElements(decryptedData, nullptr);
        
        QByteArray result(reinterpret_cast<const char*>(decryptedBytes), decryptedSize);
        
        env->ReleaseByteArrayElements(decryptedData, decryptedBytes, 0);
        env->DeleteLocalRef(jCipherText);
        env->DeleteLocalRef(decryptedData);
        
        return result;
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception during decryption";
        return QByteArray();
    }
}

bool AndroidKeystoreManager::storeEncryptedInPreferences(const QString &alias, const QByteArray &data)
{
    try {
        // Get Android context
        QJniObject activity = QJniObject::callStaticObjectMethod(
            "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
        
        if (!activity.isValid()) {
            qWarning() << "AndroidKeystoreManager: Cannot get Android context";
            return false;
        }
        
        // Get SharedPreferences
        QJniObject sharedPrefs = activity.callObjectMethod(
            "getSharedPreferences",
            "(Ljava/lang/String;I)Landroid/content/SharedPreferences;",
            QJniObject::fromString("VoiceAILLM_SecureStorage").object<jstring>(),
            0); // MODE_PRIVATE
        
        // Get editor
        QJniObject editor = sharedPrefs.callObjectMethod("edit",
                                                         "()Landroid/content/SharedPreferences$Editor;");
        
        // Convert data to Base64 string
        QString base64Data = data.toBase64();
        
        // Store the data
        editor.callObjectMethod("putString",
                               "(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;",
                               QJniObject::fromString(alias).object<jstring>(),
                               QJniObject::fromString(base64Data).object<jstring>());
        
        // Commit changes
        bool success = editor.callMethod<jboolean>("commit", "()Z");
        
        if (success) {
            qDebug() << "AndroidKeystoreManager: Successfully stored encrypted data in SharedPreferences";
        } else {
            qWarning() << "AndroidKeystoreManager: Failed to commit data to SharedPreferences";
        }
        
        return success;
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception storing encrypted data in SharedPreferences";
        return false;
    }
}

QByteArray AndroidKeystoreManager::retrieveEncryptedFromPreferences(const QString &alias)
{
    try {
        // Get Android context
        QJniObject activity = QJniObject::callStaticObjectMethod(
            "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
        
        if (!activity.isValid()) {
            qWarning() << "AndroidKeystoreManager: Cannot get Android context";
            return QByteArray();
        }
        
        // Get SharedPreferences
        QJniObject sharedPrefs = activity.callObjectMethod(
            "getSharedPreferences",
            "(Ljava/lang/String;I)Landroid/content/SharedPreferences;",
            QJniObject::fromString("VoiceAILLM_SecureStorage").object<jstring>(),
            0); // MODE_PRIVATE
        
        // Get the data
        QJniObject base64Data = sharedPrefs.callObjectMethod(
            "getString",
            "(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;",
            QJniObject::fromString(alias).object<jstring>(),
            QJniObject::fromString("").object<jstring>());
        
        QString dataString = base64Data.toString();
        if (dataString.isEmpty()) {
            return QByteArray();
        }
        
        // Convert from Base64
        QByteArray data = QByteArray::fromBase64(dataString.toUtf8());
        return data;
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception retrieving encrypted data from SharedPreferences";
        return QByteArray();
    }
}

void AndroidKeystoreManager::deleteEncryptedFromPreferences(const QString &alias)
{
    try {
        // Get Android context
        QJniObject activity = QJniObject::callStaticObjectMethod(
            "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
        
        if (!activity.isValid()) {
            qWarning() << "AndroidKeystoreManager: Cannot get Android context";
            return;
        }
        
        // Get SharedPreferences
        QJniObject sharedPrefs = activity.callObjectMethod(
            "getSharedPreferences",
            "(Ljava/lang/String;I)Landroid/content/SharedPreferences;",
            QJniObject::fromString("VoiceAILLM_SecureStorage").object<jstring>(),
            0); // MODE_PRIVATE
        
        // Get editor
        QJniObject editor = sharedPrefs.callObjectMethod("edit",
                                                         "()Landroid/content/SharedPreferences$Editor;");
        
        // Remove the data
        editor.callObjectMethod("remove",
                               "(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;",
                               QJniObject::fromString(alias).object<jstring>());
        
        // Commit changes
        editor.callMethod<jboolean>("commit", "()Z");
        
    } catch (...) {
        qWarning() << "AndroidKeystoreManager: Exception deleting encrypted data from SharedPreferences";
    }
}
#endif 