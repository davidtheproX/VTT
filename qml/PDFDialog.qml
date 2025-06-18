import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Window

ApplicationWindow {
    id: pdfDialog
    title: "PDF Tools"
    modality: Qt.ApplicationModal
    flags: Qt.Dialog | Qt.WindowCloseButtonHint
    
    width: 600
    height: 700
    minimumWidth: 500
    minimumHeight: 600
    
    // Center on screen
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    
    visible: false
    
    property var pdfManager
    
    // Theme properties - inherited from Main.qml
    property color backgroundColor: "#FAFAFA"
    property color surfaceColor: "#FFFFFF"
    property color primaryColor: "#2196F3"
    property color successColor: "#4CAF50"
    property color errorColor: "#F44336"
    property color textColor: "#212121"
    property color mutedTextColor: "#757575"
    
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
    
    // Header
    header: Rectangle {
        height: 50
        color: primaryColor
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            
            Text {
                text: "PDF Tools"
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
                
                onClicked: pdfDialog.close()
            }
        }
    }
    
    // File dialog for PDF selection
    FileDialog {
        id: pdfFileDialog
        title: "Select PDF File"
        nameFilters: ["PDF files (*.pdf)"]
        fileMode: FileDialog.OpenFile
        onAccepted: {
            console.log("FileDialog accepted!");
            console.log("FileDialog selectedFile:", selectedFile);
            console.log("FileDialog currentFile:", currentFile);
            console.log("FileDialog selectedFiles:", selectedFiles);
            
            var filePath = "";
            if (selectedFiles && selectedFiles.length > 0) {
                filePath = selectedFiles[0];
            } else if (selectedFile) {
                filePath = selectedFile;
            } else if (currentFile) {
                filePath = currentFile;
            }
            
            console.log("Final filePath:", filePath);
            
            if (pdfManager && filePath) {
                // Convert URL to local path if needed
                var filePathStr = filePath.toString();
                if (filePathStr.startsWith("file:///")) {
                    filePathStr = filePathStr.replace("file:///", "");
                    // Fix Windows path format
                    if (filePathStr.indexOf(":") === 1) {
                        // This is a Windows path like C:/path
                        // No additional changes needed
                    }
                }
                console.log("Calling pdfManager.openPdfFile with:", filePathStr);
                pdfManager.openPdfFile(filePathStr);
            } else {
                console.log("No file selected or pdfManager not available");
                console.log("pdfManager:", pdfManager);
                console.log("filePath:", filePath);
            }
        }
        onRejected: {
            console.log("FileDialog rejected/cancelled");
        }
    }
    
    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        
        ColumnLayout {
            width: parent.width
            spacing: 20
            
            // PDF Generation Section
            GroupBox {
                Layout.fillWidth: true
                title: "Generate PDF from JSON"
                
                background: Rectangle {
                    color: surfaceColor
                    radius: 6
                    border.color: Qt.lighter(surfaceColor, 1.3)
                    border.width: 1
                }
                
                label: Text {
                    text: parent.title
                    color: primaryColor
                    font.bold: true
                    font.pixelSize: 14
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 12
                    
                    Text {
                        text: "Enter JSON data to generate a PDF report:"
                        color: textColor
                        font.pixelSize: 12
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }
                    
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200
                        
                        TextArea {
                            id: jsonInput
                            placeholderText: `{
    "document_title": "Sample Report",
    "company_logo": "ACME",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+1234567890",
    "address": "123 Main St, City",
    "description": "This is a sample description",
    "table_data": [
        {"item": "Item 1", "description": "Description 1", "quantity": "2", "price": "$10.00", "total": "$20.00"}
    ],
    "subtotal": "$20.00",
    "tax": "$2.00",
    "total": "$22.00"
}`
                            wrapMode: TextArea.Wrap
                            selectByMouse: true
                            font.family: "Consolas, Monaco, monospace"
                            font.pixelSize: 11
                            color: textColor
                            
                            background: Rectangle {
                                color: Qt.darker(surfaceColor, 1.1)
                                border.color: jsonInput.activeFocus ? primaryColor : Qt.lighter(mutedTextColor, 1.5)
                                border.width: 1
                                radius: 4
                            }
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Button {
                            text: "Validate JSON"
                            enabled: jsonInput.text.trim().length > 0
                            
                            onClicked: {
                                if (pdfManager) {
                                    var isValid = pdfManager.isValidJson(jsonInput.text);
                                    validationStatus.text = isValid ? "✓ Valid JSON" : "✗ Invalid JSON";
                                    validationStatus.color = isValid ? successColor : errorColor;
                                }
                            }
                        }
                        
                        Text {
                            id: validationStatus
                            Layout.fillWidth: true
                            font.pixelSize: 11
                            wrapMode: Text.WordWrap
                        }
                    }
                    
                    Button {
                        text: pdfManager && pdfManager.isGenerating ? "Generating..." : "Generate PDF"
                        enabled: jsonInput.text.trim().length > 0 && !(pdfManager && pdfManager.isGenerating)
                        Layout.fillWidth: true
                        
                        onClicked: {
                            if (pdfManager) {
                                pdfManager.generatePdfFromJson(jsonInput.text);
                            }
                        }
                    }
                    
                    // QML-based PDF Generation
                    Text {
                        text: "Alternative QML-based PDF generation (without WebEngine dependency):"
                        color: mutedTextColor
                        font.pixelSize: 11
                        font.italic: true
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.topMargin: 8
                    }
                    
                    Button {
                        text: pdfManager && pdfManager.isGenerating ? "Generating QML PDF..." : "Generate QML PDF"
                        enabled: jsonInput.text.trim().length > 0 && !(pdfManager && pdfManager.isGenerating)
                        Layout.fillWidth: true
                        
                        background: Rectangle {
                            color: parent.enabled ? 
                                   (parent.pressed ? Qt.darker(successColor, 1.2) : 
                                    parent.hovered ? Qt.lighter(successColor, 1.1) : successColor) :
                                   Qt.lighter(mutedTextColor, 1.3)
                            radius: 4
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: parent.enabled ? "white" : mutedTextColor
                            font: parent.font
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            if (pdfManager && pdfManager.generatePdfFromJsonQML) {
                                pdfManager.generatePdfFromJsonQML(jsonInput.text);
                            }
                        }
                    }
                }
            }
            
            // PDF Viewer Section
            GroupBox {
                Layout.fillWidth: true
                title: "PDF Viewer"
                
                background: Rectangle {
                    color: surfaceColor
                    radius: 6
                    border.color: Qt.lighter(surfaceColor, 1.3)
                    border.width: 1
                }
                
                label: Text {
                    text: parent.title
                    color: primaryColor
                    font.bold: true
                    font.pixelSize: 14
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 12
                    
                    Text {
                        text: "Open and view PDF files:"
                        color: textColor
                        font.pixelSize: 12
                        Layout.fillWidth: true
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12
                        
                        Button {
                            text: "Select PDF File"
                            Layout.fillWidth: true
                            
                            background: Rectangle {
                                color: parent.pressed ? Qt.darker(primaryColor, 1.2) : 
                                       parent.hovered ? Qt.lighter(primaryColor, 1.1) : primaryColor
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
                                pdfFileDialog.open();
                            }
                        }
                        
                        Button {
                            text: "View Last Generated"
                            enabled: pdfManager && pdfManager.currentPdfPath.length > 0
                            Layout.fillWidth: true
                            
                            background: Rectangle {
                                color: parent.enabled ? 
                                       (parent.pressed ? Qt.darker(successColor, 1.2) : 
                                        parent.hovered ? Qt.lighter(successColor, 1.1) : successColor) :
                                       Qt.lighter(mutedTextColor, 1.3)
                                radius: 4
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: parent.enabled ? "white" : mutedTextColor
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: {
                                if (pdfManager && pdfManager.currentPdfPath) {
                                    pdfManager.openPdfFile(pdfManager.currentPdfPath);
                                }
                            }
                        }
                    }
                    
                    // PDF Status
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 60
                        color: Qt.darker(surfaceColor, 1.1)
                        radius: 4
                        border.color: Qt.lighter(surfaceColor, 1.3)
                        border.width: 1
                        
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            
                            Text {
                                text: "Status:"
                                color: textColor
                                font.bold: true
                                font.pixelSize: 11
                            }
                            
                            Text {
                                text: {
                                    if (!pdfManager) return "PDF Manager not available";
                                    if (pdfManager.isGenerating) return "Generating PDF...";
                                    if (pdfManager.isViewerOpen) return "PDF Viewer is open";
                                    if (pdfManager.currentPdfPath.length > 0) 
                                        return "Last generated: " + pdfManager.currentPdfPath.split('/').pop();
                                    return "Ready";
                                }
                                color: mutedTextColor
                                font.pixelSize: 10
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
            
            // Sample JSON Templates
            GroupBox {
                Layout.fillWidth: true
                title: "Sample Templates"
                
                background: Rectangle {
                    color: surfaceColor
                    radius: 6
                    border.color: Qt.lighter(surfaceColor, 1.3)
                    border.width: 1
                }
                
                label: Text {
                    text: parent.title
                    color: primaryColor
                    font.bold: true
                    font.pixelSize: 14
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 8
                    
                    Text {
                        text: "Quick templates to get started:"
                        color: textColor
                        font.pixelSize: 12
                        Layout.fillWidth: true
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Button {
                            text: "Diagnostic Template"
                            Layout.fillWidth: true
                            
                            background: Rectangle {
                                color: parent.pressed ? Qt.darker(mutedTextColor, 1.2) : 
                                       parent.hovered ? Qt.lighter(mutedTextColor, 1.1) : mutedTextColor
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
                                jsonInput.text = `{
    "title": "Diagnostic Report",
    "report_title": "Nissan Skyline Diagnostic Report",
    "logo": "https://via.placeholder.com/180x100.png?text=Garage+Tokyo",
    "company": "Garage Tokyo Auto",
    "tel": "03-1234-5678",
    "address": "1-1 Chiyoda, Chiyoda-ku, Tokyo",
    "email": "contact@garagetokyo.jp",
    "website": "www.garagetokyo.jp",
    "vin": "JN8AS51E78T000123",
    "car_number": "品川 300 あ 12-34",
    "mileage": "54,321km",
    "sn": "9898712345678",
    "report_time": "2025-06-11 13:34:15",
    "software_version": "V2.86_3.01",
    "systems_scanned": "14",
    "systems_with_dtcs": "2",
    "total_dtcs": "3",
    "systems": [
        {"number": "1", "name": "Engine Control Module (ECM)", "state": "2", "has_fault": true},
        {"number": "2", "name": "Transmission Control Module (TCM)", "state": "1", "has_fault": true},
        {"number": "3", "name": "Anti-lock Brake System (ABS)", "state": "", "has_fault": false},
        {"number": "4", "name": "Body Control Module (BCM)", "state": "", "has_fault": false}
    ],
    "fault_systems": [
        {
            "system_name": "Engine Control Module (ECM)",
            "fault_count": "2",
            "faults": [
                {"number": "1", "dtc": "P0300", "description": "Random/Multiple Cylinder Misfire Detected", "status": "Active"},
                {"number": "2", "dtc": "P0171", "description": "System Too Lean (Bank 1)", "status": "Pending"}
            ]
        },
        {
            "system_name": "Transmission Control Module (TCM)",
            "fault_count": "1",
            "faults": [
                {"number": "1", "dtc": "U0100", "description": "Lost Communication With ECM/PCM \\"A\\"", "status": "History"}
            ]
        }
    ],
    "system_details": [
        {
            "system_name": "Engine Control Module (ECM)",
            "ecu_info": true,
            "data_stream": [
                {"number": "1", "name": "Coolant Temperature", "value": "95", "unit": "°C"},
                {"number": "2", "name": "Engine RPM", "value": "750", "unit": "rpm"},
                {"number": "3", "name": "Vehicle Speed", "value": "0", "unit": "km/h"}
            ]
        }
    ],
    "battery_test": {
        "battery_info_pairs": [
            [
                {"label": "State of Charge (SOC)", "value": "85.5%"},
                {"label": "State of Health (SOH)", "value": "96.2%"}
            ],
            [
                {"label": "Total Voltage", "value": "398.4 V"},
                {"label": "Total Current", "value": "-0.5 A"}
            ]
        ],
        "cell_voltages": [
            {"module": "Module 1", "cell1": "4.12 V", "cell2": "4.11 V", "cell3": "4.12 V"},
            {"module": "Module 2", "cell1": "4.10 V", "cell2": "4.11 V", "cell3": "4.11 V"}
        ]
    }
}`;
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Connections for PDF Manager signals
    Connections {
        target: pdfManager
        
        function onPdfGenerated(filePath, success) {
            if (success) {
                validationStatus.text = "✓ PDF generated successfully: " + filePath.split('/').pop();
                validationStatus.color = successColor;
            } else {
                validationStatus.text = "✗ PDF generation failed";
                validationStatus.color = errorColor;
            }
        }
        
        function onPdfGenerationFailed(error) {
            validationStatus.text = "✗ Error: " + error;
            validationStatus.color = errorColor;
        }
        
        function onError(message) {
            validationStatus.text = "✗ " + message;
            validationStatus.color = errorColor;
        }
    }
} 