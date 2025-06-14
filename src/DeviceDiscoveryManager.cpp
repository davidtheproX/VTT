#include "DeviceDiscoveryManager.h"
#include <QDebug>
#include <QThread>
#include <QCoreApplication>
#include <QStandardPaths>
#include <QDir>

// DeviceInfo Implementation
DeviceInfo::DeviceInfo(QObject *parent)
    : QObject(parent)
    , m_isConnected(false)
{
}

DeviceInfo::DeviceInfo(const QString &name, const QString &type, const QString &address, 
                       const QString &description, QObject *parent)
    : QObject(parent)
    , m_name(name)
    , m_type(type)
    , m_address(address)
    , m_description(description)
    , m_status("Disconnected")
    , m_isConnected(false)
{
}

void DeviceInfo::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

void DeviceInfo::setType(const QString &type)
{
    if (m_type != type) {
        m_type = type;
        emit typeChanged();
    }
}

void DeviceInfo::setAddress(const QString &address)
{
    if (m_address != address) {
        m_address = address;
        emit addressChanged();
    }
}

void DeviceInfo::setStatus(const QString &status)
{
    if (m_status != status) {
        m_status = status;
        emit statusChanged();
    }
}

void DeviceInfo::setDescription(const QString &description)
{
    if (m_description != description) {
        m_description = description;
        emit descriptionChanged();
    }
}

void DeviceInfo::setIsConnected(bool connected)
{
    if (m_isConnected != connected) {
        m_isConnected = connected;
        emit isConnectedChanged();
    }
}

// DeviceDiscoveryManager Implementation
DeviceDiscoveryManager::DeviceDiscoveryManager(QObject *parent)
    : QAbstractListModel(parent)
    , m_isScanning(false)
    , m_serialPort(nullptr)
    , m_connectedSerialDevice(nullptr)
    , m_tcpSocket(nullptr)
    , m_udpSocket(nullptr)
    , m_networkManager(nullptr)
    , m_connectedNetworkDevice(nullptr)
    , m_discoveryTimer(nullptr)
    , m_refreshTimer(nullptr)
    , m_networkScanTimer(nullptr)
    , m_currentScanAddress(1)
    , m_qping(new QPing(this))
{
    qDebug() << "🔍 DeviceDiscoveryManager: Initializing device discovery system";
    
    // Initialize network manager
    m_networkManager = new QNetworkAccessManager(this);
    
    // Initialize QPing and connect signals
    m_qping->loadIniFile(); // Use default settings
    connect(m_qping, &QPing::pingCompleted, this, [this](const QString &address, bool success, int responseTime) {
        emit pingResult(address, success, responseTime);
        
        QString timestamp = QDateTime::currentDateTime().toString("hh:mm:ss");
        QString message = QString("%1: Ping %2 - %3 (%4ms)")
                         .arg(timestamp)
                         .arg(address)
                         .arg(success ? "SUCCESS" : "FAILED")
                         .arg(responseTime);
        qDebug() << "🏓" << message;
    });
    
    // Initialize timers
    m_discoveryTimer = new QTimer(this);
    m_discoveryTimer->setSingleShot(true);
    connect(m_discoveryTimer, &QTimer::timeout, this, &DeviceDiscoveryManager::onDiscoveryTimeout);
    
    m_refreshTimer = new QTimer(this);
    m_refreshTimer->setInterval(5000); // Refresh every 5 seconds
    connect(m_refreshTimer, &QTimer::timeout, this, &DeviceDiscoveryManager::refreshDevices);
    
    m_networkScanTimer = new QTimer(this);
    m_networkScanTimer->setInterval(100); // 100ms between network scans
    connect(m_networkScanTimer, &QTimer::timeout, this, [this]() {
        if (m_currentScanAddress <= 254) {
            QString address = m_scanBaseAddress + QString::number(m_currentScanAddress);
            checkHostAvailability(address);
            m_currentScanAddress++;
        } else {
            m_networkScanTimer->stop();
            setIsScanning(false);
            qDebug() << "🔍 Network scan completed";
        }
    });
    
    qDebug() << "✓ DeviceDiscoveryManager: Initialization complete";
}

