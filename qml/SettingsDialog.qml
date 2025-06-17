import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: settingsDialog
    title: "Settings"
    modal: true
    anchors.centerIn: parent
    
    // Scaling properties (will be set from Main.qml)
    property real scaleFactor: 1.0
    property real baseFont: 14
    
    // Color properties (will be set from Main.qml)
    property color primaryColor: "#2196F3"
    property color backgroundColor: "#FAFAFA"
    property color surfaceColor: "#FFFFFF"
    property color textColor: "#212121"
    property color mutedTextColor: "#757575"
    
    width: Math.min(700 * scaleFactor, parent.width * 0.9)
    height: Math.min(650 * scaleFactor, parent.height * 0.9)
    
    // Load settings when dialog opens
    onOpened: {
        loadSettings();
        
        // Refresh TTS voices when dialog opens
        if (ttsManager) {
            console.log("Settings dialog opened, refreshing TTS voices...");
            ttsManager.getCurrentVoices();
        }
    }
    
    background: Rectangle {
        color: surfaceColor
        radius: 12 * scaleFactor
        border.color: Qt.lighter(mutedTextColor, 1.8)
        border.width: 1
        
        // Drop shadow effect
        Rectangle {
            anchors.fill: parent
            anchors.margins: -4
            color: "transparent"
            border.color: Qt.rgba(0, 0, 0, 0.1)
            border.width: 1
            radius: parent.radius + 2
            z: -1
        }
    }
    
    header: Rectangle {
        height: 60 * scaleFactor
        color: primaryColor
        radius: 12 * scaleFactor
        
        // Only round top corners
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.radius
            color: parent.color
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 20 * scaleFactor
            
            Text {
                text: settingsDialog.title
                color: "white"
                font.pixelSize: baseFont * 1.3
                font.weight: Font.Medium
                Layout.fillWidth: true
            }
            
            Button {
                text: "✕"
                flat: true
                font.pixelSize: baseFont * 1.2
                
                background: Rectangle {
                    color: parent.pressed ? Qt.darker(primaryColor, 1.3) :
                           parent.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4 * scaleFactor
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: settingsDialog.close()
            }
        }
    }
    
    contentItem: ScrollView {
        anchors.fill: parent
        anchors.margins: 20 * scaleFactor
        
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        
        ColumnLayout {
            width: parent.width
            spacing: 24 * scaleFactor
            
            // AI Model Provider Settings
            GroupBox {
                Layout.fillWidth: true
                
                title: "AI Model Configuration"
                font.pixelSize: baseFont * 1.1
                font.weight: Font.Medium
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16 * scaleFactor
                    spacing: 16 * scaleFactor
                    
                    // Provider selection
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Provider:"
                            color: textColor
                            font.pixelSize: baseFont
                            Layout.minimumWidth: 80 * scaleFactor
                        }
                        
                        ComboBox {
                            id: providerComboBox
                            Layout.fillWidth: true
                            
                            model: ["OpenAI", "LM Studio", "Ollama"]
                            currentIndex: llmManager ? llmManager.currentProvider : 0
                            
                            onCurrentIndexChanged: {
                                if (llmManager) {
                                    llmManager.currentProvider = currentIndex;
                                    
                                    // Auto-test connection when provider changes (with delay)
                                    if (llmManager.baseUrl && llmManager.baseUrl !== "") {
                                        console.log("Provider changed, auto-testing connection...");
                                        Qt.callLater(function() {
                                            llmManager.testConnection();
                                        });
                                    }
                                }
                            }
                        }
                    }
                    
                    // Base URL
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Base URL:"
                            color: textColor
                            font.pixelSize: baseFont
                            Layout.minimumWidth: 80 * scaleFactor
                        }
                        
                        TextField {
                            id: baseUrlField
                            Layout.fillWidth: true
                            
                            text: llmManager ? llmManager.baseUrl : ""
                            placeholderText: "Enter base URL (e.g., http://localhost:1234/v1)"
                            
                            onTextChanged: {
                                if (llmManager) {
                                    llmManager.baseUrl = text;
                                    
                                    // Auto-test connection when base URL changes (with delay)
                                    if (text && text !== "") {
                                        testConnectionTimer.restart();
                                    }
                                }
                            }
                        }
                    }
                    
                    // API Key (only for OpenAI)
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        visible: providerComboBox.currentIndex === 0 // Only show for OpenAI
                        
                        Text {
                            text: "API Key:"
                            color: textColor
                            font.pixelSize: baseFont
                            Layout.minimumWidth: 80 * scaleFactor
                        }
                        
                        TextField {
                            id: apiKeyField
                            Layout.fillWidth: true
                            
                            text: llmManager ? llmManager.apiKey : ""
                            placeholderText: "Enter your OpenAI API key"
                            echoMode: showApiKey.checked ? TextInput.Normal : TextInput.Password
                            
                            onTextChanged: {
                                if (llmManager) {
                                    llmManager.apiKey = text;
                                }
                            }
                        }
                        
                        CheckBox {
                            id: showApiKey
                            text: "Show"
                            font.pixelSize: baseFont * 0.85
                        }
                    }
                    
                    // Model name
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Model:"
                            color: textColor
                            font.pixelSize: baseFont
                            Layout.minimumWidth: 80 * scaleFactor
                        }
                        
                        TextField {
                            id: modelField
                            Layout.fillWidth: true
                            
                            text: llmManager ? llmManager.model : ""
                            placeholderText: {
                                switch(providerComboBox.currentIndex) {
                                    case 0: return "gpt-3.5-turbo, gpt-4, etc.";
                                    case 1: return "model-name (from LM Studio)";
                                    case 2: return "llama2, codellama, etc.";
                                    default: return "Enter model name";
                                }
                            }
                            
                            onTextChanged: {
                                if (llmManager) {
                                    llmManager.model = text;
                                }
                            }
                        }
                    }
                    
                    // Test connection and Save buttons
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Button {
                            text: "Test Connection"
                            
                            onClicked: {
                                if (llmManager) {
                                    llmManager.testConnection();
                                }
                            }
                        }
                        
                        Button {
                            text: "Save AI Settings"
                            
                            background: Rectangle {
                                color: parent.pressed ? Qt.darker("#4CAF50", 1.2) :
                                       parent.hovered ? Qt.lighter("#4CAF50", 1.1) : "#4CAF50"
                                radius: 6 * scaleFactor
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: saveAISettings()
                        }
                        
                        Item { Layout.fillWidth: true }
                        
                        Rectangle {
                            width: 12 * scaleFactor
                            height: 12 * scaleFactor
                            radius: width / 2
                            color: (llmManager && llmManager.isConnected) ? "#4CAF50" : "#F44336"
                        }
                        
                        Text {
                            text: (llmManager && llmManager.isConnected) ? "Connected" : "Disconnected"
                            color: mutedTextColor
                            font.pixelSize: baseFont * 0.85
                        }
                    }
                }
            }
            
            // Voice Settings
            GroupBox {
                Layout.fillWidth: true
                
                title: "Voice Recognition"
                font.pixelSize: baseFont * 1.1
                font.weight: Font.Medium
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16 * scaleFactor
                    spacing: 16 * scaleFactor
                    
                    // Google API Key for Speech-to-Text
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Google API Key:"
                            color: textColor
                            font.pixelSize: baseFont
                            Layout.minimumWidth: 100 * scaleFactor
                        }
                        
                        TextField {
                            id: googleApiKeyField
                            Layout.fillWidth: true
                            
                            text: voiceManager ? voiceManager.googleApiKey : ""
                            placeholderText: "Enter your Google Cloud Speech-to-Text API key"
                            echoMode: showGoogleApiKey.checked ? TextInput.Normal : TextInput.Password
                            
                            onTextChanged: {
                                if (voiceManager) {
                                    voiceManager.googleApiKey = text;
                                }
                            }
                        }
                        
                        CheckBox {
                            id: showGoogleApiKey
                            text: "Show"
                            font.pixelSize: baseFont * 0.85
                        }
                    }
                    
                    // Help text for Google API key
                    Text {
                        Layout.fillWidth: true
                        text: "Get your API key from Google Cloud Console → APIs & Services → Credentials"
                        color: mutedTextColor
                        font.pixelSize: baseFont * 0.85
                        wrapMode: Text.WordWrap
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: Qt.lighter(mutedTextColor, 1.7)
                    }
                    
                    // Microphone selection
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Microphone:"
                            color: textColor
                            font.pixelSize: baseFont
                            Layout.minimumWidth: 100 * scaleFactor
                        }
                        
                        ComboBox {
                            id: microphoneComboBox
                            Layout.fillWidth: true
                            
                            model: voiceManager ? voiceManager.availableMicrophones : []
                            currentIndex: {
                                if (voiceManager && voiceManager.currentMicrophone) {
                                    const index = voiceManager.availableMicrophones.indexOf(voiceManager.currentMicrophone);
                                    return index >= 0 ? index : 0;
                                }
                                return 0;
                            }
                            
                            onActivated: {
                                if (voiceManager && currentIndex >= 0) {
                                    voiceManager.currentMicrophone = model[currentIndex];
                                }
                            }
                        }
                        
                        Button {
                            text: "🔄"
                            implicitWidth: 32 * scaleFactor
                            implicitHeight: 32 * scaleFactor
                            
                            onClicked: {
                                if (voiceManager) {
                                    voiceManager.refreshMicrophones();
                                }
                            }
                            
                            ToolTip.visible: hovered
                            ToolTip.text: "Refresh microphone list"
                        }
                    }
                    
                    // Microphone testing
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Microphone Test:"
                            color: textColor
                            font.pixelSize: baseFont
                            Layout.minimumWidth: 100 * scaleFactor
                        }
                        
                        Button {
                            id: micTestButton
                            text: voiceManager && voiceManager.isTesting ? "Stop Test" : "Start Test"
                            
                            onClicked: {
                                if (voiceManager) {
                                    if (voiceManager.isTesting) {
                                        voiceManager.stopMicrophoneTest();
                                    } else {
                                        voiceManager.startMicrophoneTest();
                                    }
                                }
                            }
                        }
                        
                        // Audio level indicator
                        Rectangle {
                            Layout.fillWidth: true
                            height: 20 * scaleFactor
                            color: "#f0f0f0"
                            border.color: mutedTextColor
                            border.width: 1
                            radius: 4
                            
                            Rectangle {
                                height: parent.height - 2
                                width: Math.max(2, (voiceManager ? voiceManager.audioLevel : 0) * parent.width)
                                x: 1
                                y: 1
                                color: {
                                    const level = voiceManager ? voiceManager.audioLevel : 0;
                                    if (level < 0.3) return "#4CAF50"; // Green
                                    if (level < 0.7) return "#FF9800"; // Orange
                                    return "#F44336"; // Red
                                }
                                radius: 3
                                
                                Behavior on width {
                                    NumberAnimation { duration: 100 }
                                }
                            }
                        }
                        
                        Text {
                            text: voiceManager && voiceManager.isTesting ? "Testing..." : "Ready"
                            color: mutedTextColor
                            font.pixelSize: baseFont * 0.85
                        }
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: Qt.lighter(mutedTextColor, 1.7)
                    }
                    
                    CheckBox {
                        id: autoSendCheckBox
                        text: "Auto-send after voice input"
                        font.pixelSize: baseFont
                        checked: true
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Recording duration:"
                            color: textColor
                            font.pixelSize: baseFont
                        }
                        
                        SpinBox {
                            id: recordingDurationSpinBox
                            from: 2
                            to: 10
                            value: 5
                            textFromValue: function(value, locale) {
                                return value + " seconds";
                            }
                        }
                    }
                    
                    // Save voice settings button
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Button {
                            text: "Save Voice Settings"
                            
                            background: Rectangle {
                                color: parent.pressed ? Qt.darker("#4CAF50", 1.2) :
                                       parent.hovered ? Qt.lighter("#4CAF50", 1.1) : "#4CAF50"
                                radius: 6 * scaleFactor
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: saveVoiceSettings()
                        }
                        
                        Item { Layout.fillWidth: true }
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        text: "Note: Voice recognition uses Google Cloud Speech-to-Text API for high accuracy."
                        color: mutedTextColor
                        font.pixelSize: baseFont * 0.85
                        wrapMode: Text.WordWrap
                    }
                }
            }
            
            // Text-to-Speech Settings
            GroupBox {
                Layout.fillWidth: true
                
                title: "Text-to-Speech"
                font.pixelSize: baseFont * 1.1
                font.weight: Font.Medium
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16 * scaleFactor
                    spacing: 16 * scaleFactor
                    
                    CheckBox {
                        id: ttsEnabledCheckbox
                        text: "Enable Text-to-Speech for AI responses"
                        font.pixelSize: baseFont
                        checked: ttsManager ? ttsManager.isEnabled : false
                        
                        onCheckedChanged: {
                            if (ttsManager) {
                                ttsManager.setIsEnabled(checked);
                            }
                        }
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        text: "AI responses will be spoken aloud using the selected voice"
                        color: mutedTextColor
                        font.pixelSize: baseFont * 0.85
                        wrapMode: Text.WordWrap
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: Qt.lighter(mutedTextColor, 1.7)
                        visible: ttsEnabledCheckbox.checked
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        visible: ttsEnabledCheckbox.checked
                        
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12 * scaleFactor
                            
                            Text {
                                text: "Voice:"
                                color: textColor
                                font.pixelSize: baseFont
                                Layout.minimumWidth: 80 * scaleFactor
                            }
                            
                            ComboBox {
                                id: voiceCombo
                                Layout.fillWidth: true
                                model: ttsManager ? ttsManager.availableVoiceNames : []
                                
                                currentIndex: {
                                    if (ttsManager && ttsManager.currentVoiceName && model.length > 0) {
                                        console.log("Looking for current voice:", ttsManager.currentVoiceName)
                                        // Try to find the current voice name in the model
                                        for (var i = 0; i < model.length; i++) {
                                            if (model[i].indexOf(ttsManager.currentVoiceName) !== -1) {
                                                console.log("Found voice at index:", i)
                                                return i;
                                            }
                                        }
                                        console.log("Current voice not found in model")
                                    }
                                    return 0;
                                }
                                
                                // Store selected voice but don't apply immediately
                                property string selectedVoice: currentText
                                property int selectedVoiceIndex: currentIndex
                                
                                onCurrentIndexChanged: {
                                    selectedVoiceIndex = currentIndex
                                    console.log("Voice selection changed to index:", currentIndex, "voice:", currentText)
                                }
                                
                                Component.onCompleted: {
                                    // Force refresh voices when component is created
                                    if (ttsManager) {
                                        console.log("Voice ComboBox created, refreshing voices...");
                                        ttsManager.getCurrentVoices();
                                        
                                        // Connect to voice updates signal
                                        ttsManager.voicesUpdated.connect(function() {
                                            console.log("Voices updated signal received");
                                            model = Qt.binding(function() { return ttsManager.availableVoiceNames; });
                                        });
                                    }
                                }
                            }
                            
                            Button {
                                text: "🔄"
                                Layout.preferredWidth: 40 * scaleFactor
                                Layout.preferredHeight: 30 * scaleFactor
                                font.pixelSize: baseFont
                                
                                background: Rectangle {
                                    color: parent.pressed ? Qt.darker(primaryColor, 1.3) :
                                           parent.hovered ? Qt.lighter(primaryColor, 1.2) : primaryColor
                                    radius: 4 * scaleFactor
                                    border.width: 1
                                    border.color: Qt.darker(primaryColor, 1.1)
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font: parent.font
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    if (ttsManager) {
                                        console.log("Refreshing voice list...");
                                        ttsManager.refreshVoices();
                                        // Force update the ComboBox model
                                        voiceCombo.model = Qt.binding(function() { return ttsManager.availableVoiceNames; });
                                    }
                                }
                                
                                ToolTip.text: "Refresh voice list from system"
                                ToolTip.visible: hovered
                            }
                        }
                        

                        
                        GridLayout {
                            Layout.fillWidth: true
                            columns: 3
                            rowSpacing: 8 * scaleFactor
                            columnSpacing: 12 * scaleFactor
                            
                            Text {
                                text: "Rate:"
                                color: textColor
                                font.pixelSize: baseFont * 0.9
                            }
                            
                            Slider {
                                id: rateSlider
                                Layout.fillWidth: true
                                from: 0.1
                                to: 2.0
                                value: ttsManager ? ttsManager.rate : 1.0
                                stepSize: 0.1
                                
                                onValueChanged: {
                                    if (ttsManager) {
                                        console.log("Rate slider changed to:", value);
                                        ttsManager.rate = value;
                                    }
                                }
                            }
                            
                            Text {
                                text: rateSlider.value.toFixed(1) + "x"
                                color: mutedTextColor
                                font.pixelSize: baseFont * 0.8
                                Layout.minimumWidth: 30 * scaleFactor
                            }
                            
                            Text {
                                text: "Pitch:"
                                color: textColor
                                font.pixelSize: baseFont * 0.9
                            }
                            
                            Slider {
                                id: pitchSlider
                                Layout.fillWidth: true
                                from: -1.0
                                to: 1.0
                                value: ttsManager ? ttsManager.pitch : 0.0
                                stepSize: 0.1
                                
                                onValueChanged: {
                                    if (ttsManager) {
                                        console.log("Pitch slider changed to:", value);
                                        ttsManager.pitch = value;
                                    }
                                }
                            }
                            
                            Text {
                                text: pitchSlider.value.toFixed(1)
                                color: mutedTextColor
                                font.pixelSize: baseFont * 0.8
                                Layout.minimumWidth: 30 * scaleFactor
                            }
                            
                            Text {
                                text: "Volume:"
                                color: textColor
                                font.pixelSize: baseFont * 0.9
                            }
                            
                            Slider {
                                id: volumeSlider
                                Layout.fillWidth: true
                                from: 0.0
                                to: 1.0
                                value: ttsManager ? ttsManager.volume : 0.8
                                stepSize: 0.05
                                
                                onValueChanged: {
                                    if (ttsManager) {
                                        console.log("Volume slider changed to:", value);
                                        ttsManager.volume = value;
                                        console.log("TTS volume set to:", ttsManager.volume);
                                    }
                                }
                                
                                onMoved: {
                                    if (ttsManager) {
                                        ttsManager.volume = value;
                                    }
                                }
                            }
                            
                            Text {
                                text: Math.round(volumeSlider.value * 100) + "%"
                                color: mutedTextColor
                                font.pixelSize: baseFont * 0.8
                                Layout.minimumWidth: 30 * scaleFactor
                            }
                        }
                        
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8 * scaleFactor
                            
                            Button {
                                text: "🔊 Test Voice"
                                
                                background: Rectangle {
                                    color: parent.pressed ? Qt.darker("#4CAF50", 1.2) :
                                           parent.hovered ? Qt.lighter("#4CAF50", 1.1) : "#4CAF50"
                                    radius: 6 * scaleFactor
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font: parent.font
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    if (ttsManager) {
                                        console.log("Test TTS button clicked")
                                        
                                        // Apply current settings first
                                        console.log("Setting rate to:", rateSlider.value)
                                        console.log("Setting pitch to:", pitchSlider.value)
                                        console.log("Setting volume to:", volumeSlider.value)
                                        
                                        ttsManager.rate = rateSlider.value;
                                        ttsManager.pitch = pitchSlider.value;
                                        ttsManager.volume = volumeSlider.value;
                                        
                                        // Apply selected voice if one is chosen
                                        if (voiceCombo.selectedVoiceIndex >= 0 && ttsManager.availableVoices.length > voiceCombo.selectedVoiceIndex) {
                                            console.log("Setting voice index:", voiceCombo.selectedVoiceIndex)
                                            var selectedVoice = ttsManager.availableVoices[voiceCombo.selectedVoiceIndex]
                                            console.log("Setting voice to:", selectedVoice.name)
                                            ttsManager.setVoice(selectedVoice)
                                        }
                                        
                                        // Test TTS with current settings
                                        ttsManager.testTTS();
                                    }
                                }
                            }
                            
                            Button {
                                text: ttsManager && ttsManager.isSpeaking ? "⏹️ Stop" : "🔇 Stop"
                                enabled: ttsManager && ttsManager.isSpeaking
                                
                                background: Rectangle {
                                    color: parent.enabled ? 
                                           (parent.pressed ? Qt.darker(errorColor, 1.2) :
                                            parent.hovered ? Qt.lighter(errorColor, 1.1) : errorColor) :
                                           Qt.lighter(mutedTextColor, 1.5)
                                    radius: 6 * scaleFactor
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    color: parent.enabled ? "white" : mutedTextColor
                                    font: parent.font
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    if (ttsManager) ttsManager.stop();
                                }
                            }
                            
                            Item { Layout.fillWidth: true }
                        }
                        
                        // Multilingual test buttons
                        Text {
                            text: "Test Different Languages:"
                            color: textColor
                            font.pixelSize: baseFont
                            font.weight: Font.Medium
                            Layout.topMargin: 8 * scaleFactor
                        }
                        
                        GridLayout {
                            Layout.fillWidth: true
                            columns: 5
                            columnSpacing: 8 * scaleFactor
                            rowSpacing: 8 * scaleFactor
                            
                            property var languages: [
                                { code: "en", flag: "🇺🇸", name: "English" },
                                { code: "zh", flag: "🇨🇳", name: "Chinese" },
                                { code: "ja", flag: "🇯🇵", name: "Japanese" },
                                { code: "ko", flag: "🇰🇷", name: "Korean" },
                                { code: "es", flag: "🇪🇸", name: "Spanish" },
                                { code: "fr", flag: "🇫🇷", name: "French" },
                                { code: "de", flag: "🇩🇪", name: "German" },
                                { code: "it", flag: "🇮🇹", name: "Italian" },
                                { code: "ru", flag: "🇷🇺", name: "Russian" },
                                { code: "ar", flag: "🇸🇦", name: "Arabic" }
                            ]
                            
                            Repeater {
                                model: parent.languages
                                
                                Button {
                                    text: modelData.flag + " " + modelData.code.toUpperCase()
                                    font.pixelSize: baseFont * 0.8
                                    Layout.preferredHeight: 30 * scaleFactor
                                    Layout.fillWidth: true
                                    
                                    background: Rectangle {
                                        color: parent.pressed ? Qt.darker("#2196F3", 1.2) :
                                               parent.hovered ? Qt.lighter("#2196F3", 1.1) : "#2196F3"
                                        radius: 4 * scaleFactor
                                    }
                                    
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        font: parent.font
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    
                                    onClicked: {
                                        if (ttsManager) {
                                            console.log("Testing language:", modelData.code, modelData.name);
                                            
                                            // Apply current settings first
                                            ttsManager.rate = rateSlider.value;
                                            ttsManager.pitch = pitchSlider.value;
                                            ttsManager.volume = volumeSlider.value;
                                            
                                            // Test specific language
                                            ttsManager.testLanguage(modelData.code);
                                        }
                                    }
                                    
                                    ToolTip.text: "Test " + modelData.name + " speech"
                                    ToolTip.visible: hovered
                                }
                            }
                        }
                        
                        // Additional test options
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8 * scaleFactor
                            Layout.topMargin: 8 * scaleFactor
                            
                            Button {
                                text: "🌍 Test All Languages"
                                font.pixelSize: baseFont * 0.9
                                
                                background: Rectangle {
                                    color: parent.pressed ? Qt.darker("#FF9800", 1.2) :
                                           parent.hovered ? Qt.lighter("#FF9800", 1.1) : "#FF9800"
                                    radius: 6 * scaleFactor
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font: parent.font
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    if (ttsManager) {
                                        console.log("Testing all languages in sequence");
                                        
                                        // Apply current settings first
                                        ttsManager.rate = rateSlider.value;
                                        ttsManager.pitch = pitchSlider.value;
                                        ttsManager.volume = volumeSlider.value;
                                        
                                        // Test all languages
                                        ttsManager.testMultilingualSpeech();
                                    }
                                }
                                
                                ToolTip.text: "Test all supported languages in sequence"
                                ToolTip.visible: hovered
                            }
                            
                            Button {
                                text: "🔄 Force Refresh All"
                                font.pixelSize: baseFont * 0.9
                                
                                background: Rectangle {
                                    color: parent.pressed ? Qt.darker("#9C27B0", 1.2) :
                                           parent.hovered ? Qt.lighter("#9C27B0", 1.1) : "#9C27B0"
                                    radius: 6 * scaleFactor
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font: parent.font
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    if (ttsManager) {
                                        console.log("Force refreshing all TTS data");
                                        ttsManager.forceRefreshAll();
                                        voiceCombo.model = Qt.binding(function() { return ttsManager.availableVoiceNames; });
                                    }
                                }
                                
                                ToolTip.text: "Force complete refresh of TTS system"
                                ToolTip.visible: hovered
                            }
                            
                            Item { Layout.fillWidth: true }
                        }
                    }
                    
                    // Save TTS settings button
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Button {
                            text: "Save TTS Settings"
                            
                            background: Rectangle {
                                color: parent.pressed ? Qt.darker("#4CAF50", 1.2) :
                                       parent.hovered ? Qt.lighter("#4CAF50", 1.1) : "#4CAF50"
                                radius: 6 * scaleFactor
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: saveTTSSettings()
                        }
                        
                        Item { Layout.fillWidth: true }
                    }
                }
            }
            
            // Interface Settings
            GroupBox {
                Layout.fillWidth: true
                
                title: "Interface"
                font.pixelSize: baseFont * 1.1
                font.weight: Font.Medium
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16 * scaleFactor
                    spacing: 16 * scaleFactor
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Text {
                            text: "Font size:"
                            color: textColor
                            font.pixelSize: baseFont
                        }
                        
                        SpinBox {
                            id: fontSizeSpinBox
                            from: 8
                            to: 24
                            value: 14
                            textFromValue: function(value, locale) {
                                return value + " px";
                            }
                        }
                    }
                    
                    CheckBox {
                        id: autoScrollCheckBox
                        text: "Auto-scroll to latest message"
                        font.pixelSize: baseFont
                        checked: true
                    }
                    
                    CheckBox {
                        id: showTimestampsCheckBox
                        text: "Show timestamps"
                        font.pixelSize: baseFont
                        checked: true
                    }
                    
                    // Save interface settings button
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12 * scaleFactor
                        
                        Button {
                            text: "Save Interface Settings"
                            
                            background: Rectangle {
                                color: parent.pressed ? Qt.darker("#4CAF50", 1.2) :
                                       parent.hovered ? Qt.lighter("#4CAF50", 1.1) : "#4CAF50"
                                radius: 6 * scaleFactor
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: saveInterfaceSettings()
                        }
                        
                        Item { Layout.fillWidth: true }
                    }
                }
            }
        }
    }
    
    footer: DialogButtonBox {
        background: Rectangle {
            color: surfaceColor
            radius: 12 * scaleFactor
            
            // Only round bottom corners
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.radius
                color: parent.color
            }
        }
        
        Button {
            text: "Save All & Close"
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            
            background: Rectangle {
                color: parent.pressed ? Qt.darker(primaryColor, 1.2) :
                       parent.hovered ? Qt.lighter(primaryColor, 1.1) : primaryColor
                radius: 6 * scaleFactor
            }
            
            contentItem: Text {
                text: parent.text
                color: "white"
                font: parent.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        
        Button {
            text: "Cancel"
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
            
            background: Rectangle {
                color: parent.pressed ? Qt.darker(mutedTextColor, 1.2) :
                       parent.hovered ? Qt.lighter(mutedTextColor, 1.1) : mutedTextColor
                radius: 6 * scaleFactor
            }
            
            contentItem: Text {
                text: parent.text
                color: "white"
                font: parent.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        
        onAccepted: {
            saveAllSettings();
            settingsDialog.close();
        }
        
        onRejected: {
            loadSettings(); // Revert changes
            settingsDialog.close();
        }
    }
    
    // Functions to load and save settings
    function loadSettings() {
        if (!databaseManager) return;
        
        var settings = databaseManager.getSettings();
        
        // Load AI settings
        if (settings.ai) {
            if (llmManager) {
                llmManager.currentProvider = settings.ai.provider || 0;
                llmManager.baseUrl = settings.ai.baseUrl || "";
                llmManager.apiKey = settings.ai.apiKey || "";
                llmManager.model = settings.ai.model || "";
                
                // Auto-test connection after loading settings
                if (settings.ai.baseUrl && settings.ai.baseUrl !== "") {
                    console.log("Auto-testing connection with loaded settings...");
                    Qt.callLater(function() {
                        llmManager.testConnection();
                    });
                }
            }
            providerComboBox.currentIndex = settings.ai.provider || 0;
            baseUrlField.text = settings.ai.baseUrl || "";
            apiKeyField.text = settings.ai.apiKey || "";
            modelField.text = settings.ai.model || "";
        }
        
        // Load voice settings
        if (settings.voice) {
            if (voiceManager) {
                voiceManager.googleApiKey = settings.voice.googleApiKey || "";
                if (settings.voice.microphone) {
                    voiceManager.currentMicrophone = settings.voice.microphone;
                }
            }
            googleApiKeyField.text = settings.voice.googleApiKey || "";
            autoSendCheckBox.checked = settings.voice.autoSend !== false;
            recordingDurationSpinBox.value = settings.voice.recordingDuration || 5;
        }
        
        // Load TTS settings
        if (settings.tts) {
            ttsEnabledCheckbox.checked = settings.tts.enabled || false;
                                    if (ttsManager) {
                            ttsManager.setIsEnabled(settings.tts.enabled || false);
                if (settings.tts.voice) ttsManager.currentVoice = settings.tts.voice;
                if (settings.tts.rate !== undefined) ttsManager.rate = settings.tts.rate;
                if (settings.tts.pitch !== undefined) ttsManager.pitch = settings.tts.pitch;
                if (settings.tts.volume !== undefined) ttsManager.volume = settings.tts.volume;
            }
        }
        
        // Load interface settings
        if (settings.interface) {
            fontSizeSpinBox.value = settings.interface.fontSize || 14;
            autoScrollCheckBox.checked = settings.interface.autoScroll !== false;
            showTimestampsCheckBox.checked = settings.interface.showTimestamps !== false;
        }
        
        console.log("Settings loaded from database");
    }
    
    function saveAISettings() {
        if (!databaseManager) return;
        
        var currentSettings = databaseManager.getSettings();
        
        if (!currentSettings.ai) {
            currentSettings.ai = {};
        }
        
        currentSettings.ai.provider = providerComboBox.currentIndex;
        currentSettings.ai.baseUrl = baseUrlField.text;
        currentSettings.ai.apiKey = apiKeyField.text;
        currentSettings.ai.model = modelField.text;
        
        if (databaseManager.updateSettings(currentSettings)) {
            console.log("AI settings saved successfully");
            showMessage("AI settings saved successfully!", "#4CAF50");
        } else {
            console.error("Failed to save AI settings");
            showMessage("Failed to save AI settings!", "#F44336");
        }
    }
    
    function saveVoiceSettings() {
        if (!databaseManager) return;
        
        var currentSettings = databaseManager.getSettings();
        
        if (!currentSettings.voice) {
            currentSettings.voice = {};
        }
        
        currentSettings.voice.googleApiKey = googleApiKeyField.text;
        currentSettings.voice.autoSend = autoSendCheckBox.checked;
        currentSettings.voice.recordingDuration = recordingDurationSpinBox.value;
        currentSettings.voice.microphone = voiceManager ? voiceManager.currentMicrophone : "";
        
        if (databaseManager.updateSettings(currentSettings)) {
            console.log("Voice settings saved successfully");
            showMessage("Voice settings saved successfully!", "#4CAF50");
        } else {
            console.error("Failed to save voice settings");
            showMessage("Failed to save voice settings!", "#F44336");
        }
    }
    
    function saveTTSSettings() {
        if (!databaseManager) return;
        
        var currentSettings = databaseManager.getSettings();
        
        if (!currentSettings.tts) {
            currentSettings.tts = {};
        }
        
        // Apply current UI values to TTS manager
        if (ttsManager) {
            console.log("Applying TTS settings from UI to manager");
            
            // Enable/disable TTS
            ttsManager.setIsEnabled(ttsEnabledCheckbox.checked);
            
            // Apply voice, rate, pitch, volume from sliders
            console.log("Setting TTS parameters:", rateSlider.value, pitchSlider.value, volumeSlider.value);
            ttsManager.rate = rateSlider.value;
            ttsManager.pitch = pitchSlider.value;
            ttsManager.volume = volumeSlider.value;
            
            // Apply selected voice using QVoice object
            if (voiceCombo.selectedVoiceIndex >= 0 && ttsManager.availableVoices.length > voiceCombo.selectedVoiceIndex) {
                var selectedVoice = ttsManager.availableVoices[voiceCombo.selectedVoiceIndex];
                console.log("Setting voice to:", selectedVoice.name, "from index:", voiceCombo.selectedVoiceIndex);
                ttsManager.setVoice(selectedVoice);
            }
        }
        
        // Save to database
        currentSettings.tts.enabled = ttsEnabledCheckbox.checked;
        if (ttsManager) {
            currentSettings.tts.voice = ttsManager.currentVoiceName;
            currentSettings.tts.rate = ttsManager.rate;
            currentSettings.tts.pitch = ttsManager.pitch;
            currentSettings.tts.volume = ttsManager.volume;
        }
        
        if (databaseManager.updateSettings(currentSettings)) {
            console.log("TTS settings saved successfully");
            showMessage("TTS settings saved successfully!", "#4CAF50");
        } else {
            console.error("Failed to save TTS settings");
            showMessage("Failed to save TTS settings!", "#F44336");
        }
    }
    
    function saveInterfaceSettings() {
        if (!databaseManager) return;
        
        var currentSettings = databaseManager.getSettings();
        
        if (!currentSettings.interface) {
            currentSettings.interface = {};
        }
        
        currentSettings.interface.fontSize = fontSizeSpinBox.value;
        currentSettings.interface.autoScroll = autoScrollCheckBox.checked;
        currentSettings.interface.showTimestamps = showTimestampsCheckBox.checked;
        
        if (databaseManager.updateSettings(currentSettings)) {
            console.log("Interface settings saved successfully");
            showMessage("Interface settings saved successfully!", "#4CAF50");
        } else {
            console.error("Failed to save interface settings");
            showMessage("Failed to save interface settings!", "#F44336");
        }
    }
    
    function saveAllSettings() {
        if (!databaseManager) return;
        
        var settings = {
            ai: {
                provider: providerComboBox.currentIndex,
                baseUrl: baseUrlField.text,
                apiKey: apiKeyField.text,
                model: modelField.text
            },
            voice: {
                googleApiKey: googleApiKeyField.text,
                autoSend: autoSendCheckBox.checked,
                recordingDuration: recordingDurationSpinBox.value,
                microphone: voiceManager ? voiceManager.currentMicrophone : ""
            },
            tts: {
                enabled: ttsEnabledCheckbox.checked,
                voice: ttsManager ? ttsManager.currentVoiceName : "",
                rate: ttsManager ? ttsManager.rate : 0.0,
                pitch: ttsManager ? ttsManager.pitch : 0.0,
                volume: ttsManager ? ttsManager.volume : 1.0
            },
            interface: {
                fontSize: fontSizeSpinBox.value,
                autoScroll: autoScrollCheckBox.checked,
                showTimestamps: showTimestampsCheckBox.checked
            }
        };
        
        // Apply TTS settings immediately
        if (ttsManager) {
            ttsManager.setIsEnabled(settings.tts.enabled);
        }
        
        if (databaseManager.updateSettings(settings)) {
            console.log("All settings saved successfully");
            showMessage("All settings saved successfully!", "#4CAF50");
            
            // Apply font size to main window immediately
            if (typeof applyFontSize === "function") {
                applyFontSize(settings.interface.fontSize);
            }
        } else {
            console.error("Failed to save settings");
            showMessage("Failed to save settings!", "#F44336");
        }
    }
    
    function showMessage(message, color) {
        messageText.text = message;
        messageText.color = color;
        messageBackground.visible = true;
        messageTimer.restart();
    }
    
    // Status message display
    Rectangle {
        id: messageBackground
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20 * scaleFactor
        
        width: messageText.width + 16 * scaleFactor
        height: messageText.height + 8 * scaleFactor
        color: Qt.rgba(0, 0, 0, 0.8)
        radius: 4 * scaleFactor
        visible: false
        
        Text {
            id: messageText
            anchors.centerIn: parent
            
            font.pixelSize: baseFont * 0.9
            font.weight: Font.Medium
            color: "white"
        }
    }
    
    Timer {
        id: messageTimer
        interval: 3000
        onTriggered: messageBackground.visible = false
    }
    
    // Timer for delayed connection testing (to avoid testing on every keystroke)
    Timer {
        id: testConnectionTimer
        interval: 2000 // 2 second delay
        repeat: false
        onTriggered: {
            if (llmManager && llmManager.baseUrl && llmManager.baseUrl !== "") {
                console.log("Auto-testing connection after URL change...");
                llmManager.testConnection();
            }
        }
    }
} 