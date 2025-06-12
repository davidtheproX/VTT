import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: promptManagerDialog
    title: "Prompt Manager"
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
    property color successColor: "#4CAF50"
    property color errorColor: "#F44336"
    
    width: Math.min(900 * scaleFactor, parent.width * 0.95)
    height: Math.min(700 * scaleFactor, parent.height * 0.9)
    
    // Load prompts when dialog opens
    onOpened: loadPrompts()
    
    property int maxPrompts: 20
    property var promptsModel: ListModel {}
    
    background: Rectangle {
        color: surfaceColor
        radius: 12 * scaleFactor
        border.color: Qt.lighter(mutedTextColor, 1.8)
        border.width: 1
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
                text: promptManagerDialog.title
                color: "white"
                font.pixelSize: baseFont * 1.3
                font.weight: Font.Medium
                Layout.fillWidth: true
            }
            
            Text {
                text: promptsModel.count + "/" + maxPrompts + " prompts"
                color: "white"
                font.pixelSize: baseFont * 0.9
                opacity: 0.8
            }
            
            Button {
                text: "✕"
                flat: true
                font.pixelSize: baseFont * 1.2
                Layout.preferredWidth: 40 * scaleFactor
                Layout.preferredHeight: 40 * scaleFactor
                
                onClicked: promptManagerDialog.close()
            }
        }
    }
    
    contentItem: ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20 * scaleFactor
        spacing: 16 * scaleFactor
        
        // Help text
        Text {
            Layout.fillWidth: true
            text: "System prompts are sent silently to the AI before your messages. Use checkboxes to enable/disable prompts."
            color: mutedTextColor
            font.pixelSize: baseFont * 0.9
            wrapMode: Text.WordWrap
        }
        
        // Add new prompt button
        RowLayout {
            Layout.fillWidth: true
            spacing: 12 * scaleFactor
            
            Button {
                id: addPromptButton
                text: "➕ Add New Prompt"
                enabled: promptsModel.count < maxPrompts
                
                onClicked: addNewPrompt()
            }
            
            Item { Layout.fillWidth: true }
            
            Text {
                text: promptsModel.count >= maxPrompts ? "Maximum prompts reached" : ""
                color: errorColor
                font.pixelSize: baseFont * 0.85
                visible: promptsModel.count >= maxPrompts
            }
        }
        
        // Prompts list
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            clip: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            
            ListView {
                id: promptsListView
                width: parent.width
                spacing: 12 * scaleFactor
                model: promptsModel
                
                delegate: Rectangle {
                    width: promptsListView.width
                    height: Math.max(promptItem.implicitHeight + 24 * scaleFactor, 120 * scaleFactor)
                    color: surfaceColor
                    border.color: Qt.lighter(mutedTextColor, 1.8)
                    border.width: 1
                    radius: 8 * scaleFactor
                    
                    ColumnLayout {
                        id: promptItem
                        anchors.fill: parent
                        anchors.margins: 16 * scaleFactor
                        spacing: 12 * scaleFactor
                        
                        // Header row with checkbox, name, category, and remove button
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12 * scaleFactor
                            
                            CheckBox {
                                id: enabledCheckBox
                                Layout.alignment: Qt.AlignVCenter
                                
                                Component.onCompleted: {
                                    checked = model && model.isActive ? model.isActive : false;
                                }
                                
                                onCheckedChanged: {
                                    if (model && model.id && checked !== (model.isActive || false)) {
                                        model.isActive = checked;
                                        updatePromptInDatabase(model.id, "isActive", checked);
                                    }
                                }
                                
                                Connections {
                                    target: model
                                    function onIsActiveChanged() {
                                        if (enabledCheckBox.checked !== (model.isActive || false)) {
                                            enabledCheckBox.checked = model.isActive || false;
                                        }
                                    }
                                }
                            }
                            
                            TextField {
                                id: nameField
                                Layout.preferredWidth: 200 * scaleFactor
                                Layout.preferredHeight: 36 * scaleFactor
                                text: model && model.name ? model.name : ""
                                placeholderText: "Prompt name..."
                                font.pixelSize: baseFont
                                font.weight: Font.Medium
                                
                                onTextChanged: {
                                    if (model && model.id) {
                                        model.name = text;
                                        updatePromptInDatabase(model.id, "name", text);
                                    }
                                }
                            }
                            
                            ComboBox {
                                id: categoryCombo
                                Layout.preferredWidth: 120 * scaleFactor
                                Layout.preferredHeight: 36 * scaleFactor
                                model: ["General", "Programming", "Creative", "Analysis", "Custom"]
                                currentIndex: {
                                    if (!model || !model.category) return 0;
                                    var category = model.category;
                                    return Math.max(0, categoryCombo.model.indexOf(category));
                                }
                                
                                onCurrentTextChanged: {
                                    if (model && model.id) {
                                        model.category = currentText;
                                        updatePromptInDatabase(model.id, "category", currentText);
                                    }
                                }
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Button {
                                id: removeButton
                                text: "➖"
                                Layout.preferredWidth: 36 * scaleFactor
                                Layout.preferredHeight: 36 * scaleFactor
                                
                                onClicked: {
                                    if (model && model.id) {
                                        removePrompt(model.id);
                                    }
                                }
                            }
                        }
                        
                        // Content text area
                        ScrollView {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100 * scaleFactor
                            
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                            TextArea {
                                id: contentArea
                                text: model && model.content ? model.content : ""
                                placeholderText: "Enter your system prompt here... This will be sent silently to the AI before your messages."
                                wrapMode: TextArea.Wrap
                                selectByMouse: true
                                
                                font.pixelSize: baseFont * 0.9
                                color: textColor
                                

                                
                                onTextChanged: {
                                    if (model && model.id) {
                                        model.content = text;
                                        updatePromptInDatabase(model.id, "content", text);
                                    }
                                }
                            }
                        }
                        
                        // Metadata row
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12 * scaleFactor
                            
                            Text {
                                text: "ID: " + (model && model.id ? model.id : "")
                                color: mutedTextColor
                                font.pixelSize: baseFont * 0.7
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: "Modified: " + (model && model.modifiedAt ? 
                                    Qt.formatDateTime(new Date(model.modifiedAt), "MMM d, hh:mm") : 
                                    Qt.formatDateTime(new Date(), "MMM d, hh:mm"))
                                color: mutedTextColor
                                font.pixelSize: baseFont * 0.7
                            }
                        }
                    }
                }
            }
        }
        
        // Status message display - moved inside the layout to avoid anchor conflicts
        Rectangle {
            id: messageBackground
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10 * scaleFactor
            
            width: messageText.implicitWidth + 16 * scaleFactor
            height: messageText.implicitHeight + 8 * scaleFactor
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
            text: "Save All Changes"
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        
        Button {
            text: "Close"
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
        
        onAccepted: {
            showMessage("All prompts saved successfully!", successColor);
            promptManagerDialog.close();
        }
        
        onRejected: promptManagerDialog.close()
    }
    
    Timer {
        id: messageTimer
        interval: 3000
        onTriggered: messageBackground.visible = false
    }
    
    // Functions
    function loadPrompts() {
        if (!databaseManager) return;
        
        promptsModel.clear();
        
        var allPrompts = databaseManager.getAllPrompts();
        for (var i = 0; i < allPrompts.length; i++) {
            var prompt = allPrompts[i];
            promptsModel.append({
                id: prompt.id,
                name: prompt.name,
                content: prompt.content,
                category: prompt.category,
                isActive: prompt.isActive,
                createdAt: prompt.createdAt,
                modifiedAt: prompt.modifiedAt
            });
        }
        
        console.log("Loaded", promptsModel.count, "prompts");
    }
    
    function addNewPrompt() {
        if (promptsModel.count >= maxPrompts) return;
        
        var promptId = "prompt-" + Date.now();
        var newPrompt = {
            id: promptId,
            name: "New Prompt " + (promptsModel.count + 1),
            content: "",
            category: "General",
            isActive: false,
            createdAt: new Date().toISOString(),
            modifiedAt: new Date().toISOString()
        };
        
        if (databaseManager && databaseManager.addPrompt(newPrompt)) {
            promptsModel.append(newPrompt);
            showMessage("New prompt added!", successColor);
        } else {
            showMessage("Failed to add prompt!", errorColor);
        }
    }
    
    function removePrompt(promptId) {
        if (!promptId || !databaseManager) return;
        
        if (databaseManager.deletePrompt(promptId)) {
            // Remove from local model
            for (var i = 0; i < promptsModel.count; i++) {
                if (promptsModel.get(i).id === promptId) {
                    promptsModel.remove(i);
                    break;
                }
            }
            showMessage("Prompt removed!", successColor);
        } else {
            showMessage("Failed to remove prompt!", errorColor);
        }
    }
    
    function updatePromptInDatabase(promptId, field, value) {
        if (!promptId || !databaseManager) return;
        
        // Find the prompt in the model
        for (var i = 0; i < promptsModel.count; i++) {
            var prompt = promptsModel.get(i);
            if (prompt.id === promptId) {
                // Update the field
                var updatedPrompt = {
                    id: prompt.id,
                    name: prompt.name,
                    content: prompt.content,
                    category: prompt.category,
                    isActive: prompt.isActive,
                    createdAt: prompt.createdAt,
                    modifiedAt: new Date().toISOString()
                };
                updatedPrompt[field] = value;
                
                // Update in database
                if (databaseManager.updatePrompt(promptId, updatedPrompt)) {
                    console.log("Updated prompt", promptId, "field", field);
                } else {
                    console.error("Failed to update prompt", promptId);
                }
                break;
            }
        }
    }
    
    function showMessage(message, color) {
        messageText.text = message;
        messageText.color = color;
        messageBackground.visible = true;
        messageTimer.restart();
    }
} 