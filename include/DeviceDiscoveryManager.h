#ifndef DEVICEDISCOVERYMANAGER_H
#define DEVICEDISCOVERYMANAGER_H

#include <QObject>
#include <QAbstractListModel>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QNetworkInterface>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <QHostInfo>
#include <QTcpSocket>
#include <QUdpSocket>
#include <QHostAddress>
#include <QProcess>
#include <QDateTime>
#include <qqmlintegration.h>
#include "QPing.h"

class DeviceInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString type READ type NOTIFY typeChanged)
    Q_PROPERTY(QString address READ address NOTIFY addressChanged)
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)
    Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)
    QML_ELEMENT

public:
    explicit DeviceInfo(QObject *parent = nullptr);
    DeviceInfo(const QString &name, const QString &type, const QString &address, 
               const QString &description = QString(), QObject *parent = nullptr);

    QString name() const { return m_name; }
    QString type() const { return m_type; }
    QString address() const { return m_address; }
    QString status() const { return m_status; }
    QString description() const { return m_description; }
    bool isConnected() const { return m_isConnected; }

    void setName(const QString &name);
    void setType(const QString &type);
    void setAddress(const QString &address);
    void setStatus(const QString &status);
    void setDescription(const QString &description);
    void setIsConnected(bool connected);

signals:
    void nameChanged();
    void typeChanged();
    void addressChanged();
    void statusChanged();
    void descriptionChanged();
    void isConnectedChanged();

private:
    QString m_name;
    QString m_type;
    QString m_address;
    QString m_status;
    QString m_description;
    bool m_isConnected;
};

class DeviceDiscoveryManager : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool isScanning READ isScanning NOTIFY isScanningChanged)
    Q_PROPERTY(QString lastError READ lastError NOTIFY lastErrorChanged)
    Q_PROPERTY(int deviceCount READ deviceCount NOTIFY deviceCountChanged)
    QML_ELEMENT

public:
    enum DeviceRoles {
        NameRole = Qt::UserRole + 1,
        TypeRole,
        AddressRole,
        StatusRole,
        DescriptionRole,
        IsConnectedRole,
        DeviceObjectRole
    };

    explicit DeviceDiscoveryManager(QObject *parent = nullptr);
    ~DeviceDiscoveryManager();

    // QAbstractListModel interface
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // Properties
    bool isScanning() const { return m_isScanning; }
    QString lastError() const { return m_lastError; }
    int deviceCount() const { return m_devices.count(); }

public slots:
    // Device discovery
    void startDiscovery();
    void stopDiscovery();
    void refreshDevices();
    
    // UART/Serial device methods
    void discoverSerialDevices();
    bool connectToSerialDevice(const QString &portName, int baudRate = 9600, 
                              int dataBits = 8, const QString &parity = "None", 
                              const QString &stopBits = "1");
    void disconnectSerialDevice();
    void sendSerialData(const QString &data);
    
    // Network device methods
    void discoverNetworkDevices();
    bool connectToNetworkDevice(const QString &address, int port);
    void disconnectNetworkDevice();
    void pingHost(const QString &address);
    
    // Utility methods
    void clearDevices();
    DeviceInfo* getDevice(int index);

signals:
    void isScanningChanged();
    void lastErrorChanged();
    void deviceCountChanged();
    void deviceDiscovered(DeviceInfo *device);
    void deviceConnected(DeviceInfo *device);
    void deviceDisconnected(DeviceInfo *device);
    void serialDataReceived(const QString &data);
    void networkDataReceived(const QString &data);
    void pingResult(const QString &address, bool success, int responseTime);
    void errorOccurred(const QString &error);

private slots:
    void onSerialDataReady();
    void onSerialError(QSerialPort::SerialPortError error);
    void onNetworkDataReady();
    void onNetworkError(QAbstractSocket::SocketError error);
    void onPingFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onDiscoveryTimeout();

private:
    void setIsScanning(bool scanning);
    void setLastError(const QString &error);
    void addDevice(DeviceInfo *device);
    void removeDevice(DeviceInfo *device);
    void updateDeviceStatus(DeviceInfo *device, const QString &status);
    
    // Network discovery helpers
    void scanNetworkRange(const QString &baseAddress, int startRange = 1, int endRange = 254);
    void checkHostAvailability(const QString &address);
    QString getLocalNetworkBase();
    
    QList<DeviceInfo*> m_devices;
    bool m_isScanning;
    QString m_lastError;
    
    // Serial communication
    QSerialPort *m_serialPort;
    DeviceInfo *m_connectedSerialDevice;
    
    // Network communication
    QTcpSocket *m_tcpSocket;
    QUdpSocket *m_udpSocket;
    QNetworkAccessManager *m_networkManager;
    DeviceInfo *m_connectedNetworkDevice;
    
    // Discovery timers and processes
    QTimer *m_discoveryTimer;
    QTimer *m_refreshTimer;
    QList<QProcess*> m_pingProcesses;
    
    // Network scanning
    QTimer *m_networkScanTimer;
    int m_currentScanAddress;
    QString m_scanBaseAddress;
    
    // QPing for proper ping functionality
    QPing *m_qping;
};

#endif // DEVICEDISCOVERYMANAGER_H 