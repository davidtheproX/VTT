import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Pdf

ApplicationWindow {
    id: pdfViewerWindow
    title: "PDF Viewer"
    width: 800
    height: 600
    
    property string pdfFilePath: ""
    property color backgroundColor: "#2b2b2b"
    property color surfaceColor: "#3c3c3c"
    property color primaryColor: "#007acc"
    property color textColor: "#ffffff"
    property color mutedTextColor: "#bbbbbb"
    
    // PDF status tracking
    property bool pdfLoaded: pdfDocument.status === PdfDocument.Ready
    property real zoomFactor: 1.0
    
    // PDF Document
    PdfDocument {
        id: pdfDocument
        source: pdfFilePath ? "file:///" + pdfFilePath : ""
        
        onStatusChanged: {
            console.log("PDF Document status changed:", status);
            if (status === PdfDocument.Ready) {
                console.log("PDF loaded successfully. Page count:", pageCount);
            } else if (status === PdfDocument.Error) {
                console.log("PDF load failed:", error);
            }
        }
    }
    
    // Function to load PDF
    function loadPDF(filePath) {
        console.log("*** PDFViewer.loadPDF called with:", filePath);
        pdfFilePath = filePath;
        console.log("*** PDFViewer.pdfFilePath set to:", pdfFilePath);
    }
    
    color: backgroundColor
    
    header: ToolBar {
        background: Rectangle {
            color: surfaceColor
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 8
            
            Text {
                text: pdfFilePath ? pdfFilePath.split('/').pop() : "PDF Viewer"
                color: textColor
                font.bold: true
                Layout.fillWidth: true
            }
            
            Text {
                text: pdfLoaded ? `Page ${pdfMultiPageView.currentPage + 1} of ${pdfDocument.pageCount}` : "No PDF"
                color: mutedTextColor
                font.pixelSize: 11
                Layout.preferredWidth: 120
            }
            
            Button {
                text: "Zoom In"
                enabled: pdfLoaded
                onClicked: {
                    zoomFactor = Math.min(zoomFactor * 1.2, 3.0);
                    pdfMultiPageView.renderScale = zoomFactor;
                }
            }
            
            Text {
                text: pdfLoaded ? Math.round(zoomFactor * 100) + "%" : "No PDF"
                color: textColor
                font.pixelSize: 12
            }
            
            Button {
                text: "Zoom Out"
                enabled: pdfLoaded
                onClicked: {
                    zoomFactor = Math.max(zoomFactor / 1.2, 0.5);
                    pdfMultiPageView.renderScale = zoomFactor;
                }
            }
            
            Button {
                text: "Reset Zoom"
                enabled: pdfLoaded
                onClicked: {
                    zoomFactor = 1.0;
                    pdfMultiPageView.renderScale = zoomFactor;
                }
            }
            
            Button {
                text: "Fit Width"
                enabled: pdfLoaded
                onClicked: {
                    pdfMultiPageView.renderScale = pdfMultiPageView.width / pdfDocument.pagePointSize(pdfMultiPageView.currentPage).width * 72;
                    zoomFactor = pdfMultiPageView.renderScale;
                }
            }
            
            Button {
                text: "Close"
                onClicked: pdfViewerWindow.close()
            }
        }
    }
    
    Rectangle {
        anchors.fill: parent
        color: backgroundColor
        
        PdfMultiPageView {
            id: pdfMultiPageView
            anchors.fill: parent
            anchors.margins: 5
            
            document: pdfDocument
            renderScale: zoomFactor
            
            // Enable selection
            property bool selectionEnabled: true
            
            Component.onCompleted: {
                console.log("PdfMultiPageView initialized");
            }
            
            onCurrentPageChanged: {
                console.log("Current page changed to:", currentPage);
            }
        }
        
        // Loading overlay
        Rectangle {
            anchors.centerIn: parent
            width: 200
            height: 80
            color: surfaceColor
            radius: 8
            border.color: primaryColor
            border.width: 2
            visible: !pdfLoaded && pdfFilePath === ""
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 10
                
                Text {
                    text: "📄"
                    font.pixelSize: 32
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "No PDF Loaded"
                    color: textColor
                    font.pixelSize: 14
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Select a PDF file to view"
                    color: mutedTextColor
                    font.pixelSize: 11
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
        
        // Loading indicator when PDF is loading
        Rectangle {
            anchors.centerIn: parent
            width: 150
            height: 60
            color: surfaceColor
            radius: 6
            border.color: primaryColor
            border.width: 1
            visible: pdfFilePath !== "" && pdfDocument.status === PdfDocument.Loading
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 8
                
                Text {
                    text: "Loading PDF..."
                    color: textColor
                    font.pixelSize: 12
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Rectangle {
                    width: 100
                    height: 3
                    color: Qt.lighter(mutedTextColor, 1.5)
                    radius: 1
                    Layout.alignment: Qt.AlignHCenter
                    
                    Rectangle {
                        width: parent.width * 0.6
                        height: parent.height
                        color: primaryColor
                        radius: 1
                        
                        PropertyAnimation on x {
                            from: -width
                            to: parent.width
                            duration: 1200
                            loops: Animation.Infinite
                        }
                    }
                }
            }
        }
        
        // Error overlay
        Rectangle {
            anchors.centerIn: parent
            width: 300
            height: 120
            color: surfaceColor
            radius: 8
            border.color: "#d32f2f"
            border.width: 2
            visible: pdfDocument.status === PdfDocument.Error
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 10
                
                Text {
                    text: "❌"
                    font.pixelSize: 32
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "PDF Load Error"
                    color: "#d32f2f"
                    font.pixelSize: 14
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Could not load the PDF file"
                    color: mutedTextColor
                    font.pixelSize: 11
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Button {
                    text: "Retry"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        pdfDocument.source = "";
                        pdfDocument.source = "file:///" + pdfFilePath;
                    }
                }
            }
        }
    }
} 