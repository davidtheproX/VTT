import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

Dialog {
    id: commTestDialog
    title: "Communication Test - Device Discovery"
    width: 1200
    height: 800
    modal: true
    
    // Color scheme properties
    property color primaryColor: "#2196F3"
    property color backgroundColor: "#1e1e1e"
    property color surfaceColor: "#2d2d2d"
    property color textColor: "#ffffff"
    property color mutedTextColor: "#b0b0b0"
    property color successColor: "#4CAF50"
    property color warningColor: "#FF9800"
    property color errorColor: "#f44336"
    property real scaleFactor: 1.0
    
    background: Rectangle {
        color: backgroundColor
        radius: 8
    }
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 20
        clip: true
        
        ColumnLayout {
            width: parent.width
            spacing: 20
            
            // Header
            Text {
                text: "🔍 Device Discovery & Communication Test"
                font.pixelSize: 18
                font.bold: true
                color: textColor
                Layout.fillWidth: true
            }
            
            // Global control buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                
                Button {
                    text: deviceDiscoveryManager && deviceDiscoveryManager.isScanning ? "Stop Discovery" : "Start Discovery"
                    enabled: deviceDiscoveryManager !== null
                    
                    onClicked: {
                        if (deviceDiscoveryManager) {
                            if (deviceDiscoveryManager.isScanning) {
                                deviceDiscoveryManager.stopDiscovery()
                            } else {
                                deviceDiscoveryManager.startDiscovery()
                            }
                        }
                    }
                }
                
                Button {
                    text: "Refresh All"
                    enabled: deviceDiscoveryManager && !deviceDiscoveryManager.isScanning
                    
                    onClicked: {
                        if (deviceDiscoveryManager) {
                            deviceDiscoveryManager.refreshDevices()
                        }
                    }
                }
                
                Button {
                    text: "Clear All"
                    enabled: deviceDiscoveryManager !== null
                    
                    onClicked: {
                        if (deviceDiscoveryManager) {
                            deviceDiscoveryManager.clearDevices()
                        }
                    }
                }
                
                Item { Layout.fillWidth: true }
                
                Text {
                    text: deviceDiscoveryManager ? "Total Devices: " + deviceDiscoveryManager.deviceCount : "Devices: 0"
                    color: mutedTextColor
                }
            }
            
            // Two-column layout for Network and Serial devices
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 400
                spacing: 20
                
                // Left column - Network Devices
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: 450
                    Layout.minimumHeight: 500
                    color: surfaceColor
                    radius: 8
                    border.color: mutedTextColor
                    border.width: 1
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        // Network header
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: "🌐 Network Devices"
                                font.pixelSize: 16
                                font.bold: true
                                color: textColor
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: getNetworkDeviceCount()
                                color: mutedTextColor
                                font.pixelSize: 12
                            }
                        }
                        
                        // Network configuration
                        GroupBox {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 220
                            title: "Network Configuration"
                            topPadding: 25
                            
                            background: Rectangle {
                                color: Qt.darker(surfaceColor, 1.1)
                                radius: 6
                                border.color: mutedTextColor
                                border.width: 1
                            }
                            
                            label: Text {
                                text: parent.title
                                color: textColor
                                font.pixelSize: 14
                                font.bold: true
                                leftPadding: 10
                                topPadding: 5
                            }
                            
                            GridLayout {
                                anchors.fill: parent
                                anchors.margins: 15
                                columns: 2
                                columnSpacing: 15
                                rowSpacing: 12
                                
                                Text { text: "IP Address:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                TextField {
                                    id: ipAddressField
                                    text: "192.168.1.100"
                                    placeholderText: "e.g., 192.168.1.100"
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    font.pixelSize: 12
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    color: textColor
                                }
                                
                                Text { text: "Subnet:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                TextField {
                                    id: subnetField
                                    text: "255.255.255.0"
                                    placeholderText: "e.g., 255.255.255.0"
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    font.pixelSize: 12
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    color: textColor
                                }
                                
                                Text { text: "Gateway:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                TextField {
                                    id: gatewayField
                                    text: "192.168.1.1"
                                    placeholderText: "e.g., 192.168.1.1"
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    font.pixelSize: 12
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    color: textColor
                                }
                                
                                Text { text: "Port:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                TextField {
                                    id: networkPortField
                                    text: "80"
                                    placeholderText: "e.g., 80, 443, 8080"
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    font.pixelSize: 12
                                    validator: IntValidator { bottom: 1; top: 65535 }
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    color: textColor
                                }
                            }
                        }
                        
                        // Save Network Configuration Button - utilizing the white space
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 80
                            color: "transparent"
                            
                            Button {
                                anchors.centerIn: parent
                                width: parent.width * 0.8
                                height: 50
                                text: "💾 Save Network Configuration"
                                font.pixelSize: 14
                                font.bold: true
                                
                                background: Rectangle {
                                    color: parent.pressed ? Qt.darker(successColor, 1.3) : 
                                           parent.hovered ? Qt.lighter(successColor, 1.1) : successColor
                                    radius: 8
                                    border.color: Qt.darker(successColor, 1.2)
                                    border.width: 2
                                    
                                    // Add a subtle shadow effect
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.topMargin: 2
                                        anchors.leftMargin: 2
                                        color: Qt.darker(successColor, 1.5)
                                        radius: parent.radius
                                        z: -1
                                    }
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font: parent.font
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    saveNetworkConfiguration()
                                }
                            }
                        }
                        
                        // Network device list
                        ListView {
                            id: networkListView
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true
                            
                            model: ListModel {
                                id: networkDevicesModel
                            }
                            
                            delegate: Rectangle {
                                width: ListView.view.width
                                height: 70
                                color: networkListView.currentIndex === index ? Qt.lighter(primaryColor, 1.8) :
                                       index % 2 === 0 ? Qt.darker(surfaceColor, 1.2) : Qt.darker(surfaceColor, 1.1)
                                radius: 4
                                border.color: networkListView.currentIndex === index ? primaryColor : "transparent"
                                border.width: 2
                                
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        networkListView.currentIndex = index
                                        loadNetworkDeviceConfig(model)
                                    }
                                }
                                
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10
                                    
                                    Text {
                                        text: "🌐"
                                        font.pixelSize: 18
                                    }
                                    
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2
                                        
                                        Text {
                                            text: model.name || "Network Device"
                                            color: textColor
                                            font.pixelSize: 12
                                            font.bold: true
                                        }
                                        
                                        Text {
                                            text: model.address || "No Address"
                                            color: mutedTextColor
                                            font.pixelSize: 10
                                        }
                                        
                                        Text {
                                            text: model.status || "Unknown"
                                            color: model.isConnected ? successColor : mutedTextColor
                                            font.pixelSize: 9
                                        }
                                    }
                                    
                                    ColumnLayout {
                                        spacing: 4
                                        
                                        Button {
                                            text: "Ping"
                                            font.pixelSize: 9
                                            Layout.preferredWidth: 50
                                            Layout.preferredHeight: 25
                                            
                                            onClicked: {
                                                if (deviceDiscoveryManager) {
                                                    let targetIP = ipAddressField.text || model.ipAddress || "8.8.8.8"
                                                    deviceDiscoveryManager.pingHost(targetIP)
                                                }
                                            }
                                        }
                                    }
                                    
                                    Rectangle {
                                        width: 8
                                        height: 8
                                        radius: 4
                                        color: model.isConnected ? successColor : mutedTextColor
                                    }
                                }
                            }
                        }
                    }
                }
                

                
                // Right column - Serial/COM Port Devices
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: 450
                    Layout.minimumHeight: 500
                    color: surfaceColor
                    radius: 8
                    border.color: mutedTextColor
                    border.width: 1
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        // Serial header
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: "📱 Serial/COM Ports"
                                font.pixelSize: 16
                                font.bold: true
                                color: textColor
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: getSerialDeviceCount()
                                color: mutedTextColor
                                font.pixelSize: 12
                            }
                        }
                        
                        // Serial configuration
                        GroupBox {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 220
                            title: "Serial Configuration"
                            topPadding: 25
                            
                            background: Rectangle {
                                color: Qt.darker(surfaceColor, 1.1)
                                radius: 6
                                border.color: mutedTextColor
                                border.width: 1
                            }
                            
                            label: Text {
                                text: parent.title
                                color: textColor
                                font.pixelSize: 14
                                font.bold: true
                                leftPadding: 10
                                topPadding: 5
                            }
                            
                            GridLayout {
                                anchors.fill: parent
                                anchors.margins: 15
                                columns: 2
                                columnSpacing: 15
                                rowSpacing: 12
                                
                                Text { text: "Baud Rate:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                ComboBox {
                                    id: baudRateCombo
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    model: ["1200", "2400", "4800", "9600", "19200", "38400", "57600", "115200", "230400", "460800", "921600"]
                                    currentIndex: 3 // Default to 9600
                                    font.pixelSize: 12
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    
                                    contentItem: Text {
                                        text: parent.displayText
                                        color: textColor
                                        font: parent.font
                                        verticalAlignment: Text.AlignVCenter
                                        leftPadding: 8
                                    }
                                }
                                
                                Text { text: "Data Bits:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                ComboBox {
                                    id: dataBitsCombo
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    model: ["5", "6", "7", "8"]
                                    currentIndex: 3 // Default to 8
                                    font.pixelSize: 12
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    
                                    contentItem: Text {
                                        text: parent.displayText
                                        color: textColor
                                        font: parent.font
                                        verticalAlignment: Text.AlignVCenter
                                        leftPadding: 8
                                    }
                                }
                                
                                Text { text: "Parity:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                ComboBox {
                                    id: parityCombo
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    model: ["None", "Even", "Odd", "Space", "Mark"]
                                    currentIndex: 0 // Default to None
                                    font.pixelSize: 12
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    
                                    contentItem: Text {
                                        text: parent.displayText
                                        color: textColor
                                        font: parent.font
                                        verticalAlignment: Text.AlignVCenter
                                        leftPadding: 8
                                    }
                                }
                                
                                Text { text: "Stop Bits:"; color: mutedTextColor; font.pixelSize: 12; font.bold: true }
                                ComboBox {
                                    id: stopBitsCombo
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    model: ["1", "1.5", "2"]
                                    currentIndex: 0 // Default to 1
                                    font.pixelSize: 12
                                    
                                    background: Rectangle {
                                        color: backgroundColor
                                        border.color: parent.activeFocus ? primaryColor : mutedTextColor
                                        border.width: 1
                                        radius: 4
                                    }
                                    
                                    contentItem: Text {
                                        text: parent.displayText
                                        color: textColor
                                        font: parent.font
                                        verticalAlignment: Text.AlignVCenter
                                        leftPadding: 8
                                    }
                                }
                            }
                        }
                        
                        // Serial device list
                        ListView {
                            id: serialListView
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true
                            
                            model: ListModel {
                                id: serialDevicesModel
                            }
                            
                            delegate: Rectangle {
                                width: ListView.view.width
                                height: 70
                                color: serialListView.currentIndex === index ? Qt.lighter(primaryColor, 1.8) :
                                       index % 2 === 0 ? Qt.darker(surfaceColor, 1.2) : Qt.darker(surfaceColor, 1.1)
                                radius: 4
                                border.color: serialListView.currentIndex === index ? primaryColor : "transparent"
                                border.width: 2
                                
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        serialListView.currentIndex = index
                                        loadSerialDeviceConfig(model)
                                    }
                                }
                                
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 10
                                    
                                    Text {
                                        text: "📱"
                                        font.pixelSize: 18
                                    }
                                    
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2
                                        
                                        Text {
                                            text: model.name || "Serial Device"
                                            color: textColor
                                            font.pixelSize: 12
                                            font.bold: true
                                        }
                                        
                                        Text {
                                            text: model.address || "No Port"
                                            color: mutedTextColor
                                            font.pixelSize: 10
                                        }
                                        
                                        Text {
                                            text: model.status || "Unknown"
                                            color: model.isConnected ? successColor : mutedTextColor
                                            font.pixelSize: 9
                                        }
                                    }
                                    
                                    ColumnLayout {
                                        spacing: 4
                                        
                                        Button {
                                            text: "Test"
                                            font.pixelSize: 9
                                            Layout.preferredWidth: 50
                                            Layout.preferredHeight: 25
                                            
                                            onClicked: {
                                                if (deviceDiscoveryManager && model.address) {
                                                    // Send test data to serial port
                                                    deviceDiscoveryManager.sendSerialData("AT\r\n")
                                                }
                                            }
                                        }
                                        
                                        Button {
                                            text: model.isConnected ? "Disconnect" : "Connect"
                                            font.pixelSize: 9
                                            Layout.preferredWidth: 50
                                            Layout.preferredHeight: 25
                                            
                                            onClicked: {
                                                if (deviceDiscoveryManager && model.address) {
                                                    if (model.isConnected) {
                                                        deviceDiscoveryManager.disconnectSerialDevice()
                                                    } else {
                                                        let baudRate = parseInt(baudRateCombo.currentText)
                                                        let dataBits = parseInt(dataBitsCombo.currentText)
                                                        let parity = parityCombo.currentText
                                                        let stopBits = stopBitsCombo.currentText
                                                        deviceDiscoveryManager.connectToSerialDevice(model.address, baudRate, dataBits, parity, stopBits)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                    Rectangle {
                                        width: 8
                                        height: 8
                                        radius: 4
                                        color: model.isConnected ? successColor : mutedTextColor
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // Status area
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 300
                color: surfaceColor
                radius: 8
                border.color: mutedTextColor
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10
                    
                    Text {
                        text: "Activity Log"
                        font.pixelSize: 14
                        font.bold: true
                        color: textColor
                    }
                    
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        
                        TextArea {
                            id: activityLog
                            readOnly: true
                            text: deviceDiscoveryManager ? deviceDiscoveryManager.lastError || "Ready - Cross-platform device discovery active" : "Device manager not available"
                            color: textColor
                            wrapMode: TextArea.Wrap
                            font.pixelSize: 11
                            font.family: "Consolas, Monaco, monospace"
                            
                            background: Rectangle {
                                color: Qt.darker(surfaceColor, 1.1)
                                radius: 4
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Helper functions
    function getNetworkDeviceCount() {
        if (!deviceDiscoveryManager) return "Count: 0"
        let count = 0
        for (let i = 0; i < deviceDiscoveryManager.deviceCount; i++) {
            let device = deviceDiscoveryManager.getDevice(i)
            if (device && (device.type === "Network Interface" || device.type === "Network Host")) {
                count++
            }
        }
        return "Count: " + count
    }
    
    function getSerialDeviceCount() {
        if (!deviceDiscoveryManager) return "Count: 0"
        let count = 0
        for (let i = 0; i < deviceDiscoveryManager.deviceCount; i++) {
            let device = deviceDiscoveryManager.getDevice(i)
            if (device && device.type === "Serial") {
                count++
            }
        }
        return "Count: " + count
    }
    
    function updateDeviceLists() {
        if (!deviceDiscoveryManager) return
        
        // Clear models
        networkDevicesModel.clear()
        serialDevicesModel.clear()
        
        // Populate models based on device type
        for (let i = 0; i < deviceDiscoveryManager.deviceCount; i++) {
            let device = deviceDiscoveryManager.getDevice(i)
            if (device) {
                if (device.type === "Serial") {
                    serialDevicesModel.append({
                        name: device.name,
                        address: device.address,
                        status: device.status,
                        isConnected: device.isConnected,
                        deviceObject: device
                    })
                } else if (device.type === "Network Interface" || device.type === "Network Host") {
                    // Extract IP address from description
                    let ipAddress = ""
                    let description = device.description || ""
                    let ipMatch = description.match(/IP: ([0-9.]+)/)
                    if (ipMatch) {
                        ipAddress = ipMatch[1]
                    }
                    
                    networkDevicesModel.append({
                        name: device.name,
                        address: device.address,
                        status: device.status,
                        isConnected: device.isConnected,
                        ipAddress: ipAddress,
                        description: description,
                        deviceObject: device
                    })
                }
            }
        }
    }
    
    function loadNetworkDeviceConfig(deviceModel) {
        if (!deviceModel) return
        
        // Load device IP address into configuration
        if (deviceModel.ipAddress) {
            ipAddressField.text = deviceModel.ipAddress
            
            // Auto-calculate subnet and gateway based on IP
            let ipParts = deviceModel.ipAddress.split('.')
            if (ipParts.length === 4) {
                // Standard Class C subnet
                subnetField.text = "255.255.255.0"
                gatewayField.text = ipParts[0] + "." + ipParts[1] + "." + ipParts[2] + ".1"
            }
        }
        
        // Log selection
        let timestamp = new Date().toLocaleTimeString()
        let message = timestamp + ": Selected " + deviceModel.name + " (" + deviceModel.status + ")\n"
        activityLog.append(message)
    }
    
    function saveNetworkConfiguration() {
        if (!deviceDiscoveryManager) return
        
        let timestamp = new Date().toLocaleTimeString()
        let message = timestamp + ": Network configuration saved - IP: " + ipAddressField.text + 
                     ", Subnet: " + subnetField.text + ", Gateway: " + gatewayField.text + 
                     ", Port: " + networkPortField.text + "\n"
        activityLog.append(message)
        
        // You can add actual network configuration logic here
        // For now, just log the configuration
        console.log("Network config saved:", {
            ip: ipAddressField.text,
            subnet: subnetField.text,
            gateway: gatewayField.text,
            port: networkPortField.text
        })
    }
    
    // Connections to update device lists when devices change
    Connections {
        target: deviceDiscoveryManager
        function onDeviceCountChanged() {
            updateDeviceLists()
        }
        function onDeviceDiscovered() {
            updateDeviceLists()
        }
        function onDeviceConnected() {
            updateDeviceLists()
        }
        function onDeviceDisconnected() {
            updateDeviceLists()
        }
        function onPingResult(address, success, responseTime) {
            let timestamp = new Date().toLocaleTimeString()
            let status = success ? "SUCCESS" : "FAILED"
            let message = timestamp + ": Ping " + address + " - " + status + " (" + responseTime + "ms)\n"
            activityLog.append(message)
        }
        function onSerialDataReceived(data) {
            let timestamp = new Date().toLocaleTimeString()
            let message = timestamp + ": Serial RX - " + data + "\n"
            activityLog.append(message)
        }
        function onNetworkDataReceived(data) {
            let timestamp = new Date().toLocaleTimeString()
            let message = timestamp + ": Network RX - " + data + "\n"
            activityLog.append(message)
        }
        function onErrorOccurred(error) {
            let timestamp = new Date().toLocaleTimeString()
            let message = timestamp + ": ERROR - " + error + "\n"
            activityLog.append(message)
        }
    }
    
    // Update lists when dialog opens
    onOpened: {
        updateDeviceLists()
    }
    
    // Stop discovery when dialog closes
    onClosed: {
        if (deviceDiscoveryManager) {
            console.log("CommTestDialog closing - stopping all device discovery processes...")
            deviceDiscoveryManager.stopDiscovery()
            // Force disconnect any connected devices
            deviceDiscoveryManager.disconnectSerialDevice()
            deviceDiscoveryManager.disconnectNetworkDevice()
            // Clear all devices to prevent any lingering processes
            deviceDiscoveryManager.clearDevices()
        }
    }
    
    // Also handle when visibility changes (as backup)
    onVisibleChanged: {
        if (!visible && deviceDiscoveryManager) {
            console.log("CommTestDialog hidden - stopping all device discovery processes...")
            deviceDiscoveryManager.stopDiscovery()
            // Force disconnect any connected devices
            deviceDiscoveryManager.disconnectSerialDevice()
            deviceDiscoveryManager.disconnectNetworkDevice()
            // Clear all devices to prevent any lingering processes
            deviceDiscoveryManager.clearDevices()
        }
    }
} 