DeviceDiscoveryManager::~DeviceDiscoveryManager()
{
    qDebug() << "🔍 DeviceDiscoveryManager: Cleaning up";
    
    stopDiscovery();
    
    // Clean up serial connection
    if (m_serialPort) {
        if (m_serialPort->isOpen()) {
            m_serialPort->close();
        }
        m_serialPort->deleteLater();
    }
    
    // Clean up network connections
    if (m_tcpSocket) {
        if (m_tcpSocket->state() != QAbstractSocket::UnconnectedState) {
            m_tcpSocket->disconnectFromHost();
        }
        m_tcpSocket->deleteLater();
    }
    
    if (m_udpSocket) {
        m_udpSocket->deleteLater();
    }
    
    // Clean up ping processes
    for (QProcess *process : m_pingProcesses) {
        if (process->state() != QProcess::NotRunning) {
            process->kill();
        }
        process->deleteLater();
    }
    
    // Clean up devices
    qDeleteAll(m_devices);
}

int DeviceDiscoveryManager::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_devices.count();
}

QVariant DeviceDiscoveryManager::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_devices.count()) {
        return QVariant();
    }
    
    DeviceInfo *device = m_devices.at(index.row());
    
    switch (role) {
    case NameRole:
        return device->name();
    case TypeRole:
        return device->type();
    case AddressRole:
        return device->address();
    case StatusRole:
        return device->status();
    case DescriptionRole:
        return device->description();
    case IsConnectedRole:
        return device->isConnected();
    case DeviceObjectRole:
        return QVariant::fromValue(device);
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> DeviceDiscoveryManager::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[TypeRole] = "type";
    roles[AddressRole] = "address";
    roles[StatusRole] = "status";
    roles[DescriptionRole] = "description";
    roles[IsConnectedRole] = "isConnected";
    roles[DeviceObjectRole] = "deviceObject";
    return roles;
}

void DeviceDiscoveryManager::startDiscovery()
{
    qDebug() << "🔍 Starting device discovery";
    
    if (m_isScanning) {
        qDebug() << "⚠ Discovery already in progress";
        return;
    }
    
    setIsScanning(true);
    clearDevices();
    
    // Start discovery for both serial and network devices
    discoverSerialDevices();
    discoverNetworkDevices();
    
    // Start refresh timer
    m_refreshTimer->start();
    
    // Set discovery timeout (30 seconds)
    m_discoveryTimer->start(30000);
}

void DeviceDiscoveryManager::stopDiscovery()
{
    qDebug() << "🔍 Stopping device discovery";
    
    setIsScanning(false);
    
    if (m_refreshTimer) {
        m_refreshTimer->stop();
    }
    
    if (m_discoveryTimer) {
        m_discoveryTimer->stop();
    }
    
    if (m_networkScanTimer) {
        m_networkScanTimer->stop();
    }
    
    // Stop ping processes
    for (QProcess *process : m_pingProcesses) {
        if (process->state() != QProcess::NotRunning) {
            process->kill();
        }
    }
}

void DeviceDiscoveryManager::refreshDevices()
{
    if (!m_isScanning) {
        return;
    }
    
    qDebug() << "🔄 Refreshing device list";
    discoverSerialDevices();
}

void DeviceDiscoveryManager::discoverSerialDevices()
{
    qDebug() << "🔍 Discovering serial devices";
    
    QList<QSerialPortInfo> serialPorts = QSerialPortInfo::availablePorts();
    
    for (const QSerialPortInfo &portInfo : serialPorts) {
        QString name = portInfo.portName();
        QString description = portInfo.description();
        QString manufacturer = portInfo.manufacturer();
        
        // Create full description
        QString fullDescription = description;
        if (!manufacturer.isEmpty() && manufacturer != description) {
            fullDescription += QString(" (%1)").arg(manufacturer);
        }
        
        // Check if device already exists
        bool exists = false;
        for (DeviceInfo *device : m_devices) {
            if (device->type() == "Serial" && device->address() == name) {
                exists = true;
                break;
            }
        }
        
        if (!exists) {
            DeviceInfo *device = new DeviceInfo(name, "Serial", name, fullDescription, this);
            device->setStatus("Available");
            addDevice(device);
            
            qDebug() << "✓ Found serial device:" << name << "-" << fullDescription;
            emit deviceDiscovered(device);
        }
    }
}

