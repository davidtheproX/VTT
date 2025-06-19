import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtSvg
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
    property color warningColor: "#FF9800"

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

                // QML Viewer Button
                Button {
                    id: qmlViewerButton
                    width: 36 * scaleFactor
                    height: 36 * scaleFactor
                    flat: true

                    background: Rectangle {
                        color: qmlViewerButton.pressed ? Qt.darker(primaryColor, 1.3) :
                           qmlViewerButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4
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
                           commTestButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4
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
                    commTestDialogLoader.openCommTest()
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
                           svgViewerButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4
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
                    oauth2LoginDialogLoader.openOAuth2Login("wechat")
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
                    oauth2LoginDialogLoader.openOAuth2Login("dingtalk")
                }
            }

            // 3D Robot Arm Button
            Button {
                id: robotArm3DButton
                width: 36 * scaleFactor
                height: 36 * scaleFactor
                flat: true

                background: Rectangle {
                    color: robotArm3DButton.pressed ? Qt.darker(primaryColor, 1.3) :
                           robotArm3DButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                }

                contentItem: Image {
                    width: 24 * scaleFactor
                    height: 24 * scaleFactor
                    source: "qrc:/qt/qml/VoiceAILLM/resources/icons/3d-viewer.svg"
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: 24 * scaleFactor
                    sourceSize.height: 24 * scaleFactor
                    smooth: true
                }

                ToolTip.text: "3D Robot Arm Demo"
                ToolTip.visible: hovered

                onClicked: {
                    console.log("3D Robot Arm button clicked")
                    robotArm3DLoader.open3DRobotArm()
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
                    pdfDialogLoader.openPdfDialog()
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
                    webBrowserLoader.openWebBrowser()
                    }
                }

                // CSV Viewer Button (Legacy - QtCharts)
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

                        // Fallback text icon - show "oC" for legacy CSV
                        Text {
                            anchors.centerIn: parent
                            text: "oC"
                            color: "#FF9800"
                            font.pixelSize: 12 * scaleFactor
                            font.bold: true
                        }
                    }

                    ToolTip.text: "CSV Data Viewer (Legacy - QtCharts)"
                    ToolTip.visible: hovered

                    onClicked: {
                        console.log("CSV button clicked (Legacy)")
                        csvDialogLoader.openCsvDialog()
                    }
                }

                // NextGen CSV Viewer Button (QtGraphs)
                Button {
                    id: nextGenCsvButton
                    width: 36 * scaleFactor
                    height: 36 * scaleFactor
                    flat: true

                    background: Rectangle {
                        color: nextGenCsvButton.pressed ? Qt.darker(primaryColor, 1.3) :
                               nextGenCsvButton.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                        radius: 4

                        // Activity indicator
                        Rectangle {
                            width: 8 * scaleFactor
                            height: 8 * scaleFactor
                            radius: width / 2
                            color: nextGenCsvViewerLoader.active ? successColor : "transparent"
                            anchors.top: parent.top
                            anchors.right: parent.right
                            anchors.margins: 2 * scaleFactor
                        }
                    }

                    contentItem: Image {
                        width: 24 * scaleFactor
                        height: 24 * scaleFactor
                        source: "qrc:/qt/qml/VoiceAILLM/resources/icons/nextgen-csv.svg"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 24 * scaleFactor
                        sourceSize.height: 24 * scaleFactor
                        smooth: true

                        // Fallback text when icon not loaded
                        Text {
                            anchors.centerIn: parent
                            text: "nC"
                            color: "#4CAF50"
                            font.pixelSize: 12 * scaleFactor
                            font.bold: true
                            visible: parent.status !== Image.Ready
                        }
                    }

                    ToolTip.text: "NextGen CSV Data Viewer (QtGraphs)"
                    ToolTip.visible: hovered

                    onClicked: {
                        console.log("NextGen CSV button clicked")
                        nextGenCsvViewerLoader.openNextGenCsvViewer()
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

                onClicked: settingsDialogLoader.openSettings()
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
                    selectByKeyboard: true

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

    // =============================================================================
    // DYNAMIC MODULE LOADERS - Load only when needed, unload when closed
    // =============================================================================

    // Settings Dialog Loader
    Loader {
        id: settingsDialogLoader
        active: false

        sourceComponent: Component {
            SettingsDialog {
        scaleFactor: mainWindow.scaleFactor
        baseFont: mainWindow.baseFont
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor

                onClosed: {
                    Qt.callLater(function() {
                        settingsDialogLoader.active = false;
                        console.log("Settings module unloaded");
                    });
                }
            }
        }

        function openSettings() {
            console.log("Loading Settings module...");
            active = true;
            if (item) {
                item.open();
            }
        }
    }

    // Prompt Manager Dialog Loader
    Loader {
        id: promptManagerDialogLoader
        active: false

        sourceComponent: Component {
            PromptManagerDialog {
        scaleFactor: mainWindow.scaleFactor
        baseFont: mainWindow.baseFont
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor
        successColor: mainWindow.successColor
        errorColor: mainWindow.errorColor

                onVisibleChanged: {
                    if (!visible) {
                        Qt.callLater(function() {
                            promptManagerDialogLoader.active = false;
                            console.log("Prompt Manager module unloaded");
                        });
                    }
                }
            }
        }

        function openPromptManager() {
            console.log("Loading Prompt Manager module...");
            active = true;
            if (item) {
                item.open();
            }
        }
    }

    // OAuth2 Login Dialog Loader
    Loader {
        id: oauth2LoginDialogLoader
        active: false

        sourceComponent: Component {
            OAuth2LoginDialog {
        oauthManager: oauth2Manager

                onVisibleChanged: {
                    if (!visible) {
                        Qt.callLater(function() {
                            oauth2LoginDialogLoader.active = false;
                            console.log("OAuth2 Login module unloaded");
                        });
                    }
                }
            }
        }

        function openOAuth2Login(provider) {
            console.log("Loading OAuth2 Login module for provider:", provider);
            active = true;
            if (item) {
                item.currentProvider = provider;
                item.open();
            }
        }
    }

    // PDF Dialog Loader
    Loader {
        id: pdfDialogLoader
        active: false

        sourceComponent: Component {
    PDFDialog {
                backgroundColor: mainWindow.backgroundColor
                surfaceColor: mainWindow.surfaceColor
                primaryColor: mainWindow.primaryColor
                successColor: mainWindow.successColor
                errorColor: mainWindow.errorColor
                textColor: mainWindow.textColor
                mutedTextColor: mainWindow.mutedTextColor
                
                Component.onCompleted: {
                    // Set the pdfManager when the dialog is created
                    pdfManager = mainWindow.pdfManager;
                }

                onClosed: {
                    Qt.callLater(function() {
                        pdfDialogLoader.active = false;
                        console.log("PDF Dialog module unloaded");
                    });
                }
            }
        }

        function openPdfDialog() {
            console.log("Loading PDF Dialog module...");
            active = true;
            if (item) {
                item.open();
            }
        }
    }

    // CSV Dialog Loader (Legacy - QtCharts)
    Loader {
        id: csvDialogLoader
        active: false

        sourceComponent: Component {
            CSVDialog {
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        primaryColor: mainWindow.primaryColor
        successColor: mainWindow.successColor
        errorColor: mainWindow.errorColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor

                onClosed: {
                    Qt.callLater(function() {
                        csvDialogLoader.active = false;
                        console.log("CSV Dialog module unloaded");
                    });
                }
            }
        }

        function openCsvDialog() {
            console.log("Loading CSV Dialog module (Legacy)...");
            active = true;
            if (item) {
                item.open();
            }
        }
    }

    // NextGen CSV Viewer Loader (QtGraphs)
    Loader {
        id: nextGenCsvViewerLoader
        active: false
        source: active ? "qrc:/qt/qml/VoiceAILLM/qml/NextGenCSVViewer.qml" : ""

        function openNextGenCsvViewer() {
            console.log("Loading NextGen CSV Viewer module (QtGraphs)...");
            active = true;
            if (item) {
                item.show();
                item.raise();
                item.requestActivate();
            }
        }

        onLoaded: {
            if (item) {
                item.onClosed.connect(function() {
                    Qt.callLater(function() {
                        nextGenCsvViewerLoader.active = false;
                        console.log("NextGen CSV Viewer module unloaded");
                    });
                });
            }
        }
    }

    // 3D Robot Arm Loader
    Loader {
        id: robotArm3DLoader
        active: false

        sourceComponent: Component {
            RobotArm3DLoader {
                onClose: {
                    Qt.callLater(function() {
                        robotArm3DLoader.active = false;
                        console.log("3D Robot Arm module unloaded");
                    });
                }
            }
        }

        function open3DRobotArm() {
            console.log("Loading 3D Robot Arm module...");
            active = true;
            if (item) {
                item.show3D = true;
            }
        }
    }

    // Communication Test Dialog Loader
    Loader {
        id: commTestDialogLoader
        active: false

        sourceComponent: Component {
            CommTestDialog {
        scaleFactor: mainWindow.scaleFactor
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor
        successColor: mainWindow.successColor
        warningColor: mainWindow.warningColor
        errorColor: mainWindow.errorColor

                onVisibleChanged: {
                    if (!visible) {
                        Qt.callLater(function() {
                            commTestDialogLoader.active = false;
                            console.log("Communication Test module unloaded");
                        });
                    }
                }
            }
        }

        function openCommTest() {
            console.log("Loading Communication Test module...");
            active = true;
            if (item) {
                item.open();
            }
        }
    }

    // Web Browser Loader
    Loader {
        id: webBrowserLoader
        active: false

        sourceComponent: Component {
            WebBrowser {
        scaleFactor: mainWindow.scaleFactor
        primaryColor: mainWindow.primaryColor
        backgroundColor: mainWindow.backgroundColor
        textColor: mainWindow.textColor

                onVisibleChanged: {
                    if (!visible) {
                        Qt.callLater(function() {
                            webBrowserLoader.active = false;
                            console.log("Web Browser module unloaded");
                        });
                    }
                }
            }
        }

        function openWebBrowser() {
            console.log("Loading Web Browser module...");
            active = true;
            if (item) {
                item.open();
            }
        }
    }

    // PDF Viewer Loader
    Loader {
        id: pdfViewerLoader
        active: false

        sourceComponent: Component {
            PDFViewer {
        backgroundColor: mainWindow.backgroundColor
        surfaceColor: mainWindow.surfaceColor
        primaryColor: mainWindow.primaryColor
        textColor: mainWindow.textColor
        mutedTextColor: mainWindow.mutedTextColor

                onVisibleChanged: {
                    if (!visible) {
                        Qt.callLater(function() {
                            pdfViewerLoader.active = false;
                            console.log("PDF Viewer module unloaded");
                        });
                    }
                }
            }
        }

        function openPdfViewer(filePath) {
            console.log("Loading PDF Viewer module for:", filePath);
            active = true;
            if (item) {
                item.loadPDF(filePath);
                item.show();
                item.raise();
                item.requestActivate();
            }
        }

        function closePdfViewer() {
            if (item) {
                item.close();
            }
        }
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
            pdfViewerLoader.openPdfViewer(filePath);
            console.log("*** Main.qml: PDF viewer module loaded");
        }

        function onPdfClosed() {
            console.log("*** Main.qml: PDF closed, hiding viewer window");
            pdfViewerLoader.closePdfViewer();
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
        console.log("=== VOICE AI LLM STARTED WITH DYNAMIC MODULE LOADING ===");
        console.log("Core chat system loaded. All other modules will load on-demand.");
        console.log("Available modules: Settings, PDF, CSV, 3D Robot Arm, Web Browser, OAuth2");

        show()
        raise()
        requestActivate()

        // PDF manager will be set when PDF dialog is loaded dynamically
        console.log("*** PDF manager available for dynamic loading:", pdfManager);

        if (databaseManager) {
            var settings = databaseManager.getSettings();
            if (settings.interface && settings.interface.fontSize) {
                applyFontSize(settings.interface.fontSize);
            }
        }
    }
}
