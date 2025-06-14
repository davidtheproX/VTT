#include "AndroidPermissionManager.h"
#include <QDebug>
#include <QCoreApplication>
#include <QTimer>

#ifdef PLATFORM_ANDROID
#include <QJniObject>
#include <QJniEnvironment>
#include <QtCore/private/qandroidextras_p.h>
#endif

// Permission constants
const QString AndroidPermissionManager::AndroidPermissions::RECORD_AUDIO = "android.permission.RECORD_AUDIO";
const QString AndroidPermissionManager::AndroidPermissions::WRITE_EXTERNAL_STORAGE = "android.permission.WRITE_EXTERNAL_STORAGE";
const QString AndroidPermissionManager::AndroidPermissions::READ_EXTERNAL_STORAGE = "android.permission.READ_EXTERNAL_STORAGE";
const QString AndroidPermissionManager::AndroidPermissions::INTERNET = "android.permission.INTERNET";
const QString AndroidPermissionManager::AndroidPermissions::ACCESS_NETWORK_STATE = "android.permission.ACCESS_NETWORK_STATE";
const QString AndroidPermissionManager::AndroidPermissions::WAKE_LOCK = "android.permission.WAKE_LOCK";
const QString AndroidPermissionManager::AndroidPermissions::CAMERA = "android.permission.CAMERA";
const QString AndroidPermissionManager::AndroidPermissions::VIBRATE = "android.permission.VIBRATE";

AndroidPermissionManager::AndroidPermissionManager(QObject *parent)
    : QObject(parent)
    , m_audioPermissionGranted(false)
    , m_storagePermissionGranted(false)
    , m_internetPermissionGranted(false)
    , m_initialized(false)
{
    qDebug() << "AndroidPermissionManager: Initializing permission manager";
    initializePermissions();
}

AndroidPermissionManager::~AndroidPermissionManager()
{
    qDebug() << "AndroidPermissionManager: Destroying permission manager";
}

void AndroidPermissionManager::initializePermissions()
{
#ifdef PLATFORM_ANDROID
    if (isAndroidPlatform()) {
        qDebug() << "AndroidPermissionManager: Running on Android platform";
        
        // Initialize JNI objects
        QJniEnvironment env;
        if (!env.isValid()) {
            qWarning() << "AndroidPermissionManager: Invalid JNI environment";
            return;
        }
        
        // Check initial permission status
        updatePermissionStatus();
        m_initialized = true;
        
        qDebug() << "AndroidPermissionManager: Initialization complete";
        qDebug() << "  Audio permission:" << m_audioPermissionGranted;
        qDebug() << "  Storage permission:" << m_storagePermissionGranted;
        qDebug() << "  Internet permission:" << m_internetPermissionGranted;
    } else {
        qDebug() << "AndroidPermissionManager: Not running on Android, permissions auto-granted";
        m_audioPermissionGranted = true;
        m_storagePermissionGranted = true;
        m_internetPermissionGranted = true;
        m_initialized = true;
    }
#else
    qDebug() << "AndroidPermissionManager: Compiled without Android support, permissions auto-granted";
    m_audioPermissionGranted = true;
    m_storagePermissionGranted = true;
    m_internetPermissionGranted = true;
    m_initialized = true;
#endif
    
    emit permissionStatusChanged();
}

bool AndroidPermissionManager::isAndroidPlatform()
{
#ifdef PLATFORM_ANDROID
    return true;
#else
    return false;
#endif
}

