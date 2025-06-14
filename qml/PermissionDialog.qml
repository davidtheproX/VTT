import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: permissionDialog
    
    property bool audioPermissionNeeded: false
    property bool storagePermissionNeeded: false
    property string permissionType: ""
    property string permissionReason: ""
    
    title: "Permission Required"
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel
    
    // Material design styling
    Material.theme: Material.Light
    Material.accent: Material.Blue
    
    // Mobile-friendly sizing
    property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"
    width: isMobile ? Math.min(parent.width * 0.9, 400) : 400
    height: Math.min(implicitHeight, parent.height * 0.8)
    
    // Center on screen
    anchors.centerIn: parent
    
    contentItem: ColumnLayout {
        spacing: 20
        
        // Permission icon
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 64
            height: 64
            radius: 32
            color: Material.color(Material.Blue, Material.Shade100)
            
            Text {
                anchors.centerIn: parent
                text: getPermissionIcon()
                font.pixelSize: 32
            }
        }
        
        // Permission explanation
        Text {
            Layout.fillWidth: true
            Layout.margins: 16
            text: getPermissionText()
            font.pixelSize: 16
            color: Material.foreground
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
        
        // Feature benefits
        Rectangle {
            Layout.fillWidth: true
            Layout.margins: 8
            height: featuresList.height + 20
            color: Material.color(Material.Grey, Material.Shade50)
            radius: 8
            border.color: Material.color(Material.Grey, Material.Shade200)
            border.width: 1
            
            Column {
                id: featuresList
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 16
                spacing: 8
                
                Text {
                    text: "This permission enables:"
                    font.weight: Font.Medium
                    font.pixelSize: 14
                    color: Material.foreground
                }
                
                Repeater {
                    model: getPermissionFeatures()
                    
                    Row {
                        width: parent.width
                        spacing: 8
                        
                        Text {
                            text: "•"
                            color: Material.color(Material.Blue)
                            font.pixelSize: 14
                        }
                        
                        Text {
                            text: modelData
                            color: Material.foreground
                            font.pixelSize: 14
                            width: parent.width - 16
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }
        }
        
        // Privacy note
        Text {
            Layout.fillWidth: true
            Layout.margins: 8
            text: "🔒 Your privacy is protected. This app follows strict data security practices."
            font.pixelSize: 12
            color: Material.hintTextColor
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.italic: true
        }
    }
    
    function getPermissionIcon() {
        switch(permissionType) {
            case "audio": return "🎤"
            case "storage": return "💾"
            case "camera": return "📷"
            case "location": return "📍"
            default: return "🔐"
        }
    }
    
    function getPermissionText() {
        switch(permissionType) {
            case "audio":
                return "Voice AI LLM needs access to your microphone to provide voice recognition and speech-to-text features."
            case "storage":
                return "Voice AI LLM needs storage access to save and load your documents, PDFs, and CSV files."
            case "camera":
                return "Voice AI LLM needs camera access for QR code scanning and document capture features."
            case "location":
                return "Voice AI LLM needs location access to provide location-based services and recommendations."
            default:
                return "Voice AI LLM needs this permission to provide full functionality."
        }
    }
    
    function getPermissionFeatures() {
        switch(permissionType) {
            case "audio":
                return [
                    "Voice commands and speech recognition",
                    "Real-time audio transcription",
                    "Voice-to-text input for chat",
                    "Audio recording for voice memos"
                ]
            case "storage":
                return [
                    "Save and load PDF documents",
                    "Import and export CSV files", 
                    "Store application settings",
                    "Cache downloaded content"
                ]
            case "camera":
                return [
                    "Scan QR codes for quick setup",
                    "Capture documents for processing",
                    "Take photos for AI analysis"
                ]
            default:
                return ["Enhanced app functionality"]
        }
    }
    
    // Handle permission request result
    onAccepted: {
        console.log("User accepted permission request for:", permissionType)
        requestPermission()
    }
    
    onRejected: {
        console.log("User rejected permission request for:", permissionType)
        handlePermissionDenied()
    }
    
    function requestPermission() {
        if (typeof permissionManager !== 'undefined') {
            switch(permissionType) {
                case "audio":
                    permissionManager.requestAudioPermission()
                    break
                case "storage":
                    permissionManager.requestStoragePermission()
                    break
                default:
                    permissionManager.requestAllPermissions()
                    break
            }
        }
    }
    
    function handlePermissionDenied() {
        // Show educational message about enabling permissions in settings
        var settingsDialog = Qt.createComponent("PermissionSettingsDialog.qml")
        if (settingsDialog.status === Component.Ready) {
            var dialog = settingsDialog.createObject(parent, {
                "permissionType": permissionType
            })
            dialog.open()
        }
    }
    
    // Public interface
    function showAudioPermission(reason) {
        permissionType = "audio"
        permissionReason = reason || "Voice recognition requires microphone access"
        audioPermissionNeeded = true
        open()
    }
    
    function showStoragePermission(reason) {
        permissionType = "storage" 
        permissionReason = reason || "File operations require storage access"
        storagePermissionNeeded = true
        open()
    }
    
    function showAllPermissions() {
        permissionType = "all"
        permissionReason = "Full app functionality requires multiple permissions"
        audioPermissionNeeded = true
        storagePermissionNeeded = true
        open()
    }
} 