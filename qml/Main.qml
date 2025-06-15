import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import QtSvg
import VoiceAILLM 1.0

ApplicationWindow {
    id: mainWindow
    title: "Voice AI LLM Assistant"
    
    // Material Design configuration
    Material.theme: Qt.platform.os === "android" || Qt.platform.os === "ios" ? Material.Light : Material.System
    Material.accent: Material.Blue
    Material.primary: Material.Blue
    Material.foreground: Material.Grey
    
    // Responsive sizing - mobile-first approach
    property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"
    property bool isTablet: isMobile && Math.min(width, height) > 600
    
    // Mobile keyboard handling (Android & iOS)
    property bool isAndroid: Qt.platform.os === "android"
    property bool isIOS: Qt.platform.os === "ios"
    property bool needsKeyboardHandling: isAndroid || isIOS
    property bool keyboardVisible: false
    property real keyboardHeight: 0
    property real originalHeight: height
    
    // Mobile touch optimizations
    property bool enableHoverEffects: !isMobile
    
    // Adaptive dimensions with keyboard awareness
    width: isMobile ? (isTablet ? 1024 : 375) : 1280
    height: isMobile ? (isTablet ? 768 : 812) : 800
    minimumWidth: isMobile ? 320 : 800
    minimumHeight: isMobile ? 568 : 600
    
    visibility: isMobile ? Window.FullScreen : Window.Windowed
    visible: true
    
    // Keyboard detection for mobile platforms (Android & iOS)
    onHeightChanged: {
        if (needsKeyboardHandling && originalHeight > 0) {
            var heightDifference = originalHeight - height;
            var keyboardThreshold = isIOS ? 300 : 200; // iOS keyboard is typically larger
            
            if (heightDifference > keyboardThreshold) {
                keyboardVisible = true;
                keyboardHeight = heightDifference;
            } else {
                keyboardVisible = false;
                keyboardHeight = 0;
            }
        }
    }
    

    
    // Adaptive scaling with platform and keyboard awareness
    property real scaleFactor: {
        if (isMobile) {
            if (keyboardVisible) {
                // Platform-specific keyboard scaling
                if (isIOS) return isTablet ? 1.1 : 0.9;  // iOS keyboards need different scaling
                return isTablet ? 1.0 : 0.85;           // Android scaling
            } else {
                // Platform-specific mobile scaling
                if (isIOS) return isTablet ? 1.3 : 1.1;  // iOS prefers slightly larger UI
                return isTablet ? 1.2 : 1.0;             // Android scaling
            }
        } else {
            // Desktop scaling - responsive to window size
            var baseScale = Math.min(width / 1280, height / 800);
            return Math.max(0.8, Math.min(baseScale, 2.0)); // Clamp between 0.8x and 2.0x
        }
    }
    property real baseFontSize: isMobile ? (isTablet ? 16 : 14) : 14
    property real baseFont: baseFontSize * scaleFactor
    
    // Material Design colors with platform adaptation
    property color primaryColor: Material.color(Material.Blue)
    property color secondaryColor: Material.color(Material.Amber)
    property color backgroundColor: Material.backgroundColor
    property color surfaceColor: Material.backgroundColor
    property color textColor: Material.foreground
    property color mutedTextColor: Material.hintTextColor
    property color errorColor: Material.color(Material.Red)
    property color successColor: Material.color(Material.Green)
    property color warningColor: Material.color(Material.Orange)
    
    color: backgroundColor
    
    // Platform-adaptive font
    font.family: isMobile ? "Roboto" : (Qt.platform.os === "windows" ? "Segoe UI" : "System")
    font.pixelSize: baseFont
    
    header: ToolBar {
        id: headerBar
        // Dynamic height based on keyboard state
        height: keyboardVisible ? (40 * scaleFactor) : (60 * scaleFactor)
        
        // Smooth height transitions
        Behavior on height {
            NumberAnimation {
                duration: keyboardVisible ? 200 : 300
                easing.type: Easing.OutQuad
            }
        }
        
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
            anchors.margins: keyboardVisible ? (8 * scaleFactor) : (16 * scaleFactor)
            
            // Adaptive margins based on keyboard state
            Behavior on anchors.margins {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
            
            Text {
                text: keyboardVisible ? "Voice AI" : "Voice AI LLM Assistant"
                color: "white"
                font.pixelSize: keyboardVisible ? (baseFont * 1.2) : (baseFont * 1.4)
                font.weight: Font.Medium
                Layout.fillWidth: true
                
                // Smooth text size transitions
                Behavior on font.pixelSize {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }
            }
            
            // Connection status indicator
            Rectangle {
                width: keyboardVisible ? (8 * scaleFactor) : (12 * scaleFactor)
                height: keyboardVisible ? (8 * scaleFactor) : (12 * scaleFactor)
                radius: width / 2
                color: llmManager.isConnected ? successColor : errorColor
                
                Behavior on width {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                Behavior on height {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                
                ToolTip.text: llmManager.isConnected ? "Connected" : "Disconnected"
                ToolTip.visible: connectionMouseArea.containsMouse && !keyboardVisible
                
                MouseArea {
                    id: connectionMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
            
            // Compact toolbar when keyboard is visible
            Row {
                spacing: keyboardVisible ? (4 * scaleFactor) : (8 * scaleFactor)
                visible: !keyboardVisible || isTablet
                
                Behavior on spacing {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }

                // QML Viewer Button
                Button {
                    id: qmlViewerButton
                    width: 36 * scaleFactor
                    height: 36 * scaleFactor
                    flat: true
                    
                    background: Rectangle {
                        color: qmlViewerButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                               (enableHoverEffects && qmlViewerButton.hovered) ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4
                        
                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }
                    }
                    
                    contentItem: Image {
                        width: 24 * scaleFactor
                        height: 24 * scaleFactor
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/qml-viewer.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        smooth: true
                    }
                    
                    ToolTip.text: "QML UI Viewer (Qt Design Studio)"
                    ToolTip.visible: hovered
                    
                    onClicked: {
                        console.log("QML Viewer button clicked")
                        qmlViewerDialogLoader.openQmlViewer()
                    }
                }

                // Comm Test Button
                Button {
                    id: commTestButton
                    width: 36 * scaleFactor
                    height: 36 * scaleFactor
                    flat: true
                    
                    background: Rectangle {
                        color: commTestButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                               (enableHoverEffects && commTestButton.hovered) ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4
                        
                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }
                    }
                    
                    contentItem: Text {
                        text: "📡"
                        font.pixelSize: 20 * scaleFactor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    ToolTip.text: "Communication Test - Device Discovery"
                    ToolTip.visible: hovered
                    
                    onClicked: {
                        console.log("Comm Test button clicked")
                        commTestDialog.open()
                    }
                }

                // SVG Viewer Button
                Button {
                    id: svgViewerButton
                    width: 36 * scaleFactor
                    height: 36 * scaleFactor
                    flat: true
                    
                    background: Rectangle {
                        color: svgViewerButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                               (enableHoverEffects && svgViewerButton.hovered) ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4
                        
                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }
                    }
                    
                    contentItem: Image {
                        width: 24 * scaleFactor
                        height: 24 * scaleFactor
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/svg-viewer.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        smooth: true
                    }
                    
                    ToolTip.text: "SVG Life Data Viewer"
                    ToolTip.visible: hovered
                    
                    onClicked: {
                        console.log("SVG Viewer button clicked")
                        svgViewerDialogLoader.openSvgViewer()
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
                    
                    contentItem: Image {
                        width: 24 * scaleFactor
                        height: 24 * scaleFactor
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/wechat.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        smooth: true
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
                    
                    contentItem: Image {
                        width: 24 * scaleFactor
                        height: 24 * scaleFactor
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/dingtalk.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        smooth: true
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
                    
                    contentItem: Image {
                        width: 24 * scaleFactor
                        height: 24 * scaleFactor
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/pdf.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        smooth: true
                    }
                    
                    ToolTip.text: "PDF Tools"
                    ToolTip.visible: hovered
                    
                    onClicked: {
                        pdfDialog.open()
                    }
                }

                // Web Browser Button
                Button {
                    id: browserButton
                    width: 36 * scaleFactor
                    height: 36 * scaleFactor
                    flat: true
                    
                    background: Rectangle {
                        color: browserButton.pressed ? Qt.darker(primaryColor, 1.3) : 
                               browserButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4
                    }
                    
                    contentItem: Image {
                        width: 24 * scaleFactor
                        height: 24 * scaleFactor
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/browser.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        smooth: true
                    }
                    
                    ToolTip.text: "Web Browser"
                    ToolTip.visible: hovered
                    
                    onClicked: {
                        console.log("Browser button clicked")
                        webBrowser.open()
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
    }
    
    // Main content with keyboard-aware layout
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: keyboardVisible ? (8 * scaleFactor) : (16 * scaleFactor)
        spacing: keyboardVisible ? (8 * scaleFactor) : (16 * scaleFactor)
        
        // Smooth margin transitions
        Behavior on anchors.margins {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
        
        Behavior on spacing {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
        
        // Prompt selector - hide when keyboard is visible on phones
        RowLayout {
            Layout.fillWidth: true
            spacing: 12 * scaleFactor
            visible: !keyboardVisible || isTablet
            Layout.preferredHeight: visible ? implicitHeight : 0
            
            // Smooth visibility transitions
            opacity: visible ? 1.0 : 0.0
            Behavior on opacity {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
            
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
        
        // Chat area with keyboard-aware sizing
        ChatWindow {
            id: chatWindow
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            // Adjust chat window height when keyboard is visible
            Layout.preferredHeight: {
                if (keyboardVisible && !isTablet) {
                    return Math.max(200 * scaleFactor, parent.height * 0.4);
                }
                return -1; // Use Layout.fillHeight default
            }
            
            scaleFactor: mainWindow.scaleFactor
            baseFont: mainWindow.baseFont
            
            // Color properties
            primaryColor: mainWindow.primaryColor
            backgroundColor: mainWindow.backgroundColor
            surfaceColor: mainWindow.surfaceColor
            textColor: mainWindow.textColor
            mutedTextColor: mainWindow.mutedTextColor
        }
        
        // Input area with enhanced keyboard handling
        RowLayout {
            Layout.fillWidth: true
            spacing: keyboardVisible ? (8 * scaleFactor) : (12 * scaleFactor)
            
            Behavior on spacing {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
            
            // Voice input button
            VoiceButton {
                id: voiceButton
                Layout.preferredWidth: keyboardVisible ? (40 * scaleFactor) : (50 * scaleFactor)
                Layout.preferredHeight: keyboardVisible ? (40 * scaleFactor) : (50 * scaleFactor)
                
                Behavior on Layout.preferredWidth {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                Behavior on Layout.preferredHeight {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                
                scaleFactor: mainWindow.scaleFactor
                primaryColor: mainWindow.primaryColor
                errorColor: mainWindow.errorColor
                
                isListening: voiceManager.isListening
                audioLevel: voiceManager.audioLevel
                
                onClicked: voiceManager.toggleListening()
            }
            
            // Text input with keyboard optimization
            ScrollView {
                Layout.fillWidth: true
                Layout.maximumHeight: keyboardVisible ? (80 * scaleFactor) : (120 * scaleFactor)
                
                Behavior on Layout.maximumHeight {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                
                TextArea {
                    id: textInput
                    placeholderText: keyboardVisible ? "Type message..." : "Type your message or use voice input..."
                    wrapMode: TextArea.Wrap
                    selectByMouse: true
                    
                    font.pixelSize: baseFont
                    color: textColor
                    
                                         // Enhanced focus handling for keyboard on mobile platforms
                     onActiveFocusChanged: {
                         if (activeFocus && needsKeyboardHandling) {
                             // Ensure input is visible when keyboard appears
                             Qt.callLater(function() {
                                 if (keyboardVisible) {
                                     // Scroll to make input visible on mobile
                                     var contentArea = parent.parent.parent;
                                     if (contentArea && contentArea.contentY !== undefined) {
                                         contentArea.contentY = Math.max(0, 
                                             contentArea.contentHeight - contentArea.height);
                                     }
                                 }
                             });
                         }
                     }
                    
                    background: Rectangle {
                        color: surfaceColor
                        border.color: textInput.activeFocus ? primaryColor : Qt.lighter(mutedTextColor, 1.5)
                        border.width: 2
                        radius: keyboardVisible ? (6 * scaleFactor) : (8 * scaleFactor)
                        
                        Behavior on radius {
                            NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                        }
                    }
                    
                    Keys.onPressed: function(event) {
                        if (event.key === Qt.Key_Return && !(event.modifiers & Qt.ShiftModifier)) {
                            event.accepted = true;
                            sendMessage();
                        }
                    }
                }
            }
            
            // Send button with keyboard adaptation
            Button {
                id: sendButton
                text: keyboardVisible ? "→" : "Send"
                enabled: textInput.text.trim().length > 0 && !chatManager.isProcessing
                
                Layout.preferredWidth: keyboardVisible ? (50 * scaleFactor) : (80 * scaleFactor)
                Layout.preferredHeight: keyboardVisible ? (40 * scaleFactor) : (50 * scaleFactor)
                
                Behavior on Layout.preferredWidth {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                Behavior on Layout.preferredHeight {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                
                font.pixelSize: keyboardVisible ? (baseFont * 1.2) : baseFont
                font.weight: Font.Medium
                
                background: Rectangle {
                    color: sendButton.enabled ? 
                           (sendButton.pressed ? Qt.darker(primaryColor, 1.2) : 
                            sendButton.hovered ? Qt.lighter(primaryColor, 1.1) : primaryColor) :
                           Qt.lighter(mutedTextColor, 1.3)
                    radius: keyboardVisible ? (6 * scaleFactor) : (8 * scaleFactor)
                    
                    Behavior on radius {
                        NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                    }
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
        
        // Status bar - compact when keyboard is visible
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: keyboardVisible ? (20 * scaleFactor) : (30 * scaleFactor)
            color: Qt.lighter(backgroundColor, 1.05)
            radius: 4 * scaleFactor
            visible: !keyboardVisible || isTablet
            
            Behavior on Layout.preferredHeight {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: keyboardVisible ? (4 * scaleFactor) : (8 * scaleFactor)
                
                Behavior on anchors.margins {
                    NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                }
                
                Text {
                    text: {
                        if (chatManager.isProcessing) return "Processing...";
                        if (voiceManager.isListening) return "Listening...";
                        return `Ready • ${chatManager.messageCount} messages`;
                    }
                    color: mutedTextColor
                    font.pixelSize: (baseFont * 0.85)
                    Layout.fillWidth: true
                }
                
                Text {
                    text: `Provider: ${llmManager.currentProvider === 0 ? "OpenAI" : 
                                    llmManager.currentProvider === 1 ? "LM Studio" : "Ollama"}`
                    color: mutedTextColor
                    font.pixelSize: (baseFont * 0.85)
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
    
    // Communication Test dialog
    CommTestDialog {
        id: commTestDialog
        
        // Pass theme properties
        scaleFactor: mainWindow.scaleFactor
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor
        successColor: mainWindow.successColor
        warningColor: mainWindow.warningColor
        errorColor: mainWindow.errorColor
    }
    
    // Web Browser
    WebBrowser {
        id: webBrowser
        
        // Pass theme properties
        scaleFactor: mainWindow.scaleFactor
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        textColor: mainWindow.textColor
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
    
    // QML Viewer Dialog - loaded only when needed
    Loader {
        id: qmlViewerDialogLoader
        active: false
        
        sourceComponent: Component {
            QmlViewerDialog {
                onVisibleChanged: {
                    if (!visible) {
                        // Unload the dialog when closed to save memory
                        Qt.callLater(function() {
                            qmlViewerDialogLoader.active = false;
                        });
                    }
                }
            }
        }
        
        function openQmlViewer() {
            active = true;
            if (item) {
                item.visible = true;
            }
        }
    }

    // SVG Viewer Dialog - loaded only when needed
    Loader {
        id: svgViewerDialogLoader
        active: false
        
        sourceComponent: Component {
            SvgViewerDialog {
                onVisibleChanged: {
                    if (!visible) {
                        // Unload the dialog when closed to save memory
                        Qt.callLater(function() {
                            svgViewerDialogLoader.active = false;
                        });
                    }
                }
            }
        }
        
        function openSvgViewer() {
            active = true;
            if (item) {
                item.visible = true;
            }
        }
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
        // Initialize mobile-specific properties for keyboard handling
        if (needsKeyboardHandling) {
            originalHeight = height;
        }
        
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