void DeviceDiscoveryManager::discoverNetworkDevices()
{
    qDebug() << "🌐 Discovering local network interfaces...";
    
    // Get all network interfaces on this system
    QList<QNetworkInterface> interfaces = QNetworkInterface::allInterfaces();
    
    for (const QNetworkInterface &interface : interfaces) {
        // Skip loopback interfaces
        if (interface.flags() & QNetworkInterface::IsLoopBack) {
            continue;
        }
        
        QString name = interface.humanReadableName();
        QString address = interface.hardwareAddress();
        
        // Get interface type
        QString interfaceType = "Unknown";
        switch (interface.type()) {
            case QNetworkInterface::Wifi:
                interfaceType = "WiFi";
                break;
            case QNetworkInterface::Ethernet:
                interfaceType = "Ethernet";
                break;
            case QNetworkInterface::Ppp:
                interfaceType = "PPP";
                break;
            case QNetworkInterface::Slip:
                interfaceType = "SLIP";
                break;
            case QNetworkInterface::CanBus:
                interfaceType = "CAN Bus";
                break;
            case QNetworkInterface::Virtual:
                interfaceType = "Virtual";
                break;
            default:
                interfaceType = "Other";
                break;
        }
        
        // Get IP addresses
        QStringList ipAddresses;
        QList<QNetworkAddressEntry> entries = interface.addressEntries();
        for (const QNetworkAddressEntry &entry : entries) {
            if (entry.ip().protocol() == QAbstractSocket::IPv4Protocol) {
                ipAddresses << entry.ip().toString();
            }
        }
        
        QString description = QString("Type: %1, MTU: %2")
                                .arg(interfaceType)
                                .arg(interface.maximumTransmissionUnit());
        
        if (!ipAddresses.isEmpty()) {
            description += QString(", IP: %1").arg(ipAddresses.join(", "));
        }
        
        // Determine connection status
        bool isUp = interface.flags() & QNetworkInterface::IsUp;
        bool isRunning = interface.flags() & QNetworkInterface::IsRunning;
        
        QString status;
        bool isConnected = false;
        
        if (!isUp) {
            status = "Disabled";
            isConnected = false;
        } else if (isUp && isRunning && !ipAddresses.isEmpty()) {
            status = "Connected";
            isConnected = true;
        } else if (isUp && !isRunning) {
            status = "No Carrier";
            isConnected = false;
        } else if (isUp && isRunning && ipAddresses.isEmpty()) {
            status = "No IP Address";
            isConnected = false;
        } else {
            status = "Unknown";
            isConnected = false;
        }
        
        // Use MAC address as identifier, fallback to interface name
        QString deviceAddress = !address.isEmpty() ? address : interface.name();
        
        DeviceInfo *device = new DeviceInfo(name, "Network Interface", deviceAddress, description, this);
        device->setStatus(status);
        device->setIsConnected(isConnected);
        
        addDevice(device);
        emit deviceDiscovered(device);
        
        qDebug() << "📡 Found network interface:" << name << "(" << interfaceType << ")" 
                 << "- Status:" << status << "- Address:" << deviceAddress;
    }
    
    qDebug() << "✓ Network interface discovery complete";
}

