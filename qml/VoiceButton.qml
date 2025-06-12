import QtQuick
import QtQuick.Controls

Button {
    id: voiceButton
    
    // Properties for styling and scaling
    property real scaleFactor: 1.0
    property color primaryColor: "#2196F3"
    property color errorColor: "#F44336"
    
    // Voice state properties
    property bool isListening: false
    property real audioLevel: 0.0
    
    width: 50 * scaleFactor
    height: 50 * scaleFactor
    
    background: Rectangle {
        color: {
            if (voiceButton.isListening) {
                return voiceButton.pressed ? Qt.darker(errorColor, 1.2) : 
                       voiceButton.hovered ? Qt.lighter(errorColor, 1.1) : errorColor;
            } else {
                return voiceButton.pressed ? Qt.darker(primaryColor, 1.2) : 
                       voiceButton.hovered ? Qt.lighter(primaryColor, 1.1) : primaryColor;
            }
        }
        radius: width / 2
        
        // Animated border when listening
        Rectangle {
            anchors.centerIn: parent
            width: parent.width + 8 * scaleFactor
            height: parent.height + 8 * scaleFactor
            radius: width / 2
            color: "transparent"
            border.color: isListening ? Qt.lighter(errorColor, 1.3) : "transparent"
            border.width: 2 * scaleFactor
            opacity: isListening ? 0.6 : 0
            
            SequentialAnimation {
                running: isListening
                loops: Animation.Infinite
                
                NumberAnimation {
                    target: parent
                    property: "scale"
                    from: 1.0
                    to: 1.1
                    duration: 1000
                }
                NumberAnimation {
                    target: parent
                    property: "scale"
                    from: 1.1
                    to: 1.0
                    duration: 1000
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
            
            // Pulse animation when listening
            SequentialAnimation {
                running: isListening
                loops: Animation.Infinite
                
                NumberAnimation {
                    target: micIcon
                    property: "scale"
                    from: 1.0
                    to: 1.2
                    duration: 600
                }
                NumberAnimation {
                    target: micIcon
                    property: "scale"
                    from: 1.2
                    to: 1.0
                    duration: 600
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
    
    // Visual feedback for different states
    states: [
        State {
            name: "listening"
            when: isListening
            PropertyChanges {
                target: voiceButton
                scale: 1.05
            }
        },
        State {
            name: "pressed"
            when: voiceButton.pressed
            PropertyChanges {
                target: voiceButton
                scale: 0.95
            }
        }
    ]
    
    transitions: [
        Transition {
            NumberAnimation {
                property: "scale"
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
    ]
} 