import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    // Properties
    property int role: 0 // 0 = user, 1 = assistant
    property string content: ""
    property var timestamp: new Date()
    property string messageId: ""
    property bool isStreaming: false
    
    // Style properties
    property real scaleFactor: 1.0
    property real baseFont: 14
    property color primaryColor: "#2196F3"
    property color backgroundColor: "#FAFAFA"
    property color surfaceColor: "#FFFFFF"
    property color textColor: "#212121"
    property color mutedTextColor: "#757575"
    
    // Signals
    signal editRequested(string messageId, string newContent)
    signal deleteRequested(string messageId)
    signal regenerateRequested()
    
    // Layout
    width: parent.width
    height: contentColumn.height + 32 * scaleFactor
    
    color: role === 0 ? Qt.lighter(primaryColor, 1.95) : surfaceColor
    border.color: Qt.lighter(mutedTextColor, 1.8)
    border.width: 1
    radius: 12 * scaleFactor
    
    // Margins from parent
    anchors.leftMargin: role === 0 ? 60 * scaleFactor : 0
    anchors.rightMargin: role === 1 ? 60 * scaleFactor : 0
    
    Column {
        id: contentColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 16 * scaleFactor
        spacing: 8 * scaleFactor
        
        // Header row
        Row {
            width: parent.width
            spacing: 8 * scaleFactor
            
            // Role indicator
            Rectangle {
                width: 24 * scaleFactor
                height: 24 * scaleFactor
                radius: width / 2
                color: role === 0 ? primaryColor : "#4CAF50"
                
                Text {
                    anchors.centerIn: parent
                    text: role === 0 ? "U" : "A"
                    color: "white"
                    font.pixelSize: baseFont * 0.8
                    font.weight: Font.Bold
                }
            }
            
            Column {
                width: parent.width - 32 * scaleFactor
                
                Text {
                    text: role === 0 ? "You" : "Assistant"
                    color: textColor
                    font.pixelSize: baseFont * 0.9
                    font.weight: Font.Medium
                }
                
                Row {
                    spacing: 8 * scaleFactor
                    
                    Text {
                        text: Qt.formatDateTime(timestamp, "hh:mm:ss")
                        color: mutedTextColor
                        font.pixelSize: baseFont * 0.75
                    }
                    
                    // Streaming indicator
                    Rectangle {
                        visible: isStreaming
                        width: 8 * scaleFactor
                        height: 8 * scaleFactor
                        radius: width / 2
                        color: "#4CAF50"
                        
                        SequentialAnimation {
                            running: isStreaming
                            loops: Animation.Infinite
                            
                            NumberAnimation {
                                target: parent
                                property: "opacity"
                                from: 0.3
                                to: 1.0
                                duration: 800
                            }
                            NumberAnimation {
                                target: parent
                                property: "opacity"
                                from: 1.0
                                to: 0.3
                                duration: 800
                            }
                        }
                    }
                }
            }
        }
        
        // Message content
        Rectangle {
            width: parent.width
            height: Math.max(messageText.contentHeight + 16 * scaleFactor, 40 * scaleFactor)
            color: messageText.editMode ? Qt.lighter(surfaceColor, 1.05) : "transparent"
            border.color: messageText.editMode ? primaryColor : "transparent"
            border.width: messageText.editMode ? 1 : 0
            radius: 4 * scaleFactor
            
            ScrollView {
                anchors.fill: parent
                anchors.margins: messageText.editMode ? 8 * scaleFactor : 0
                
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                
                TextArea {
                    id: messageText
                    text: content
                    readOnly: !editMode
                    wrapMode: TextArea.Wrap
                    selectByMouse: true
                    
                    property bool editMode: false
                    
                    color: textColor
                    font.pixelSize: baseFont
                    font.family: "Segoe UI, Roboto, Arial, sans-serif"
                    
                    // Use transparent background to avoid style conflicts
                    background: Item {}
                    
                    // Handle edit mode
                    Keys.onPressed: function(event) {
                        if (editMode) {
                            if (event.key === Qt.Key_Escape) {
                                editMode = false;
                                text = content; // Reset text
                                event.accepted = true;
                            } else if (event.key === Qt.Key_Return && (event.modifiers & Qt.ControlModifier)) {
                                editMode = false;
                                editRequested(messageId, text);
                                event.accepted = true;
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Actions button with proper styling and functionality
    Rectangle {
        id: actionsButtonContainer
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 8 * scaleFactor
        
        width: 32 * scaleFactor
        height: 32 * scaleFactor
        radius: 6 * scaleFactor
        color: actionsButton.pressed ? Qt.lighter(mutedTextColor, 1.7) :
               actionsButton.hovered ? Qt.lighter(mutedTextColor, 1.8) : "transparent"
        
        Text {
            anchors.centerIn: parent
            text: "⋮"
            color: mutedTextColor
            font.pixelSize: baseFont
        }
        
        MouseArea {
            id: actionsButton
            anchors.fill: parent
            hoverEnabled: true
            
            onClicked: actionsMenu.open()
        }
        
        Menu {
            id: actionsMenu
            y: parent.height
            
            MenuItem {
                text: "Copy"
                onTriggered: {
                    // Copy message to clipboard
                    console.log("Copy message:", messageId);
                }
            }
            
            MenuItem {
                text: "Edit"
                visible: role === 0 // Only allow editing user messages
                onTriggered: {
                    messageText.editMode = true;
                    messageText.forceActiveFocus();
                    messageText.selectAll();
                }
            }
            
            MenuSeparator {
                visible: role === 1 // Only show for assistant messages
            }
            
            MenuItem {
                text: "Regenerate"
                visible: role === 1 // Only show for assistant messages
                onTriggered: regenerateRequested()
            }
            
            MenuSeparator {}
            
            MenuItem {
                text: "Delete"
                onTriggered: deleteRequested(messageId)
            }
        }
    }
    
    // Hover effect
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: messageMouseArea.containsMouse ? Qt.lighter(primaryColor, 1.3) : "transparent"
        border.width: 1
        radius: parent.radius
        
        Behavior on border.color {
            PropertyAnimation {
                duration: 150
            }
        }
    }
    
    MouseArea {
        id: messageMouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton // Don't interfere with text selection
    }
} 