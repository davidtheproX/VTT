#ifndef ANDROIDPERMISSIONMANAGER_H
#define ANDROIDPERMISSIONMANAGER_H

#include <QObject>
#include <QStringList>
#include <QJniObject>
#include <QJniEnvironment>
#include <QCoreApplication>
#include <QtCore/qpermissions.h>
#include "PlatformDetection.h"

class AndroidPermissionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool audioPermissionGranted READ audioPermissionGranted NOTIFY audioPermissionChanged)
    Q_PROPERTY(bool storagePermissionGranted READ storagePermissionGranted NOTIFY storagePermissionChanged)
    Q_PROPERTY(bool internetPermissionGranted READ internetPermissionGranted NOTIFY internetPermissionChanged)

public:
    explicit AndroidPermissionManager(QObject *parent = nullptr);
    ~AndroidPermissionManager();

    // Permission status getters
    bool audioPermissionGranted() const { return m_audioPermissionGranted; }
    bool storagePermissionGranted() const { return m_storagePermissionGranted; }
    bool internetPermissionGranted() const { return m_internetPermissionGranted; }

    // Static utility methods
    static bool isAndroidPlatform();
    static bool hasPermission(const QString &permission);
    static void requestPermission(const QString &permission);
    static void requestMultiplePermissions(const QStringList &permissions);

public slots:
    // Request specific permissions
    void requestAudioPermission();
    void requestStoragePermission();
    void requestAllPermissions();
    
    // Check permission status
    void checkPermissionStatus();
    void refreshPermissions();

    // Handle permission results
    void onPermissionResult(const QString &permission, bool granted);

signals:
    void audioPermissionChanged();
    void storagePermissionChanged();
    void internetPermissionChanged();
    void permissionGranted(const QString &permission);
    void permissionDenied(const QString &permission);
    void allPermissionsGranted();
    void permissionStatusChanged();

private:
    void initializePermissions();
    void updatePermissionStatus();
    bool checkAndroidPermission(const QString &permission);
    void requestAndroidPermission(const QString &permission);

    // Permission status
    bool m_audioPermissionGranted;
    bool m_storagePermissionGranted;
    bool m_internetPermissionGranted;
    bool m_initialized;

    // Android specific
    QJniObject m_javaPermissionManager;
    
    // Permission constants
    struct AndroidPermissions {
        static const QString RECORD_AUDIO;
        static const QString WRITE_EXTERNAL_STORAGE;
        static const QString READ_EXTERNAL_STORAGE;
        static const QString INTERNET;
        static const QString ACCESS_NETWORK_STATE;
        static const QString WAKE_LOCK;
        static const QString CAMERA;
        static const QString VIBRATE;
    };

    // Permission request codes
    enum PermissionRequestCode {
        AUDIO_PERMISSION_REQUEST = 1000,
        STORAGE_PERMISSION_REQUEST = 1001,
        ALL_PERMISSIONS_REQUEST = 1002
    };

private slots:
    void handlePermissionResult(int requestCode, const QStringList &permissions, const QList<int> &grantResults);
};

#ifdef PLATFORM_ANDROID
// JNI callback functions
extern "C" {
    JNIEXPORT void JNICALL Java_com_voiceaillm_app_PermissionHelper_onPermissionResult(
        JNIEnv *env, jobject thiz, jint requestCode, jobjectArray permissions, jintArray grantResults);
}
#endif

#endif // ANDROIDPERMISSIONMANAGER_H 