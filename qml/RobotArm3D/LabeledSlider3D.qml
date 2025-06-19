import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

ColumnLayout {
    id: root
    
    property alias labelText: label.text
    property alias from: slider.from
    property alias to: slider.to
    property alias value: slider.value
    property alias stepSize: slider.stepSize
    
    spacing: 8
    
    Label {
        id: label
        text: "Rotation"
        font.pixelSize: 12
        color: "#ffffff"
        Layout.fillWidth: true
    }
    
    Slider {
        id: slider
        Layout.fillWidth: true
        Layout.preferredHeight: 32
        
        from: -180
        to: 180
        value: 0
        stepSize: 1
        
        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: slider.availableWidth
            height: implicitHeight
            radius: 2
            color: "#424242"
            
            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                color: "#2196F3"
                radius: 2
            }
        }
        
        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 20
            implicitHeight: 20
            radius: 10
            color: slider.pressed ? "#1976D2" : "#2196F3"
            border.color: "#ffffff"
            border.width: 1
        }
    }
    
    Label {
        text: Math.round(slider.value) + "°"
        font.pixelSize: 10
        color: "#b0b0b0"
        horizontalAlignment: Text.AlignHCenter
        Layout.fillWidth: true
    }
} 