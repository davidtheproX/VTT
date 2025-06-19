import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    id: qmlViewerWindow
    title: "QML UI Viewer"
    
    // Auto-resize to 1280x800 as requested
    width: 1280
    height: 800
    minimumWidth: 800
    minimumHeight: 600
    
    visibility: Window.Windowed
    visible: false
    
    // Center on screen when opened
    Component.onCompleted: {
        x = (Screen.width - width) / 2
        y = (Screen.height - height) / 2
    }
    
    // High DPI scaling support
    property real scaleFactor: Math.min(width / 1280, height / 800)
    property real baseFont: 14 * scaleFactor
    
    // Color scheme matching main app
    property color primaryColor: "#41CD52"  // Qt Green
    property color backgroundColor: "#FAFAFA"
    property color surfaceColor: "#FFFFFF"
    property color textColor: "#212121"
    property color mutedTextColor: "#757575"
    
    color: backgroundColor
    
    // Header with controls
    header: ToolBar {
        height: 60 * scaleFactor
        
        background: Rectangle {
            color: primaryColor
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Qt.darker(primaryColor, 1.2)
            }
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 16 * scaleFactor
            
            Text {
                text: "QML UI Viewer - Qt Design Studio"
                color: "white"
                font.pixelSize: baseFont * 1.4
                font.weight: Font.Medium
                Layout.fillWidth: true
            }
            
            // Control buttons
            ToolButton {
                text: "🔄"
                font.pixelSize: baseFont * 1.2
                onClicked: reloadQml()
                
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
                
                ToolTip.text: "Reload QML"
                ToolTip.visible: hovered
            }
            
            ToolButton {
                text: "📱"
                font.pixelSize: baseFont * 1.2
                onClicked: toggleResponsiveMode()
                
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
                
                ToolTip.text: "Toggle Responsive Preview"
                ToolTip.visible: hovered
            }
            
            Rectangle {
                width: 1
                height: 30 * scaleFactor
                color: Qt.darker(primaryColor, 1.2)
            }
            
            Button {
                text: "Close"
                onClicked: qmlViewerWindow.close()
                
                background: Rectangle {
                    color: parent.pressed ? Qt.darker(primaryColor, 1.3) : 
                           parent.hovered ? "#e74c3c" : Qt.darker(primaryColor, 1.1)
                    radius: 4
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: baseFont
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    
    // Main content area
    RowLayout {
        anchors.fill: parent
        anchors.margins: 8 * scaleFactor
        spacing: 8 * scaleFactor
        
        // QML display area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: surfaceColor
            border.color: "#e0e0e0"
            border.width: 1
            radius: 4
            
            ScrollView {
                id: qmlScrollView
                anchors.fill: parent
                anchors.margins: 4
                clip: true
                
                // QML content container
                Rectangle {
                    id: qmlContainer
                    width: Math.max(qmlScrollView.width, qmlLoader.item ? qmlLoader.item.width : 0)
                    height: Math.max(qmlScrollView.height, qmlLoader.item ? qmlLoader.item.height : 0)
                    color: "transparent"
                    
                    Loader {
                        id: qmlLoader
                        anchors.centerIn: parent
                        
                        // Auto-scaling properties
                        property real originalWidth: item ? item.implicitWidth || item.width : 1920
                        property real originalHeight: item ? item.implicitHeight || item.height : 958
                        property real containerWidth: qmlContainer.width
                        property real containerHeight: qmlContainer.height
                        property real autoScale: calculateAutoScale()
                        
                        // Apply auto-scaling
                        scale: autoScale
                        
                        // Calculate optimal scale while maintaining aspect ratio
                        function calculateAutoScale() {
                            if (!item || originalWidth <= 0 || originalHeight <= 0) {
                                return 1.0
                            }
                            
                            var availableWidth = containerWidth - 40  // Leave some margin
                            var availableHeight = containerHeight - 40
                            
                            var scaleX = availableWidth / originalWidth
                            var scaleY = availableHeight / originalHeight
                            
                            // Use the smaller scale to maintain aspect ratio
                            var optimalScale = Math.min(scaleX, scaleY)
                            
                            // Limit scaling between 0.1x and 3.0x for usability
                            return Math.max(0.1, Math.min(3.0, optimalScale))
                        }
                        
                        // Update scale when container size changes
                        onContainerWidthChanged: autoScale = calculateAutoScale()
                        onContainerHeightChanged: autoScale = calculateAutoScale()
                        
                        // Default source - will be set when dialog opens
                        source: ""
                        
                        onStatusChanged: {
                            if (status === Loader.Loading) {
                                console.log("QML Viewer: Loading QML file...")
                                loadingIndicator.visible = true
                                errorDisplay.visible = false
                            } else if (status === Loader.Ready) {
                                console.log("QML Viewer: QML file loaded successfully")
                                loadingIndicator.visible = false
                                errorDisplay.visible = false
                                if (item) {
                                    // Update original dimensions
                                    originalWidth = item.implicitWidth || item.width
                                    originalHeight = item.implicitHeight || item.height
                                    
                                    console.log("QML Viewer: Original dimensions:", originalWidth, "x", originalHeight)
                                    
                                    // Recalculate auto-scale for new content
                                    Qt.callLater(function() {
                                        autoScale = calculateAutoScale()
                                        console.log("QML Viewer: Auto-scale calculated:", autoScale)
                                    })
                                    
                                    infoPanel.updateFileInfo(source.toString(), originalWidth, originalHeight)
                                }
                            } else if (status === Loader.Error) {
                                console.log("QML Viewer: Error loading QML file:", sourceComponent.errorString())
                                loadingIndicator.visible = false
                                errorDisplay.visible = true
                                errorDisplay.errorText = sourceComponent ? sourceComponent.errorString() : "Unknown error"
                            }
                        }
                        
                        onSourceChanged: {
                            console.log("QML Viewer: Source changed to:", source)
                        }
                    }
                    
                    // Loading indicator
                    Rectangle {
                        id: loadingIndicator
                        anchors.centerIn: parent
                        width: 200 * scaleFactor
                        height: 100 * scaleFactor
                        color: surfaceColor
                        border.color: primaryColor
                        border.width: 1
                        radius: 8
                        visible: false
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 16 * scaleFactor
                            
                            BusyIndicator {
                                anchors.horizontalCenter: parent.horizontalCenter
                                running: parent.parent.visible
                            }
                            
                            Text {
                                text: "Loading QML..."
                                color: textColor
                                font.pixelSize: baseFont
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    
                    // Error display
                    Rectangle {
                        id: errorDisplay
                        anchors.centerIn: parent
                        width: Math.min(400 * scaleFactor, qmlContainer.width - 40)
                        height: 200 * scaleFactor
                        color: "#fff5f5"
                        border.color: "#e53e3e"
                        border.width: 2
                        radius: 8
                        visible: false
                        
                        property string errorText: ""
                        
                        Column {
                            anchors.centerIn: parent
                            anchors.margins: 16 * scaleFactor
                            spacing: 16 * scaleFactor
                            width: parent.width - 32 * scaleFactor
                            
                            Text {
                                text: "⚠️ QML Loading Error"
                                color: "#e53e3e"
                                font.pixelSize: baseFont * 1.2
                                font.weight: Font.Bold
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            ScrollView {
                                width: parent.width
                                height: 80 * scaleFactor
                                clip: true
                                
                                Text {
                                    text: errorDisplay.errorText
                                    color: "#c53030"
                                    font.pixelSize: baseFont * 0.9
                                    wrapMode: Text.Wrap
                                    width: parent.width
                                }
                            }
                            
                            Button {
                                text: "Retry"
                                anchors.horizontalCenter: parent.horizontalCenter
                                onClicked: reloadQml()
                            }
                        }
                    }
                }
            }
        }
        
        // Information panel
        Rectangle {
            id: infoPanel
            Layout.preferredWidth: 300 * scaleFactor
            Layout.fillHeight: true
            color: surfaceColor
            border.color: "#e0e0e0"
            border.width: 1
            radius: 4
            
            function updateFileInfo(filePath, itemWidth, itemHeight) {
                filePathText.text = filePath.split('/').pop() || "Unknown"
                dimensionsText.text = `${itemWidth} x ${itemHeight}`
                statusText.text = "Loaded"
                lastLoadedText.text = new Date().toLocaleTimeString()
                updateScaleInfo()
            }
            
            function clearFileInfo() {
                filePathText.text = "None"
                dimensionsText.text = "N/A"
                statusText.text = "Not loaded"
                lastLoadedText.text = "N/A"
                scaleText.text = "N/A"
            }
            
            function updateScaleInfo() {
                var scalePercent = Math.round(qmlLoader.autoScale * 100)
                scaleText.text = scalePercent + "%"
            }
            
            // Update scale display when auto-scale changes
            Connections {
                target: qmlLoader
                function onAutoScaleChanged() {
                    infoPanel.updateScaleInfo()
                }
            }
            
            ScrollView {
                anchors.fill: parent
                anchors.margins: 12 * scaleFactor
                
                ColumnLayout {
                    width: parent.width
                    spacing: 16 * scaleFactor
                    
                    // File info section
                    GroupBox {
                        Layout.fillWidth: true
                        title: "File Information"
                        font.pixelSize: baseFont
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 8 * scaleFactor
                            
                            Text {
                                text: "File:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: filePathText
                                text: "Lifedata.ui.qml"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }
                            
                            Text {
                                text: "Type:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                text: "Qt Design Studio UI"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                        }
                    }
                    
                    // Display info section
                    GroupBox {
                        Layout.fillWidth: true
                        title: "Display Information"
                        font.pixelSize: baseFont
                        
                        GridLayout {
                            width: parent.width
                            columns: 2
                            columnSpacing: 8 * scaleFactor
                            rowSpacing: 4 * scaleFactor
                            
                            Text {
                                text: "Dimensions:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: dimensionsText
                                text: "N/A"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                            
                            Text {
                                text: "Status:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: statusText
                                text: "Ready"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                            
                            Text {
                                text: "Last Loaded:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: lastLoadedText
                                text: "N/A"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                            
                            Text {
                                text: "Scale:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: scaleText
                                text: "100%"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                        }
                    }
                    
                    // Controls section
                    GroupBox {
                        Layout.fillWidth: true
                        title: "Controls"
                        font.pixelSize: baseFont
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 8 * scaleFactor
                            
                            Button {
                                Layout.fillWidth: true
                                text: "Reload QML"
                                font.pixelSize: baseFont * 0.9
                                onClicked: reloadQml()
                            }
                            
                            Button {
                                Layout.fillWidth: true
                                text: "Fit to Window"
                                font.pixelSize: baseFont * 0.9
                                onClicked: fitToWindow()
                            }
                            
                            Button {
                                Layout.fillWidth: true
                                text: "Reset Zoom"
                                font.pixelSize: baseFont * 0.9
                                onClicked: resetZoom()
                            }
                            
                            // Manual zoom controls
                            Text {
                                text: "Manual Scale:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 4 * scaleFactor
                                
                                Button {
                                    text: "25%"
                                    font.pixelSize: baseFont * 0.8
                                    Layout.preferredWidth: 40 * scaleFactor
                                    onClicked: setManualScale(0.25)
                                }
                                
                                Button {
                                    text: "50%"
                                    font.pixelSize: baseFont * 0.8
                                    Layout.preferredWidth: 40 * scaleFactor
                                    onClicked: setManualScale(0.5)
                                }
                                
                                Button {
                                    text: "100%"
                                    font.pixelSize: baseFont * 0.8
                                    Layout.preferredWidth: 40 * scaleFactor
                                    onClicked: setManualScale(1.0)
                                }
                                
                                Button {
                                    text: "Auto"
                                    font.pixelSize: baseFont * 0.8
                                    Layout.fillWidth: true
                                    onClicked: enableAutoScale()
                                }
                            }
                        }
                    }
                    
                    // Qt Design Studio info
                    GroupBox {
                        Layout.fillWidth: true
                        title: "Qt Design Studio"
                        font.pixelSize: baseFont
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 8 * scaleFactor
                            
                            Text {
                                text: "This viewer displays QML files generated from Qt Design Studio (.ui.qml files)."
                                font.pixelSize: baseFont * 0.8
                                color: mutedTextColor
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }
                            
                            Text {
                                text: "• Interactive UI preview\n• Responsive design testing\n• Real-time updates"
                                font.pixelSize: baseFont * 0.8
                                color: mutedTextColor
                                Layout.fillWidth: true
                            }
                        }
                    }
                    
                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
    
    // Functions
    function loadQmlFile(filePath) {
        console.log("QML Viewer: Loading file:", filePath)
        qmlLoader.source = ""
        Qt.callLater(function() {
            qmlLoader.source = filePath
        })
    }
    
    function reloadQml() {
        console.log("QML Viewer: Reloading QML file")
        var currentSource = qmlLoader.source
        qmlLoader.source = ""
        Qt.callLater(function() {
            qmlLoader.source = currentSource
        })
    }
    
    function toggleResponsiveMode() {
        // Toggle between desktop and mobile preview sizes
        if (qmlContainer.width > 600) {
            qmlContainer.width = 375  // Mobile width
            qmlContainer.height = 667 // Mobile height
        } else {
            qmlContainer.width = qmlScrollView.width
            qmlContainer.height = qmlScrollView.height
        }
    }
    
    function fitToWindow() {
        // Auto-scaling already handles fitting to window
        // Force recalculation of auto-scale
        qmlLoader.autoScale = qmlLoader.calculateAutoScale()
        console.log("QML Viewer: Fit to window - Auto-scale:", qmlLoader.autoScale)
    }
    
    function resetZoom() {
        // Reset to original size (1:1 scale)
        // We can override auto-scale temporarily by setting a fixed scale
        qmlLoader.scale = 1.0
        console.log("QML Viewer: Reset zoom to 1:1 scale")
        
        // Re-enable auto-scaling after a short delay
        Qt.callLater(function() {
            qmlLoader.scale = Qt.binding(function() { return qmlLoader.autoScale })
        })
    }
    
    function setManualScale(scale) {
        // Override auto-scaling with manual scale
        qmlLoader.scale = scale
        console.log("QML Viewer: Manual scale set to:", scale)
        
        // Update scale display
        infoPanel.scaleText.text = Math.round(scale * 100) + "%"
    }
    
    function enableAutoScale() {
        // Re-enable auto-scaling
        qmlLoader.scale = Qt.binding(function() { return qmlLoader.autoScale })
        console.log("QML Viewer: Auto-scaling re-enabled")
        
        // Update scale display
        infoPanel.updateScaleInfo()
    }
    
    // Auto-load the Lifedata.ui.qml when opened
    onVisibleChanged: {
        if (visible) {
            Qt.callLater(function() {
                loadQmlFile("qrc:/qt/qml/VoiceAILLM/resources/templates/Lifedata.ui.qml")
            })
        }
    }
} 