bool AndroidPermissionManager::hasPermission(const QString &permission)
{
#ifdef PLATFORM_ANDROID
    if (!isAndroidPlatform()) {
        return true; // Non-Android platforms don't need runtime permissions
    }
    
    QJniObject activity = QJniObject::callStaticObjectMethod(
        "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
    
    if (!activity.isValid()) {
        qWarning() << "AndroidPermissionManager: Cannot get Android activity";
        return false;
    }
    
    QJniObject javaPermission = QJniObject::fromString(permission);
    jint result = activity.callMethod<jint>("checkSelfPermission", "(Ljava/lang/String;)I", javaPermission.object<jstring>());
    
    // PackageManager.PERMISSION_GRANTED = 0
    bool granted = (result == 0);
    qDebug() << "AndroidPermissionManager: Permission" << permission << "status:" << (granted ? "GRANTED" : "DENIED");
    
    return granted;
#else
    Q_UNUSED(permission)
    return true;
#endif
}

void AndroidPermissionManager::requestPermission(const QString &permission)
{
#ifdef PLATFORM_ANDROID
    if (!isAndroidPlatform()) {
        return;
    }
    
    if (hasPermission(permission)) {
        qDebug() << "AndroidPermissionManager: Permission already granted:" << permission;
        return;
    }
    
    qDebug() << "AndroidPermissionManager: Requesting permission:" << permission;
    
    QJniObject activity = QJniObject::callStaticObjectMethod(
        "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
    
    if (!activity.isValid()) {
        qWarning() << "AndroidPermissionManager: Cannot get Android activity for permission request";
        return;
    }
    
    // Create permission array
    QJniEnvironment env;
    jobjectArray permissionArray = env->NewObjectArray(1, env->FindClass("java/lang/String"), nullptr);
    QJniObject javaPermission = QJniObject::fromString(permission);
    env->SetObjectArrayElement(permissionArray, 0, javaPermission.object<jstring>());
    
    // Request permission
    activity.callMethod<void>("requestPermissions", "([Ljava/lang/String;I)V", 
                             permissionArray, static_cast<jint>(1000));
    
    env->DeleteLocalRef(permissionArray);
#else
    Q_UNUSED(permission)
#endif
}

void AndroidPermissionManager::requestMultiplePermissions(const QStringList &permissions)
{
#ifdef PLATFORM_ANDROID
    if (!isAndroidPlatform() || permissions.isEmpty()) {
        return;
    }
    
    QStringList missingPermissions;
    for (const QString &permission : permissions) {
        if (!hasPermission(permission)) {
            missingPermissions.append(permission);
        }
    }
    
    if (missingPermissions.isEmpty()) {
        qDebug() << "AndroidPermissionManager: All permissions already granted";
        return;
    }
    
    qDebug() << "AndroidPermissionManager: Requesting permissions:" << missingPermissions;
    
    QJniObject activity = QJniObject::callStaticObjectMethod(
        "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
    
    if (!activity.isValid()) {
        qWarning() << "AndroidPermissionManager: Cannot get Android activity for multiple permission request";
        return;
    }
    
    // Create permission array
    QJniEnvironment env;
    jobjectArray permissionArray = env->NewObjectArray(missingPermissions.size(), env->FindClass("java/lang/String"), nullptr);
    
    for (int i = 0; i < missingPermissions.size(); ++i) {
        QJniObject javaPermission = QJniObject::fromString(missingPermissions[i]);
        env->SetObjectArrayElement(permissionArray, i, javaPermission.object<jstring>());
    }
    
    // Request permissions
    activity.callMethod<void>("requestPermissions", "([Ljava/lang/String;I)V", 
                             permissionArray, static_cast<jint>(ALL_PERMISSIONS_REQUEST));
    
    env->DeleteLocalRef(permissionArray);
#else
    Q_UNUSED(permissions)
#endif
}

void AndroidPermissionManager::requestAudioPermission()
{
    qDebug() << "AndroidPermissionManager: Requesting audio permission";
    requestPermission(AndroidPermissions::RECORD_AUDIO);
}

void AndroidPermissionManager::requestStoragePermission()
{
    qDebug() << "AndroidPermissionManager: Requesting storage permissions";
    QStringList storagePermissions;
    storagePermissions << AndroidPermissions::WRITE_EXTERNAL_STORAGE
                      << AndroidPermissions::READ_EXTERNAL_STORAGE;
    requestMultiplePermissions(storagePermissions);
}

void AndroidPermissionManager::requestAllPermissions()
{
    qDebug() << "AndroidPermissionManager: Requesting all permissions";
    QStringList allPermissions;
    allPermissions << AndroidPermissions::RECORD_AUDIO
                  << AndroidPermissions::WRITE_EXTERNAL_STORAGE
                  << AndroidPermissions::READ_EXTERNAL_STORAGE
                  << AndroidPermissions::INTERNET
                  << AndroidPermissions::ACCESS_NETWORK_STATE
                  << AndroidPermissions::WAKE_LOCK;
    requestMultiplePermissions(allPermissions);
}

void AndroidPermissionManager::checkPermissionStatus()
{
    qDebug() << "AndroidPermissionManager: Checking permission status";
    updatePermissionStatus();
}

void AndroidPermissionManager::refreshPermissions()
{
    qDebug() << "AndroidPermissionManager: Refreshing permissions";
    updatePermissionStatus();
    emit permissionStatusChanged();
}

void AndroidPermissionManager::updatePermissionStatus()
{
    bool audioOld = m_audioPermissionGranted;
    bool storageOld = m_storagePermissionGranted;
    bool internetOld = m_internetPermissionGranted;
    
    m_audioPermissionGranted = hasPermission(AndroidPermissions::RECORD_AUDIO);
    m_storagePermissionGranted = hasPermission(AndroidPermissions::WRITE_EXTERNAL_STORAGE) &&
                                hasPermission(AndroidPermissions::READ_EXTERNAL_STORAGE);
    m_internetPermissionGranted = hasPermission(AndroidPermissions::INTERNET) &&
                                 hasPermission(AndroidPermissions::ACCESS_NETWORK_STATE);
    
    // Emit change signals if status changed
    if (audioOld != m_audioPermissionGranted) {
        emit audioPermissionChanged();
        emit permissionGranted(AndroidPermissions::RECORD_AUDIO);
    }
    
    if (storageOld != m_storagePermissionGranted) {
        emit storagePermissionChanged();
    }
    
    if (internetOld != m_internetPermissionGranted) {
        emit internetPermissionChanged();
    }
    
    // Check if all permissions are granted
    if (m_audioPermissionGranted && m_storagePermissionGranted && m_internetPermissionGranted) {
        emit allPermissionsGranted();
    }
}

void AndroidPermissionManager::onPermissionResult(const QString &permission, bool granted)
{
    qDebug() << "AndroidPermissionManager: Permission result -" << permission << ":" << (granted ? "GRANTED" : "DENIED");
    
    if (granted) {
        emit permissionGranted(permission);
    } else {
        emit permissionDenied(permission);
    }
    
    // Update status after permission result
    QTimer::singleShot(100, this, &AndroidPermissionManager::updatePermissionStatus);
}

void AndroidPermissionManager::handlePermissionResult(int requestCode, const QStringList &permissions, const QList<int> &grantResults)
{
    qDebug() << "AndroidPermissionManager: Handling permission result, request code:" << requestCode;
    
    for (int i = 0; i < permissions.size() && i < grantResults.size(); ++i) {
        bool granted = (grantResults[i] == 0); // PackageManager.PERMISSION_GRANTED = 0
        onPermissionResult(permissions[i], granted);
    }
    
    updatePermissionStatus();
}

#ifdef PLATFORM_ANDROID
// JNI callback implementation
extern "C" JNIEXPORT void JNICALL
Java_com_voiceaillm_app_PermissionHelper_onPermissionResult(JNIEnv *env, jobject thiz, 
                                                           jint requestCode, jobjectArray permissions, jintArray grantResults)
{
    Q_UNUSED(thiz)
    
    // Convert Java arrays to Qt types
    QStringList permissionList;
    QList<int> resultList;
    
    jsize permissionCount = env->GetArrayLength(permissions);
    jsize resultCount = env->GetArrayLength(grantResults);
    
    // Get permissions
    for (jsize i = 0; i < permissionCount; ++i) {
        jstring javaString = (jstring)env->GetObjectArrayElement(permissions, i);
        const char *nativeString = env->GetStringUTFChars(javaString, 0);
        permissionList.append(QString::fromUtf8(nativeString));
        env->ReleaseStringUTFChars(javaString, nativeString);
        env->DeleteLocalRef(javaString);
    }
    
    // Get results
    jint *results = env->GetIntArrayElements(grantResults, nullptr);
    for (jsize i = 0; i < resultCount; ++i) {
        resultList.append(results[i]);
    }
    env->ReleaseIntArrayElements(grantResults, results, 0);
    
    // Find the AndroidPermissionManager instance and call the handler
    // This would typically be done through a global instance or singleton
    qDebug() << "JNI: Permission result callback received";
}
#endif 