import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    property string seriesName: ""
    property int seriesIndex: 0
    property color seriesColor: "#ff0000"
    property bool seriesVisible: true
    
    signal visibilityChanged(bool visible)
    signal colorChanged(color color)
    
    height: 30
    Layout.fillWidth: true
    color: mouseArea.containsMouse ? "#f0f0f0" : "transparent"
    radius: 4
    
    RowLayout {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 8
        
        // Visibility checkbox
        CheckBox {
            id: visibilityCheckbox
            Layout.preferredWidth: 20
            checked: seriesVisible
            
            onToggled: {
                seriesVisible = checked
                root.visibilityChanged(checked)
            }
        }
        
        // Color indicator
        Rectangle {
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            color: seriesColor
            radius: 2
            border.width: 1
            border.color: "#888888"
            
            MouseArea {
                anchors.fill: parent
                onClicked: colorDialog.open()
            }
        }
        
        // Series name
        Text {
            text: seriesName
            font.pixelSize: 9
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: visibilityCheckbox.toggle()
    }
    
    // Color picker dialog (simplified)
    Rectangle {
        id: colorDialog
        visible: false
        width: 200
        height: 100
        color: "white"
        border.color: "#cccccc"
        border.width: 1
        radius: 4
        z: 1000
        
        anchors.centerIn: parent
        
        function open() {
            visible = true
        }
        
        function close() {
            visible = false
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            
            Text {
                text: "Choose color for " + seriesName
                font.pixelSize: 10
                Layout.fillWidth: true
            }
            
            RowLayout {
                Layout.fillWidth: true
                
                Repeater {
                    model: ["#ff0000", "#00aa00", "#0000ff", "#ff8800", "#8800ff", "#000000"]
                    
                    delegate: Rectangle {
                        width: 20
                        height: 20
                        color: modelData
                        border.width: 1
                        border.color: "#888888"
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                seriesColor = modelData
                                root.colorChanged(modelData)
                                colorDialog.close()
                            }
                        }
                    }
                }
            }
            
            Button {
                text: "Close"
                Layout.fillWidth: true
                font.pixelSize: 9
                onClicked: colorDialog.close()
            }
        }
    }
} 