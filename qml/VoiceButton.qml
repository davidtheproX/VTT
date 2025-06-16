import QtQuick
import QtQuick.Controls

Button {
    id: voiceButton
    
    // Properties for styling and scaling
    property real scaleFactor: 1.0
    property color primaryColor: "#2196F3"
    property color errorColor: "#F44336"
    
    // Mobile touch optimizations
    property bool enableHoverEffects: Qt.platform.os !== "android" && Qt.platform.os !== "ios"
    
    // Voice state properties
    property bool isListening: false
    property real audioLevel: 0.0
    
    width: 50 * scaleFactor
    height: 50 * scaleFactor
    
    background: Rectangle {
        color: currentBackgroundColor
        radius: width / 2
        
        // Animated border when listening (simplified for Android)
        Rectangle {
            anchors.centerIn: parent
            width: parent.width + 8 * scaleFactor
            height: parent.height + 8 * scaleFactor
            radius: width / 2
            color: "transparent"
            border.color: isListening ? Qt.lighter(errorColor, 1.3) : "transparent"
            border.width: 2 * scaleFactor
            opacity: isListening ? 0.6 : 0
            
            // Simplified opacity animation instead of scale to prevent jumping
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
            }
        }
        
        // Audio level visualization
        Rectangle {
            visible: isListening && audioLevel > 0
            anchors.centerIn: parent
            width: parent.width * (0.3 + audioLevel * 0.4)
            height: parent.height * (0.3 + audioLevel * 0.4)
            radius: width / 2
            color: Qt.lighter(errorColor, 1.5)
            opacity: 0.3
            
            Behavior on width {
                NumberAnimation { duration: 100 }
            }
            Behavior on height {
                NumberAnimation { duration: 100 }
            }
        }
    }
    
    contentItem: Item {
        anchors.fill: parent
        
        // Microphone icon
        Text {
            id: micIcon
            anchors.centerIn: parent
            text: isListening ? "⏹" : "🎤"
            color: "white"
            font.pixelSize: 18 * scaleFactor
            
            // Simplified color animation instead of scale to prevent jumping
            Behavior on color {
                ColorAnimation { 
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    
    // Tooltip
    ToolTip.text: isListening ? "Click to stop recording" : "Click to start voice input"
    ToolTip.visible: hovered
    ToolTip.delay: 1000
    
    // Press and hold for continuous recording
    property bool pressAndHoldMode: false
    
    onPressed: {
        if (!isListening) {
            pressAndHoldTimer.start();
        }
    }
    
    onReleased: {
        pressAndHoldTimer.stop();
        if (pressAndHoldMode && isListening) {
            clicked();
        }
        pressAndHoldMode = false;
    }
    
    Timer {
        id: pressAndHoldTimer
        interval: 500 // 0.5 seconds
        onTriggered: {
            pressAndHoldMode = true;
            if (!isListening) {
                voiceButton.clicked();
            }
        }
    }
    
    // Simplified visual feedback without scale changes to prevent jumping on Android
    // Use color changes instead of scale for better mobile experience
    property color currentBackgroundColor: {
        if (isListening) {
            return pressed ? Qt.darker(errorColor, 1.2) : 
                   (enableHoverEffects && hovered) ? Qt.lighter(errorColor, 1.1) : errorColor;
        } else {
            return pressed ? Qt.darker(primaryColor, 1.2) : 
                   (enableHoverEffects && hovered) ? Qt.lighter(primaryColor, 1.1) : primaryColor;
            }
        }
    
    // Smooth color transitions
    Behavior on currentBackgroundColor {
        ColorAnimation { 
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
} 