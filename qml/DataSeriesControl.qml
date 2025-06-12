import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GroupBox {
    id: root
    title: "Data Series"

    property alias model: seriesList.model
    
    signal seriesToggled(string seriesName, bool visible)
    signal seriesColorChanged(string seriesName, color color)

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        // Series selection buttons
        RowLayout {
            Layout.fillWidth: true
            
            Button {
                text: "All"
                flat: true
                font.pixelSize: 10
                Layout.fillWidth: true
                onClicked: {
                    if (model) {
                        model.selectAllSeries()
                    }
                }
            }
            
            Button {
                text: "None" 
                flat: true
                font.pixelSize: 10
                Layout.fillWidth: true
                onClicked: {
                    if (model) {
                        model.selectNoneSeries()
                    }
                }
            }
        }

        // Search/filter
        TextField {
            id: searchField
            Layout.fillWidth: true
            placeholderText: "Filter series..."
            font.pixelSize: 10
            
            onTextChanged: {
                // TODO: Implement filtering
            }
        }

        // Series list
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: seriesList
                spacing: 4

                delegate: SeriesDelegate {
                    width: seriesList.width
                    seriesName: model.name || ""
                    seriesVisible: model.visible || false
                    seriesColor: model.color || "#000000"
                    onRightAxis: model.onRightAxis || false
                    dataType: model.dataType || ""
                    minValue: model.minValue || 0
                    maxValue: model.maxValue || 0
                    unit: model.unit || ""

                    onToggled: root.seriesToggled(seriesName, visible)
                    onColorChanged: root.seriesColorChanged(seriesName, color)
                }
            }
        }

        // Axis controls
        GroupBox {
            title: "Axis Settings"
            Layout.fillWidth: true
            font.pixelSize: 10

            ColumnLayout {
                anchors.fill: parent
                spacing: 4

                CheckBox {
                    text: "Auto Scale Y"
                    font.pixelSize: 9
                    checked: true
                }

                CheckBox {
                    text: "Show Right Axis"
                    font.pixelSize: 9
                    checked: false
                }

                CheckBox {
                    text: "Sync Axes"
                    font.pixelSize: 9
                    checked: false
                }
            }
        }
    }
} 