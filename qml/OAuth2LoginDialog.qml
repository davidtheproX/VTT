import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Dialog {
    id: oauth2Dialog
    
    property var oauthManager: null
    property string currentProvider: ""
    
    title: "OAuth2 Login"
    width: 500
    height: 600
    modal: true
    
    // Theme colors
    property color backgroundColor: "#f8f9fa"
    property color cardColor: "#ffffff"
    property color primaryColor: "#007bff"
    property color successColor: "#28a745"
    property color errorColor: "#dc3545"
    property color textColor: "#333333"
    property color mutedTextColor: "#6c757d"
    
    background: Rectangle {
        color: backgroundColor
        radius: 8
        
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: "#dee2e6"
            border.width: 1
            radius: 8
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20
        
        // Header
        Text {
            Layout.fillWidth: true
            text: "Choose Login Method"
            font.pixelSize: 24
            font.weight: Font.Bold
            color: textColor
            horizontalAlignment: Text.AlignHCenter
        }
        
        Text {
            Layout.fillWidth: true
            text: "Login with WeChat or DingTalk using QR code or OAuth2 flow"
            font.pixelSize: 14
            color: mutedTextColor
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }
        
        // Provider selection
        RowLayout {
            Layout.fillWidth: true
            spacing: 20
            
            // WeChat Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: cardColor
                radius: 8
                border.color: currentProvider === "wechat" ? primaryColor : "#dee2e6"
                border.width: currentProvider === "wechat" ? 2 : 1
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: currentProvider = "wechat"
                }
                
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 10
                    
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        width: 48
                        height: 48
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/wechat.svg"
                            fillMode: Image.PreserveAspectFit
                            sourceSize.width: 48
                            sourceSize.height: 48
                        smooth: true
                    }
                    
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "WeChat"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        color: textColor
                    }
                    
                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 12
                        height: 12
                        radius: 6
                        color: oauthManager && oauthManager.isWeChatAuthenticated ? successColor : mutedTextColor
                        visible: oauthManager && oauthManager.isWeChatAuthenticated
                    }
                }
            }
            
            // DingTalk Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: cardColor
                radius: 8
                border.color: currentProvider === "dingtalk" ? primaryColor : "#dee2e6"
                border.width: currentProvider === "dingtalk" ? 2 : 1
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: currentProvider = "dingtalk"
                }
                
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 10
                    
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        width: 48
                        height: 48
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/dingtalk.svg"
                            fillMode: Image.PreserveAspectFit
                            sourceSize.width: 48
                            sourceSize.height: 48
                        smooth: true
                    }
                    
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "DingTalk"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        color: textColor
                    }
                    
                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 12
                        height: 12
                        radius: 6
                        color: oauthManager && oauthManager.isDingTalkAuthenticated ? successColor : mutedTextColor
                        visible: oauthManager && oauthManager.isDingTalkAuthenticated
                    }
                }
            }
        }
        
        // QR Code Display Area
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 300
            color: cardColor
            radius: 8
            border.color: "#dee2e6"
            border.width: 1
            visible: currentProvider !== ""
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: getCurrentProviderTitle()
                    font.pixelSize: 18
                    font.weight: Font.Medium
                    color: textColor
                }
                
                // QR Code or Loading
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 200
                    color: "#f8f9fa"
                    border.color: "#dee2e6"
                    border.width: 1
                    radius: 4
                    
                    // Loading indicator
                    BusyIndicator {
                        anchors.centerIn: parent
                        running: getCurrentProviderLoading()
                        visible: getCurrentProviderLoading()
                    }
                    
                    // QR Code Image
                    Image {
                        anchors.centerIn: parent
                        width: 180
                        height: 180
                        source: getCurrentQRCode()
                        visible: !getCurrentProviderLoading() && getCurrentQRCode() !== ""
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    // No QR Code message
                    Text {
                        anchors.centerIn: parent
                        text: "Click 'Generate QR Code' to start"
                        color: mutedTextColor
                        font.pixelSize: 14
                        visible: !getCurrentProviderLoading() && getCurrentQRCode() === ""
                    }
                }
                
                Text {
                    Layout.fillWidth: true
                    text: "Scan the QR code with your " + (currentProvider === "wechat" ? "WeChat" : "DingTalk") + " app to login"
                    font.pixelSize: 12
                    color: mutedTextColor
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    visible: getCurrentQRCode() !== ""
                }
            }
        }
        
        // Action Buttons
        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            visible: currentProvider !== ""
            
            Button {
                text: "Generate QR Code"
                enabled: !getCurrentProviderLoading()
                
                onClicked: {
                    if (currentProvider === "wechat" && oauthManager) {
                        oauthManager.refreshWeChatQRCode()
                    } else if (currentProvider === "dingtalk" && oauthManager) {
                        oauthManager.refreshDingTalkQRCode()
                    }
                }
            }
            
            Button {
                text: "OAuth2 Flow"
                enabled: !getCurrentProviderLoading()
                
                onClicked: {
                    if (currentProvider === "wechat" && oauthManager) {
                        oauthManager.startWeChatOAuth()
                    } else if (currentProvider === "dingtalk" && oauthManager) {
                        oauthManager.startDingTalkOAuth()
                    }
                }
            }
            
            Item { Layout.fillWidth: true }
            
            Button {
                text: "Logout"
                enabled: getCurrentProviderAuthenticated()
                
                onClicked: {
                    if (currentProvider === "wechat" && oauthManager) {
                        oauthManager.logoutWeChat()
                    } else if (currentProvider === "dingtalk" && oauthManager) {
                        oauthManager.logoutDingTalk()
                    }
                }
            }
            
            Button {
                text: "Settings"
                
                onClicked: {
                    credentialsDialog.currentProvider = currentProvider
                    credentialsDialog.open()
                }
            }
        }
        
        // Status message
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: statusText.visible ? 40 : 0
            color: getCurrentProviderAuthenticated() ? successColor : errorColor
            radius: 4
            visible: statusText.text !== ""
            
            Text {
                id: statusText
                anchors.centerIn: parent
                text: getStatusMessage()
                color: "white"
                font.pixelSize: 14
                font.weight: Font.Medium
            }
        }
        
        Item { Layout.fillHeight: true }
    }
    
    // Credentials configuration dialog
    Dialog {
        id: credentialsDialog
        
        property string currentProvider: ""
        
        title: "Configure " + (currentProvider === "wechat" ? "WeChat" : "DingTalk") + " Credentials"
        width: 400
        height: 300
        modal: true
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            
            Text {
                text: "Enter your " + (credentialsDialog.currentProvider === "wechat" ? "WeChat" : "DingTalk") + " app credentials:"
                font.pixelSize: 14
                color: textColor
            }
            
            GridLayout {
                Layout.fillWidth: true
                columns: 2
                columnSpacing: 10
                rowSpacing: 10
                
                Text {
                    text: "App ID:"
                    color: textColor
                }
                
                TextField {
                    id: appIdField
                    Layout.fillWidth: true
                    placeholderText: "Enter App ID"
                }
                
                Text {
                    text: "App Secret:"
                    color: textColor
                }
                
                TextField {
                    id: appSecretField
                    Layout.fillWidth: true
                    placeholderText: "Enter App Secret"
                    echoMode: TextInput.Password
                }
            }
            
            Text {
                Layout.fillWidth: true
                text: "You can get these credentials from the " + 
                      (credentialsDialog.currentProvider === "wechat" ? "WeChat Open Platform" : "DingTalk Open Platform") +
                      " developer console."
                font.pixelSize: 12
                color: mutedTextColor
                wrapMode: Text.WordWrap
            }
            
            Item { Layout.fillHeight: true }
            
            RowLayout {
                Layout.fillWidth: true
                
                Item { Layout.fillWidth: true }
                
                Button {
                    text: "Cancel"
                    onClicked: credentialsDialog.close()
                }
                
                Button {
                    text: "Save"
                    enabled: appIdField.text !== "" && appSecretField.text !== ""
                    
                    onClicked: {
                        if (oauthManager) {
                            if (credentialsDialog.currentProvider === "wechat") {
                                oauthManager.setWeChatCredentials(appIdField.text, appSecretField.text)
                            } else if (credentialsDialog.currentProvider === "dingtalk") {
                                oauthManager.setDingTalkCredentials(appIdField.text, appSecretField.text)
                            }
                        }
                        credentialsDialog.close()
                    }
                }
            }
        }
        
        onOpened: {
            appIdField.text = ""
            appSecretField.text = ""
        }
    }
    
    // Footer buttons
    footer: RowLayout {
        spacing: 10
        
        Item { Layout.fillWidth: true }
        
        Button {
            text: "Close"
            onClicked: oauth2Dialog.close()
        }
    }
    
    // Helper functions
    function getCurrentProviderTitle() {
        if (currentProvider === "wechat") return "WeChat Login"
        if (currentProvider === "dingtalk") return "DingTalk Login"
        return ""
    }
    
    function getCurrentProviderLoading() {
        if (!oauthManager) return false
        if (currentProvider === "wechat") return oauthManager.isWeChatLoading
        if (currentProvider === "dingtalk") return oauthManager.isDingTalkLoading
        return false
    }
    
    function getCurrentProviderAuthenticated() {
        if (!oauthManager) return false
        if (currentProvider === "wechat") return oauthManager.isWeChatAuthenticated
        if (currentProvider === "dingtalk") return oauthManager.isDingTalkAuthenticated
        return false
    }
    
    function getCurrentQRCode() {
        if (!oauthManager) return ""
        if (currentProvider === "wechat") return oauthManager.weChatQRCode
        if (currentProvider === "dingtalk") return oauthManager.dingTalkQRCode
        return ""
    }
    
    function getStatusMessage() {
        if (!oauthManager) return ""
        
        if (getCurrentProviderAuthenticated()) {
            return "Successfully authenticated with " + (currentProvider === "wechat" ? "WeChat" : "DingTalk")
        }
        
        return ""
    }
    
    // Connections to OAuth manager
    Connections {
        target: oauthManager
        
        function onAuthenticationSuccess(provider) {
            if ((provider === 0 && currentProvider === "wechat") || 
                (provider === 1 && currentProvider === "dingtalk")) {
                // Success - could auto-close or show success message
            }
        }
        
        function onAuthenticationError(provider, error) {
            console.error("OAuth authentication error:", error)
        }
    }
} 