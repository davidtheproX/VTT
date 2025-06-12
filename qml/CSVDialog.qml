import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Dialog {
    id: csvDialog
    title: "CSV Data Viewer & Charts"
    width: parent ? parent.width * 0.95 : 1200
    height: parent ? parent.height * 0.95 : 800
    anchors.centerIn: parent
    modal: true
    
    // Theme properties
    property color backgroundColor: parent ? parent.backgroundColor : "#FAFAFA"
    property color surfaceColor: parent ? parent.surfaceColor : "#FFFFFF"
    property color primaryColor: parent ? parent.primaryColor : "#2196F3"
    property color successColor: parent ? parent.successColor : "#4CAF50"
    property color errorColor: parent ? parent.errorColor : "#F44336"
    property color textColor: parent ? parent.textColor : "#212121"
    property color mutedTextColor: parent ? parent.mutedTextColor : "#757575"
    
    // Data properties for CSV files
    property var csvHeaders: []
    property var numericColumns: []
    property var visibleSeries: ({})
    property var seriesColors: ["#FF4444", "#44FF44", "#4444FF", "#FFAA44", "#AA44FF", "#44AAFF"]
    property int currentRow: 0
    property bool csvLoaded: false
    property bool playMode: false
    
    // Axis selection properties
    property int selectedXAxisColumn: 0
    property int selectedYAxisColumn: 1
    property string xAxisName: "Time"
    property string yAxisName: "Value"
    
    // Real-time data properties (for future play functionality)
    property var dataSeriesA: []
    property var dataSeriesB: []
    property var dataSeriesC: []
    property int sampleSize: 60
    property int currentIndex: 0
    property bool isRunning: false
    property real currentValueA: 0
    property real currentValueB: 0
    property real currentValueC: 0
    
    background: Rectangle {
        color: backgroundColor
        radius: 8
        border.color: Qt.lighter(backgroundColor, 1.2)
        border.width: 1
    }
    
    // File dialog for CSV loading
    FileDialog {
        id: fileDialog
        title: "Select CSV File"
        nameFilters: ["CSV files (*.csv)", "All files (*)"]
        onAccepted: {
            console.log("Selected file:", selectedFile)
            csvViewer.loadFile(selectedFile)
        }
    }
    
    Connections {
        target: csvViewer
        function onFileLoaded() {
            csvLoaded = true
            loadCSVData()
        }
        function onLoadError(message) {
            statusText.text = "Error: " + message
        }
    }
    
    function loadCSVData() {
        var summary = csvViewer.getDataSummary()
        csvHeaders = summary.headers
        numericColumns = []
        visibleSeries = {}
        
        // Clear combo box models
        xAxisModel.clear()
        yAxisModel.clear()
        
        // Find numeric columns for plotting
        var columnStats = summary.columnStats
        for (var i = 0; i < columnStats.length; i++) {
            if (columnStats[i].isNumeric) {
                var column = {
                    index: i,
                    name: columnStats[i].name,
                    min: columnStats[i].min,
                    max: columnStats[i].max,
                    avg: columnStats[i].avg
                }
                numericColumns.push(column)
                visibleSeries[columnStats[i].name] = true
                
                // Add to combo box models
                xAxisModel.append({"name": columnStats[i].name, "index": i})
                yAxisModel.append({"name": columnStats[i].name, "index": i})
            }
        }
        
        // Set default axis selections
        if (numericColumns.length > 0) {
            selectedXAxisColumn = 0
            xAxisName = numericColumns[0].name
            xAxisCombo.currentIndex = 0
            
            if (numericColumns.length > 1) {
                selectedYAxisColumn = 1
                yAxisName = numericColumns[1].name
                yAxisCombo.currentIndex = 1
            } else {
                selectedYAxisColumn = 0
                yAxisName = numericColumns[0].name
                yAxisCombo.currentIndex = 0
            }
        }
        
        statusText.text = "Loaded " + csvViewer.totalRows + " rows, " + numericColumns.length + " numeric columns"
        currentRow = 0
        updateChart()
    }
    
    function updateChart() {
        if (!csvLoaded || numericColumns.length === 0) return
        chartCanvas.requestPaint()
    }
    
    function getChartData() {
        if (!csvLoaded) return []
        
        var data = []
        var maxRows = Math.min(csvViewer.totalRows, playMode ? currentRow + 1 : csvViewer.totalRows)
        
        for (var row = 0; row < maxRows; row++) {
            var rowData = csvViewer.getDataRow(row)
            var point = {}
            
            // Get X and Y values from selected columns
            if (selectedXAxisColumn < numericColumns.length && 
                numericColumns[selectedXAxisColumn].index < rowData.length) {
                point.x = rowData[numericColumns[selectedXAxisColumn].index]
            }
            
            if (selectedYAxisColumn < numericColumns.length && 
                numericColumns[selectedYAxisColumn].index < rowData.length) {
                point.y = rowData[numericColumns[selectedYAxisColumn].index]
            }
            
            // Also include all other numeric values for multi-series plotting
            for (var i = 0; i < numericColumns.length; i++) {
                var col = numericColumns[i]
                if (col.index < rowData.length) {
                    point[col.name] = rowData[col.index]
                }
            }
            
            data.push(point)
        }
        return data
    }

    // Header
    header: ToolBar {
        height: 50
        background: Rectangle {
            color: primaryColor
            radius: 8
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: parent.radius
                color: parent.color
            }
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            
            Text {
                text: csvLoaded ? ("CSV Viewer: " + csvViewer.currentFileName) : "CSV Data Viewer (Load a file to begin)"
                color: "white"
                font.pixelSize: 16
                font.bold: true
                Layout.fillWidth: true
            }
            
            Button {
                text: "✕"
                flat: true
                font.pixelSize: 16
                background: Rectangle {
                    color: parent.pressed ? Qt.darker(primaryColor, 1.3) : 
                           parent.hovered ? Qt.darker(primaryColor, 1.1) : "transparent"
                    radius: 4
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: csvDialog.close()
            }
        }
    }
    
    // Main content
    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        
        // Left control panel
        Rectangle {
            Layout.preferredWidth: 200
            Layout.fillHeight: true
            color: surfaceColor
            radius: 8
            border.color: Qt.lighter(surfaceColor, 1.3)
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 15
                
                // File operations
                GroupBox {
                    title: "File Operations"
                    Layout.fillWidth: true
                    font.pixelSize: 10
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 5
                        
                        Button {
                            text: "📁 Load CSV File"
                            Layout.fillWidth: true
                            font.pixelSize: 10
                            onClicked: fileDialog.open()
                        }
                        
                        Text {
                            id: statusText
                            text: "No file loaded"
                            Layout.fillWidth: true
                            font.pixelSize: 9
                            color: mutedTextColor
                            wrapMode: Text.WordWrap
                        }
                    }
                }
                
                // Playback controls (for future use and current CSV animation)
                GroupBox {
                    title: "Playback Controls"
                    Layout.fillWidth: true
                    font.pixelSize: 10
                    visible: csvLoaded
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 5
                        
                        Button {
                            text: playMode ? (isRunning ? "⏸ Pause" : "▶ Play") : "🎬 Enable Play Mode"
                            Layout.fillWidth: true
                            font.pixelSize: 10
                            enabled: csvLoaded
                            
                            background: Rectangle {
                                color: playMode ? (isRunning ? "#FFA500" : successColor) : primaryColor
                                radius: 4
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: {
                                if (!playMode) {
                                    playMode = true
                                    currentRow = 0
                                } else {
                                    isRunning = !isRunning
                                }
                            }
                        }
                        
                        Button {
                            text: "⏹ Stop"
                            Layout.fillWidth: true
                            font.pixelSize: 10
                            enabled: playMode
                            onClicked: {
                                isRunning = false
                                playMode = false
                                currentRow = 0
                                updateChart()
                            }
                        }
                        
                        Text {
                            text: playMode ? ("Row: " + (currentRow + 1) + " / " + csvViewer.totalRows) : "Show all data"
                            font.pixelSize: 9
                            color: mutedTextColor
                            Layout.fillWidth: true
                        }
                    }
                }
                
                // Data series controls
                GroupBox {
                    title: "Axis Selection"
                    Layout.fillWidth: true
                    font.pixelSize: 10
                    visible: csvLoaded && numericColumns.length > 0
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 8
                        
                        // X-Axis selection
                        RowLayout {
                            spacing: 5
                            
                            Text {
                                text: "X-Axis:"
                                font.pixelSize: 9
                                color: textColor
                                width: 40
                            }
                            
                            ComboBox {
                                id: xAxisCombo
                                Layout.fillWidth: true
                                font.pixelSize: 9
                                
                                model: ListModel {
                                    id: xAxisModel
                                }
                                
                                textRole: "name"
                                
                                onCurrentIndexChanged: {
                                    if (currentIndex >= 0 && currentIndex < count) {
                                        selectedXAxisColumn = currentIndex
                                        xAxisName = model.get(currentIndex).name
                                        updateChart()
                                    }
                                }
                            }
                        }
                        
                        // Y-Axis selection
                        RowLayout {
                            spacing: 5
                            
                            Text {
                                text: "Y-Axis:"
                                font.pixelSize: 9
                                color: textColor
                                width: 40
                            }
                            
                            ComboBox {
                                id: yAxisCombo
                                Layout.fillWidth: true
                                font.pixelSize: 9
                                
                                model: ListModel {
                                    id: yAxisModel
                                }
                                
                                textRole: "name"
                                
                                onCurrentIndexChanged: {
                                    if (currentIndex >= 0 && currentIndex < count) {
                                        selectedYAxisColumn = currentIndex
                                        yAxisName = model.get(currentIndex).name
                                        updateChart()
                                    }
                                }
                            }
                        }
                        
                        // Current axis values display
                        Rectangle {
                            Layout.fillWidth: true
                            height: 25
                            color: "#F0F0F0"
                            border.color: "#CCCCCC"
                            border.width: 1
                            radius: 4
                            
                            Text {
                                anchors.centerIn: parent
                                text: "X: " + xAxisName + " vs Y: " + yAxisName
                                font.pixelSize: 9
                                color: textColor
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
                
                // Data series controls
                GroupBox {
                    title: "Data Series"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: 10
                    visible: csvLoaded && numericColumns.length > 0
                    
                    ScrollView {
                        anchors.fill: parent
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 5
                            
                            Repeater {
                                model: numericColumns.length
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 35
                                    color: "transparent"
                                    border.color: Qt.lighter(surfaceColor, 1.5)
                                    border.width: 1
                                    radius: 4
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 5
                                        spacing: 5
                                        
                                        CheckBox {
                                            id: seriesCheckbox
                                            checked: numericColumns[index] ? visibleSeries[numericColumns[index].name] : false
                                            onCheckedChanged: {
                                                if (numericColumns[index]) {
                                                    visibleSeries[numericColumns[index].name] = checked
                                                    updateChart()
                                                }
                                            }
                                        }
                                        
                                        Rectangle {
                                            width: 12
                                            height: 12
                                            color: seriesColors[index % seriesColors.length]
                                            radius: 2
                                        }
                                        
                                        Text {
                                            text: numericColumns[index] ? numericColumns[index].name : ""
                                            font.pixelSize: 9
                                            color: textColor
                                            Layout.fillWidth: true
                                            elide: Text.ElideRight
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Real-time mode controls (for future synthetic data)
                GroupBox {
                    title: "Real-Time Demo Mode"
                    Layout.fillWidth: true
                    font.pixelSize: 10
                    visible: !csvLoaded
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 5
                        
                        Button {
                            text: isRunning ? "⏸ Freeze" : "▶ Run Demo"
                            Layout.fillWidth: true
                            font.pixelSize: 10
                            checkable: true
                            checked: isRunning
                            
                            background: Rectangle {
                                color: parent.checked ? successColor : primaryColor
                                radius: 4
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: {
                                if (!csvLoaded) {
                                    isRunning = !isRunning
                                }
                            }
                        }
                        
                        // Current values for demo mode
                        Column {
                            spacing: 8
                            visible: !csvLoaded
                            
                            // Alpha Value (Red)
                            Row {
                                spacing: 5
                                Text {
                                    text: "Alpha:"
                                    font.pixelSize: 9
                                    color: textColor
                                    width: 45
                                }
                                Rectangle {
                                    width: 60
                                    height: 20
                                    color: "#FFCCCC"
                                    border.color: "#888888"
                                    border.width: 1
                                    Text {
                                        anchors.centerIn: parent
                                        text: currentValueA.toFixed(2)
                                        font.pixelSize: 9
                                        color: textColor
                                    }
                                }
                            }
                            
                            // Beta Value (Green)
                            Row {
                                spacing: 5
                                Text {
                                    text: "Beta:"
                                    font.pixelSize: 9
                                    color: textColor
                                    width: 45
                                }
                                Rectangle {
                                    width: 60
                                    height: 20
                                    color: "#CCFFCC"
                                    border.color: "#888888"
                                    border.width: 1
                                    Text {
                                        anchors.centerIn: parent
                                        text: currentValueB.toFixed(2)
                                        font.pixelSize: 9
                                        color: textColor
                                    }
                                }
                            }
                            
                            // Gamma Value (Blue)
                            Row {
                                spacing: 5
                                Text {
                                    text: "Gamma:"
                                    font.pixelSize: 9
                                    color: textColor
                                    width: 45
                                }
                                Rectangle {
                                    width: 60
                                    height: 20
                                    color: "#CCCCFF"
                                    border.color: "#888888"
                                    border.width: 1
                                    Text {
                                        anchors.centerIn: parent
                                        text: currentValueC.toFixed(2)
                                        font.pixelSize: 9
                                        color: textColor
                                    }
                                }
                            }
                        }
                    }
                }
                
                Item { Layout.fillHeight: true }
            }
        }
        
        // Main chart area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: surfaceColor
            radius: 8
            border.color: Qt.lighter(surfaceColor, 1.3)
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10
                
                // Chart title
                Text {
                    text: csvLoaded ? ("Data Visualization: " + xAxisName + " vs " + yAxisName) : "Real-Time Chart Demo (Load CSV for actual data)"
                    font.pixelSize: 14
                    font.bold: true
                    color: textColor
                    Layout.alignment: Qt.AlignHCenter
                }
                
                // Chart canvas
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    border.color: "#CCCCCC"
                    border.width: 1
                    radius: 4
                    
                    Canvas {
                        id: chartCanvas
                        anchors.fill: parent
                        anchors.margins: 1
                        
                        property real minY: 0
                        property real maxY: 100
                        property int dataPoints: csvLoaded ? (playMode ? currentRow + 1 : csvViewer.totalRows) : sampleSize
                        
                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)
                            
                            // Chart margins
                            var margin = 40
                            var chartWidth = width - 2 * margin
                            var chartHeight = height - 2 * margin
                            
                            if (csvLoaded && numericColumns.length > 0) {
                                // Draw CSV data
                                drawCSVChart(ctx, margin, chartWidth, chartHeight)
                            } else {
                                // Draw demo data (ChartDirector style)
                                drawDemoChart(ctx, margin, chartWidth, chartHeight)
                            }
                        }
                        
                        function drawCSVChart(ctx, margin, chartWidth, chartHeight) {
                            var data = getChartData()
                            if (data.length === 0) return
                            
                            // Calculate X and Y ranges from selected axes
                            var xValues = []
                            var yValues = []
                            
                            for (var i = 0; i < data.length; i++) {
                                if (data[i].x !== undefined && data[i].y !== undefined) {
                                    xValues.push(data[i].x)
                                    yValues.push(data[i].y)
                                }
                            }
                            
                            if (xValues.length === 0 || yValues.length === 0) return
                            
                            var minX = Math.min.apply(Math, xValues)
                            var maxX = Math.max.apply(Math, xValues)
                            var minY = Math.min.apply(Math, yValues)
                            var maxY = Math.max.apply(Math, yValues)
                            
                            var xRange = maxX - minX
                            var yRange = maxY - minY
                            if (xRange === 0) xRange = 1
                            if (yRange === 0) yRange = 1
                            
                            // Add some padding
                            minX -= xRange * 0.1
                            maxX += xRange * 0.1
                            minY -= yRange * 0.1
                            maxY += yRange * 0.1
                            xRange = maxX - minX
                            yRange = maxY - minY
                            
                            // Draw grid
                            ctx.strokeStyle = "#E0E0E0"
                            ctx.lineWidth = 1
                            
                            // Vertical grid lines
                            for (var x = 0; x <= 10; x++) {
                                var xPos = margin + (x / 10) * chartWidth
                                ctx.beginPath()
                                ctx.moveTo(xPos, margin)
                                ctx.lineTo(xPos, margin + chartHeight)
                                ctx.stroke()
                            }
                            
                            // Horizontal grid lines
                            for (var y = 0; y <= 10; y++) {
                                var yPos = margin + (y / 10) * chartHeight
                                ctx.beginPath()
                                ctx.moveTo(margin, yPos)
                                ctx.lineTo(margin + chartWidth, yPos)
                                ctx.stroke()
                            }
                            
                            // Draw axes
                            ctx.strokeStyle = "#666666"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            ctx.moveTo(margin, margin)
                            ctx.lineTo(margin, margin + chartHeight)
                            ctx.lineTo(margin + chartWidth, margin + chartHeight)
                            ctx.stroke()
                            
                            // Draw legend
                            var legendY = margin + 10
                            ctx.font = "10px Arial"
                            ctx.fillStyle = "#333333"
                            ctx.fillText("Primary: " + xAxisName + " vs " + yAxisName, margin + 10, legendY)
                            
                            // Draw main scatter plot for selected X vs Y (primary series)
                            ctx.fillStyle = seriesColors[0]
                            ctx.strokeStyle = seriesColors[0]
                            ctx.lineWidth = 2
                            
                            var prevX = null, prevY = null
                            for (var i = 0; i < data.length; i++) {
                                if (data[i].x !== undefined && data[i].y !== undefined) {
                                    var x = margin + ((data[i].x - minX) / xRange) * chartWidth
                                    var y = margin + chartHeight - ((data[i].y - minY) / yRange) * chartHeight
                                    
                                    // Draw point
                                    ctx.beginPath()
                                    ctx.arc(x, y, 3, 0, 2 * Math.PI)
                                    ctx.fill()
                                    
                                    // Draw line to previous point
                                    if (prevX !== null && prevY !== null) {
                                        ctx.beginPath()
                                        ctx.moveTo(prevX, prevY)
                                        ctx.lineTo(x, y)
                                        ctx.stroke()
                                    }
                                    
                                    prevX = x
                                    prevY = y
                                }
                            }
                            
                            // Draw additional series for other visible columns (plotted against X-axis)
                            var seriesIndex = 1
                            for (var colIndex = 0; colIndex < numericColumns.length; colIndex++) {
                                if (colIndex === selectedXAxisColumn || colIndex === selectedYAxisColumn) continue
                                
                                var col = numericColumns[colIndex]
                                if (!visibleSeries[col.name]) continue
                                
                                // Calculate Y range for this series
                                var seriesYValues = []
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i][col.name] !== undefined) {
                                        seriesYValues.push(data[i][col.name])
                                    }
                                }
                                
                                if (seriesYValues.length === 0) continue
                                
                                var seriesMinY = Math.min.apply(Math, seriesYValues)
                                var seriesMaxY = Math.max.apply(Math, seriesYValues)
                                var seriesYRange = seriesMaxY - seriesMinY
                                if (seriesYRange === 0) seriesYRange = 1
                                
                                // Normalize to chart area
                                seriesMinY -= seriesYRange * 0.1
                                seriesMaxY += seriesYRange * 0.1
                                seriesYRange = seriesMaxY - seriesMinY
                                
                                // Draw series
                                ctx.strokeStyle = seriesColors[seriesIndex % seriesColors.length]
                                ctx.fillStyle = seriesColors[seriesIndex % seriesColors.length]
                                ctx.lineWidth = 1.5
                                
                                var prevSeriesX = null, prevSeriesY = null
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].x !== undefined && data[i][col.name] !== undefined) {
                                        var x = margin + ((data[i].x - minX) / xRange) * chartWidth
                                        var y = margin + chartHeight - ((data[i][col.name] - seriesMinY) / seriesYRange) * chartHeight
                                        
                                        // Draw small point
                                        ctx.beginPath()
                                        ctx.arc(x, y, 1.5, 0, 2 * Math.PI)
                                        ctx.fill()
                                        
                                        // Draw line
                                        if (prevSeriesX !== null && prevSeriesY !== null) {
                                            ctx.beginPath()
                                            ctx.moveTo(prevSeriesX, prevSeriesY)
                                            ctx.lineTo(x, y)
                                            ctx.stroke()
                                        }
                                        
                                        prevSeriesX = x
                                        prevSeriesY = y
                                    }
                                }
                                
                                // Draw series legend
                                legendY += 15
                                ctx.fillStyle = seriesColors[seriesIndex % seriesColors.length]
                                ctx.fillRect(margin + 10, legendY - 8, 15, 3)
                                ctx.fillStyle = "#333333"
                                ctx.fillText(col.name + " (right axis)", margin + 30, legendY)
                                
                                seriesIndex++
                            }
                            
                            // Draw X-axis labels
                            ctx.fillStyle = "#666666"
                            ctx.font = "10px Arial"
                            for (var labelX = 0; labelX <= 5; labelX++) {
                                var value = minX + (labelX / 5) * xRange
                                var xPos = margin + (labelX / 5) * chartWidth
                                ctx.fillText(value.toFixed(1), xPos - 15, height - 5)
                            }
                            
                            // Draw Y-axis labels (for primary series)
                            for (var labelY = 0; labelY <= 5; labelY++) {
                                var value = minY + (labelY / 5) * yRange
                                var yPos = margin + chartHeight - (labelY / 5) * chartHeight
                                ctx.fillText(value.toFixed(1), 5, yPos + 3)
                            }
                            
                            // Draw axis labels
                            ctx.font = "12px Arial"
                            ctx.fillStyle = "#333333"
                            
                            // X-axis label
                            ctx.fillText(xAxisName, margin + chartWidth/2 - 30, height - 20)
                            
                            // Y-axis label (rotated)
                            ctx.save()
                            ctx.translate(15, margin + chartHeight/2)
                            ctx.rotate(-Math.PI/2)
                            ctx.fillText(yAxisName, -30, 0)
                            ctx.restore()
                        }
                        
                        function drawDemoChart(ctx, margin, chartWidth, chartHeight) {
                            // Demo chart drawing (existing ChartDirector style code)
                            minY = 0
                            maxY = 300
                            var yRange = maxY - minY
                            
                            // Draw grid
                            ctx.strokeStyle = "#E0E0E0"
                            ctx.lineWidth = 1
                            
                            for (var x = 0; x <= 10; x++) {
                                var xPos = margin + (x / 10) * chartWidth
                                ctx.beginPath()
                                ctx.moveTo(xPos, margin)
                                ctx.lineTo(xPos, margin + chartHeight)
                                ctx.stroke()
                            }
                            
                            for (var y = 0; y <= 10; y++) {
                                var yPos = margin + (y / 10) * chartHeight
                                ctx.beginPath()
                                ctx.moveTo(margin, yPos)
                                ctx.lineTo(margin + chartWidth, yPos)
                                ctx.stroke()
                            }
                            
                            // Draw axes
                            ctx.strokeStyle = "#666666"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            ctx.moveTo(margin, margin)
                            ctx.lineTo(margin, margin + chartHeight)
                            ctx.lineTo(margin + chartWidth, margin + chartHeight)
                            ctx.stroke()
                            
                            // Draw legend
                            var legendY = margin + 10
                            ctx.font = "12px Arial"
                            
                            // Alpha series (Red)
                            ctx.fillStyle = "#FF4444"
                            ctx.fillRect(margin + 10, legendY, 15, 3)
                            ctx.fillStyle = "#333333"
                            ctx.fillText("Alpha Software", margin + 30, legendY + 10)
                            
                            // Beta series (Green)
                            legendY += 20
                            ctx.fillStyle = "#44FF44"
                            ctx.fillRect(margin + 10, legendY, 15, 3)
                            ctx.fillStyle = "#333333"
                            ctx.fillText("Beta Hardware", margin + 30, legendY + 10)
                            
                            // Gamma series (Blue)
                            legendY += 20
                            ctx.fillStyle = "#4444FF"
                            ctx.fillRect(margin + 10, legendY, 15, 3)
                            ctx.fillStyle = "#333333"
                            ctx.fillText("Gamma Services", margin + 30, legendY + 10)
                            
                            // Draw data lines
                            if (dataSeriesA.length > 0) {
                                // Alpha series
                                ctx.strokeStyle = "#FF4444"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                for (var i = 0; i < dataSeriesA.length; i++) {
                                    var x = margin + (i / (sampleSize - 1)) * chartWidth
                                    var y = margin + chartHeight - ((dataSeriesA[i] - minY) / yRange) * chartHeight
                                    if (i === 0) ctx.moveTo(x, y)
                                    else ctx.lineTo(x, y)
                                }
                                ctx.stroke()
                                
                                // Beta series
                                ctx.strokeStyle = "#44FF44"
                                ctx.beginPath()
                                for (var i = 0; i < dataSeriesB.length; i++) {
                                    var x = margin + (i / (sampleSize - 1)) * chartWidth
                                    var y = margin + chartHeight - ((dataSeriesB[i] - minY) / yRange) * chartHeight
                                    if (i === 0) ctx.moveTo(x, y)
                                    else ctx.lineTo(x, y)
                                }
                                ctx.stroke()
                                
                                // Gamma series
                                ctx.strokeStyle = "#4444FF"
                                ctx.beginPath()
                                for (var i = 0; i < dataSeriesC.length; i++) {
                                    var x = margin + (i / (sampleSize - 1)) * chartWidth
                                    var y = margin + chartHeight - ((dataSeriesC[i] - minY) / yRange) * chartHeight
                                    if (i === 0) ctx.moveTo(x, y)
                                    else ctx.lineTo(x, y)
                                }
                                ctx.stroke()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Timer for real-time updates
    Timer {
        id: updateTimer
        interval: 250
        running: isRunning || (playMode && isRunning)
        repeat: true
        onTriggered: {
            if (csvLoaded && playMode && isRunning) {
                // CSV playback mode
                if (currentRow < csvViewer.totalRows - 1) {
                    currentRow++
                    updateChart()
                } else {
                    isRunning = false // Stop at end
                }
            } else if (!csvLoaded && isRunning) {
                // Demo mode (ChartDirector style)
                currentIndex++
                var p = currentIndex * 0.1
                
                // Generate data using ChartDirector formulas
                var dataA = 20 + Math.cos(p * 129241) * 10 + 1 / (Math.cos(p) * Math.cos(p) + 0.01)
                var dataB = 150 + 100 * Math.sin(p / 27.7) * Math.sin(p / 10.1)
                var dataC = 150 + 100 * Math.cos(p / 6.7) * Math.cos(p / 11.9)
                
                // Update current values
                currentValueA = dataA
                currentValueB = dataB
                currentValueC = dataC
                
                // Add to series
                dataSeriesA.push(dataA)
                dataSeriesB.push(dataB)
                dataSeriesC.push(dataC)
                
                // Keep only recent samples
                if (dataSeriesA.length > sampleSize) {
                    dataSeriesA.shift()
                    dataSeriesB.shift()
                    dataSeriesC.shift()
                }
                
                chartCanvas.requestPaint()
            }
        }
    }
}