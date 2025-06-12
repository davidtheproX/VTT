import QtQuick

Rectangle {
    id: root
    width: 840  // A4 width at ~300 DPI
    height: 1188 // A4 height at ~300 DPI
    color: "#e9ecf5"
    
    // Properties to be populated with data
    property string title: ""
    property string report_title: ""
    property string company: ""
    property string email: ""
    property string tel: ""
    property string website: ""
    property string address: ""
    property string vin: ""
    property string mileage: ""
    property string car_number: ""
    property string report_time: ""
    property string sn: ""
    property string software_version: ""
    property string systems_scanned: ""
    property string systems_with_dtcs: ""
    property string total_dtcs: ""
    
    property var systemsList: []
    property var faultSystemsList: []
    property var systemDetailsList: []
    property var batteryTestData: ({})
    
    Flickable {
        id: contentFlickable
        anchors.fill: parent
        contentHeight: contentColumn.height
        
        Column {
            id: contentColumn
            width: parent.width
            
            // Content Box
            Rectangle {
                width: parent.width - 20
                anchors.horizontalCenter: parent.horizontalCenter
                height: childrenRect.height + 180 // padding bottom
                color: "white"
                
                Column {
                    width: parent.width
                    
                    // Header
                    Rectangle {
                        id: header
                        width: parent.width
                        height: 120
                        color: "transparent"
                        
                        Column {
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: 0
                            anchors.verticalCenterOffset: 10
                            
                            Text {
                                id: titleText
                                text: root.report_title
                                font.pixelSize: 36
                                font.bold: true
                                color: "#000000"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Rectangle {
                                width: header.width - 32
                                height: 6
                                color: "#2e4573"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.topMargin: 9
                            }
                            
                            Rectangle {
                                width: header.width - 32
                                height: 1
                                color: "#2e4573"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.topMargin: 4
                            }
                        }
                    }
                    
                    // Basic Info Section
                    Rectangle {
                        width: parent.width
                        height: 120
                        color: "transparent"
                        
                        Row {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 20
                            
                            // Logo placeholder
                            Rectangle {
                                width: 188
                                height: 102
                                color: "#f0f0f0"
                                border.color: "#ccc"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "LOGO"
                                    color: "#666"
                                    font.pixelSize: 16
                                }
                            }
                            
                            // Company info grid - Replace InfoField with Row elements
                            Grid {
                                columns: 2
                                columnSpacing: 20
                                rowSpacing: 10
                                anchors.verticalCenter: parent.verticalCenter
                                
                                Row {
                                    spacing: 10
                                    Text { text: "Company:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                    Text { text: root.company; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                                }
                                Row {
                                    spacing: 10
                                    Text { text: "Email:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                    Text { text: root.email; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                                }
                                Row {
                                    spacing: 10
                                    Text { text: "Tel:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                    Text { text: root.tel; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                                }
                                Row {
                                    spacing: 10
                                    Text { text: "Website:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                    Text { text: root.website; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                                }
                            }
                            
                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 228 - 40
                                
                                Row {
                                    spacing: 10
                                    Text { text: "Address:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                    Text { text: root.address; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap; width: parent.width - 130 }
                                }
                            }
                        }
                    }
                    
                    // Basic Information Section
                    Column {
                        width: parent.width
                        anchors.margins: 10
                        
                        Rectangle {
                            height: 40
                            color: "#2e4573"
                            
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Basic Information"
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                            }
                        }
                        
                        Grid {
                            columns: 2
                            columnSpacing: 20
                            rowSpacing: 14
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - 20
                            
                            Row {
                                spacing: 10
                                Text { text: "VIN:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                Text { text: root.vin; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                            }
                            Row {
                                spacing: 10
                                Text { text: "Mileage:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                Text { text: root.mileage; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                            }
                            Row {
                                spacing: 10
                                Text { text: "Car Number:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                Text { text: root.car_number; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                            }
                            Row {
                                spacing: 10
                                Text { text: "Report Time:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                Text { text: root.report_time; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                            }
                            Row {
                                spacing: 10
                                Text { text: "SN:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                Text { text: root.sn; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                            }
                            Row {
                                spacing: 10
                                Text { text: "Software Version:"; font.pixelSize: 16; font.bold: true; color: "#333333"; width: 120 }
                                Text { text: root.software_version; font.pixelSize: 16; color: "#666666"; wrapMode: Text.WordWrap }
                            }
                        }
                    }
                    
                    // Scan Overview Section
                    Column {
                        width: parent.width
                        anchors.margins: 10
                        
                        Rectangle {
                            height: 40
                            color: "#2e4573"
                            
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Scan Overview"
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                            }
                        }
                        
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            text: "System(s) Scanned: " + root.systems_scanned + 
                                  ", System(s) with DTCs: " + root.systems_with_dtcs + 
                                  ", Total DTCs: " + root.total_dtcs
                            font.pixelSize: 18
                            color: "#666666"
                            wrapMode: Text.WordWrap
                        }
                        
                        // Systems table
                        Rectangle {
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: systemsRepeater.count * 54 + 54
                            color: "transparent"
                            border.color: "#cccccc"
                            
                            Column {
                                width: parent.width
                                
                                // Table header
                                Rectangle {
                                    width: parent.width
                                    height: 54
                                    color: "#DCE6F5"
                                    
                                    Row {
                                        anchors.fill: parent
                                        anchors.margins: 8
                                        
                                        Text { 
                                            text: "No."
                                            width: parent.width * 0.1
                                            font.pixelSize: 18
                                            color: "#000"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        Text { 
                                            text: "System Name"
                                            width: parent.width * 0.7
                                            font.pixelSize: 18
                                            color: "#000"
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        Text { 
                                            text: "State"
                                            width: parent.width * 0.2
                                            font.pixelSize: 18
                                            color: "#000"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }
                                
                                // Table rows
                                Repeater {
                                    id: systemsRepeater
                                    model: root.systemsList
                                    
                                    Rectangle {
                                        width: parent.width
                                        height: 54
                                        color: "transparent"
                                        border.width: 1
                                        border.color: "#cccccc"
                                        
                                        Row {
                                            anchors.fill: parent
                                            anchors.margins: 8
                                            
                                            Text { 
                                                text: modelData.no || ""
                                                width: parent.width * 0.1
                                                font.pixelSize: 18
                                                color: "#000"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                            Text { 
                                                text: modelData.name || ""
                                                width: parent.width * 0.7
                                                font.pixelSize: 18
                                                color: "#000"
                                                verticalAlignment: Text.AlignVCenter
                                                wrapMode: Text.WordWrap
                                            }
                                            Text { 
                                                text: modelData.state || ""
                                                width: parent.width * 0.2
                                                font.pixelSize: 18
                                                color: modelData.has_faults ? "#f41717" : "#000"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    // Fault Codes Section
                    Column {
                        width: parent.width
                        anchors.margins: 10
                        visible: root.faultSystemsList.length > 0
                        
                        Rectangle {
                            height: 40
                            color: "#2e4573"
                            
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Fault Codes"
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                            }
                        }
                        
                        Repeater {
                            model: root.faultSystemsList
                            
                            Column {
                                width: parent.width
                                
                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 16
                                    text: (modelData.system_name || "") + " (Found " + (modelData.fault_count || "0") + ")"
                                    font.pixelSize: 20
                                    color: "#2e4573"
                                    font.bold: true
                                }
                                
                                Rectangle {
                                    width: parent.width - 20
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    height: (modelData.faults ? modelData.faults.length : 0) * 54 + 54
                                    color: "transparent"
                                    border.color: "#cccccc"
                                    
                                    Column {
                                        width: parent.width
                                        
                                        // Fault table header
                                        Rectangle {
                                            width: parent.width
                                            height: 54
                                            color: "#DCE6F5"
                                            
                                            Row {
                                                anchors.fill: parent
                                                anchors.margins: 8
                                                
                                                Text { 
                                                    text: "No."
                                                    width: parent.width * 0.1
                                                    font.pixelSize: 18
                                                    color: "#000"
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                                Text { 
                                                    text: "DTC"
                                                    width: parent.width * 0.15
                                                    font.pixelSize: 18
                                                    color: "#000"
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                                Text { 
                                                    text: "Description"
                                                    width: parent.width * 0.55
                                                    font.pixelSize: 18
                                                    color: "#000"
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                                Text { 
                                                    text: "Status"
                                                    width: parent.width * 0.2
                                                    font.pixelSize: 18
                                                    color: "#000"
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                            }
                                        }
                                        
                                        // Fault rows
                                        Repeater {
                                            model: modelData.faults || []
                                            
                                            Rectangle {
                                                width: parent.width
                                                height: 54
                                                color: "transparent"
                                                border.width: 1
                                                border.color: "#cccccc"
                                                
                                                Row {
                                                    anchors.fill: parent
                                                    anchors.margins: 8
                                                    
                                                    Text { 
                                                        text: modelData.no || ""
                                                        width: parent.width * 0.1
                                                        font.pixelSize: 18
                                                        color: "#000"
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                    }
                                                    Text { 
                                                        text: modelData.dtc || ""
                                                        width: parent.width * 0.15
                                                        font.pixelSize: 18
                                                        color: "#000"
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                    }
                                                    Text { 
                                                        text: modelData.description || ""
                                                        width: parent.width * 0.55
                                                        font.pixelSize: 18
                                                        color: "#000"
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.WordWrap
                                                    }
                                                    Text { 
                                                        text: modelData.status || ""
                                                        width: parent.width * 0.2
                                                        font.pixelSize: 18
                                                        color: "#000"
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    // Footer statement
                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.topMargin: 71
                        width: parent.width - 20
                        text: "*This report is generated based on the data read from the vehicle's electronic control units. The results are for reference only."
                        font.pixelSize: 16
                        color: "#808080"
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }
} 