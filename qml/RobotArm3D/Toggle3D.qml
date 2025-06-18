import QtQuick
import QtQuick.Controls

CheckBox {
    id: root
    
    property alias labelText: root.text
    
    font.pixelSize: 12
    
    indicator: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        radius: 3
        border.color: root.checked ? "#2196F3" : "#757575"
        border.width: 2
        color: "transparent"
        
        Rectangle {
            width: 12
            height: 12
            x: 4
            y: 4
            radius: 2
            color: "#2196F3"
            visible: root.checked
        }
    }
    
    contentItem: Text {
        text: root.text
        font: root.font
        opacity: enabled ? 1.0 : 0.3
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        leftPadding: root.indicator.width + root.spacing
    }
} 