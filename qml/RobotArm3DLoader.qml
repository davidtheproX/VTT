import QtQuick
import QtQuick.Controls

Item {
    id: loader3D
    
    property bool show3D: false
    signal close()
    
    // Check if Quick3D is available at runtime
    property bool quick3DAvailable: false
    property bool quick3DChecked: false
    
    Component.onCompleted: {
        console.log("RobotArm3DLoader: Component completed")
        checkQuick3DAvailability()
    }
    
    function checkQuick3DAvailability() {
        if (quick3DChecked) return
        quick3DChecked = true
        
        console.log("RobotArm3DLoader: Checking Quick3D availability...")
        
        // Simplified check - assume Quick3D is available if we got this far
        // We'll handle the actual loading failure gracefully
        quick3DAvailable = true
        console.log("RobotArm3DLoader: Assuming Quick3D is available, will test during loading")
    }
    
    Loader {
        id: robotArmLoader
        anchors.fill: parent
        active: false
        
        function loadRobotArm() {
            console.log("RobotArm3DLoader: loadRobotArm() called")
            console.log("RobotArm3DLoader: quick3DAvailable =", quick3DAvailable)
            
            if (!quick3DChecked) {
                checkQuick3DAvailability()
            }
            
            if (quick3DAvailable) {
                console.log("RobotArm3DLoader: Attempting to load 3D robot arm...")
                source = "qrc:/qt/qml/VoiceAILLM/qml/RobotArm3DDialog.qml"
                active = true
            } else {
                console.log("RobotArm3DLoader: Quick3D not available, showing fallback")
                fallbackDialog.open()
            }
        }
        
        onStatusChanged: {
            console.log("RobotArm3DLoader: Loader status changed to", status)
            if (status === Loader.Error) {
                console.error("RobotArm3DLoader: Failed to load 3D robot arm:", source)
                console.error("RobotArm3DLoader: Error string:", robotArmLoader.errorString())
                quick3DAvailable = false
                active = false
                source = ""
                console.log("RobotArm3DLoader: Opening fallback dialog due to load error")
                fallbackDialog.open()
            } else if (status === Loader.Ready && item) {
                console.log("RobotArm3DLoader: 3D robot arm loaded successfully")
                console.log("RobotArm3DLoader: Opening ApplicationWindow")
                
                // Connect the close signal from the ApplicationWindow
                if (item.hasOwnProperty("closed")) {
                    item.closed.connect(function() {
                        console.log("RobotArm3DLoader: ApplicationWindow closed")
                        loader3D.close()
                    })
                }
                
                // Open the ApplicationWindow
                if (item.hasOwnProperty("open")) {
                    item.open()
                } else {
                    item.visible = true
                    if (item.hasOwnProperty("raise")) {
                        item.raise()
                    }
                    if (item.hasOwnProperty("requestActivate")) {
                        item.requestActivate()
                    }
                }
            }
        }
    }
    
    // Fallback dialog when 3D is not available
    Dialog {
        id: fallbackDialog
        title: "3D Robot Arm"
        modal: true
        anchors.centerIn: Overlay.overlay
        width: 400
        height: 200
        
        Column {
            anchors.centerIn: parent
            spacing: 20
            
            Text {
                text: "3D Robot Arm Demo"
                font.pixelSize: 18
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                text: "Qt Quick3D is not available on this system.\nThe 3D robot arm demo requires Qt Quick3D support."
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                width: parent.width - 40
            }
            
            Button {
                text: "OK"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    console.log("RobotArm3DLoader: Fallback dialog OK clicked")
                    fallbackDialog.close()
                }
            }
        }
        
        onOpened: console.log("RobotArm3DLoader: Fallback dialog opened")
        onClosed: {
            console.log("RobotArm3DLoader: Fallback dialog closed")
            loader3D.close()
        }
    }
    
    // Handle show3D property changes
    onShow3DChanged: {
        console.log("RobotArm3DLoader: show3D changed to", show3D)
        if (show3D) {
            robotArmLoader.loadRobotArm()
        } else {
            console.log("RobotArm3DLoader: Hiding 3D components")
            if (robotArmLoader.item && robotArmLoader.item.hasOwnProperty("close")) {
                robotArmLoader.item.close()
            } else if (robotArmLoader.item) {
                robotArmLoader.item.visible = false
            }
            robotArmLoader.active = false
            robotArmLoader.source = ""
            fallbackDialog.close()
        }
    }
    
    onClose: {
        console.log("RobotArm3DLoader: close() signal emitted")
        show3D = false
    }
} 