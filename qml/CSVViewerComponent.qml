import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Item {
    id: root

    // Properties exposed to main window
    property bool isFileLoaded: csvViewerBackend.isFileLoaded
    property bool isLoading: csvViewerBackend.isLoading
    property string currentFileName: csvViewerBackend.currentFileName
    property string statusMessage: csvViewerBackend.statusMessage
    property int totalRows: csvViewerBackend.totalRows
    property int totalColumns: csvViewerBackend.totalColumns
    property alias seriesModel: csvViewerBackend.seriesModel
    property alias dataModel: csvViewerBackend.dataModel
    property alias chartProvider: csvViewerBackend.chartProvider

    // Functions
    function openFile(fileUrl) {
        if (fileUrl) {
            csvViewerBackend.loadFile(fileUrl)
        } else {
            fileDialog.open()
        }
    }

    function exportChart(format) {
        csvViewerBackend.exportChart(format)
    }

    function exportData() {
        csvViewerBackend.exportData()
    }

    function resetChart() {
        csvViewerBackend.resetChart()
    }

    function toggleSeries(seriesName, visible) {
        csvViewerBackend.toggleSeries(seriesName, visible)
    }

    function setSeriesColor(seriesName, color) {
        csvViewerBackend.setSeriesColor(seriesName, color)
    }

    function filterData(minTime, maxTime) {
        csvViewerBackend.filterData(minTime, maxTime)
    }

    function clearFilter() {
        csvViewerBackend.clearFilter()
    }

    function onChartHovered(seriesName, x, y, state) {
        csvViewerBackend.onChartHovered(seriesName, x, y, state)
    }

    function onChartZoomed(minX, maxX, minY, maxY) {
        csvViewerBackend.onChartZoomed(minX, maxX, minY, maxY)
    }

    function highlightDataPoint(time) {
        csvViewerBackend.highlightDataPoint(time)
    }

    function savePreset(name) {
        csvViewerBackend.savePreset(name)
    }

    function loadPreset(name) {
        csvViewerBackend.loadPreset(name)
    }

    function getAvailablePresets() {
        return csvViewerBackend.getAvailablePresets()
    }

    // Backend connection - This will be registered from C++
    CSVViewerBackend {
        id: csvViewerBackend
    }

    // File dialog
    FileDialog {
        id: fileDialog
        title: "Open CSV File"
        nameFilters: ["CSV files (*.csv)", "Text files (*.txt)", "All files (*)"]
        onAccepted: csvViewerBackend.loadFile(selectedFile)
    }

    // Status and error handling
    Connections {
        target: csvViewerBackend
        
        function onFileLoaded() {
            console.log("File loaded successfully")
        }
        
        function onLoadError(message) {
            errorDialog.text = message
            errorDialog.open()
        }
        
        function onStatusChanged() {
            console.log("Status:", csvViewerBackend.statusMessage)
        }
    }

    // Error dialog
    Dialog {
        id: errorDialog
        title: "Error"
        modal: true
        anchors.centerIn: parent
        
        property alias text: errorText.text
        
        ColumnLayout {
            Label {
                id: errorText
                Layout.preferredWidth: 400
                wrapMode: Text.WordWrap
            }
            
            Button {
                text: "OK"
                Layout.alignment: Qt.AlignRight
                onClicked: errorDialog.close()
            }
        }
    }
} 