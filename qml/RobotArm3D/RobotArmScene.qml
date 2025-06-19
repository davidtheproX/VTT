import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick3D

Rectangle {
    id: root
    color: "#2c2c2c"
    
    property real scaleFactor: Math.min(width / 800, height / 600)
    
    property alias rotation1: roboticArm.rotation1
    property alias rotation2: roboticArm.rotation2
    property alias rotation3: roboticArm.rotation3
    property alias rotation4: roboticArm.rotation4
    property alias clawsAngle: roboticArm.clawsAngle
    
    RowLayout {
        anchors.fill: parent
        anchors.margins: 20 * scaleFactor
        spacing: 20 * scaleFactor
        
        // 3D View
        View3D {
            id: view3D
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 400 * scaleFactor
            
            // Simplified environment for Qt 6.9 compatibility
            environment: SceneEnvironment {
                clearColor: "#404040"
                backgroundMode: SceneEnvironment.Color
                antialiasingMode: SceneEnvironment.MSAA
                antialiasingQuality: SceneEnvironment.High
            }
            
            // Fixed camera position
            PerspectiveCamera {
                id: camera
                position: Qt.vector3d(0, 200, 800)
                lookAtNode: roboticArm
                
                PropertyAnimation on eulerRotation.y {
                    from: 0
                    to: 360
                    duration: 20000
                    running: autoRotateToggle.checked
                    loops: Animation.Infinite
                }
            }
            
            // Better lighting setup
            DirectionalLight {
                position: Qt.vector3d(0, 500, 500)
                brightness: 1.0
                castsShadow: true
            }
            
            DirectionalLight {
                position: Qt.vector3d(500, 200, 0)
                brightness: 0.5
            }
            
            // Add a test cube first to verify 3D is working
            Model {
                id: testCube
                position: Qt.vector3d(-200, 0, 0)
                source: "#Cube"
                scale: Qt.vector3d(0.5, 0.5, 0.5)
                materials: [
                    DefaultMaterial {
                        diffuseColor: "red"
                    }
                ]
                
                PropertyAnimation on eulerRotation.y {
                    from: 0
                    to: 360
                    duration: 3000
                    running: true
                    loops: Animation.Infinite
                }
            }
            
            // Robot Arm
            RoboticArm3D {
                id: roboticArm
                position: Qt.vector3d(0, 0, 0)
                rotation1: rotation1Slider.value
                rotation2: rotation2Slider.value
                rotation3: rotation3Slider.value
                rotation4: rotation4Slider.value
                clawsAngle: clawToggle.checked ? 0 : 90
            }
            
            // Mouse area for camera control
            MouseArea {
                anchors.fill: parent
                property vector2d lastPos
                
                onPressed: function(mouse) {
                    lastPos = Qt.vector2d(mouse.x, mouse.y)
                }
                
                onPositionChanged: function(mouse) {
                    if (pressed) {
                        var delta = Qt.vector2d(mouse.x, mouse.y).minus(lastPos)
                        camera.eulerRotation.y += delta.x * 0.5
                        camera.eulerRotation.x -= delta.y * 0.5
                        lastPos = Qt.vector2d(mouse.x, mouse.y)
                    }
                }
                
                onWheel: function(wheel) {
                    var delta = wheel.angleDelta.y * 0.01
                    var newPos = camera.position
                    var scaleFactor = 1 - delta * 0.1
                    camera.position = Qt.vector3d(newPos.x * scaleFactor, newPos.y * scaleFactor, newPos.z * scaleFactor)
                }
            }
        }
        
        // Control Panel
        Rectangle {
            Layout.preferredWidth: 200 * scaleFactor
            Layout.fillHeight: true
            color: "#1e1e1e"
            radius: 8
            border.color: "#404040"
            border.width: 1
            
            ScrollView {
                anchors.fill: parent
                anchors.margins: 16 * scaleFactor
                
                ColumnLayout {
                    width: parent.width
                    spacing: 16 * scaleFactor
                    
                    Text {
                        text: "Robot Arm Control"
                        font.pixelSize: 16 * scaleFactor
                        font.bold: true
                        color: "#ffffff"
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    Text {
                        text: "Red cube = 3D working"
                        font.pixelSize: 12 * scaleFactor
                        color: "#ff6666"
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#404040"
                    }
                    
                    Toggle3D {
                        id: autoRotateToggle
                        text: "Auto Rotate"
                        Layout.fillWidth: true
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#404040"
                    }
                    
                    LabeledSlider3D {
                        id: rotation1Slider
                        Layout.fillWidth: true
                        labelText: "Rotation 1 (Hand)"
                        from: -90
                        to: 90
                        value: 60
                    }
                    
                    LabeledSlider3D {
                        id: rotation2Slider
                        Layout.fillWidth: true
                        labelText: "Rotation 2 (Arm)"
                        from: -135
                        to: 135
                        value: 45
                    }
                    
                    LabeledSlider3D {
                        id: rotation3Slider
                        Layout.fillWidth: true
                        labelText: "Rotation 3 (Forearm)"
                        from: -90
                        to: 90
                        value: 45
                    }
                    
                    LabeledSlider3D {
                        id: rotation4Slider
                        Layout.fillWidth: true
                        labelText: "Rotation 4 (Base)"
                        from: -180
                        to: 180
                        value: 0
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#404040"
                    }
                    
                    Toggle3D {
                        id: clawToggle
                        text: "Claw Open"
                        Layout.fillWidth: true
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#404040"
                    }
                    
                    // Reset button
                    Button {
                        Layout.fillWidth: true
                        text: "Reset Pose"
                        
                        background: Rectangle {
                            color: parent.pressed ? "#388e3c" : "#4caf50"
                            radius: 4
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            font.pixelSize: 12 * scaleFactor
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            rotation1Slider.value = 60
                            rotation2Slider.value = 45
                            rotation3Slider.value = 45
                            rotation4Slider.value = 0
                            clawToggle.checked = false
                        }
                    }
                    
                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
} 