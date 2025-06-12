import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
    id: root
    
    property string seriesName: ""
    property bool seriesVisible: false
    property color seriesColor: "#000000"
    property bool onRightAxis: false
    property string dataType: ""
    property real minValue: 0
    property real maxValue: 0
    property string unit: ""

    signal toggled(bool visible)
    signal colorChanged(color color)

    width: parent ? parent.width : 200
    height: 40
    color: mouseArea.containsMouse ? "#f5f5f5" : "transparent"
    radius: 4

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        onClicked: {
            visibilityCheckbox.checked = !visibilityCheckbox.checked
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 8

        // Visibility checkbox
        CheckBox {
            id: visibilityCheckbox
            Layout.preferredWidth: 20
            checked: root.seriesVisible
            onToggled: root.toggled(checked)
        }

        // Color indicator
        Rectangle {
            id: colorIndicator
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            radius: 2
            border.width: 1
            border.color: "#cccccc"
            color: root.seriesColor

            MouseArea {
                anchors.fill: parent
                onClicked: colorDialog.open()
            }
        }

        // Series name and info
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Label {
                id: nameLabel
                text: root.seriesName
                font.pixelSize: 11
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Label {
                text: root.dataType + " • " + root.minValue.toFixed(2) + " - " + root.maxValue.toFixed(2) + " " + root.unit
                font.pixelSize: 9
                color: "#666666"
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }

        // Right axis checkbox
        CheckBox {
            id: rightAxisCheckbox
            text: "R"
            font.pixelSize: 8
            checked: root.onRightAxis
            ToolTip.text: "Use right axis"
            ToolTip.visible: hovered
            Layout.preferredWidth: 30
        }

        // Options button
        Button {
            text: "⋮"
            flat: true
            font.pixelSize: 12
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            
            onClicked: seriesMenu.popup()

            Menu {
                id: seriesMenu
                
                Action {
                    text: "Change Color..."
                    onTriggered: colorDialog.open()
                }
                
                MenuSeparator {}
                
                Action {
                    text: "Hide Others"
                    onTriggered: {
                        // This would be handled by the parent model
                        console.log("Hide others for", root.seriesName)
                    }
                }
                
                Action {
                    text: "Properties..."
                    onTriggered: {
                        // Show series properties dialog
                        console.log("Show properties for", root.seriesName)
                    }
                }
            }
        }
    }

    // Color picker dialog
    ColorDialog {
        id: colorDialog
        title: "Choose color for " + root.seriesName
        selectedColor: root.seriesColor
        onAccepted: {
            root.seriesColor = selectedColor
            root.colorChanged(selectedColor)
        }
    }
} 