import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    title: "Interactive SVG Viewer"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Toolbar
        ToolBar {
            Layout.fillWidth: true
            
            RowLayout {
                anchors.fill: parent
                
                ToolButton {
                    text: "Open"
                    onClicked: fileDialog.open()
                }
                
                ToolSeparator {}
                
                ToolButton {
                    text: "Zoom In"
                    onClicked: svgViewer.zoomIn()
                }
                
                ToolButton {
                    text: "Zoom Out"
                    onClicked: svgViewer.zoomOut()
                }
                
                ToolButton {
                    text: "Fit"
                    onClicked: svgViewer.zoomToFit()
                }
                
                ToolButton {
                    text: "Reset"
                    onClicked: svgViewer.resetView()
                }
                
                ToolSeparator {}
                
                CheckBox {
                    text: "Enable Zoom"
                    checked: svgViewer.enableZoom
                    onCheckedChanged: svgViewer.enableZoom = checked
                }
                
                CheckBox {
                    text: "Enable Pan"
                    checked: svgViewer.enablePan
                    onCheckedChanged: svgViewer.enablePan = checked
                }
                
                Item { Layout.fillWidth: true }
                
                Label {
                    text: `Scale: ${svgViewer.scale.toFixed(2)}x`
                }
            }
        }

        // Main content area
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // SVG viewer
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#f0f0f0"
                border.color: "#ccc"
                border.width: 1

                SvgHandler {
                    id: svgViewer
                    anchors.fill: parent
                    source: "qrc:/example.svg" // Default SVG
                    
                    onElementClicked: function(elementId, position) {
                        console.log("Element clicked:", elementId, "at", position)
                        elementInfo.text = `Clicked: ${elementId} at (${position.x.toFixed(1)}, ${position.y.toFixed(1)})`
                        highlightedElementField.text = elementId
                    }
                    
                    onElementHovered: function(elementId, position) {
                        console.log("Element hovered:", elementId, "at", position)
                        hoverInfo.text = `Hovering: ${elementId}`
                    }
                    
                    onSvgClicked: function(position) {
                        console.log("SVG background clicked at", position)
                        elementInfo.text = `Background clicked at (${position.x.toFixed(1)}, ${position.y.toFixed(1)})`
                    }
                    
                    onViewChanged: function(scale, offset) {
                        scaleSlider.value = scale
                    }
                }
                
                // Overlay controls
                Rectangle {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 10
                    width: 150
                    height: zoomControls.height + 20
                    color: "white"
                    border.color: "#ccc"
                    radius: 5
                    opacity: 0.9
                    
                    Column {
                        id: zoomControls
                        anchors.centerIn: parent
                        spacing: 5
                        
                        Label {
                            text: "Zoom Control"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        Slider {
                            id: scaleSlider
                            from: 0.1
                            to: 5.0
                            value: svgViewer.scale
                            onValueChanged: {
                                if (Math.abs(value - svgViewer.scale) > 0.01) {
                                    svgViewer.scale = value
                                }
                            }
                        }
                        
                        Label {
                            text: `${(scaleSlider.value * 100).toFixed(0)}%`
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }

            // Side panel
            Rectangle {
                Layout.preferredWidth: 250
                Layout.fillHeight: true
                color: "white"
                border.color: "#ccc"
                border.width: 1

                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 10

                    Column {
                        width: parent.width
                        spacing: 10

                        GroupBox {
                            title: "File Info"
                            width: parent.width
                            
                            Column {
                                width: parent.width
                                spacing: 5
                                
                                Label {
                                    text: "Source:"
                                    font.bold: true
                                }
                                
                                Label {
                                    text: svgViewer.source
                                    wrapMode: Text.Wrap
                                    width: parent.width
                                }
                            }
                        }

                        GroupBox {
                            title: "Interaction"
                            width: parent.width
                            
                            Column {
                                width: parent.width
                                spacing: 5
                                
                                Label {
                                    id: elementInfo
                                    text: "Click on SVG elements..."
                                    wrapMode: Text.Wrap
                                    width: parent.width
                                }
                                
                                Label {
                                    id: hoverInfo
                                    text: "Hover info will appear here"
                                    wrapMode: Text.Wrap
                                    width: parent.width
                                    color: "blue"
                                }
                            }
                        }

                        GroupBox {
                            title: "Element Control"
                            width: parent.width
                            
                            Column {
                                width: parent.width
                                spacing: 5
                                
                                Label {
                                    text: "Highlight Element:"
                                    font.bold: true
                                }
                                
                                TextField {
                                    id: highlightedElementField
                                    width: parent.width
                                    placeholderText: "Enter element ID"
                                    onTextChanged: svgViewer.highlightedElement = text
                                }
                                
                                Button {
                                    text: "Clear Highlight"
                                    onClicked: {
                                        highlightedElementField.text = ""
                                        svgViewer.highlightedElement = ""
                                    }
                                }
                            }
                        }

                        GroupBox {
                            title: "Elements List"
                            width: parent.width
                            
                            ListView {
                                width: parent.width
                                height: Math.min(200, contentHeight)
                                model: svgViewer.getElementIds()
                                
                                delegate: ItemDelegate {
                                    width: parent.width
                                    text: modelData
                                    
                                    onClicked: {
                                        svgViewer.highlightedElement = modelData
                                        highlightedElementField.text = modelData
                                    }
                                }
                            }
                        }

                        GroupBox {
                            title: "View Transform"
                            width: parent.width
                            
                            Grid {
                                columns: 2
                                spacing: 5
                                width: parent.width
                                
                                Label { text: "Scale:" }
                                Label { text: svgViewer.scale.toFixed(3) }
                                
                                Label { text: "Offset X:" }
                                Label { text: svgViewer.offset.x.toFixed(1) }
                                
                                Label { text: "Offset Y:" }
                                Label { text: svgViewer.offset.y.toFixed(1) }
                            }
                        }
                    }
                }
            }
        }
    }

    // File dialog for opening SVG files
    FileDialog {
        id: fileDialog
        title: "Select SVG File"
        nameFilters: ["SVG files (*.svg)", "All files (*)"]
        onAccepted: {
            svgViewer.source = selectedFile
        }
    }
}