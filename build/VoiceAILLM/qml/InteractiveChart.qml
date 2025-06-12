import QtQuick
import QtQuick.Controls
import QtCharts

ChartView {
    id: chartView
    antialiasing: true
    backgroundColor: "#fafafa"
    dropShadowEnabled: false
    margins.top: 10
    margins.bottom: 10
    margins.left: 10
    margins.right: 10

    property var dataProvider
    property bool allowZoom: true
    property bool allowPan: true
    property bool showCrosshair: true
    property real timelinePosition: -1

    signal dataPointHovered(string seriesName, real x, real y, bool state)
    signal zoomChanged(real minX, real maxX, real minY, real maxY)
    signal timeHighlighted(real time)

    // Axes
    ValueAxis {
        id: axisX
        titleText: "Time"
        titleFont.pixelSize: 12
        labelFormat: "%.2f"
        gridLineColor: "#e0e0e0"
        color: "#666666"
    }

    ValueAxis {
        id: axisY
        titleText: "Value"
        titleFont.pixelSize: 12
        labelFormat: "%.2f"
        gridLineColor: "#e0e0e0"
        color: "#666666"
    }

    ValueAxis {
        id: axisY2
        titleText: "Secondary"
        titleFont.pixelSize: 12
        labelFormat: "%.2f"
        gridLineColor: "transparent"
        color: "#666666"
        visible: false
    }

    // Update chart when data changes
    Connections {
        target: dataProvider
        function onSeriesDataChanged() {
            updateChart()
        }
        function onRangeChanged() {
            updateAxes()
        }
    }

    // Mouse area for interactions
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        property bool isDragging: false
        property point dragStart
        property real zoomFactor: 1.1

        onPressed: (mouse) => {
            if (allowPan && mouse.button === Qt.LeftButton) {
                isDragging = true
                dragStart = Qt.point(mouse.x, mouse.y)
                chartView.grabMouse()
            }
        }

        onReleased: (mouse) => {
            if (isDragging) {
                isDragging = false
                chartView.releaseMouse()
            }
        }

        onPositionChanged: (mouse) => {
            if (isDragging && allowPan) {
                var dx = mouse.x - dragStart.x
                var dy = mouse.y - dragStart.y
                
                var xRange = axisX.max - axisX.min
                var yRange = axisY.max - axisY.min
                
                var xDelta = (dx / chartView.plotArea.width) * xRange
                var yDelta = (dy / chartView.plotArea.height) * yRange
                
                axisX.min -= xDelta
                axisX.max -= xDelta
                axisY.min += yDelta
                axisY.max += yDelta
                
                dragStart = Qt.point(mouse.x, mouse.y)
                emitZoomChanged()
            } else {
                // Handle hover for data point highlighting
                updateHover(mouse.x, mouse.y)
            }
        }

        onWheel: (wheel) => {
            if (allowZoom) {
                var factor = wheel.angleDelta.y > 0 ? zoomFactor : (1.0 / zoomFactor)
                
                // Get mouse position in chart coordinates
                var mousePoint = chartView.mapToValue(Qt.point(wheel.x, wheel.y), chartView.series(0))
                
                var xRange = axisX.max - axisX.min
                var yRange = axisY.max - axisY.min
                
                var newXRange = xRange / factor
                var newYRange = yRange / factor
                
                var xCenter = mousePoint.x
                var yCenter = mousePoint.y
                
                axisX.min = xCenter - newXRange * 0.5
                axisX.max = xCenter + newXRange * 0.5
                axisY.min = yCenter - newYRange * 0.5
                axisY.max = yCenter + newYRange * 0.5
                
                emitZoomChanged()
            }
        }

        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                contextMenu.popup()
            } else {
                // Handle timeline click
                var timeValue = chartView.mapToValue(Qt.point(mouse.x, mouse.y), chartView.series(0)).x
                timelinePosition = timeValue
                timeHighlighted(timeValue)
            }
        }

        onDoubleClicked: {
            resetZoom()
        }
    }

    // Context menu
    Menu {
        id: contextMenu
        
        Action {
            text: "Reset Zoom"
            onTriggered: resetZoom()
        }
        
        MenuSeparator {}
        
        Action {
            text: "Auto Scale Y"
            onTriggered: autoScaleY()
        }
        
        Action {
            text: "Auto Scale All"
            onTriggered: autoScaleAll()
        }
        
        MenuSeparator {}
        
        Action {
            text: "Export Chart..."
            onTriggered: exportDialog.open()
        }
    }

    // Crosshair lines
    Rectangle {
        id: verticalCrosshair
        width: 1
        height: chartView.plotArea.height
        color: "#ff6b35"
        opacity: 0.7
        visible: false
        x: chartView.plotArea.x
        y: chartView.plotArea.y
    }

    Rectangle {
        id: horizontalCrosshair
        width: chartView.plotArea.width
        height: 1
        color: "#ff6b35"
        opacity: 0.7
        visible: false
        x: chartView.plotArea.x
        y: chartView.plotArea.y
    }

    // Timeline indicator
    Rectangle {
        id: timelineIndicator
        width: 2
        height: chartView.plotArea.height
        color: "#2196f3"
        opacity: 0.8
        visible: timelinePosition >= 0
        x: {
            if (timelinePosition >= 0 && axisX.max > axisX.min) {
                var normalizedPos = (timelinePosition - axisX.min) / (axisX.max - axisX.min)
                return chartView.plotArea.x + normalizedPos * chartView.plotArea.width
            }
            return 0
        }
        y: chartView.plotArea.y
    }

    // Data point tooltip
    Rectangle {
        id: tooltip
        width: tooltipText.width + 16
        height: tooltipText.height + 12
        color: "#333333"
        border.color: "#555555"
        radius: 4
        opacity: 0.9
        visible: false
        z: 100

        Text {
            id: tooltipText
            anchors.centerIn: parent
            color: "#ffffff"
            font.pixelSize: 11
            font.family: "Consolas, Monaco, monospace"
        }
    }

    // Functions
    function updateChart() {
        if (!dataProvider) return
        
        // Clear existing series
        chartView.removeAllSeries()
        
        // Add new series
        var seriesData = dataProvider.seriesData
        for (var i = 0; i < seriesData.length; i++) {
            var seriesInfo = seriesData[i]
            if (seriesInfo.visible) {
                createSeries(seriesInfo)
            }
        }
        
        updateAxes()
    }

    function createSeries(seriesInfo) {
        var series = chartView.createSeries(ChartView.SeriesTypeLine, seriesInfo.name)
        series.color = seriesInfo.color
        series.width = 2
        series.pointsVisible = false
        
        // Attach to appropriate axis
        if (seriesInfo.onRightAxis) {
            chartView.setAxisY(axisY2, series)
            axisY2.visible = true
        } else {
            chartView.setAxisY(axisY, series)
        }
        chartView.setAxisX(axisX, series)
        
        // Add data points
        for (var j = 0; j < seriesInfo.points.length; j++) {
            var point = seriesInfo.points[j]
            series.append(point.x, point.y)
        }
        
        // Connect hover signals
        series.hovered.connect(function(point, state) {
            dataPointHovered(seriesInfo.name, point.x, point.y, state)
            if (state && showCrosshair) {
                showTooltip(point, seriesInfo.name, seriesInfo.color)
            } else {
                hideTooltip()
            }
        })
    }

    function updateAxes() {
        if (!dataProvider) return
        
        axisX.min = dataProvider.minTime
        axisX.max = dataProvider.maxTime
        axisY.min = dataProvider.minY
        axisY.max = dataProvider.maxY
        
        if (axisY2.visible) {
            axisY2.min = dataProvider.minY2
            axisY2.max = dataProvider.maxY2
        }
    }

    function resetZoom() {
        if (!dataProvider) return
        
        updateAxes()
        emitZoomChanged()
    }

    function autoScaleY() {
        if (!dataProvider) return
        
        axisY.min = dataProvider.minY
        axisY.max = dataProvider.maxY
        emitZoomChanged()
    }

    function autoScaleAll() {
        resetZoom()
    }

    function emitZoomChanged() {
        zoomChanged(axisX.min, axisX.max, axisY.min, axisY.max)
    }

    function updateHover(mouseX, mouseY) {
        if (!showCrosshair) return
        
        var plotArea = chartView.plotArea
        if (mouseX >= plotArea.x && mouseX <= plotArea.x + plotArea.width &&
            mouseY >= plotArea.y && mouseY <= plotArea.y + plotArea.height) {
            
            verticalCrosshair.x = mouseX
            verticalCrosshair.visible = true
            
            horizontalCrosshair.y = mouseY
            horizontalCrosshair.visible = true
        } else {
            verticalCrosshair.visible = false
            horizontalCrosshair.visible = false
        }
    }

    function showTooltip(point, seriesName, color) {
        tooltipText.text = `${seriesName}\nTime: ${point.x.toFixed(3)}\nValue: ${point.y.toFixed(3)}`
        tooltip.color = Qt.darker(color, 1.5)
        
        // Position tooltip near cursor
        var plotArea = chartView.plotArea
        var pointPos = chartView.mapToPosition(point, chartView.series(seriesName))
        
        tooltip.x = Math.min(pointPos.x + 15, chartView.width - tooltip.width - 10)
        tooltip.y = Math.max(pointPos.y - tooltip.height - 15, 10)
        tooltip.visible = true
    }

    function hideTooltip() {
        tooltip.visible = false
        if (showCrosshair) {
            verticalCrosshair.visible = false
            horizontalCrosshair.visible = false
        }
    }

    function setTimelinePosition(time) {
        timelinePosition = time
    }

    function exportChart(format) {
        // This would be implemented in C++ backend
        console.log("Exporting chart as", format)
    }

    // Initialize
    Component.onCompleted: {
        if (dataProvider) {
            updateChart()
        }
    }
} 