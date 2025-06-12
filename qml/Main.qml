import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import VoiceAILLM 1.0

ApplicationWindow {
    id: mainWindow
    title: "Voice AI LLM Assistant"
    
    // Base size 1280x800 with scaling support
    width: 1280
    height: 800
    minimumWidth: 800
    minimumHeight: 600
    
    visibility: Window.Windowed
    visible: true
    
    // High DPI scaling support
    property real scaleFactor: Math.min(width / 1280, height / 800)
    property real baseFontSize: 14  // Can be changed by settings
    property real baseFont: baseFontSize * scaleFactor
    
    // Color scheme
    property color primaryColor: "#2196F3"
    property color secondaryColor: "#FFC107"
    property color backgroundColor: "#FAFAFA"
    property color surfaceColor: "#FFFFFF"
    property color textColor: "#212121"
    property color mutedTextColor: "#757575"
    property color errorColor: "#F44336"
    property color successColor: "#4CAF50"
    
    color: backgroundColor
    
    // Global font settings
    font.family: "Segoe UI, Roboto, Arial, sans-serif"
    font.pixelSize: baseFont
    
    header: ToolBar {
        id: headerBar
        height: 60 * scaleFactor
        
        background: Rectangle {
            color: primaryColor
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Qt.darker(primaryColor, 1.2)
            }
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 16 * scaleFactor
            
            Text {
                text: "Voice AI LLM Assistant"
                color: "white"
                font.pixelSize: baseFont * 1.4
                font.weight: Font.Medium
                Layout.fillWidth: true
            }
            
            // Connection status indicator
            Rectangle {
                width: 12 * scaleFactor
                height: 12 * scaleFactor
                radius: width / 2
                color: llmManager.isConnected ? successColor : errorColor
                
                ToolTip.text: llmManager.isConnected ? "Connected" : "Disconnected"
                ToolTip.visible: connectionMouseArea.containsMouse
                
                MouseArea {
                    id: connectionMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
            
            // OAuth2 Login buttons
            Button {
                id: wechatButton
                width: 36 * scaleFactor
                height: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: wechatButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                           wechatButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                    
                    // Authentication indicator
                    Rectangle {
                        width: 8 * scaleFactor
                        height: 8 * scaleFactor
                        radius: width / 2
                        color: oauth2Manager && oauth2Manager.isWeChatAuthenticated ? successColor : "transparent"
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 2 * scaleFactor
                    }
                }
                
                contentItem: Item {
                    width: 24 * scaleFactor
                    height: 24 * scaleFactor
                    
                    Image {
                        id: wechatIcon
                        anchors.fill: parent
                        source: "qrc:/VoiceAILLM/resources/icons/wechat.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        cache: false
                        visible: status === Image.Ready
                    }
                    
                    // Fallback text icon if SVG fails to load
                    Text {
                        anchors.centerIn: parent
                        text: "W"
                        color: "#1AAD19"
                        font.pixelSize: 16 * scaleFactor
                        font.bold: true
                        visible: wechatIcon.status !== Image.Ready
                    }
                }
                
                ToolTip.text: oauth2Manager && oauth2Manager.isWeChatAuthenticated ? "WeChat (Authenticated)" : "WeChat Login"
                ToolTip.visible: hovered
                
                onClicked: {
                    oauth2LoginDialog.currentProvider = "wechat"
                    oauth2LoginDialog.open()
                }
            }
            
            Button {
                id: dingtalkButton
                width: 36 * scaleFactor
                height: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: dingtalkButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                           dingtalkButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                    
                    // Authentication indicator
                    Rectangle {
                        width: 8 * scaleFactor
                        height: 8 * scaleFactor
                        radius: width / 2
                        color: oauth2Manager && oauth2Manager.isDingTalkAuthenticated ? successColor : "transparent"
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 2 * scaleFactor
                    }
                }
                
                contentItem: Item {
                    width: 24 * scaleFactor
                    height: 24 * scaleFactor
                    
                    Image {
                        id: dingtalkIcon
                        anchors.fill: parent
                        source: "qrc:/VoiceAILLM/resources/icons/dingtalk.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        cache: false
                        visible: status === Image.Ready
                    }
                    
                    // Fallback text icon if SVG fails to load
                    Text {
                        anchors.centerIn: parent
                        text: "D"
                        color: "#2B7CE6"
                        font.pixelSize: 16 * scaleFactor
                        font.bold: true
                        visible: dingtalkIcon.status !== Image.Ready
                    }
                }
                
                ToolTip.text: oauth2Manager && oauth2Manager.isDingTalkAuthenticated ? "DingTalk (Authenticated)" : "DingTalk Login"
                ToolTip.visible: hovered
                
                onClicked: {
                    oauth2LoginDialog.currentProvider = "dingtalk"
                    oauth2LoginDialog.open()
                }
            }

            // PDF Manager Button
            Button {
                id: pdfButton
                width: 36 * scaleFactor
                height: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: pdfButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                           pdfButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                    
                    // Activity indicator
                    Rectangle {
                        width: 8 * scaleFactor
                        height: 8 * scaleFactor
                        radius: width / 2
                        color: pdfManager && (pdfManager.isGenerating || pdfManager.isViewerOpen) ? successColor : "transparent"
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 2 * scaleFactor
                    }
                }
                
                contentItem: Item {
                    width: 24 * scaleFactor
                    height: 24 * scaleFactor
                    
                    Image {
                        id: pdfIcon
                        anchors.fill: parent
                        source: "qrc:/VoiceAILLM/resources/icons/pdf.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        cache: false
                        visible: status === Image.Ready
                    }
                    
                    // Fallback text icon if SVG fails to load
                    Text {
                        anchors.centerIn: parent
                        text: "P"
                        color: "#e53e3e"
                        font.pixelSize: 16 * scaleFactor
                        font.bold: true
                        visible: pdfIcon.status !== Image.Ready
                    }
                }
                
                ToolTip.text: "PDF Tools"
                ToolTip.visible: hovered
                
                onClicked: {
                    pdfDialog.open()
                }
            }

            // CSV Viewer Button
            Button {
                id: csvButton
                width: 36 * scaleFactor
                height: 36 * scaleFactor
                flat: true
                
                background: Rectangle {
                    color: csvButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                           csvButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                    
                    // Activity indicator
                    Rectangle {
                        width: 8 * scaleFactor
                        height: 8 * scaleFactor
                        radius: width / 2
                        color: csvViewer && csvViewer.isFileLoaded ? successColor : "transparent"
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 2 * scaleFactor
                    }
                }
                
                contentItem: Item {
                    width: 24 * scaleFactor
                    height: 24 * scaleFactor
                    
                    // Fallback text icon - show "C" for CSV
                    Text {
                        anchors.centerIn: parent
                        text: "C"
                        color: "#4CAF50"
                        font.pixelSize: 16 * scaleFactor
                        font.bold: true
                    }
                }
                
                ToolTip.text: "CSV Data Viewer"
                ToolTip.visible: hovered
                
                onClicked: {
                    console.log("CSV button clicked")
                    csvDialog.open()
                }
            }
            
            Button {
                id: settingsButton
                text: "⚙"
                font.pixelSize: baseFont * 1.2
                flat: true
                
                background: Rectangle {
                    color: settingsButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                           settingsButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                }
                
                contentItem: Text {
                    text: settingsButton.text
                    color: "white"
                    font: settingsButton.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.text: "Settings"
                ToolTip.visible: hovered
                
                onClicked: settingsDialog.open()
            }
        }
    }
    
    // Main content area
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16 * scaleFactor
        spacing: 16 * scaleFactor
        
        // Prompt selector
        RowLayout {
            Layout.fillWidth: true
            spacing: 12 * scaleFactor
            
            Text {
                text: "Active Prompt:"
                color: textColor
                font.pixelSize: baseFont
                font.weight: Font.Medium
            }
            
            ComboBox {
                id: promptComboBox
                Layout.fillWidth: true
                Layout.maximumWidth: 300 * scaleFactor
                
                model: promptManager
                textRole: "name"
                valueRole: "promptId"
                
                currentIndex: {
                    for (let i = 0; i < count; i++) {
                        if (model.data(model.index(i, 0), promptManager.constructor.IsActiveRole)) {
                            return i;
                        }
                    }
                    return -1;
                }
                
                onCurrentValueChanged: {
                    if (currentValue) {
                        promptManager.activatePrompt(currentValue);
                    }
                }
                
                delegate: ItemDelegate {
                    width: promptComboBox.width
                    
                    contentItem: Column {
                        Text {
                            text: model.name
                            color: textColor
                            font.pixelSize: baseFont
                            elide: Text.ElideRight
                            width: parent.width
                        }
                        Text {
                            text: model.category
                            color: mutedTextColor
                            font.pixelSize: baseFont * 0.85
                            elide: Text.ElideRight
                            width: parent.width
                        }
                    }
                    
                    background: Rectangle {
                        color: parent.hovered ? Qt.lighter(primaryColor, 1.8) : "transparent"
                    }
                }
            }
            
            Button {
                text: "Manage Prompts"
                flat: true
                font.pixelSize: baseFont * 0.9
                
                onClicked: promptManagerDialog.open()
            }
        }
        
        // Chat area
        ChatWindow {
            id: chatWindow
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            scaleFactor: mainWindow.scaleFactor
            baseFont: mainWindow.baseFont
            
            // Color properties
            primaryColor: mainWindow.primaryColor
            backgroundColor: mainWindow.backgroundColor
            surfaceColor: mainWindow.surfaceColor
            textColor: mainWindow.textColor
            mutedTextColor: mainWindow.mutedTextColor
        }
        
        // Input area
        RowLayout {
            Layout.fillWidth: true
            spacing: 12 * scaleFactor
            
            // Voice input button
            VoiceButton {
                id: voiceButton
                Layout.preferredWidth: 50 * scaleFactor
                Layout.preferredHeight: 50 * scaleFactor
                
                scaleFactor: mainWindow.scaleFactor
                primaryColor: mainWindow.primaryColor
                errorColor: mainWindow.errorColor
                
                isListening: voiceManager.isListening
                audioLevel: voiceManager.audioLevel
                
                onClicked: voiceManager.toggleListening()
            }
            
            // Text input
            ScrollView {
                Layout.fillWidth: true
                Layout.maximumHeight: 120 * scaleFactor
                
                TextArea {
                    id: textInput
                    placeholderText: "Type your message or use voice input..."
                    wrapMode: TextArea.Wrap
                    selectByMouse: true
                    
                    font.pixelSize: baseFont
                    color: textColor
                    
                    background: Rectangle {
                        color: surfaceColor
                        border.color: textInput.activeFocus ? primaryColor : Qt.lighter(mutedTextColor, 1.5)
                        border.width: 2
                        radius: 8 * scaleFactor
                    }
                    
                    Keys.onPressed: function(event) {
                        if (event.key === Qt.Key_Return && !(event.modifiers & Qt.ShiftModifier)) {
                            event.accepted = true;
                            sendMessage();
                        }
                    }
                }
            }
            
            // Send button
            Button {
                id: sendButton
                text: "Send"
                enabled: textInput.text.trim().length > 0 && !chatManager.isProcessing
                
                Layout.preferredWidth: 80 * scaleFactor
                Layout.preferredHeight: 50 * scaleFactor
                
                font.pixelSize: baseFont
                font.weight: Font.Medium
                
                background: Rectangle {
                    color: sendButton.enabled ? 
                           (sendButton.pressed ? Qt.darker(primaryColor, 1.2) : 
                            sendButton.hovered ? Qt.lighter(primaryColor, 1.1) : primaryColor) :
                           Qt.lighter(mutedTextColor, 1.3)
                    radius: 8 * scaleFactor
                }
                
                contentItem: Text {
                    text: sendButton.text
                    color: sendButton.enabled ? "white" : mutedTextColor
                    font: sendButton.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: sendMessage()
            }
        }
        
        // Status bar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 30 * scaleFactor
            color: Qt.lighter(backgroundColor, 1.05)
            radius: 4 * scaleFactor
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 8 * scaleFactor
                
                Text {
                    text: {
                        if (chatManager.isProcessing) return "Processing...";
                        if (voiceManager.isListening) return "Listening...";
                        return `Ready • ${chatManager.messageCount} messages`;
                    }
                    color: mutedTextColor
                    font.pixelSize: baseFont * 0.85
                    Layout.fillWidth: true
                }
                
                Text {
                    text: `Provider: ${llmManager.currentProvider === 0 ? "OpenAI" : 
                                    llmManager.currentProvider === 1 ? "LM Studio" : "Ollama"}`
                    color: mutedTextColor
                    font.pixelSize: baseFont * 0.85
                }
            }
        }
    }
    
    // Settings dialog
    SettingsDialog {
        id: settingsDialog
        
        scaleFactor: mainWindow.scaleFactor
        baseFont: mainWindow.baseFont
        
        // Color properties
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor
    }
    
    // Prompt manager dialog
    PromptManagerDialog {
        id: promptManagerDialog
        
        scaleFactor: mainWindow.scaleFactor
        baseFont: mainWindow.baseFont
        
        // Color properties
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor
        successColor: mainWindow.successColor
        errorColor: mainWindow.errorColor
    }
    
    // OAuth2 login dialog
    OAuth2LoginDialog {
        id: oauth2LoginDialog
        
        oauthManager: oauth2Manager
    }
    
    // PDF dialog
    PDFDialog {
        id: pdfDialog
    }

    // CSV dialog
    CSVDialog {
        id: csvDialog
        
        // Pass theme colors
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        primaryColor: mainWindow.primaryColor
        successColor: mainWindow.successColor
        errorColor: mainWindow.errorColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor
    }
    
    // PDF viewer window
    PDFViewer {
        id: pdfViewerWindow
        visible: false
        
        // Inherit colors from main window
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        primaryColor: mainWindow.primaryColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor
    }
    
    // Functions
    function sendMessage() {
        if (textInput.text.trim().length > 0) {
            chatManager.processUserInput(textInput.text.trim());
            textInput.clear();
        }
    }
    
    // Connections
    Connections {
        target: voiceManager
        function onTextRecognized(text) {
            textInput.text = text;
            sendMessage();
        }
        
        function onError(errorMessage) {
            console.error("Voice recognition error:", errorMessage);
        }
    }
    
    Connections {
        target: chatManager
        function onError(errorMessage) {
            console.error("Chat error:", errorMessage);
        }
    }
    
    Connections {
        target: llmManager
        function onError(errorMessage) {
            console.error("LLM error:", errorMessage);
        }
    }
    
    Connections {
        target: pdfManager
        function onPdfOpened(filePath) {
            console.log("*** Main.qml: onPdfOpened signal received! FilePath:", filePath);
            pdfViewerWindow.loadPDF(filePath);
            pdfViewerWindow.show();
            pdfViewerWindow.raise();
            pdfViewerWindow.requestActivate();
            console.log("*** Main.qml: PDF viewer window shown");
        }
        
        function onPdfClosed() {
            console.log("*** Main.qml: PDF closed, hiding viewer window");
            pdfViewerWindow.close();
        }
        
        function onError(errorMessage) {
            console.error("*** Main.qml: PDF error:", errorMessage);
        }
    }
    
    // Font size change function for settings
    function applyFontSize(newSize) {
        baseFontSize = newSize;
        console.log("Font size changed to:", newSize);
    }
    
    // Load settings on startup
    Component.onCompleted: {
        show()
        raise()
        requestActivate()
        
        // Set the pdfManager property for PDF dialog
        console.log("*** Setting pdfDialog.pdfManager to:", pdfManager);
        pdfDialog.pdfManager = pdfManager;
        
        if (databaseManager) {
            var settings = databaseManager.getSettings();
            if (settings.interface && settings.interface.fontSize) {
                applyFontSize(settings.interface.fontSize);
            }
        }
    }
} 