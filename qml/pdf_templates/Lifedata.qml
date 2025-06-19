import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: lifeDataReport
    width: 840
    height: 1188  // A4 size in points at 72 DPI
    color: "#e9ecf5"
    
    // Properties for template data binding (populated by QMLPDFGenerator)
    property string title: "Vehicle Diagnostic Report"
    property string report_title: "Vehicle Diagnostic Report"
    property string company: "Vehicle Diagnostics Inc."
    property string email: "info@vehiclediag.com"
    property string tel: "+1-555-0123"
    property string website: "www.vehiclediag.com"
    property string address: "123 Main Street, City, State 12345"
    property string logo: ""
    
    // Vehicle info from JSON
    property string vin: "1HGBH41JXMN109186"
    property string mileage: "85,432 miles"
    property string car_number: "VD-2024-001"
    property string report_time: "2024-06-19 20:00:00"
    property string sn: "VD123456789"
    property string software_version: "v2.1.0"
    
    // Overview from JSON
    property string systems_scanned: "8"
    property string systems_with_dtcs: "2"
    property string total_dtcs: "3"
    
    // Arrays from JSON (will be populated by QMLPDFGenerator)
    property var systems: []
    property var fault_systems: []
    property var system_details: []
    property var battery_test: null
    
    ScrollView {
        anchors.fill: parent
        contentHeight: contentColumn.height
        
        Column {
            id: contentColumn
            width: parent.width
            
            // Main content box
            Rectangle {
                width: parent.width - 20
                anchors.horizontalCenter: parent.horizontalCenter
                height: childrenRect.height + 90  // Extra space for footer
                color: "#ffffff"
                
                Column {
                    width: parent.width
                    spacing: 0
                    
                    // Header Section
                    Item {
                        width: parent.width
                        height: 84
                        
                        Column {
                            anchors.centerIn: parent
                            width: parent.width - 32
                            spacing: 9
                            
                            Text {
                                text: report_title
                                font.pixelSize: 36
                                font.bold: true
                                color: "#000000"
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                topPadding: 27
                            }
                            
                            Rectangle {
                                width: parent.width
                                height: 6
                                color: "#2e4573"
                            }
                            
                            Rectangle {
                                width: parent.width
                                height: 1
                                color: "#2e4573"
                            }
                        }
                    }
                    
                    // Company Info Section
                    Item {
                        width: parent.width
                        height: 140
                        
                        Row {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 20
                            
                            // Logo placeholder
                            Rectangle {
                                width: 188
                                height: 102
                                color: "#f0f0f0"
                                border.color: "#cccccc"
                                border.width: 1
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "LOGO"
                                    color: "#666666"
                                    font.pixelSize: 16
                                }
                            }
                            
                            // Company details
                            Grid {
                                columns: 2
                                columnSpacing: 40
                                rowSpacing: 8
                                width: parent.width - 208
                                
                                Row {
                                    spacing: 10
                                    Text { text: "Company:"; color: "#666666"; font.pixelSize: 16 }
                                    Text { text: company; color: "#000000"; font.pixelSize: 16 }
                                }
                                Row {
                                    spacing: 10
                                    Text { text: "Email:"; color: "#666666"; font.pixelSize: 16 }
                                    Text { text: email; color: "#000000"; font.pixelSize: 16 }
                                }
                                Row {
                                    spacing: 10
                                    Text { text: "Tel:"; color: "#666666"; font.pixelSize: 16 }
                                    Text { text: tel; color: "#000000"; font.pixelSize: 16 }
                                }
                                Row {
                                    spacing: 10
                                    Text { text: "Website:"; color: "#666666"; font.pixelSize: 16 }
                                    Text { text: website; color: "#000000"; font.pixelSize: 16 }
                                }
                            }
                            
                        }
                        
                        // Address (full width)
                        Row {
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.margins: 16
                            spacing: 10
                            Text { text: "Address:"; color: "#666666"; font.pixelSize: 16 }
                            Text { text: address; color: "#000000"; font.pixelSize: 16 }
                        }
                    }
                    
                    // Main content area
                    Column {
                        width: parent.width
                        anchors.margins: 10
                        spacing: 20
                        
                        // Basic Information Section
                        SectionHeader {
                            title: "Basic Information"
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        InformationGrid {
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            model: [
                                {label: "VIN:", value: vin},
                                {label: "Mileage:", value: mileage},
                                {label: "Car Number:", value: car_number},
                                {label: "Report Time:", value: report_time},
                                {label: "SN:", value: sn},
                                {label: "Software Version:", value: software_version}
                            ]
                        }
                        
                        // Scan Overview Section
                        SectionHeader {
                            title: "Scan Overview"
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        Column {
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 12
                            
                            Row {
                                spacing: 5
                                Text { text: "System(s) Scanned:"; color: "#666666"; font.pixelSize: 18 }
                                Text { text: systems_scanned; color: "#000000"; font.pixelSize: 18; font.bold: true }
                                Text { text: ", System(s) with DTCs:"; color: "#666666"; font.pixelSize: 18 }
                                Text { text: systems_with_dtcs; color: "#e20015"; font.pixelSize: 18; font.bold: true }
                                Text { text: ", Total DTCs:"; color: "#666666"; font.pixelSize: 18 }
                                Text { text: total_dtcs; color: "#000000"; font.pixelSize: 18; font.bold: true }
                            }
                            
                            SystemTable {
                                width: parent.width
                                systemsData: systems
                            }
                        }
                        
                        // Fault Codes Section (only show if there are faults)
                        Loader {
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            active: fault_systems && fault_systems.length > 0
                            sourceComponent: Column {
                                spacing: 20
                                
                                SectionHeader {
                                    title: "Fault Codes"
                                    starIcon: true
                                    width: parent.width
                                }
                                
                                Repeater {
                                    model: fault_systems
                                    delegate: FaultSystemTable {
                                        width: parent.width
                                        systemData: modelData
                                    }
                                }
                            }
                        }
                        
                        // System Details Section
                        Loader {
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            active: system_details && system_details.length > 0
                            sourceComponent: Column {
                                spacing: 20
                                
                                Repeater {
                                    model: system_details
                                    delegate: SystemDetailSection {
                                        width: parent.width
                                        systemData: modelData
                                    }
                                }
                            }
                        }
                        
                        // Battery Test Section (only show if battery data exists)
                        Loader {
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            active: battery_test !== null
                            sourceComponent: BatteryTestSection {
                                width: parent.width
                                batteryData: battery_test
                            }
                        }
                        
                        // Footer statement
                        Item {
                            width: parent.width
                            height: 80
                            
                            Text {
                                anchors.centerIn: parent
                                width: parent.width - 40
                                text: "*This report is generated based on the data read from the vehicle's electronic control units. The results are for reference only."
                                color: "#808080"
                                font.pixelSize: 16
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignLeft
                                
                                Text {
                                    text: "*"
                                    color: "#f41717"
                                    font.pixelSize: 16
                                    anchors.left: parent.left
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Custom Components
    component SectionHeader: Item {
        property string title: ""
        property bool starIcon: false
        height: 48
        
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            
            Row {
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10
                
                Rectangle {
                    width: 16
                    height: 18
                    color: "#2E4573"
                    
                    Canvas {
                        anchors.fill: parent
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.fillStyle = "#ffffff";
                            if (starIcon) {
                                // Star shape
                                ctx.beginPath();
                                var cx = width/2, cy = height/2;
                                var spikes = 5, outerRadius = 8, innerRadius = 4;
                                var rotation = Math.PI / 2 * 3;
                                var x = cx, y = cy;
                                var step = Math.PI / spikes;
                                
                                ctx.moveTo(cx, cy - outerRadius);
                                for (var i = 0; i < spikes; i++) {
                                    x = cx + Math.cos(rotation) * outerRadius;
                                    y = cy + Math.sin(rotation) * outerRadius;
                                    ctx.lineTo(x, y);
                                    rotation += step;
                                    x = cx + Math.cos(rotation) * innerRadius;
                                    y = cy + Math.sin(rotation) * innerRadius;
                                    ctx.lineTo(x, y);
                                    rotation += step;
                                }
                                ctx.lineTo(cx, cy - outerRadius);
                                ctx.closePath();
                            } else {
                                // Arrow shape
                                ctx.beginPath();
                                ctx.moveTo(0, 0);
                                ctx.lineTo(width, height/2);
                                ctx.lineTo(0, height);
                                ctx.closePath();
                            }
                            ctx.fill();
                        }
                    }
                }
                
                Text {
                    text: title
                    font.pixelSize: 24
                    color: "#2E4573"
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
        
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: starIcon ? 0 : 32
            width: parent.width - (starIcon ? 0 : 32)
            height: 4
            color: "#2E4573"
        }
        
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -1
            width: parent.width
            height: 1
            color: "#B8C3D9"
        }
    }
    
    component InformationGrid: Flow {
        property var model: []
        spacing: 14
        
        Repeater {
            model: parent.model
            delegate: Row {
                width: (parent.width - parent.spacing) / 2
                spacing: 10
                
                Text {
                    text: modelData.label
                    color: "#666666"
                    font.pixelSize: 18
                    width: 120
                }
                Text {
                    text: modelData.value
                    color: "#000000"
                    font.pixelSize: 18
                    width: parent.width - 130
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
    
    component SystemTable: Column {
        property var systemsData: []
        spacing: 0
        
        // Header
        Rectangle {
            width: parent.width
            height: 54
            color: "#DCE6F5"
            radius: 10
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: parent.height / 2
                color: parent.color
            }
            
            Row {
                anchors.fill: parent
                anchors.margins: 8
                
                Text { text: "No."; width: parent.width * 0.1; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                Text { text: "System Name"; width: parent.width * 0.7; color: "#000"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter; leftPadding: 35 }
                Text { text: "State"; width: parent.width * 0.2; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
            }
        }
        
        // Data rows from JSON
        Repeater {
            model: systemsData
            
            delegate: Rectangle {
                width: parent.width
                height: 54
                color: "transparent"
                border.color: "#cccccc"
                border.width: 1
                
                Row {
                    anchors.fill: parent
                    anchors.margins: 8
                    
                    Text { 
                        text: modelData.no || ""
                        width: parent.width * 0.1
                        color: "#000"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text { 
                        text: modelData.name || ""
                        width: parent.width * 0.7
                        color: "#000"
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 35
                    }
                    Row {
                        width: parent.width * 0.2
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 5
                        
                        Rectangle {
                            width: 17
                            height: 17
                            radius: 8.5
                            color: (modelData.has_faults === true) ? "#f41717" : "#4CAF50"
                            anchors.verticalCenter: parent.verticalCenter
                            
                            Text {
                                anchors.centerIn: parent
                                text: (modelData.has_faults === true) ? "!" : "✓"
                                color: "white"
                                font.pixelSize: 12
                                font.bold: true
                            }
                        }
                        
                        Text { 
                            text: modelData.state || ""
                            color: (modelData.has_faults === true) ? "#f41717" : "#000"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    
    component FaultSystemTable: Column {
        property var systemData: null
        spacing: 12
        
        Text {
            text: (systemData ? systemData.system_name : "") + " (Found " + (systemData && systemData.faults ? systemData.faults.length : 0) + ")"
            color: "#2e4573"
            font.pixelSize: 20
            font.bold: true
            leftPadding: 10
            
            Rectangle {
                width: 4
                height: 14
                color: "#2e4573"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        Column {
            width: parent.width
            spacing: 0
            
            // Header
            Rectangle {
                width: parent.width
                height: 54
                color: "#DCE6F5"
                radius: 10
                
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: parent.height / 2
                    color: parent.color
                }
                
                Row {
                    anchors.fill: parent
                    anchors.margins: 8
                    
                    Text { text: "No."; width: parent.width * 0.1; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: "DTC"; width: parent.width * 0.15; color: "#000"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter; leftPadding: 30 }
                    Text { text: "Description"; width: parent.width * 0.55; color: "#000"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: "Status"; width: parent.width * 0.2; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                }
            }
            
            // Fault rows from JSON
            Repeater {
                model: systemData && systemData.faults ? systemData.faults : []
                
                delegate: Rectangle {
                    width: parent.width
                    height: 54
                    color: "transparent"
                    border.color: "#cccccc"
                    border.width: 1
                    
                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        
                        Text { 
                            text: modelData.no || ""
                            width: parent.width * 0.1
                            color: "#000"
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text { 
                            text: modelData.dtc || ""
                            width: parent.width * 0.15
                            color: "#000"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                            leftPadding: 30
                        }
                        Text { 
                            text: modelData.description || ""
                            width: parent.width * 0.55
                            color: "#000"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                            wrapMode: Text.WordWrap
                        }
                        Text { 
                            text: modelData.status || ""
                            width: parent.width * 0.2
                            color: "#000"
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    
    component SystemDetailSection: Column {
        property var systemData: null
        spacing: 20
        
        SectionHeader {
            title: systemData ? systemData.system_name : ""
            width: parent.width
        }
        
        // ECU Info
        Loader {
            width: parent.width
            active: systemData && systemData.ecu_info
            sourceComponent: Column {
                spacing: 12
                
                Text {
                    text: "ECU Information"
                    color: "#2e4573"
                    font.pixelSize: 20
                    font.bold: true
                    leftPadding: 10
                    
                    Rectangle {
                        width: 4
                        height: 14
                        color: "#2e4573"
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                Grid {
                    columns: 2
                    columnSpacing: 40
                    rowSpacing: 8
                    width: parent.width
                    
                    Row {
                        spacing: 10
                        Text { text: "ECU Part Number:"; color: "#666666"; font.pixelSize: 18; width: 180 }
                        Text { text: systemData.ecu_info.part_number || ""; color: "#000000"; font.pixelSize: 18 }
                    }
                    Row {
                        spacing: 10
                        Text { text: "Calibration ID:"; color: "#666666"; font.pixelSize: 18; width: 180 }
                        Text { text: systemData.ecu_info.calibration_id || ""; color: "#000000"; font.pixelSize: 18 }
                    }
                    Row {
                        spacing: 10
                        Text { text: "Hardware Number:"; color: "#666666"; font.pixelSize: 18; width: 180 }
                        Text { text: systemData.ecu_info.hardware_number || ""; color: "#000000"; font.pixelSize: 18 }
                    }
                    Row {
                        spacing: 10
                        Text { text: "Software Version:"; color: "#666666"; font.pixelSize: 18; width: 180 }
                        Text { text: systemData.ecu_info.software_version || ""; color: "#000000"; font.pixelSize: 18 }
                    }
                }
            }
        }
        
        // Data Stream
        Loader {
            width: parent.width
            active: systemData && systemData.data_stream
            sourceComponent: DataStreamTable {
                width: parent.width
                title: "Data Stream"
                dataStreamArray: systemData.data_stream
            }
        }
    }
    
    component DataStreamTable: Column {
        property string title: ""
        property var dataStreamArray: []
        spacing: 12
        
        Text {
            text: title + " (Found " + dataStreamArray.length + ")"
            color: "#2e4573"
            font.pixelSize: 20
            font.bold: true
            leftPadding: 10
            
            Rectangle {
                width: 4
                height: 14
                color: "#2e4573"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        Column {
            width: parent.width
            spacing: 0
            
            // Header
            Rectangle {
                width: parent.width
                height: 54
                color: "#DCE6F5"
                radius: 10
                
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: parent.height / 2
                    color: parent.color
                }
                
                Row {
                    anchors.fill: parent
                    anchors.margins: 8
                    
                    Text { text: "No."; width: parent.width * 0.1; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: "Name"; width: parent.width * 0.5; color: "#000"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter; leftPadding: 37 }
                    Text { text: "Value"; width: parent.width * 0.25; color: "#000"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: "Unit"; width: parent.width * 0.15; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                }
            }
            
            // Data rows from JSON
            Repeater {
                model: dataStreamArray
                
                delegate: Rectangle {
                    width: parent.width
                    height: 54
                    color: "transparent"
                    border.color: "#cccccc"
                    border.width: 1
                    
                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        
                        Text { 
                            text: modelData.no || ""
                            width: parent.width * 0.1
                            color: "#000"
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text { 
                            text: modelData.name || ""
                            width: parent.width * 0.5
                            color: "#000"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                            leftPadding: 37
                        }
                        Text { 
                            text: modelData.value || ""
                            width: parent.width * 0.25
                            color: "#000"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text { 
                            text: modelData.unit || ""
                            width: parent.width * 0.15
                            color: "#000"
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    
    component BatteryTestSection: Column {
        property var batteryData: null
        spacing: 20
        
        SectionHeader {
            title: "Battery Pack Test"
            width: parent.width
        }
        
        // Pack Information
        Column {
            spacing: 12
            width: parent.width
            
            Text {
                text: "Pack Information"
                color: "#2e4573"
                font.pixelSize: 20
                font.bold: true
                leftPadding: 10
                
                Rectangle {
                    width: 4
                    height: 14
                    color: "#2e4573"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            
            Grid {
                columns: 2
                columnSpacing: 40
                rowSpacing: 8
                width: parent.width
                
                Row {
                    spacing: 10
                    Text { text: "State of Charge (SOC):"; color: "#666666"; font.pixelSize: 18; width: 200 }
                    Text { text: batteryData ? batteryData.soc : ""; color: "#000000"; font.pixelSize: 18 }
                }
                Row {
                    spacing: 10
                    Text { text: "State of Health (SOH):"; color: "#666666"; font.pixelSize: 18; width: 200 }
                    Text { text: batteryData ? batteryData.soh : ""; color: "#000000"; font.pixelSize: 18 }
                }
                Row {
                    spacing: 10
                    Text { text: "Total Voltage:"; color: "#666666"; font.pixelSize: 18; width: 200 }
                    Text { text: batteryData ? batteryData.total_voltage : ""; color: "#000000"; font.pixelSize: 18 }
                }
                Row {
                    spacing: 10
                    Text { text: "Total Current:"; color: "#666666"; font.pixelSize: 18; width: 200 }
                    Text { text: batteryData ? batteryData.total_current : ""; color: "#000000"; font.pixelSize: 18 }
                }
            }
        }
        
        // Cell Voltages
        Loader {
            width: parent.width
            active: batteryData && batteryData.cell_voltages
            sourceComponent: Column {
                spacing: 12
                
                Text {
                    text: "Cell Voltages"
                    color: "#2e4573"
                    font.pixelSize: 20
                    font.bold: true
                    leftPadding: 10
                    
                    Rectangle {
                        width: 4
                        height: 14
                        color: "#2e4573"
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                Column {
                    width: parent.width
                    spacing: 0
                    
                    // Header
                    Rectangle {
                        width: parent.width
                        height: 54
                        color: "#DCE6F5"
                        radius: 10
                        
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: parent.height / 2
                            color: parent.color
                        }
                        
                        Row {
                            anchors.fill: parent
                            anchors.margins: 8
                            
                            Text { text: "Cell Group"; width: parent.width * 0.25; color: "#000"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "Cell 1"; width: parent.width * 0.25; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "Cell 2"; width: parent.width * 0.25; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "Cell 3"; width: parent.width * 0.25; color: "#000"; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter; anchors.verticalCenter: parent.verticalCenter }
                        }
                    }
                    
                    // Cell voltage rows
                    Repeater {
                        model: batteryData ? batteryData.cell_voltages : []
                        
                        delegate: Rectangle {
                            width: parent.width
                            height: 54
                            color: "transparent"
                            border.color: "#cccccc"
                            border.width: 1
                            
                            Row {
                                anchors.fill: parent
                                anchors.margins: 8
                                
                                Text { 
                                    text: modelData.module || ""
                                    width: parent.width * 0.25
                                    color: "#000"
                                    font.pixelSize: 18
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text { 
                                    text: modelData.cell1 || ""
                                    width: parent.width * 0.25
                                    color: "#000"
                                    font.pixelSize: 18
                                    horizontalAlignment: Text.AlignHCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text { 
                                    text: modelData.cell2 || ""
                                    width: parent.width * 0.25
                                    color: "#000"
                                    font.pixelSize: 18
                                    horizontalAlignment: Text.AlignHCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text { 
                                    text: modelData.cell3 || ""
                                    width: parent.width * 0.25
                                    color: "#000"
                                    font.pixelSize: 18
                                    horizontalAlignment: Text.AlignHCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
} 