bool DeviceDiscoveryManager::connectToSerialDevice(const QString &portName, int baudRate, 
                                                  int dataBits, const QString &parity, 
                                                  const QString &stopBits)
{
    qDebug() << "🔌 Connecting to serial device:" << portName 
             << "- Baud:" << baudRate 
             << "- Data bits:" << dataBits 
             << "- Parity:" << parity 
             << "- Stop bits:" << stopBits;
    
    // Disconnect existing connection
    disconnectSerialDevice();
    
    // Create new serial port
    m_serialPort = new QSerialPort(this);
    m_serialPort->setPortName(portName);
    m_serialPort->setBaudRate(baudRate);
    
    // Set data bits (cross-platform compatible)
    switch (dataBits) {
        case 5: m_serialPort->setDataBits(QSerialPort::Data5); break;
        case 6: m_serialPort->setDataBits(QSerialPort::Data6); break;
        case 7: m_serialPort->setDataBits(QSerialPort::Data7); break;
        case 8: 
        default: m_serialPort->setDataBits(QSerialPort::Data8); break;
    }
    
    // Set parity (cross-platform compatible)
    if (parity == "Even") {
        m_serialPort->setParity(QSerialPort::EvenParity);
    } else if (parity == "Odd") {
        m_serialPort->setParity(QSerialPort::OddParity);
    } else if (parity == "Space") {
        m_serialPort->setParity(QSerialPort::SpaceParity);
    } else if (parity == "Mark") {
        m_serialPort->setParity(QSerialPort::MarkParity);
    } else {
        m_serialPort->setParity(QSerialPort::NoParity); // Default: None
    }
    
    // Set stop bits (cross-platform compatible)
    if (stopBits == "1.5") {
        m_serialPort->setStopBits(QSerialPort::OneAndHalfStop);
    } else if (stopBits == "2") {
        m_serialPort->setStopBits(QSerialPort::TwoStop);
    } else {
        m_serialPort->setStopBits(QSerialPort::OneStop); // Default: 1
    }
    
    // Set flow control to none (most compatible across platforms)
    m_serialPort->setFlowControl(QSerialPort::NoFlowControl);
    
    // Connect signals
    connect(m_serialPort, &QSerialPort::readyRead, this, &DeviceDiscoveryManager::onSerialDataReady);
    connect(m_serialPort, &QSerialPort::errorOccurred, this, &DeviceDiscoveryManager::onSerialError);
    
    if (m_serialPort->open(QIODevice::ReadWrite)) {
        // Find and update device status
        for (DeviceInfo *device : m_devices) {
            if (device->type() == "Serial" && device->address() == portName) {
                device->setStatus(QString("Connected (%1-%2-%3-%4)").arg(baudRate).arg(dataBits).arg(parity).arg(stopBits));
                device->setIsConnected(true);
                m_connectedSerialDevice = device;
                emit deviceConnected(device);
                break;
            }
        }
        
        qDebug() << "✓ Serial connection established";
        return true;
    } else {
        QString error = QString("Failed to connect to %1: %2").arg(portName, m_serialPort->errorString());
        setLastError(error);
        qDebug() << "✗" << error;
        
        m_serialPort->deleteLater();
        m_serialPort = nullptr;
        return false;
    }
}

void DeviceDiscoveryManager::disconnectSerialDevice()
{
    if (m_serialPort && m_serialPort->isOpen()) {
        qDebug() << "🔌 Disconnecting serial device";
        
        m_serialPort->close();
        m_serialPort->deleteLater();
        m_serialPort = nullptr;
        
        if (m_connectedSerialDevice) {
            m_connectedSerialDevice->setStatus("Available");
            m_connectedSerialDevice->setIsConnected(false);
            emit deviceDisconnected(m_connectedSerialDevice);
            m_connectedSerialDevice = nullptr;
        }
    }
}

void DeviceDiscoveryManager::sendSerialData(const QString &data)
{
    if (m_serialPort && m_serialPort->isOpen()) {
        QByteArray dataToSend = data.toUtf8();
        qint64 bytesWritten = m_serialPort->write(dataToSend);
        
        if (bytesWritten == -1) {
            setLastError("Failed to send serial data");
            qDebug() << "✗ Failed to send serial data";
        } else {
            qDebug() << "📤 Sent serial data:" << data << "(" << bytesWritten << "bytes)";
        }
    } else {
        setLastError("No serial connection available");
        qDebug() << "✗ No serial connection available for sending data";
    }
}

