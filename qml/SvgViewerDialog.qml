import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import VoiceAILLM 1.0

ApplicationWindow {
    id: svgViewerWindow
    title: "SVG Life Data Viewer"
    
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
    property color primaryColor: "#2196F3"
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
                text: "SVG Life Data Viewer"
                color: "white"
                font.pixelSize: baseFont * 1.4
                font.weight: Font.Medium
                Layout.fillWidth: true
            }
            
            // Zoom controls
            ToolButton {
                text: "🔍+"
                font.pixelSize: baseFont * 1.2
                onClicked: svgHandler.zoomIn()
                
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
                
                ToolTip.text: "Zoom In"
                ToolTip.visible: hovered
            }
            
            ToolButton {
                text: "🔍-"
                font.pixelSize: baseFont * 1.2
                onClicked: svgHandler.zoomOut()
                
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
                
                ToolTip.text: "Zoom Out"
                ToolTip.visible: hovered
            }
            
            ToolButton {
                text: "⊞"
                font.pixelSize: baseFont * 1.2
                onClicked: svgHandler.zoomToFit()
                
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
                
                ToolTip.text: "Fit to Window"
                ToolTip.visible: hovered
            }
            
            ToolButton {
                text: "↻"
                font.pixelSize: baseFont * 1.2
                onClicked: svgHandler.resetView()
                
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
                
                ToolTip.text: "Reset View"
                ToolTip.visible: hovered
            }
            
            Rectangle {
                width: 1
                height: 30 * scaleFactor
                color: Qt.darker(primaryColor, 1.2)
            }
            
            Button {
                text: "Close"
                onClicked: svgViewerWindow.close()
                
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
        
        // SVG display area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: surfaceColor
            border.color: "#e0e0e0"
            border.width: 1
            radius: 4
            
            SvgHandler {
                id: svgHandler
                anchors.fill: parent
                anchors.margins: 4
                
                // Load the life data SVG from templates
                source: "qrc:/qt/qml/VoiceAILLM/resources/templates/LifeData.svg"
                
                enableZoom: true
                enablePan: true
                
                // Debug visibility
                visible: true
                
                onElementClicked: function(elementId, position) {
                    console.log("SVG Element clicked:", elementId, "at position:", position)
                    infoPanel.updateElementInfo(elementId, position, "clicked")
                }
                
                onElementHovered: function(elementId, position) {
                    console.log("SVG Element hovered:", elementId, "at position:", position)
                    infoPanel.updateElementInfo(elementId, position, "hovered")
                }
                
                onSvgClicked: function(position) {
                    console.log("SVG background clicked at:", position)
                    infoPanel.clearElementInfo()
                }
                
                onViewChanged: function(scale, offset) {
                    infoPanel.updateViewInfo(scale, offset)
                }
                
                Component.onCompleted: {
                    console.log("SvgHandler component created")
                    console.log("SvgHandler source:", source)
                    
                    // Auto-fit the SVG when loaded
                    Qt.callLater(function() {
                        console.log("Attempting to zoom to fit...")
                        zoomToFit()
                    })
                }
                
                onSourceChanged: {
                    console.log("SvgHandler source changed to:", source)
                }
            }
            
            // Fallback display when SVG is not loaded
            Rectangle {
                anchors.fill: parent
                color: "#f0f0f0"
                visible: !svgHandler.visible || svgHandler.source === ""
                
                Column {
                    anchors.centerIn: parent
                    spacing: 16 * scaleFactor
                    
                    Text {
                        text: "⚠️ SVG Loading Issue"
                        font.pixelSize: baseFont * 1.5
                        color: textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    Text {
                        text: "Source: " + svgHandler.source
                        font.pixelSize: baseFont * 0.9
                        color: mutedTextColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode: Text.Wrap
                        width: 400 * scaleFactor
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    Button {
                        text: "Retry Loading"
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            console.log("Manually retrying SVG load...")
                            svgHandler.source = ""
                            Qt.callLater(function() {
                                svgHandler.source = "qrc:/qt/qml/VoiceAILLM/resources/templates/LifeData.svg"
                            })
                        }
                    }
                }
            }
            
            // Zoom indicator overlay
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 12 * scaleFactor
                width: zoomText.width + 16 * scaleFactor
                height: zoomText.height + 8 * scaleFactor
                color: surfaceColor
                border.color: primaryColor
                border.width: 1
                radius: 4
                opacity: 0.9
                
                Text {
                    id: zoomText
                    anchors.centerIn: parent
                    text: `${Math.round(svgHandler.scale * 100)}%`
                    color: textColor
                    font.pixelSize: baseFont * 0.9
                    font.weight: Font.Medium
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
            
            function updateElementInfo(elementId, position, action) {
                elementIdText.text = elementId || "None"
                positionText.text = position ? `(${position.x.toFixed(1)}, ${position.y.toFixed(1)})` : "N/A"
                actionText.text = action || "None"
                lastInteractionText.text = new Date().toLocaleTimeString()
            }
            
            function clearElementInfo() {
                elementIdText.text = "None"
                positionText.text = "N/A"
                actionText.text = "Background clicked"
                lastInteractionText.text = new Date().toLocaleTimeString()
            }
            
            function updateViewInfo(scale, offset) {
                scaleText.text = `${Math.round(scale * 100)}%`
                offsetText.text = `(${offset.x.toFixed(1)}, ${offset.y.toFixed(1)})`
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
                                text: "Source:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                text: "LifeData.svg"
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
                                text: "Interactive Life Data Visualization"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }
                        }
                    }
                    
                    // View info section
                    GroupBox {
                        Layout.fillWidth: true
                        title: "View Information"
                        font.pixelSize: baseFont
                        
                        GridLayout {
                            width: parent.width
                            columns: 2
                            columnSpacing: 8 * scaleFactor
                            rowSpacing: 4 * scaleFactor
                            
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
                            
                            Text {
                                text: "Offset:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: offsetText
                                text: "(0, 0)"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                        }
                    }
                    
                    // Interaction info section
                    GroupBox {
                        Layout.fillWidth: true
                        title: "Interaction"
                        font.pixelSize: baseFont
                        
                        GridLayout {
                            width: parent.width
                            columns: 2
                            columnSpacing: 8 * scaleFactor
                            rowSpacing: 4 * scaleFactor
                            
                            Text {
                                text: "Element:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: elementIdText
                                text: "None"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }
                            
                            Text {
                                text: "Position:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: positionText
                                text: "N/A"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                            
                            Text {
                                text: "Action:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: actionText
                                text: "None"
                                font.pixelSize: baseFont * 0.9
                                color: mutedTextColor
                            }
                            
                            Text {
                                text: "Time:"
                                font.pixelSize: baseFont * 0.9
                                font.weight: Font.Bold
                                color: textColor
                            }
                            
                            Text {
                                id: lastInteractionText
                                text: "N/A"
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
                            
                            CheckBox {
                                text: "Enable Zoom"
                                checked: svgHandler.enableZoom
                                font.pixelSize: baseFont * 0.9
                                onCheckedChanged: svgHandler.enableZoom = checked
                            }
                            
                            CheckBox {
                                text: "Enable Pan"
                                checked: svgHandler.enablePan
                                font.pixelSize: baseFont * 0.9
                                onCheckedChanged: svgHandler.enablePan = checked
                            }
                            
                            Button {
                                Layout.fillWidth: true
                                text: "Reset View"
                                font.pixelSize: baseFont * 0.9
                                onClicked: svgHandler.resetView()
                            }
                            
                            Button {
                                Layout.fillWidth: true
                                text: "Fit to Window"
                                font.pixelSize: baseFont * 0.9
                                onClicked: svgHandler.zoomToFit()
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
} 