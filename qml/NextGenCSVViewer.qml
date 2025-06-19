import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtGraphs
import QtQuick.Controls.Material

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1400
    height: 900
    title: "NextGen CSV Data Viewer (QtGraphs)"

    property alias nextGenCsvViewer: nextGenCsvViewerComponent
    property bool debugMode: Qt.application.arguments ? Qt.application.arguments.indexOf("--debug") !== -1 : false

    signal closed()

    onClosing: {
        closed()
    }

    // Material Design theme
    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.Orange

    NextGenCSVViewerComponent {
        id: nextGenCsvViewerComponent
    }

    menuBar: MenuBar {
        Menu {
            title: "&File"
            Action {
                text: "&Open CSV..."
                shortcut: "Ctrl+O"
                onTriggered: nextGenCsvViewer.openFile()
            }
            MenuSeparator {}
            Action {
                text: "&Export Chart..."
                enabled: nextGenCsvViewer.isFileLoaded
                onTriggered: exportDialog.open()
            }
            Action {
                text: "Export &Data..."
                enabled: nextGenCsvViewer.isFileLoaded
                onTriggered: nextGenCsvViewer.exportData()
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
                enabled: nextGenCsvViewer.isFileLoaded
                onTriggered: nextGenCsvViewer.resetChart()
            }
            Action {
                text: "&Auto Scale"
                enabled: nextGenCsvViewer.isFileLoaded
                onTriggered: nextGenCsvViewer.autoScaleAxes()
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
            title: "&Demo"
            Action {
                text: nextGenCsvViewer.isRealTimeDemoActive ? "S&top Demo" : "&Start Demo"
                onTriggered: {
                    if (nextGenCsvViewer.isRealTimeDemoActive) {
                        nextGenCsvViewer.stopRealTimeDemo()
                    } else {
                        nextGenCsvViewer.startRealTimeDemo()
                    }
                }
            }
            MenuSeparator {}
            Action {
                text: "&Pause Demo"
                enabled: nextGenCsvViewer.isRealTimeDemoActive
                onTriggered: nextGenCsvViewer.pauseRealTimeDemo()
            }
            Action {
                text: "&Resume Demo"
                enabled: nextGenCsvViewer.isRealTimeDemoActive
                onTriggered: nextGenCsvViewer.resumeRealTimeDemo()
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
                            text: nextGenCsvViewer.isFileLoaded ? nextGenCsvViewer.currentFileName : "No file loaded"
                            font.bold: true
                            elide: Text.ElideMiddle
                            Layout.fillWidth: true
                        }
                        
                        Label {
                            text: nextGenCsvViewer.isFileLoaded ? 
                                `${nextGenCsvViewer.totalRows} rows, ${nextGenCsvViewer.totalColumns} columns` : ""
                            font.pointSize: 9
                            color: Material.color(Material.Grey)
                        }
                        
                        Label {
                            text: nextGenCsvViewer.statusMessage
                            font.pointSize: 9
                            color: Material.color(Material.Grey)
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                    }
                }

                // NextGen Series Control
                GroupBox {
                    title: "Series Control (NextGen)"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ScrollView {
                        anchors.fill: parent
                        clip: true

                        ColumnLayout {
                            width: parent.width
                            spacing: 4

                            Repeater {
                                model: nextGenCsvViewer.seriesNames

                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 40
                                    color: index % 2 ? "#f8f8f8" : "white"
                                    border.color: "#e0e0e0"
                                    border.width: 1
                                    radius: 4

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 8
                                        spacing: 8

                                        CheckBox {
                                            id: visibilityCheckBox
                                            checked: nextGenCsvViewer.seriesVisibility && 
                                                    index < nextGenCsvViewer.seriesVisibility.length ? 
                                                    nextGenCsvViewer.seriesVisibility[index] : true
                                            
                                            onToggled: {
                                                nextGenCsvViewer.toggleSeries(index, checked)
                                            }
                                        }

                                        Rectangle {
                                            width: 20
                                            height: 20
                                            radius: 4
                                            color: nextGenCsvViewer.seriesColors && 
                                                   index < nextGenCsvViewer.seriesColors.length ? 
                                                   nextGenCsvViewer.seriesColors[index] : "#000000"
                                            border.color: Qt.darker(color, 1.5)
                                            border.width: 1

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: colorDialog.open()
                                            }
                                        }

                                        Text {
                                            text: modelData
                                            font.pointSize: 10
                                            Layout.fillWidth: true
                                            elide: Text.ElideRight
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Axis Control
                GroupBox {
                    title: "Axis Control"
                    Layout.fillWidth: true

                    GridLayout {
                        anchors.fill: parent
                        columns: 2
                        columnSpacing: 8
                        rowSpacing: 4

                        Label { text: "X Min:" }
                        SpinBox {
                            from: -999999
                            to: 999999
                            value: nextGenCsvViewer.xAxisMin
                            editable: true
                            onValueChanged: updateAxisRange()
                        }

                        Label { text: "X Max:" }
                        SpinBox {
                            from: -999999
                            to: 999999
                            value: nextGenCsvViewer.xAxisMax
                            editable: true
                            onValueChanged: updateAxisRange()
                        }

                        Label { text: "Y Min:" }
                        SpinBox {
                            from: -999999
                            to: 999999
                            value: nextGenCsvViewer.yAxisMin
                            editable: true
                            onValueChanged: updateAxisRange()
                        }

                        Label { text: "Y Max:" }
                        SpinBox {
                            from: -999999
                            to: 999999
                            value: nextGenCsvViewer.yAxisMax
                            editable: true
                            onValueChanged: updateAxisRange()
                        }

                        Button {
                            text: "Auto Scale"
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            onClicked: nextGenCsvViewer.autoScaleAxes()
                        }
                    }
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

                Loader {
                    id: chartLoader
                    anchors.fill: parent
                    source: "qrc:/qt/qml/VoiceAILLM/qml/NextGenInteractiveChart.qml"
                    
                    onLoaded: {
                        if (item) {
                            if (debugMode) {
                                console.log("=== Chart loaded, setting up dataProvider ===")
                                console.log("nextGenCsvViewer:", nextGenCsvViewer)
                                console.log("nextGenCsvViewer.backend:", nextGenCsvViewer.backend)
                                console.log("Backend seriesData initial:", nextGenCsvViewer.backend ? nextGenCsvViewer.backend.seriesData : "BACKEND NULL")
                            }
                            
                            item.dataProvider = nextGenCsvViewer.backend
                            
                            if (debugMode) {
                                console.log("Chart item.dataProvider after assignment:", item.dataProvider)
                                console.log("Chart item.dataProvider.seriesData:", item.dataProvider ? item.dataProvider.seriesData : "PROVIDER NULL")
                            }
                            
                            item.dataPointHovered.connect(function(seriesIndex, x, y, state) {
                                nextGenCsvViewer.onChartHovered(seriesIndex, x, y, state)
                            })
                            item.zoomChanged.connect(function(minX, maxX, minY, maxY) {
                                nextGenCsvViewer.onChartZoomed(minX, maxX, minY, maxY)
                            })
                            item.timeHighlighted.connect(function(time) {
                                nextGenCsvViewer.highlightDataPoint(time)
                            })
                            
                            if (debugMode) {
                                console.log("=== Chart dataProvider setup complete ===")
                            }
                        } else {
                            if (debugMode) {
                                console.log("ERROR: Chart item is null after loading")
                            }
                        }
                    }
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
                        onClicked: nextGenCsvViewer.resetChart()
                    }

                    Button {
                        text: "Auto Scale"
                        flat: true
                        onClicked: nextGenCsvViewer.autoScaleAxes()
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

                    Button {
                        text: nextGenCsvViewer.isRealTimeDemoActive ? "Stop Demo" : "Start Demo"
                        flat: true
                        onClicked: {
                            if (debugMode) {
                                console.log("Button clicked. Current isRealTimeDemoActive:", nextGenCsvViewer.isRealTimeDemoActive)
                            }
                            if (nextGenCsvViewer.isRealTimeDemoActive) {
                                if (debugMode) {
                                    console.log("Calling stopRealTimeDemo()")
                                }
                                nextGenCsvViewer.stopRealTimeDemo()
                            } else {
                                if (debugMode) {
                                    console.log("Calling startRealTimeDemo()")
                                }
                                nextGenCsvViewer.startRealTimeDemo()
                            }
                        }
                        
                        // Add property change monitoring
                        Connections {
                            target: nextGenCsvViewer
                            function onRealTimeDemoActiveChanged() {
                                if (debugMode) {
                                    console.log("Demo state changed to:", nextGenCsvViewer.isRealTimeDemoActive)
                                    console.log("Button text should now be:", nextGenCsvViewer.isRealTimeDemoActive ? "Stop Demo" : "Start Demo")
                                }
                            }
                        }
                    }
                }

                // Loading overlay
                Rectangle {
                    anchors.fill: parent
                    color: "white"
                    opacity: 0.8
                    visible: nextGenCsvViewer.isLoading

                    BusyIndicator {
                        anchors.centerIn: parent
                        running: parent.visible
                    }

                    Label {
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: 60
                        text: "Loading CSV data..."
                        font.pointSize: 12
                    }
                }
            }
        }
    }

    // Export dialog
    FileDialog {
        id: exportDialog
        title: "Export Chart"
        fileMode: FileDialog.SaveFile
        nameFilters: ["PNG files (*.png)", "PDF files (*.pdf)", "SVG files (*.svg)"]
        onAccepted: {
            var format = selectedNameFilter.value.includes("png") ? "png" : 
                        selectedNameFilter.value.includes("pdf") ? "pdf" : "svg"
            nextGenCsvViewer.exportChart(format)
        }
    }

    // Color dialog for series colors
    ColorDialog {
        id: colorDialog
        title: "Choose Series Color"
        onAccepted: {
            // This would need to be connected to the specific series
            // Implementation depends on the specific series being edited
        }
    }

    // Full screen chart dialog
    ApplicationWindow {
        id: chartFullScreenDialog
        title: "NextGen CSV Chart - Full Screen"
        modality: Qt.ApplicationModal
        width: 1200
        height: 800
        visible: false

        Loader {
            anchors.fill: parent
            source: "qrc:/qt/qml/VoiceAILLM/qml/NextGenInteractiveChart.qml"
            
            onLoaded: {
                if (item) {
                    item.dataProvider = nextGenCsvViewer.backend
                    item.dataPointHovered.connect(function(seriesIndex, x, y, state) {
                        nextGenCsvViewer.onChartHovered(seriesIndex, x, y, state)
                    })
                    item.zoomChanged.connect(function(minX, maxX, minY, maxY) {
                        nextGenCsvViewer.onChartZoomed(minX, maxX, minY, maxY)
                    })
                    item.timeHighlighted.connect(function(time) {
                        nextGenCsvViewer.highlightDataPoint(time)
                    })
                }
            }
        }

        Button {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 12
            text: "Close"
            onClicked: chartFullScreenDialog.close()
        }
    }

    // Helper functions
    function updateAxisRange() {
        // This would be called when axis spinboxes change
        // Implementation needs to collect all spinbox values
    }

    // Initialize
    Component.onCompleted: {
        if (debugMode) {
            console.log("NextGen CSV Viewer initialized with QtGraphs")
            console.log("Backend instance:", nextGenCsvViewer.backend)
            console.log("Ready for manual demo start")
        }
    }
} 