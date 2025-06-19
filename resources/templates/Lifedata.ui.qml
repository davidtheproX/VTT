import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: reportPage
    // A4 size for print: 840pt x 1188pt at 72dpi
    width: 840
    height: 1188
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

    // Content Box - analogous to .content-box in HTML
    Rectangle {
        id: contentBox
        width: parent.width - 20 // 10px padding on each side for the report div
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        height: mainContentColumn.implicitHeight + headerSection.implicitHeight + 90

        ColumnLayout {
            id: mainContentColumn
            width: parent.width
            spacing: 0

            // Header Section - analogous to .header
            Item {
                id: headerSection
                Layout.fillWidth: true
                Layout.minimumHeight: 84
                Layout.leftMargin: 16
                Layout.rightMargin: 16

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Text {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 40
                        Layout.topMargin: 27
                        text: report_title
                        font.pixelSize: 36
                        font.bold: true
                        color: "#000000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 6
                        color: "#2e4573"
                        Layout.topMargin: 9
                        Layout.bottomMargin: 4
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#2e4573"
                    }
                }
            }

            // Repair Info Basic - analogous to .repair-info-basic
            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 16
                Layout.bottomMargin: 16
                Layout.leftMargin: 16
                Layout.rightMargin: 16
                spacing: 20

                Rectangle {
                    id: companyLogo
                    width: 188
                    height: 102
                    color: "#f0f0f0"
                    border.color: "#cccccc"
                    border.width: 1
                    Layout.alignment: Qt.AlignTop

                    Text {
                        anchors.centerIn: parent
                        text: "LOGO"
                        color: "#666666"
                        font.pixelSize: 16
                    }
                }

                // InformationList for Company Details
                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    columnSpacing: 40
                    rowSpacing: 14

                    // Company Info Row 1
                    Text { 
                        text: "Company:"
                        font.pixelSize: 16
                        color: "#666666"
                        Layout.minimumWidth: 70
                    }
                    Text { 
                        text: company
                        font.pixelSize: 16
                        color: "#000000"
                        Layout.fillWidth: true
                    }

                    // Email
                    Text { 
                        text: "Email:"
                        font.pixelSize: 16
                        color: "#666666"
                        Layout.minimumWidth: 70
                    }
                    Text { 
                        text: email
                        font.pixelSize: 16
                        color: "#000000"
                        Layout.fillWidth: true
                    }

                    // Tel
                    Text { 
                        text: "Tel:"
                        font.pixelSize: 16
                        color: "#666666"
                        Layout.minimumWidth: 70
                    }
                    Text { 
                        text: tel
                        font.pixelSize: 16
                        color: "#000000"
                        Layout.fillWidth: true
                    }

                    // Website
                    Text { 
                        text: "Website:"
                        font.pixelSize: 16
                        color: "#666666"
                        Layout.minimumWidth: 70
                    }
                    Text { 
                        text: website
                        font.pixelSize: 16
                        color: "#000000"
                        Layout.fillWidth: true
                    }

                    // Address (spans full width)
                    Text { 
                        text: "Address:"
                        font.pixelSize: 16
                        color: "#666666"
                        Layout.minimumWidth: 70
                    }
                    Text { 
                        text: address
                        font.pixelSize: 16
                        color: "#000000"
                        Layout.fillWidth: true
                        Layout.columnSpan: 1
                        wrapMode: Text.WordWrap
                    }
                }
            }

            // Main Content Area (padding: 0 10px;)
            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                spacing: 12

                // Basic Information section
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 0

                    // Model Header
                    Item {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 48
                        Layout.topMargin: 12

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: "#B8C3D9"
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 6
                            spacing: 10

                            Image {
                                width: 16
                                height: 18
                                source: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 18'%3E%3Cpath fill='%232E4573' d='M0 0 L16 9 L0 18 Z'/%3E%3C/svg%3E"
                                fillMode: Image.PreserveAspectFit
                                Layout.alignment: Qt.AlignVCenter
                            }

                            Text {
                                text: "Basic Information"
                                font.pixelSize: 24
                                color: "#2E4573"
                                Layout.fillWidth: true
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    // Information Grid
                    GridLayout {
                        Layout.fillWidth: true
                        Layout.topMargin: 12
                        columns: 2
                        columnSpacing: 20
                        rowSpacing: 14

                        // VIN
                        Text { text: "VIN:"; color: "#666666"; font.pixelSize: 18; Layout.minimumWidth: 120 }
                        Text { text: vin; color: "#000000"; font.pixelSize: 18; Layout.fillWidth: true }

                        // Mileage
                        Text { text: "Mileage:"; color: "#666666"; font.pixelSize: 18; Layout.minimumWidth: 120 }
                        Text { text: mileage; color: "#000000"; font.pixelSize: 18; Layout.fillWidth: true }

                        // Car Number
                        Text { text: "Car Number:"; color: "#666666"; font.pixelSize: 18; Layout.minimumWidth: 120 }
                        Text { text: car_number; color: "#000000"; font.pixelSize: 18; Layout.fillWidth: true }

                        // Report Time
                        Text { text: "Report Time:"; color: "#666666"; font.pixelSize: 18; Layout.minimumWidth: 120 }
                        Text { text: report_time; color: "#000000"; font.pixelSize: 18; Layout.fillWidth: true }

                        // SN
                        Text { text: "SN:"; color: "#666666"; font.pixelSize: 18; Layout.minimumWidth: 120 }
                        Text { text: sn; color: "#000000"; font.pixelSize: 18; Layout.fillWidth: true }

                        // Software Version
                        Text { text: "Software Version:"; color: "#666666"; font.pixelSize: 18; Layout.minimumWidth: 120 }
                        Text { text: software_version; color: "#000000"; font.pixelSize: 18; Layout.fillWidth: true }
                    }
                }

                // Scan Overview section
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 0

                    // Model Header
                    Item {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 48
                        Layout.topMargin: 12

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: "#B8C3D9"
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 6
                            spacing: 10

                            Image {
                                width: 16
                                height: 18
                                source: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 18'%3E%3Cpath fill='%232E4573' d='M0 0 L16 9 L0 18 Z'/%3E%3C/svg%3E"
                                fillMode: Image.PreserveAspectFit
                                Layout.alignment: Qt.AlignVCenter
                            }

                            Text {
                                text: "Scan Overview"
                                font.pixelSize: 24
                                color: "#2E4573"
                                Layout.fillWidth: true
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    // Summary prompt
                    Text {
                        Layout.fillWidth: true
                        Layout.topMargin: 12
                        Layout.bottomMargin: 12
                        font.pixelSize: 18
                        color: "#666666"
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                        text: "System(s) Scanned: <b>" + systems_scanned + "</b>, System(s) with DTCs: <b style='color: #e20015;'>" + systems_with_dtcs + "</b>, Total DTCs: <b>" + total_dtcs + "</b>"
                    }

                    // Systems Table
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 0

                        // Table Header
                        Rectangle {
                            Layout.fillWidth: true
                            height: 54
                            color: "#DCE6F5"
                            radius: 10

                            // Overlay rectangle to make only top corners rounded
                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: parent.height / 2
                                color: "#DCE6F5"
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: parent.width * 0.0195
                                anchors.rightMargin: parent.width * 0.0195
                                spacing: 0

                                Text {
                                    text: "No."
                                    font.pixelSize: 18
                                    color: "#000000"
                                    Layout.preferredWidth: parent.width * 0.044
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                Text {
                                    text: "System Name"
                                    font.pixelSize: 18
                                    color: "#000000"
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 35
                                    verticalAlignment: Text.AlignVCenter
                                }
                                Text {
                                    text: "State"
                                    font.pixelSize: 18
                                    color: "#000000"
                                    Layout.preferredWidth: parent.width * 0.12
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }

                        // Table Rows
                        Repeater {
                            model: systems
                            delegate: Rectangle {
                                Layout.fillWidth: true
                                height: 54
                                color: "#ffffff"
                                border.color: "#cccccc"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: parent.width * 0.0195
                                    anchors.rightMargin: parent.width * 0.0195
                                    spacing: 0

                                    Text {
                                        text: modelData.no || ""
                                        font.pixelSize: 18
                                        color: "#000000"
                                        Layout.preferredWidth: parent.width * 0.044
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    Text {
                                        text: modelData.name || ""
                                        font.pixelSize: 18
                                        color: "#000000"
                                        Layout.fillWidth: true
                                        Layout.leftMargin: 35
                                        verticalAlignment: Text.AlignVCenter
                                        wrapMode: Text.WordWrap
                                    }

                                    RowLayout {
                                        Layout.preferredWidth: parent.width * 0.12
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        spacing: 5

                                        Image {
                                            width: 17
                                            height: 17
                                            source: modelData.has_faults ?
                                                        "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 17 17'%3E%3Cpath d='M8.5 0 L17 17 L0 17 Z' fill='%23f41717'/%3E%3Ctext x='50%25' y='75%25' fill='white' font-size='12' text-anchor='middle'%3E!%3C/text%3E%3C/svg%3E" :
                                                        "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 17 17'%3E%3Ccircle cx='8.5' cy='8.5' r='8' fill='%234CAF50'/%3E%3Cpath d='M5 8.5 L7.5 11 L12 6.5' stroke='white' stroke-width='2' fill='none'/%3E%3C/svg%3E"
                                            fillMode: Image.PreserveAspectFit
                                        }

                                        Text {
                                            text: modelData.state || ""
                                            font.pixelSize: 18
                                            color: modelData.has_faults ? "#f41717" : "#000000"
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Fault Codes section
                ColumnLayout {
                    Layout.fillWidth: true
                    visible: fault_systems && fault_systems.length > 0
                    spacing: 0

                    // Model Header with Star
                    Item {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 48
                        Layout.topMargin: 12

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: "#B8C3D9"
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 6
                            spacing: 10

                            Image {
                                width: 18
                                height: 18
                                source: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'%3E%3Cpath fill='%232E4573' d='M9 0 L11.1 6.5 H18 L12.4 10.5 L14.5 17 L9 13 L3.5 17 L5.6 10.5 L0 6.5 H6.9 Z'/%3E%3C/svg%3E"
                                fillMode: Image.PreserveAspectFit
                                Layout.alignment: Qt.AlignVCenter
                            }

                            Text {
                                text: "Fault Codes"
                                font.pixelSize: 24
                                color: "#2E4573"
                                Layout.fillWidth: true
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    // Fault Systems
                    Repeater {
                        model: fault_systems || []
                        delegate: ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 0

                            // Sub-title
                            RowLayout {
                                Layout.fillWidth: true
                                Layout.topMargin: 16
                                Layout.leftMargin: 10
                                Layout.bottomMargin: 12
                                spacing: 6

                                Rectangle {
                                    width: 4
                                    height: 14
                                    color: "#2e4573"
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Text {
                                    text: (modelData.system_name || "") + " (Found " + (modelData.fault_count || "0") + ")"
                                    font.pixelSize: 20
                                    color: "#2e4573"
                                    Layout.fillWidth: true
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }

                            // Fault Table
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 0

                                // Fault Table Header
                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 54
                                    color: "#DCE6F5"
                                    radius: 10

                                    Rectangle {
                                        anchors.bottom: parent.bottom
                                        width: parent.width
                                        height: parent.height / 2
                                        color: "#DCE6F5"
                                    }

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: parent.width * 0.0195
                                        anchors.rightMargin: parent.width * 0.0195
                                        spacing: 0

                                        Text { text: "No."; font.pixelSize: 18; color: "#000000"; Layout.preferredWidth: parent.width * 0.044; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                                        Text { text: "DTC"; font.pixelSize: 18; color: "#000000"; Layout.preferredWidth: parent.width * 0.10; Layout.leftMargin: 30; verticalAlignment: Text.AlignVCenter }
                                        Text { text: "Description"; font.pixelSize: 18; color: "#000000"; Layout.fillWidth: true; verticalAlignment: Text.AlignVCenter }
                                        Text { text: "Status"; font.pixelSize: 18; color: "#000000"; Layout.preferredWidth: parent.width * 0.24; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                                    }
                                }

                                // Fault Table Rows
                                Repeater {
                                    model: modelData.faults || []
                                    delegate: Rectangle {
                                        Layout.fillWidth: true
                                        height: 54
                                        color: "#ffffff"
                                        border.color: "#cccccc"
                                        border.width: 1

                                        RowLayout {
                                            anchors.fill: parent
                                            anchors.leftMargin: parent.width * 0.0195
                                            anchors.rightMargin: parent.width * 0.0195
                                            spacing: 0

                                            Text { text: modelData.no || ""; font.pixelSize: 18; color: "#000000"; Layout.preferredWidth: parent.width * 0.044; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                                            Text { text: modelData.dtc || ""; font.pixelSize: 18; color: "#000000"; Layout.preferredWidth: parent.width * 0.10; Layout.leftMargin: 30; verticalAlignment: Text.AlignVCenter }
                                            Text { text: modelData.description || ""; font.pixelSize: 18; color: "#000000"; Layout.fillWidth: true; wrapMode: Text.WordWrap; verticalAlignment: Text.AlignVCenter }
                                            Text { text: modelData.status || ""; font.pixelSize: 18; color: "#000000"; Layout.preferredWidth: parent.width * 0.24; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Footer statement
                Text {
                    Layout.fillWidth: true
                    Layout.topMargin: 71
                    Layout.bottomMargin: 8
                    color: "#808080"
                    font.pixelSize: 16
                    wrapMode: Text.Wrap
                    textFormat: Text.RichText
                    text: "<span style='color: #f41717;'>*</span>This report is generated based on the data read from the vehicle's electronic control units. The results are for reference only."
                }
            }
        }
    }
} 