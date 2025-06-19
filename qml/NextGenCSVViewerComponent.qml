import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import VoiceAILLM

Item {
    id: root

    // Backend instance
    NextGenCSVViewerBackend {
        id: nextGenCsvViewerBackend
    }

    // Properties exposed to main window
    property bool isFileLoaded: nextGenCsvViewerBackend.isFileLoaded
    property bool isLoading: nextGenCsvViewerBackend.isLoading
    property string currentFileName: nextGenCsvViewerBackend.currentFileName
    property string statusMessage: nextGenCsvViewerBackend.statusMessage
    property int totalRows: nextGenCsvViewerBackend.totalRows
    property int totalColumns: nextGenCsvViewerBackend.totalColumns
    property alias seriesData: nextGenCsvViewerBackend.seriesData
    property alias seriesNames: nextGenCsvViewerBackend.seriesNames
    property alias seriesColors: nextGenCsvViewerBackend.seriesColors
    property alias seriesVisibility: nextGenCsvViewerBackend.seriesVisibility
    property alias xAxisMin: nextGenCsvViewerBackend.xAxisMin
    property alias xAxisMax: nextGenCsvViewerBackend.xAxisMax
    property alias yAxisMin: nextGenCsvViewerBackend.yAxisMin
    property alias yAxisMax: nextGenCsvViewerBackend.yAxisMax
    property alias isRealTimeDemoActive: nextGenCsvViewerBackend.isRealTimeDemoActive

    // Functions
    function openFile(fileUrl) {
        if (fileUrl) {
            nextGenCsvViewerBackend.loadFile(fileUrl)
        } else {
            fileDialog.open()
        }
    }

    function exportChart(format) {
        nextGenCsvViewerBackend.exportChart(format)
    }

    function exportData() {
        nextGenCsvViewerBackend.exportData()
    }

    function resetChart() {
        nextGenCsvViewerBackend.resetChart()
    }

    function toggleSeries(seriesIndex, visible) {
        nextGenCsvViewerBackend.toggleSeries(seriesIndex, visible)
    }

    function setSeriesColor(seriesIndex, color) {
        nextGenCsvViewerBackend.setSeriesColor(seriesIndex, color)
    }

    function filterData(minTime, maxTime) {
        nextGenCsvViewerBackend.filterData(minTime, maxTime)
    }

    function clearFilter() {
        nextGenCsvViewerBackend.clearFilter()
    }

    function onChartHovered(seriesIndex, x, y, state) {
        nextGenCsvViewerBackend.onChartHovered(seriesIndex, x, y, state)
    }

    function onChartZoomed(minX, maxX, minY, maxY) {
        nextGenCsvViewerBackend.onChartZoomed(minX, maxX, minY, maxY)
    }

    function highlightDataPoint(time) {
        nextGenCsvViewerBackend.highlightDataPoint(time)
    }

    function setAxisRange(xMin, xMax, yMin, yMax) {
        nextGenCsvViewerBackend.setAxisRange(xMin, xMax, yMin, yMax)
    }

    function startRealTimeDemo() {
        nextGenCsvViewerBackend.startRealTimeDemo()
    }

    function stopRealTimeDemo() {
        nextGenCsvViewerBackend.stopRealTimeDemo()
    }

    function pauseRealTimeDemo() {
        nextGenCsvViewerBackend.pauseRealTimeDemo()
    }

    function resumeRealTimeDemo() {
        nextGenCsvViewerBackend.resumeRealTimeDemo()
    }

    function autoScaleAxes() {
        nextGenCsvViewerBackend.autoScaleAxes()
    }

    // Backend access for QML components
    property alias backend: nextGenCsvViewerBackend

    // File dialog for opening CSV files
    FileDialog {
        id: fileDialog
        title: "Open CSV File"
        nameFilters: ["CSV files (*.csv)", "Text files (*.txt)", "All files (*)"]
        fileMode: FileDialog.OpenFile
        onAccepted: {
            nextGenCsvViewerBackend.loadFile(selectedFile)
        }
    }

    // Signals forwarding
    Connections {
        target: nextGenCsvViewerBackend
        
        function onDataPointHovered(seriesIndex, x, y) {
            // Forward signal to external components if needed
        }
        
        function onZoomChanged(minX, maxX, minY, maxY) {
            // Forward signal to external components if needed
        }
        
        function onTimelineHighlighted(time) {
            // Forward signal to external components if needed
        }
    }
} 