bool DeviceDiscoveryManager::connectToNetworkDevice(const QString &address, int port)
{
    qDebug() << "🔌 Connecting to network device:" << address << ":" << port;
    
    // Disconnect existing connection
    disconnectNetworkDevice();
    
    // Create new TCP socket
    m_tcpSocket = new QTcpSocket(this);
    connect(m_tcpSocket, &QTcpSocket::connected, this, [this, address]() {
        qDebug() << "✓ Network connection established to" << address;
        
        // Find and update device status
        for (DeviceInfo *device : m_devices) {
            if (device->address() == address) {
                device->setStatus("Connected");
                device->setIsConnected(true);
                m_connectedNetworkDevice = device;
                emit deviceConnected(device);
                break;
            }
        }
    });
    
    connect(m_tcpSocket, &QTcpSocket::readyRead, this, &DeviceDiscoveryManager::onNetworkDataReady);
    connect(m_tcpSocket, &QTcpSocket::errorOccurred, this, &DeviceDiscoveryManager::onNetworkError);
    
    m_tcpSocket->connectToHost(address, port);
    
    // Wait for connection (with timeout)
    if (m_tcpSocket->waitForConnected(5000)) {
        return true;
    } else {
        QString error = QString("Failed to connect to %1:%2 - %3").arg(address).arg(port).arg(m_tcpSocket->errorString());
        setLastError(error);
        qDebug() << "✗" << error;
        
        m_tcpSocket->deleteLater();
        m_tcpSocket = nullptr;
        return false;
    }
}

void DeviceDiscoveryManager::disconnectNetworkDevice()
{
    if (m_tcpSocket && m_tcpSocket->state() != QAbstractSocket::UnconnectedState) {
        qDebug() << "🔌 Disconnecting network device";
        
        m_tcpSocket->disconnectFromHost();
        m_tcpSocket->deleteLater();
        m_tcpSocket = nullptr;
        
        if (m_connectedNetworkDevice) {
            m_connectedNetworkDevice->setStatus("Available");
            m_connectedNetworkDevice->setIsConnected(false);
            emit deviceDisconnected(m_connectedNetworkDevice);
            m_connectedNetworkDevice = nullptr;
        }
    }
}

void DeviceDiscoveryManager::pingHost(const QString &address)
{
    qDebug() << "🏓 Pinging host:" << address;
    
    if (!m_qping) {
        qDebug() << "✗ QPing not initialized";
        emit pingResult(address, false, 0);
        return;
    }
    
    // Use QPing for proper ICMP ping
    QPing::pingResult result = m_qping->ping(address, 3000);
    
    // The result will be emitted via the pingCompleted signal
    // which is already connected in the constructor
}

void DeviceDiscoveryManager::clearDevices()
{
    if (!m_devices.isEmpty()) {
        beginRemoveRows(QModelIndex(), 0, m_devices.count() - 1);
        qDeleteAll(m_devices);
        m_devices.clear();
        endRemoveRows();
        emit deviceCountChanged();
    }
}

DeviceInfo* DeviceDiscoveryManager::getDevice(int index)
{
    if (index >= 0 && index < m_devices.count()) {
        return m_devices.at(index);
    }
    return nullptr;
}

void DeviceDiscoveryManager::onSerialDataReady()
{
    if (m_serialPort) {
        QByteArray data = m_serialPort->readAll();
        QString dataString = QString::fromUtf8(data);
        
        qDebug() << "📥 Received serial data:" << dataString;
        emit serialDataReceived(dataString);
    }
}

void DeviceDiscoveryManager::onSerialError(QSerialPort::SerialPortError error)
{
    if (error != QSerialPort::NoError) {
        QString errorString = QString("Serial port error: %1").arg(m_serialPort->errorString());
        setLastError(errorString);
        qDebug() << "✗" << errorString;
        emit errorOccurred(errorString);
    }
}

void DeviceDiscoveryManager::onNetworkDataReady()
{
    if (m_tcpSocket) {
        QByteArray data = m_tcpSocket->readAll();
        QString dataString = QString::fromUtf8(data);
        
        qDebug() << "📥 Received network data:" << dataString;
        emit networkDataReceived(dataString);
    }
}

void DeviceDiscoveryManager::onNetworkError(QAbstractSocket::SocketError error)
{
    Q_UNUSED(error)
    if (m_tcpSocket) {
        QString errorString = QString("Network error: %1").arg(m_tcpSocket->errorString());
        setLastError(errorString);
        qDebug() << "✗" << errorString;
        emit errorOccurred(errorString);
    }
}

