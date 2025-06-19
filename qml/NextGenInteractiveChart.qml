import QtQuick
import QtQuick.Controls
import QtGraphs

Item {
    id: root
    
    // Properties for data and interaction
    property var dataProvider: null
    property bool allowZoom: true
    property bool allowPan: true
    property bool showCrosshair: true
    property real timelinePosition: -1
    property alias xAxis: axisX
    property alias yAxis: axisY

    // Signals for interaction
    signal dataPointHovered(int seriesIndex, real x, real y, bool state)
    signal zoomChanged(real minX, real maxX, real minY, real maxY)
    signal timeHighlighted(real time)
    
    // Background - match legacy CSV viewer
    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "#fafafa"
        border.color: "#e0e0e0"
        border.width: 1
    }
    
    // Custom title at the top
    Text {
        id: titleText
        text: "NextGen Interactive Chart (QtGraphs)"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10
        font.pixelSize: 16
        font.bold: true
        color: "#333333"
    }

    // Main chart view
    GraphsView {
        id: graphsView
        anchors.top: titleText.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: legendArea.top
        anchors.margins: 10
        
        // Chart theme with proper QtGraphs theming
        theme: GraphsTheme {
            colorScheme: GraphsTheme.ColorScheme.Light
            backgroundColor: "#fafafa"
            gridVisible: true
            // Use a built-in light theme that has proper grid styling
            theme: GraphsTheme.Theme.QtGreen
        }

        // X-axis with only valid QtGraphs properties
        axisX: ValueAxis {
            id: axisX
            titleText: "Time"
            titleVisible: true
            gridVisible: true
            lineVisible: true
            labelsVisible: true
            
            // Explicit range definition required for QtGraphs
            min: dataProvider ? dataProvider.xAxisMin : 0
            max: dataProvider ? dataProvider.xAxisMax : 100
        }
        
        // Y-axis with only valid QtGraphs properties  
        axisY: ValueAxis {
            id: axisY
            titleText: "Value"
            titleVisible: true
            gridVisible: true
            lineVisible: true
            labelsVisible: true
            
            // Explicit range definition required for QtGraphs
            min: dataProvider ? dataProvider.yAxisMin : 0
            max: dataProvider ? dataProvider.yAxisMax : 100
        }

        // Pre-create LineSeries for the demo (16 series for full mathematical demo)
        LineSeries {
            id: series0
            color: "#FF4444"
            width: 2.0  // Thinner lines like old CSV viewer
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series1
            color: "#44FF44"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series2
            color: "#4444FF"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series3
            color: "#FFAA44"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series4
            color: "#AA44FF"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series5
            color: "#44AAFF"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series6
            color: "#FF8844"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series7
            color: "#44FF88"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series8
            color: "#FFAA88"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series9
            color: "#88AAFF"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series10
            color: "#AA88FF"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series11
            color: "#88FFAA"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series12
            color: "#FFCC44"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series13
            color: "#44CCFF"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series14
            color: "#CC44FF"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
        LineSeries {
            id: series15
            color: "#44FFCC"
            width: 2.0
            capStyle: Qt.RoundCap
            visible: false
        }
    }

    // Custom legend at the bottom
    Rectangle {
        id: legendArea
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        color: "#f5f5f5"
        border.color: "#e0e0e0"
        border.width: 1

        Flickable {
            anchors.fill: parent
            anchors.margins: 5
            contentWidth: legendRow.width
            contentHeight: legendRow.height
            clip: true

            Row {
                id: legendRow
                spacing: 15
                height: parent.height

                Repeater {
                    id: legendRepeater
                    model: dataProvider ? (dataProvider.seriesNames ? dataProvider.seriesNames.length : 0) : 0

                    Row {
                        spacing: 5
                        visible: dataProvider && dataProvider.seriesVisibility ? 
                                (index < dataProvider.seriesVisibility.length ? dataProvider.seriesVisibility[index] : true) : true

                        Rectangle {
                            width: 20
                            height: 3
                            color: dataProvider && dataProvider.seriesColors ? 
                                  (index < dataProvider.seriesColors.length ? dataProvider.seriesColors[index] : generateColor(index)) : 
                                  generateColor(index)
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: dataProvider && dataProvider.seriesNames ? 
                                 (index < dataProvider.seriesNames.length ? dataProvider.seriesNames[index] : "Series " + (index + 1)) : 
                                 "Series " + (index + 1)
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 10
                            color: "#666666"
                        }
                    }
                }
            }
        }
    }

    // Array to hold all series references (16 series)
    property var allSeries: [series0, series1, series2, series3, series4, series5, series6, series7, 
                            series8, series9, series10, series11, series12, series13, series14, series15]

    // Functions - Define before Connections for proper scoping
    property bool debugMode: Qt.application.arguments ? debugMode : false
    
    function updateChart() {
        if (debugMode) {
            console.log("=== updateChart called ===")
        }
        if (!dataProvider || !dataProvider.seriesData) {
            if (debugMode) {
                console.log("No data provider or series data available")
            }
            return
        }
        
        if (debugMode) {
            console.log("Series data available:", dataProvider.seriesData.length, "series")
            console.log("Axis ranges: X=[", dataProvider.xAxisMin, ",", dataProvider.xAxisMax, "] Y=[", dataProvider.yAxisMin, ",", dataProvider.yAxisMax, "]")
        }

        // Clear all existing series data
        clearAllSeries()

        // Create new series from data
        var seriesData = dataProvider.seriesData
        var seriesNames = dataProvider.seriesNames || []
        var seriesColors = dataProvider.seriesColors || []
        var seriesVisibility = dataProvider.seriesVisibility || []

        if (debugMode) {
            console.log("Processing", seriesData.length, "series for update")
        }

        for (var i = 0; i < Math.min(seriesData.length, allSeries.length); i++) {
            if (i < seriesVisibility.length && !seriesVisibility[i]) {
                if (debugMode) {
                    console.log("Skipping hidden series", i)
                }
                allSeries[i].visible = false
                continue
            }

            var series = allSeries[i]
            var seriesColor = i < seriesColors.length ? seriesColors[i] : generateColor(i)
            
            if (debugMode) {
                console.log("Updating series", i, "with color", seriesColor)
            }

            // Set series properties
            series.color = seriesColor
            series.visible = true

            // Add data points to series
            var points = seriesData[i]
            if (debugMode) {
                console.log("DEBUG: Series", i, "raw points sample:", JSON.stringify(points).substring(0, 200) + "...")
                console.log("DEBUG: Series", i, "type:", typeof points, "isArray:", Array.isArray(points), "length:", points ? points.length : "N/A")
                
                // Check first element structure
                if (points && points.length > 0) {
                    console.log("DEBUG: First element type:", typeof points[0], "isArray:", Array.isArray(points[0]), "value:", JSON.stringify(points[0]))
                }
            }
            // Check if points is array-like (has length property and indexed access)
            if (points && typeof points.length === 'number' && points.length > 0) {
                if (debugMode) {
                    console.log("Adding", points.length, "points to series", i)
                }
                // Force series to be visible and configured for line drawing  
                series.visible = true
                
                for (var j = 0; j < points.length; j++) {
                    var point = points[j]
                    
                    // Handle both [x,y] array format and {x:val, y:val} object format
                    var x, y
                    if (Array.isArray(point) && point.length >= 2) {
                        x = point[0]
                        y = point[1]
                    } else if (point && typeof point.x === 'number' && typeof point.y === 'number') {
                        x = point.x
                        y = point.y
                    } else {
                        if (debugMode) {
                            console.log("  Invalid point", j, ":", typeof point, point)
                        }
                        continue
                    }
                    
                    if (typeof x === 'number' && typeof y === 'number') {
                        series.append(x, y)
                        // Debug: log first few points and some mid/end points
                        if (debugMode) {
                            if (j < 3 || j === Math.floor(points.length/2) || j >= points.length - 3) {
                                console.log("  Point", j, ":", x, ",", y)
                            }
                        }
                    } else {
                        if (debugMode) {
                            console.log("  Invalid coordinates at point", j, ":", x, y)
                        }
                    }
                }
                if (debugMode) {
                    console.log("Series", i, "final state: count =", series.count, "visible =", series.visible, "color =", series.color, "width =", series.width)
                }
            } else {
                if (debugMode) {
                    console.log("No valid points for series", i, "- points type:", typeof points, "hasLength:", typeof points.length, "length:", points ? points.length : "N/A")
                }
            }
        }
        
        if (debugMode) {
            console.log("Chart update complete. Total series processed:", Math.min(seriesData.length, allSeries.length))
        }
        updateAxes()
    }

    function clearAllSeries() {
        if (debugMode) {
            console.log("Clearing all series data")
        }
        for (var i = 0; i < allSeries.length; i++) {
            allSeries[i].clear()
            allSeries[i].visible = false
            if (debugMode) {
                console.log("Cleared series", i, "- count:", allSeries[i].count)
            }
        }
    }

    function updateAxes() {
        if (dataProvider) {
            if (debugMode) {
                console.log("Updating axes: X=[", dataProvider.xAxisMin, ",", dataProvider.xAxisMax, "] Y=[", dataProvider.yAxisMin, ",", dataProvider.yAxisMax, "]")
            }
            axisX.min = dataProvider.xAxisMin
            axisX.max = dataProvider.xAxisMax
            axisY.min = dataProvider.yAxisMin
            axisY.max = dataProvider.yAxisMax
            if (debugMode) {
                console.log("Axes updated successfully")
            }
        }
    }

    function resetZoom() {
        if (dataProvider) {
            dataProvider.autoScaleAxes()
        }
    }

    function autoScaleY() {
        if (dataProvider) {
            dataProvider.autoScaleAxes()
        }
    }

    function autoScaleAll() {
        if (dataProvider) {
            dataProvider.autoScaleAxes()
        }
    }

    function generateColor(index) {
        var colors = [
            "#FF4444", "#44FF44", "#4444FF", "#FFAA44", "#AA44FF", "#44AAFF",
            "#FF8844", "#44FF88", "#8844FF", "#FFFF44", "#FF44AA", "#44FFAA",
            "#FF6644", "#66FF44", "#4466FF", "#AAFF44"
        ]
        return colors[index % colors.length]
    }

    // Monitor dataProvider changes
    onDataProviderChanged: {
        if (debugMode) {
            console.log("=== DataProvider changed ===")
            console.log("dataProvider:", dataProvider)
            if (dataProvider) {
                console.log("dataProvider.seriesData:", dataProvider.seriesData)
                console.log("dataProvider.seriesData.length:", dataProvider.seriesData ? dataProvider.seriesData.length : "NULL")
                console.log("dataProvider.seriesNames:", dataProvider.seriesNames)
                console.log("dataProvider.xAxisMin:", dataProvider.xAxisMin)
                console.log("dataProvider.xAxisMax:", dataProvider.xAxisMax)
                console.log("dataProvider.yAxisMin:", dataProvider.yAxisMin)
                console.log("dataProvider.yAxisMax:", dataProvider.yAxisMax)
            } else {
                console.log("DataProvider is null!")
            }
        }
        if (dataProvider) {
            // Delay to ensure dataProvider is fully initialized
            Qt.callLater(updateChart)
        }
    }

    // Update chart when data changes
    Connections {
        target: dataProvider
        enabled: dataProvider !== null && dataProvider !== undefined
        ignoreUnknownSignals: true
        
        function onSeriesDataChanged() {
            if (debugMode) {
                console.log("Signal: seriesDataChanged")
            }
            if (dataProvider) {
                updateChart()
            }
        }
        
        function onSeriesNamesChanged() {
            if (debugMode) {
                console.log("Signal: seriesNamesChanged")
            }
            if (dataProvider) {
                updateChart()
            }
        }
        
        function onSeriesColorsChanged() {
            if (debugMode) {
                console.log("Signal: seriesColorsChanged")
            }
            if (dataProvider) {
                updateChart()
            }
        }
        
        function onSeriesVisibilityChanged() {
            if (debugMode) {
                console.log("Signal: seriesVisibilityChanged")
            }
            if (dataProvider) {
                updateChart()
            }
        }
        
        function onAxisRangeChanged() {
            if (debugMode) {
                console.log("Signal: axisRangeChanged")
            }
            if (dataProvider) {
                updateAxes()
            }
        }
    }

    // Timeline indicator
    Rectangle {
        id: timelineIndicator
        width: 2
        height: graphsView.plotArea ? graphsView.plotArea.height : 0
        color: "#ff6b35"
        opacity: 0.8
        visible: timelinePosition >= 0 && timelinePosition >= axisX.min && timelinePosition <= axisX.max
        z: 50
        
        x: {
            if (timelinePosition < 0 || !graphsView.plotArea) return -width
            var plotAreaX = graphsView.plotArea.x
            var plotAreaWidth = graphsView.plotArea.width
            var range = axisX.max - axisX.min
            var position = (timelinePosition - axisX.min) / range
            return plotAreaX + position * plotAreaWidth - width/2
        }
        y: graphsView.plotArea ? graphsView.plotArea.y : 0
    }

    // Initialize chart when component is ready
    Component.onCompleted: {
        if (debugMode) {
            console.log("NextGenInteractiveChart completed, dataProvider:", dataProvider)
        }
        if (dataProvider) {
            updateChart()
        }
    }
} 