import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Window

ApplicationWindow {
    id: csvDialog
    title: "CSV Data Viewer & Charts"
    modality: Qt.ApplicationModal
    flags: Qt.Dialog | Qt.WindowCloseButtonHint
    
    width: 1200
    height: 800
    minimumWidth: 1000
    minimumHeight: 600
    
    // Center on screen
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    
    visible: false
    
    // Theme properties
    property color backgroundColor: "#FAFAFA"
    property color surfaceColor: "#FFFFFF"
    property color primaryColor: "#2196F3"
    property color successColor: "#4CAF50"
    property color errorColor: "#F44336"
    property color textColor: "#212121"
    property color mutedTextColor: "#757575"
    
    // Data properties for CSV files
    property var csvHeaders: []
    property var numericColumns: []
    property var visibleSeries: ({})
    property var seriesColors: [
        "#FF4444", "#44FF44", "#4444FF", "#FFAA44", "#AA44FF", "#44AAFF",
        "#FF8844", "#44FF88", "#8844FF", "#FFFF44", "#FF44AA", "#44FFAA",
        "#FF6644", "#66FF44", "#4466FF", "#AAFF44"
    ]
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
    property var dataSeriesD: []
    property var dataSeriesE: []
    property var dataSeriesF: []
    property var dataSeriesG: []
    property var dataSeriesH: []
    property var dataSeriesI: []
    property var dataSeriesJ: []
    property var dataSeriesK: []
    property var dataSeriesL: []
    property var dataSeriesM: []
    property var dataSeriesN: []
    property var dataSeriesO: []
    property var dataSeriesP: []
    property int sampleSize: 60
    property int currentIndex: 0
    property bool isRunning: false
    property real currentValueA: 0
    property real currentValueB: 0
    property real currentValueC: 0
    property real currentValueD: 0
    property real currentValueE: 0
    property real currentValueF: 0
    property real currentValueG: 0
    property real currentValueH: 0
    property real currentValueI: 0
    property real currentValueJ: 0
    property real currentValueK: 0
    property real currentValueL: 0
    property real currentValueM: 0
    property real currentValueN: 0
    property real currentValueO: 0
    property real currentValueP: 0
    
    signal closed()
    
    function open() {
        visible = true
        raise()
        requestActivate()
    }
    
    function close() {
        visible = false
        closed()
    }
    
    onClosing: function(close) {
        close.accepted = true
        closed()
    }
    
    color: backgroundColor

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
    header: Rectangle {
        height: 50
        color: primaryColor
        
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
                            
                            onClicked: {
                                if (!csvLoaded) {
                                    isRunning = !isRunning
                                }
                            }
                        }
                        
                        // Current values for demo mode - showing first 8 series
                        ScrollView {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 120
                            visible: !csvLoaded
                            
                            Column {
                                spacing: 4
                                width: parent.width
                                
                                property var seriesNames: ["Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta"]
                                property var currentValues: [currentValueA, currentValueB, currentValueC, currentValueD, 
                                                           currentValueE, currentValueF, currentValueG, currentValueH]
                                
                                Repeater {
                                    model: 8
                                    
                                    Row {
                                        spacing: 5
                                        Text {
                                            text: parent.parent.seriesNames[index] + ":"
                                            font.pixelSize: 8
                                            color: textColor
                                            width: 40
                                        }
                                        Rectangle {
                                            width: 50
                                            height: 15
                                            color: Qt.lighter(seriesColors[index], 1.7)
                                            border.color: seriesColors[index]
                                            border.width: 1
                                            Text {
                                                anchors.centerIn: parent
                                                text: parent.parent.parent.currentValues[index] ? parent.parent.parent.currentValues[index].toFixed(1) : "0.0"
                                                font.pixelSize: 8
                                                color: textColor
                                            }
                                        }
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
                            
                            // Draw legend in two columns
                            var legendY = margin + 10
                            var legendX1 = margin + 10
                            var legendX2 = margin + chartWidth / 2 + 10
                            ctx.font = "10px Arial"
                            
                            var seriesNames = [
                                "Alpha Software", "Beta Hardware", "Gamma Services", "Delta Analytics",
                                "Epsilon Network", "Zeta Security", "Eta Database", "Theta AI/ML",
                                "Iota IoT Sensors", "Kappa Blockchain", "Lambda Serverless", "Mu DevOps",
                                "Nu Monitoring", "Xi Automation", "Omicron Cloud", "Pi Performance"
                            ]
                            
                            for (var s = 0; s < 16; s++) {
                                var xPos = (s < 8) ? legendX1 : legendX2
                                var yPos = legendY + (s % 8) * 12
                                
                                ctx.fillStyle = seriesColors[s]
                                ctx.fillRect(xPos, yPos, 12, 2)
                                ctx.fillStyle = "#333333"
                                ctx.fillText(seriesNames[s], xPos + 16, yPos + 8)
                            }
                            
                            // Draw data lines for all 16 series
                            if (dataSeriesA.length > 0) {
                                var allSeries = [
                                    dataSeriesA, dataSeriesB, dataSeriesC, dataSeriesD,
                                    dataSeriesE, dataSeriesF, dataSeriesG, dataSeriesH,
                                    dataSeriesI, dataSeriesJ, dataSeriesK, dataSeriesL,
                                    dataSeriesM, dataSeriesN, dataSeriesO, dataSeriesP
                                ]
                                
                                for (var seriesIdx = 0; seriesIdx < allSeries.length; seriesIdx++) {
                                    var series = allSeries[seriesIdx]
                                    if (series.length > 0) {
                                        ctx.strokeStyle = seriesColors[seriesIdx]
                                        ctx.lineWidth = 1.5
                                        ctx.beginPath()
                                        for (var i = 0; i < series.length; i++) {
                                            var x = margin + (i / (sampleSize - 1)) * chartWidth
                                            var y = margin + chartHeight - ((series[i] - minY) / yRange) * chartHeight
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
        }
    }
    
    // Timer for real-time updates
    Timer {
        id: updateTimer
        interval: 1
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
                
                // Generate data using ChartDirector formulas with variations
                var dataA = 20 + Math.cos(p * 129241) * 10 + 1 / (Math.cos(p) * Math.cos(p) + 0.01)
                var dataB = 150 + 100 * Math.sin(p / 27.7) * Math.sin(p / 10.1)
                var dataC = 150 + 100 * Math.cos(p / 6.7) * Math.cos(p / 11.9)
                var dataD = 80 + 60 * Math.sin(p / 15.3) * Math.cos(p / 8.2)
                var dataE = 120 + 80 * Math.cos(p / 12.4) * Math.sin(p / 20.1)
                var dataF = 90 + 70 * Math.sin(p / 18.7) + 20 * Math.cos(p * 3.1)
                var dataG = 160 + 90 * Math.cos(p / 9.8) * Math.cos(p / 14.3)
                var dataH = 110 + 85 * Math.sin(p / 22.5) * Math.sin(p / 7.9)
                var dataI = 140 + 95 * Math.cos(p / 16.2) + 15 * Math.sin(p * 2.4)
                var dataJ = 75 + 65 * Math.sin(p / 11.7) * Math.cos(p / 19.8)
                var dataK = 185 + 110 * Math.cos(p / 13.9) * Math.sin(p / 6.4)
                var dataL = 95 + 75 * Math.sin(p / 21.3) + 25 * Math.cos(p * 1.8)
                var dataM = 130 + 88 * Math.cos(p / 8.6) * Math.cos(p / 17.2)
                var dataN = 105 + 78 * Math.sin(p / 14.8) * Math.sin(p / 9.5)
                var dataO = 170 + 100 * Math.cos(p / 10.4) + 30 * Math.sin(p * 2.9)
                var dataP = 85 + 68 * Math.sin(p / 24.1) * Math.cos(p / 5.7)
                
                // Update current values
                currentValueA = dataA
                currentValueB = dataB
                currentValueC = dataC
                currentValueD = dataD
                currentValueE = dataE
                currentValueF = dataF
                currentValueG = dataG
                currentValueH = dataH
                currentValueI = dataI
                currentValueJ = dataJ
                currentValueK = dataK
                currentValueL = dataL
                currentValueM = dataM
                currentValueN = dataN
                currentValueO = dataO
                currentValueP = dataP
                
                // Add to series
                dataSeriesA.push(dataA)
                dataSeriesB.push(dataB)
                dataSeriesC.push(dataC)
                dataSeriesD.push(dataD)
                dataSeriesE.push(dataE)
                dataSeriesF.push(dataF)
                dataSeriesG.push(dataG)
                dataSeriesH.push(dataH)
                dataSeriesI.push(dataI)
                dataSeriesJ.push(dataJ)
                dataSeriesK.push(dataK)
                dataSeriesL.push(dataL)
                dataSeriesM.push(dataM)
                dataSeriesN.push(dataN)
                dataSeriesO.push(dataO)
                dataSeriesP.push(dataP)
                
                // Keep only recent samples
                if (dataSeriesA.length > sampleSize) {
                    dataSeriesA.shift()
                    dataSeriesB.shift()
                    dataSeriesC.shift()
                    dataSeriesD.shift()
                    dataSeriesE.shift()
                    dataSeriesF.shift()
                    dataSeriesG.shift()
                    dataSeriesH.shift()
                    dataSeriesI.shift()
                    dataSeriesJ.shift()
                    dataSeriesK.shift()
                    dataSeriesL.shift()
                    dataSeriesM.shift()
                    dataSeriesN.shift()
                    dataSeriesO.shift()
                    dataSeriesP.shift()
                }
                
                chartCanvas.requestPaint()
            }
        }
    }
}