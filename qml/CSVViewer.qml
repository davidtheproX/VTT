import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtCharts
import QtQuick.Controls.Material

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1400
    height: 900
    title: "CSV Data Viewer"

    property alias csvViewer: csvViewerComponent

    // Material Design theme
    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.Orange

    CSVViewerComponent {
        id: csvViewerComponent
    }

    menuBar: MenuBar {
        Menu {
            title: "&File"
            Action {
                text: "&Open CSV..."
                shortcut: "Ctrl+O"
                onTriggered: csvViewer.openFile()
            }
            MenuSeparator {}
            Action {
                text: "&Export Chart..."
                enabled: csvViewer.isFileLoaded
                onTriggered: exportDialog.open()
            }
            Action {
                text: "Export &Data..."
                enabled: csvViewer.isFileLoaded
                onTriggered: csvViewer.exportData()
            }
            MenuSeparator {}
            Action {
                text: "&Quit"
                shortcut: "Ctrl+Q"
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: "&View"
            Action {
                text: "&Reset Chart"
                enabled: csvViewer.isFileLoaded
                onTriggered: csvViewer.resetChart()
            }
            Action {
                text: "&Full Screen"
                shortcut: "F11"
                checkable: true
                onTriggered: {
                    if (checked) {
                        mainWindow.showFullScreen()
                    } else {
                        mainWindow.showNormal()
                    }
                }
            }
        }
        Menu {
            title: "&Presets"
            Action {
                text: "&Save Preset..."
                enabled: csvViewer.isFileLoaded
                onTriggered: savePresetDialog.open()
            }
            Action {
                text: "&Load Preset..."
                enabled: csvViewer.isFileLoaded
                onTriggered: loadPresetDialog.open()
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        // Left panel - Data series controls
        ScrollView {
            id: leftPanel
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            Layout.minimumWidth: 250
            clip: true

            ColumnLayout {
                width: leftPanel.width - 20
                spacing: 12

                // File info
                GroupBox {
                    title: "File Information"
                    Layout.fillWidth: true

                    ColumnLayout {
                        anchors.fill: parent
                        
                        Label {
                            text: csvViewer.isFileLoaded ? csvViewer.currentFileName : "No file loaded"
                            font.bold: true
                            elide: Text.ElideMiddle
                            Layout.fillWidth: true
                        }
                        
                        Label {
                            text: csvViewer.isFileLoaded ? 
                                `${csvViewer.totalRows} rows, ${csvViewer.totalColumns} columns` : ""
                            font.pointSize: 9
                            color: Material.color(Material.Grey)
                        }
                    }
                }

                // Data series control
                DataSeriesControl {
                    id: seriesControl
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: csvViewer.seriesModel
                    
                    onSeriesToggled: csvViewer.toggleSeries(seriesName, visible)
                    onSeriesColorChanged: csvViewer.setSeriesColor(seriesName, color)
                }

                // Data filtering
                DataFilterControl {
                    id: filterControl
                    Layout.fillWidth: true
                    chartProvider: csvViewer.chartProvider
                    
                    onFilterChanged: csvViewer.filterData(minTime, maxTime)
                    onFilterCleared: csvViewer.clearFilter()
                }
            }
        }

        // Main content area
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8

            // Chart area
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 400

                InteractiveChart {
                    id: mainChart
                    anchors.fill: parent
                    dataProvider: csvViewer.chartProvider
                    
                    onDataPointHovered: csvViewer.onChartHovered(seriesName, x, y, state)
                    onZoomChanged: csvViewer.onChartZoomed(minX, maxX, minY, maxY)
                    onTimeHighlighted: csvViewer.highlightDataPoint(time)
                }

                // Chart overlay controls
                Row {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 12
                    spacing: 8

                    Button {
                        text: "Reset Zoom"
                        flat: true
                        onClicked: csvViewer.resetChart()
                    }

                    Button {
                        text: "Export"
                        flat: true
                        onClicked: exportDialog.open()
                    }

                    Button {
                        text: "Full Screen"
                        flat: true
                        onClicked: chartFullScreenDialog.open()
                    }
                }

                // Loading overlay
                Rectangle {
                    anchors.fill: parent
                    color: Material.background
                    opacity: csvViewer.isLoading ? 0.8 : 0
                    visible: opacity > 0
                    
                    Behavior on opacity {
                        NumberAnimation { duration: 200 }
                    }

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 16

                        BusyIndicator {
                            Layout.alignment: Qt.AlignHCenter
                            running: csvViewer.isLoading
                        }

                        Label {
                            text: csvViewer.statusMessage
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }

            // Raw data viewer
            RawDataViewer {
                id: rawDataViewer
                Layout.fillWidth: true
                Layout.preferredHeight: 250
                Layout.minimumHeight: 150
                model: csvViewer.dataModel
                
                onRowSelected: csvViewer.highlightDataPoint(time)
            }
        }
    }

    // File dialogs and popups
    FileDialog {
        id: fileDialog
        title: "Open CSV File"
        nameFilters: ["CSV files (*.csv)", "Text files (*.txt)", "All files (*)"]
        onAccepted: csvViewer.openFile(fileUrl)
    }

    Dialog {
        id: exportDialog
        title: "Export Chart"
        modal: true
        anchors.centerIn: parent
        width: 300

        ColumnLayout {
            anchors.fill: parent
            spacing: 12

            Label {
                text: "Export format:"
            }

            ComboBox {
                id: exportFormatCombo
                Layout.fillWidth: true
                model: ["PNG", "JPEG", "SVG", "PDF"]
            }

            RowLayout {
                Layout.fillWidth: true

                Button {
                    text: "Cancel"
                    onClicked: exportDialog.close()
                }

                Button {
                    text: "Export"
                    highlighted: true
                    onClicked: {
                        csvViewer.exportChart(exportFormatCombo.currentText.toLowerCase())
                        exportDialog.close()
                    }
                }
            }
        }
    }

    Dialog {
        id: savePresetDialog
        title: "Save Preset"
        modal: true
        anchors.centerIn: parent
        width: 350

        ColumnLayout {
            anchors.fill: parent
            spacing: 12

            Label {
                text: "Preset name:"
            }

            TextField {
                id: presetNameField
                Layout.fillWidth: true
                placeholderText: "Enter preset name..."
            }

            RowLayout {
                Layout.fillWidth: true

                Button {
                    text: "Cancel"
                    onClicked: savePresetDialog.close()
                }

                Button {
                    text: "Save"
                    highlighted: true
                    enabled: presetNameField.text.length > 0
                    onClicked: {
                        csvViewer.savePreset(presetNameField.text)
                        savePresetDialog.close()
                        presetNameField.clear()
                    }
                }
            }
        }
    }

    Dialog {
        id: loadPresetDialog
        title: "Load Preset"
        modal: true
        anchors.centerIn: parent
        width: 350

        ColumnLayout {
            anchors.fill: parent
            spacing: 12

            Label {
                text: "Available presets:"
            }

            ListView {
                id: presetsList
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                model: csvViewer.getAvailablePresets()
                
                delegate: ItemDelegate {
                    width: presetsList.width
                    text: modelData
                    
                    onClicked: {
                        csvViewer.loadPreset(modelData)
                        loadPresetDialog.close()
                    }
                }
            }

            Button {
                text: "Cancel"
                Layout.alignment: Qt.AlignRight
                onClicked: loadPresetDialog.close()
            }
        }
    }

    Dialog {
        id: chartFullScreenDialog
        modal: true
        width: mainWindow.width * 0.9
        height: mainWindow.height * 0.9
        anchors.centerIn: parent

        InteractiveChart {
            anchors.fill: parent
            dataProvider: csvViewer.chartProvider
            
            onDataPointHovered: csvViewer.onChartHovered(seriesName, x, y, state)
            onZoomChanged: csvViewer.onChartZoomed(minX, maxX, minY, maxY)
            onTimeHighlighted: csvViewer.highlightDataPoint(time)
        }
    }

    // Welcome screen when no file is loaded
    Item {
        anchors.fill: parent
        visible: !csvViewer.isFileLoaded && !csvViewer.isLoading

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 24

            Image {
                source: "qrc:/icons/csv-icon.png"
                Layout.alignment: Qt.AlignHCenter
                sourceSize.width: 128
                sourceSize.height: 128
                opacity: 0.6
            }

            Label {
                text: "CSV Data Viewer"
                font.pointSize: 24
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: "Open a CSV file to get started"
                font.pointSize: 12
                color: Material.color(Material.Grey)
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: "Open CSV File"
                highlighted: true
                Layout.alignment: Qt.AlignHCenter
                onClicked: csvViewer.openFile()
            }
        }
    }

    // Status bar
    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.margins: 4

            Label {
                text: csvViewer.statusMessage
                Layout.fillWidth: true
            }

            Label {
                text: csvViewer.isFileLoaded ? 
                    `${csvViewer.totalRows} rows × ${csvViewer.totalColumns} columns` : ""
                font.pointSize: 9
            }
        }
    }

    // Keyboard shortcuts
    Shortcut {
        sequence: "Ctrl+O"
        onActivated: csvViewer.openFile()
    }

    Shortcut {
        sequence: "F11"
        onActivated: {
            if (mainWindow.visibility === Window.FullScreen) {
                mainWindow.showNormal()
            } else {
                mainWindow.showFullScreen()
            }
        }
    }

    Shortcut {
        sequence: "Escape"
        onActivated: {
            if (mainWindow.visibility === Window.FullScreen) {
                mainWindow.showNormal()
            }
        }
    }
} 