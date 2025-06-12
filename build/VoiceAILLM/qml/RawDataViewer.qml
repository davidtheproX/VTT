import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GroupBox {
    id: root
    title: "Raw Data"

    property alias model: tableView.model
    property int highlightedRow: -1

    signal rowSelected(real time)

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        // Controls row
        RowLayout {
            Layout.fillWidth: true

            TextField {
                id: searchField
                Layout.fillWidth: true
                placeholderText: "Search data..."
                font.pixelSize: 10

                onTextChanged: {
                    // TODO: Implement search functionality
                    console.log("Search:", text)
                }
            }

            Button {
                text: "Export CSV"
                flat: true
                font.pixelSize: 9
                onClicked: {
                    // TODO: Implement CSV export
                    console.log("Export CSV")
                }
            }

            Button {
                text: "Copy"
                flat: true
                font.pixelSize: 9
                onClicked: {
                    // TODO: Implement copy to clipboard
                    console.log("Copy data")
                }
            }
        }

        // Info bar
        Label {
            id: infoLabel
            text: model ? (model.rowCount + " rows × " + model.columnCount + " columns") : "No data"
            font.pixelSize: 9
            color: "#666666"
        }

        // Table view
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            TableView {
                id: tableView
                alternatingRows: true
                selectionBehavior: TableView.SelectRows
                
                // Row highlighting
                rowDelegate: Rectangle {
                    height: 24
                    color: {
                        if (root.highlightedRow === row) {
                            return "#4CAF50"  // Green highlight for chart-synchronized row
                        } else if (tableView.isRowSelected(row)) {
                            return "#2196F3"  // Blue for user selection
                        } else if (row % 2 === 0) {
                            return "#fafafa"  // Alternating row color
                        } else {
                            return "#ffffff"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            tableView.selectionModel.setCurrentIndex(
                                tableView.model.index(row, 0), 
                                ItemSelectionModel.ClearAndSelect | ItemSelectionModel.Rows
                            )
                            
                            // Get time value from first column (assuming it's time)
                            if (tableView.model && tableView.model.rowCount > row) {
                                var timeValue = tableView.model.getValue(row, 0)
                                root.rowSelected(timeValue)
                            }
                        }
                    }
                }

                // Column headers
                HorizontalHeaderView {
                    id: horizontalHeader
                    syncView: tableView
                    height: 24
                    
                    delegate: Rectangle {
                        implicitHeight: 24
                        color: "#e0e0e0"
                        border.color: "#cccccc"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: display
                            font.pixelSize: 9
                            font.bold: true
                            elide: Text.ElideRight
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // TODO: Implement column sorting
                                console.log("Sort by column:", column)
                            }
                        }
                    }
                }

                // Row numbers
                VerticalHeaderView {
                    id: verticalHeader
                    syncView: tableView
                    width: 40

                    delegate: Rectangle {
                        implicitWidth: 40
                        color: "#f0f0f0"
                        border.color: "#cccccc"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: row + 1
                            font.pixelSize: 8
                            color: "#666666"
                        }
                    }
                }

                // Data cells
                delegate: Rectangle {
                    implicitWidth: Math.max(80, cellText.implicitWidth + 12)
                    implicitHeight: 24
                    border.color: "#e0e0e0"
                    border.width: 0.5

                    color: {
                        if (root.highlightedRow === row) {
                            return "#C8E6C9"  // Light green for highlighted row
                        } else {
                            return "#ffffff"
                        }
                    }

                    Text {
                        id: cellText
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 6
                        anchors.rightMargin: 6
                        
                        text: display || ""
                        font.pixelSize: 9
                        elide: Text.ElideRight
                        
                        // Format numbers nicely
                        Component.onCompleted: {
                            if (typeof display === 'number') {
                                text = display.toFixed(3)
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        
                        onClicked: {
                            tableView.selectionModel.setCurrentIndex(
                                tableView.model.index(row, column), 
                                ItemSelectionModel.ClearAndSelect
                            )
                        }

                        onDoubleClicked: {
                            // Copy cell value to clipboard
                            // TODO: Implement clipboard functionality
                            console.log("Copy cell:", display)
                        }
                    }

                    ToolTip {
                        visible: parent.parent.cellText.truncated && mouseArea.containsMouse
                        text: display || ""
                        delay: 1000
                    }
                }
            }
        }

        // Status bar
        RowLayout {
            Layout.fillWidth: true

            Label {
                text: tableView.selectionModel && tableView.selectionModel.hasSelection ? 
                      "Selected: Row " + (tableView.selectionModel.currentIndex.row + 1) : 
                      "No selection"
                font.pixelSize: 9
                color: "#666666"
                Layout.fillWidth: true
            }

            Label {
                text: "Navigate: ↑↓ arrows, Page Up/Down"
                font.pixelSize: 8
                color: "#999999"
            }
        }
    }

    // Keyboard navigation
    Keys.onPressed: (event) => {
        if (!tableView.model) return
        
        var currentRow = tableView.selectionModel.currentIndex.row
        var newRow = currentRow
        
        switch (event.key) {
            case Qt.Key_Up:
                newRow = Math.max(0, currentRow - 1)
                break
            case Qt.Key_Down:
                newRow = Math.min(tableView.model.rowCount - 1, currentRow + 1)
                break
            case Qt.Key_PageUp:
                newRow = Math.max(0, currentRow - 10)
                break
            case Qt.Key_PageDown:
                newRow = Math.min(tableView.model.rowCount - 1, currentRow + 10)
                break
            case Qt.Key_Home:
                newRow = 0
                break
            case Qt.Key_End:
                newRow = tableView.model.rowCount - 1
                break
            default:
                return
        }
        
        if (newRow !== currentRow) {
            tableView.selectionModel.setCurrentIndex(
                tableView.model.index(newRow, 0), 
                ItemSelectionModel.ClearAndSelect | ItemSelectionModel.Rows
            )
            
            // Scroll to the selected row
            tableView.positionViewAtRow(newRow, TableView.Contain)
            
            // Emit time selection
            var timeValue = tableView.model.getValue(newRow, 0)
            root.rowSelected(timeValue)
            
            event.accepted = true
        }
    }

    function highlightRow(row) {
        root.highlightedRow = row
        if (row >= 0 && tableView.model && row < tableView.model.rowCount) {
            tableView.positionViewAtRow(row, TableView.Contain)
        }
    }

    function clearHighlight() {
        root.highlightedRow = -1
    }

    // Focus handling
    Component.onCompleted: {
        focus = true
    }
} 