void DeviceDiscoveryManager::onPingFinished(int exitCode, QProcess::ExitStatus exitStatus)
{
    QProcess *process = qobject_cast<QProcess*>(sender());
    if (!process) return;
    
    QString address = process->property("address").toString();
    qint64 startTime = process->property("startTime").toLongLong();
    int responseTime = QDateTime::currentMSecsSinceEpoch() - startTime;
    
    bool success = (exitCode == 0 && exitStatus == QProcess::NormalExit);
    
    qDebug() << "🏓 Ping result for" << address << ":" << (success ? "SUCCESS" : "FAILED") 
             << "(" << responseTime << "ms)";
    
    emit pingResult(address, success, responseTime);
    
    if (success) {
        // Add as network device if not already present
        bool exists = false;
        for (DeviceInfo *device : m_devices) {
            if (device->address() == address && device->type() == "Network Host") {
                exists = true;
                break;
            }
        }
        
        if (!exists) {
            DeviceInfo *device = new DeviceInfo(address, "Network Host", address, 
                                                QString("Ping: %1ms").arg(responseTime), this);
            device->setStatus("Reachable");
            addDevice(device);
            emit deviceDiscovered(device);
        }
    }
    
    // Clean up
    m_pingProcesses.removeAll(process);
    process->deleteLater();
}

void DeviceDiscoveryManager::onDiscoveryTimeout()
{
    qDebug() << "⏰ Discovery timeout reached";
    stopDiscovery();
}

void DeviceDiscoveryManager::setIsScanning(bool scanning)
{
    if (m_isScanning != scanning) {
        m_isScanning = scanning;
        emit isScanningChanged();
    }
}

void DeviceDiscoveryManager::setLastError(const QString &error)
{
    if (m_lastError != error) {
        m_lastError = error;
        emit lastErrorChanged();
    }
}

void DeviceDiscoveryManager::addDevice(DeviceInfo *device)
{
    beginInsertRows(QModelIndex(), m_devices.count(), m_devices.count());
    m_devices.append(device);
    endInsertRows();
    emit deviceCountChanged();
}

void DeviceDiscoveryManager::removeDevice(DeviceInfo *device)
{
    int index = m_devices.indexOf(device);
    if (index >= 0) {
        beginRemoveRows(QModelIndex(), index, index);
        m_devices.removeAt(index);
        endRemoveRows();
        device->deleteLater();
        emit deviceCountChanged();
    }
}

void DeviceDiscoveryManager::updateDeviceStatus(DeviceInfo *device, const QString &status)
{
    device->setStatus(status);
    
    // Emit data changed for this device
    int index = m_devices.indexOf(device);
    if (index >= 0) {
        QModelIndex modelIndex = createIndex(index, 0);
        emit dataChanged(modelIndex, modelIndex);
    }
}

void DeviceDiscoveryManager::scanNetworkRange(const QString &baseAddress, int startRange, int endRange)
{
    qDebug() << "🔍 Scanning network range:" << baseAddress << startRange << "-" << endRange;
    
    for (int i = startRange; i <= endRange; ++i) {
        QString address = baseAddress + QString::number(i);
        checkHostAvailability(address);
    }
}

void DeviceDiscoveryManager::checkHostAvailability(const QString &address)
{
    // Use ping to check host availability
    pingHost(address);
}

QString DeviceDiscoveryManager::getLocalNetworkBase()
{
    QList<QNetworkInterface> interfaces = QNetworkInterface::allInterfaces();
    
    for (const QNetworkInterface &interface : interfaces) {
        if (interface.flags() & QNetworkInterface::IsUp &&
            interface.flags() & QNetworkInterface::IsRunning &&
            !(interface.flags() & QNetworkInterface::IsLoopBack)) {
            
            QList<QNetworkAddressEntry> entries = interface.addressEntries();
            for (const QNetworkAddressEntry &entry : entries) {
                QHostAddress address = entry.ip();
                if (address.protocol() == QAbstractSocket::IPv4Protocol && 
                    !address.isLoopback()) {
                    
                    QString addressString = address.toString();
                    QStringList parts = addressString.split('.');
                    if (parts.size() == 4) {
                        return QString("%1.%2.%3.").arg(parts[0], parts[1], parts[2]);
                    }
                }
            }
        }
    }
    
    return QString();
} 