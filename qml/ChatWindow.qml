import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

Rectangle {
    id: chatWindow
    
    // Properties for styling and scaling
    property real scaleFactor: 1.0
    property real baseFont: 14
    
    // Color properties
    property color primaryColor: "#2196F3"
    property color backgroundColor: "#FAFAFA"
    property color surfaceColor: "#FFFFFF"
    property color textColor: "#212121"
    property color mutedTextColor: "#757575"
    
    color: surfaceColor
    radius: 12 * scaleFactor
    border.color: Qt.lighter(mutedTextColor, 1.7)
    border.width: 1
    
    // Drop shadow effect
    Rectangle {
        anchors.fill: parent
        anchors.margins: -2
        color: "transparent"
        border.color: Qt.rgba(0, 0, 0, 0.1)
        border.width: 1
        radius: parent.radius + 1
        z: -1
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 1
        spacing: 0
        
        // Chat header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50 * scaleFactor
            color: Qt.lighter(surfaceColor, 1.02)
            radius: parent.parent.radius
            
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
                anchors.margins: 16 * scaleFactor
                
                Text {
                    text: "Chat"
                    color: textColor
                    font.pixelSize: baseFont * 1.1
                    font.weight: Font.Medium
                    Layout.fillWidth: true
                }
                
                Button {
                    text: "Clear"
                    flat: true
                    font.pixelSize: baseFont * 0.85
                    
                    background: Rectangle {
                        color: parent.pressed ? Qt.lighter(mutedTextColor, 1.8) :
                               parent.hovered ? Qt.lighter(mutedTextColor, 1.9) : "transparent"
                        radius: 4 * scaleFactor
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: mutedTextColor
                        font: parent.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: chatManager.clearChat()
                }
                
                Button {
                    text: "Export"
                    flat: true
                    font.pixelSize: baseFont * 0.85
                    
                    background: Rectangle {
                        color: parent.pressed ? Qt.lighter(mutedTextColor, 1.8) :
                               parent.hovered ? Qt.lighter(mutedTextColor, 1.9) : "transparent"
                        radius: 4 * scaleFactor
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: mutedTextColor
                        font: parent.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        exportChatHistory();
                    }
                }
            }
        }
        
        // Separator
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: Qt.lighter(mutedTextColor, 1.7)
        }
        
        // Messages area
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            clip: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            
            background: Rectangle {
                color: "transparent"
            }
            
            ListView {
                id: messagesList
                model: chatManager
                spacing: 12 * scaleFactor
                
                // Auto-scroll to bottom
                property bool shouldAutoScroll: true
                
                onCountChanged: {
                    if (shouldAutoScroll) {
                        Qt.callLater(function() {
                            messagesList.positionViewAtEnd();
                        });
                    }
                }
                
                onMovementStarted: {
                    shouldAutoScroll = false;
                }
                
                onMovementEnded: {
                    shouldAutoScroll = atYEnd;
                }
                
                // Header for top padding
                header: Item {
                    width: messagesList.width
                    height: 16 * scaleFactor
                }
                
                // Footer for bottom padding
                footer: Item {
                    width: messagesList.width
                    height: 16 * scaleFactor
                }
                
                delegate: MessageDelegate {
                    width: messagesList.width
                    
                    scaleFactor: chatWindow.scaleFactor
                    baseFont: chatWindow.baseFont
                    
                    // Color properties
                    primaryColor: chatWindow.primaryColor
                    surfaceColor: chatWindow.surfaceColor
                    textColor: chatWindow.textColor
                    mutedTextColor: chatWindow.mutedTextColor
                    
                    // Message data
                    messageId: model.messageId
                    content: model.content
                    role: model.role
                    timestamp: model.timestamp
                    isStreaming: model.isStreaming
                    
                    onDeleteRequested: function(id) {
                        chatManager.deleteMessage(id);
                    }
                    
                    onEditRequested: function(id, newContent) {
                        chatManager.editMessage(id, newContent);
                    }
                    
                    onRegenerateRequested: {
                        chatManager.regenerateLastResponse();
                    }
                }
                
                // Empty state
                Rectangle {
                    visible: messagesList.count === 0
                    anchors.centerIn: parent
                    width: Math.min(parent.width * 0.8, 400 * scaleFactor)
                    height: 200 * scaleFactor
                    color: "transparent"
                    
                    Column {
                        anchors.centerIn: parent
                        spacing: 16 * scaleFactor
                        
                        Text {
                            text: "🤖"
                            font.pixelSize: baseFont * 3
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        Text {
                            text: "Welcome to Voice AI LLM Assistant"
                            color: textColor
                            font.pixelSize: baseFont * 1.2
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        Text {
                            text: "Start a conversation by typing a message or using voice input"
                            color: mutedTextColor
                            font.pixelSize: baseFont * 0.9
                            wrapMode: Text.WordWrap
                            width: parent.parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
        }
        
        // Processing indicator
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: visible ? 40 * scaleFactor : 0
            color: Qt.lighter(backgroundColor, 1.02)
            visible: chatManager.isProcessing
            
            RowLayout {
                anchors.centerIn: parent
                spacing: 8 * scaleFactor
                
                // Animated dots
                Row {
                    spacing: 4 * scaleFactor
                    
                    Repeater {
                        model: 3
                        
                        Rectangle {
                            width: 6 * scaleFactor
                            height: 6 * scaleFactor
                            radius: width / 2
                            color: primaryColor
                            opacity: 0.3
                            
                            SequentialAnimation {
                                running: chatManager.isProcessing
                                loops: Animation.Infinite
                                
                                PauseAnimation { duration: index * 200 }
                                NumberAnimation {
                                    target: parent
                                    property: "opacity"
                                    from: 0.3
                                    to: 1.0
                                    duration: 400
                                }
                                NumberAnimation {
                                    target: parent
                                    property: "opacity"
                                    from: 1.0
                                    to: 0.3
                                    duration: 400
                                }
                                PauseAnimation { duration: (2 - index) * 200 }
                            }
                        }
                    }
                }
                
                Text {
                    text: "AI is thinking..."
                    color: mutedTextColor
                    font.pixelSize: baseFont * 0.9
                }
            }
        }
    }
    
    // Export functionality
    function exportChatHistory() {
        if (!chatManager) return;
        
        var messages = [];
        for (var i = 0; i < chatManager.rowCount(); i++) {
            var message = chatManager.getMessage(i);
            if (message) {
                messages.push({
                    role: message.role,
                    content: message.content,
                    timestamp: message.timestamp
                });
            }
        }
        
        if (messages.length === 0) {
            console.log("No messages to export");
            return;
        }
        
        // Create export content in different formats
        var timestamp = new Date().toISOString().slice(0, 19).replace(/:/g, "-");
        var filename = "VoiceAI_Chat_" + timestamp;
        
        // Export as JSON
        var jsonContent = JSON.stringify({
            exportDate: new Date().toISOString(),
            messageCount: messages.length,
            messages: messages
        }, null, 2);
        
        // Export as Markdown
        var mdContent = "# Voice AI LLM Chat Export\n\n";
        mdContent += "**Export Date:** " + new Date().toLocaleString() + "\n";
        mdContent += "**Message Count:** " + messages.length + "\n\n";
        mdContent += "---\n\n";
        
        for (var i = 0; i < messages.length; i++) {
            var msg = messages[i];
            var roleIcon = msg.role === "user" ? "👤" : "🤖";
            var roleTitle = msg.role === "user" ? "User" : "Assistant";
            mdContent += "## " + roleIcon + " " + roleTitle + "\n";
            mdContent += "**Time:** " + new Date(msg.timestamp).toLocaleString() + "\n\n";
            mdContent += msg.content + "\n\n";
            mdContent += "---\n\n";
        }
        
        // Export to files with proper file writing
        try {
            // Export JSON format
            chatManager.exportChat(filename + ".json");
            
            // Create markdown file content and save
            var tempMdFile = filename + ".md";
            if (Qt.platform.os === "windows") {
                tempMdFile = "C:/temp/" + tempMdFile;
            } else {
                tempMdFile = "/tmp/" + tempMdFile;
            }
            
            // Use Qt's file writing capabilities via C++
            var success = chatManager.writeTextFile(tempMdFile, mdContent);
            
            if (success) {
                console.log("Chat exported successfully:");
                console.log("JSON: " + filename + ".json");
                console.log("Markdown: " + tempMdFile);
            } else {
                console.log("Export completed (JSON format only)");
            }
            
        } catch (error) {
            console.log("Export error:", error.toString());
            // Fallback to console output
            console.log("=== CHAT EXPORT FALLBACK ===");
            console.log(jsonContent);
            console.log("=== END EXPORT ===");
        }
    }
} 