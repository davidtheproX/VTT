import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "RobotArm3D"

ApplicationWindow {
    id: root
    title: "3D Robot Arm Demo"
    modality: Qt.ApplicationModal
    flags: Qt.Dialog | Qt.WindowCloseButtonHint
    
    // Fixed size for better visibility
    width: 1000
    height: 700
    minimumWidth: 800
    minimumHeight: 600
    
    // Center on screen
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    
    visible: false
    
    color: "#2c2c2c"
    
    property real scaleFactor: Math.min(width / 1000, height / 700)
    
    signal closed()
    
    function open() {
        visible = true
        raise()
        requestActivate()
    }
    
    function close() {
        visible = false
        closed()
    }
    
    onClosing: function(close) {
        close.accepted = true
        closed()
    }
    
    header: Rectangle {
        height: 50
        color: "#1e1e1e"
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            
            Text {
                text: root.title
                font.pixelSize: 18
                font.bold: true
                color: "#ffffff"
                Layout.fillWidth: true
            }
            
            Text {
                text: "Qt Quick 3D Demo"
                font.pixelSize: 12
                color: "#b0b0b0"
            }
            
            Button {
                id: closeButton
                width: 32
                height: 32
                flat: true
                
                background: Rectangle {
                    color: closeButton.pressed ? "#f44336" : 
                           closeButton.hovered ? "#ff5722" : "transparent"
                    radius: 4
                }
                
                contentItem: Text {
                    text: "✕"
                    font.pixelSize: 16
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: root.close()
            }
        }
    }
    
    RobotArmScene {
        id: robotArmScene
        anchors.fill: parent
        anchors.margins: 10
    }
    
    footer: Rectangle {
        height: 60
        color: "#1e1e1e"
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            
            Text {
                text: "🎮 Mouse: Rotate camera | Wheel: Zoom | Sliders: Control joints | Red cube should be visible"
                font.pixelSize: 12
                color: "#b0b0b0"
                Layout.fillWidth: true
            }
            
            Button {
                text: "Demo Sequence"
                
                background: Rectangle {
                    color: parent.pressed ? "#388e3c" : "#4caf50"
                    radius: 4
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 12
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    demoSequence.start()
                }
            }
        }
    }
    
    // Demo sequence animation
    SequentialAnimation {
        id: demoSequence
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation4"
            to: 180
            duration: 2000
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation2"
            to: -90
            duration: 1500
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation3"
            to: 90
            duration: 1500
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "clawsAngle"
            to: 90
            duration: 1000
            easing.type: Easing.InOutQuad
        }
        
        PauseAnimation {
            duration: 1000
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "clawsAngle"
            to: 0
            duration: 1000
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation1"
            to: -45
            duration: 1500
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation4"
            to: -180
            duration: 2000
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation1"
            to: 60
            duration: 1500
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation2"
            to: 45
            duration: 1500
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation3"
            to: 45
            duration: 1500
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation {
            target: robotArmScene
            property: "rotation4"
            to: 0
            duration: 2000
            easing.type: Easing.InOutQuad
        }
    }
} 