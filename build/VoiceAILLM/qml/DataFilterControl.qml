import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GroupBox {
    id: root
    title: "Data Filter"

    property var chartProvider
    property real minTime: 0
    property real maxTime: 100
    property real currentMinTime: 0
    property real currentMaxTime: 100

    signal filterChanged(real minTime, real maxTime)
    signal filterCleared()

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        // Time range display
        Label {
            text: "Time Range: " + currentMinTime.toFixed(2) + " - " + currentMaxTime.toFixed(2)
            font.pixelSize: 10
            Layout.fillWidth: true
        }

        // Time range sliders
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            Label {
                text: "Min Time: " + minTimeSlider.value.toFixed(2)
                font.pixelSize: 9
            }

            Slider {
                id: minTimeSlider
                Layout.fillWidth: true
                from: root.minTime
                to: root.maxTime
                value: root.currentMinTime
                stepSize: (root.maxTime - root.minTime) / 1000

                onValueChanged: {
                    if (value >= maxTimeSlider.value) {
                        value = maxTimeSlider.value - stepSize
                    }
                    root.currentMinTime = value
                }
            }

            Label {
                text: "Max Time: " + maxTimeSlider.value.toFixed(2)
                font.pixelSize: 9
            }

            Slider {
                id: maxTimeSlider
                Layout.fillWidth: true
                from: root.minTime
                to: root.maxTime
                value: root.currentMaxTime
                stepSize: (root.maxTime - root.minTime) / 1000

                onValueChanged: {
                    if (value <= minTimeSlider.value) {
                        value = minTimeSlider.value + stepSize
                    }
                    root.currentMaxTime = value
                }
            }
        }

        // Precise time inputs
        GridLayout {
            columns: 2
            Layout.fillWidth: true

            Label {
                text: "From:"
                font.pixelSize: 9
            }

            SpinBox {
                id: minTimeSpinBox
                Layout.fillWidth: true
                from: root.minTime * 100
                to: root.maxTime * 100
                value: root.currentMinTime * 100
                stepSize: 1
                editable: true

                property real realValue: value / 100.0

                onValueChanged: {
                    if (realValue !== root.currentMinTime) {
                        root.currentMinTime = realValue
                        minTimeSlider.value = realValue
                    }
                }

                textFromValue: function(value, locale) {
                    return Number(value / 100.0).toFixed(2)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 100
                }
            }

            Label {
                text: "To:"
                font.pixelSize: 9
            }

            SpinBox {
                id: maxTimeSpinBox
                Layout.fillWidth: true
                from: root.minTime * 100
                to: root.maxTime * 100
                value: root.currentMaxTime * 100
                stepSize: 1
                editable: true

                property real realValue: value / 100.0

                onValueChanged: {
                    if (realValue !== root.currentMaxTime) {
                        root.currentMaxTime = realValue
                        maxTimeSlider.value = realValue
                    }
                }

                textFromValue: function(value, locale) {
                    return Number(value / 100.0).toFixed(2)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 100
                }
            }
        }

        // Filter buttons
        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "Apply"
                highlighted: true
                Layout.fillWidth: true
                enabled: root.currentMinTime !== root.minTime || root.currentMaxTime !== root.maxTime
                onClicked: {
                    root.filterChanged(root.currentMinTime, root.currentMaxTime)
                }
            }

            Button {
                text: "Reset"
                Layout.fillWidth: true
                onClicked: {
                    root.currentMinTime = root.minTime
                    root.currentMaxTime = root.maxTime
                    minTimeSlider.value = root.minTime
                    maxTimeSlider.value = root.maxTime
                    root.filterCleared()
                }
            }
        }

        // Quick filter presets
        GroupBox {
            title: "Quick Filters"
            Layout.fillWidth: true
            font.pixelSize: 10

            ColumnLayout {
                anchors.fill: parent
                spacing: 4

                Button {
                    text: "First 25%"
                    flat: true
                    font.pixelSize: 9
                    Layout.fillWidth: true
                    onClicked: {
                        var range = root.maxTime - root.minTime
                        root.currentMinTime = root.minTime
                        root.currentMaxTime = root.minTime + range * 0.25
                        updateSliders()
                    }
                }

                Button {
                    text: "Middle 50%"
                    flat: true
                    font.pixelSize: 9
                    Layout.fillWidth: true
                    onClicked: {
                        var range = root.maxTime - root.minTime
                        root.currentMinTime = root.minTime + range * 0.25
                        root.currentMaxTime = root.minTime + range * 0.75
                        updateSliders()
                    }
                }

                Button {
                    text: "Last 25%"
                    flat: true
                    font.pixelSize: 9
                    Layout.fillWidth: true
                    onClicked: {
                        var range = root.maxTime - root.minTime
                        root.currentMinTime = root.minTime + range * 0.75
                        root.currentMaxTime = root.maxTime
                        updateSliders()
                    }
                }
            }
        }

        // Data statistics
        GroupBox {
            title: "Statistics"
            Layout.fillWidth: true
            font.pixelSize: 10

            ColumnLayout {
                anchors.fill: parent
                spacing: 2

                Label {
                    text: "Total Duration: " + (root.maxTime - root.minTime).toFixed(2) + "s"
                    font.pixelSize: 9
                    Layout.fillWidth: true
                }

                Label {
                    text: "Filtered Duration: " + (root.currentMaxTime - root.currentMinTime).toFixed(2) + "s"
                    font.pixelSize: 9
                    Layout.fillWidth: true
                }

                Label {
                    text: "Coverage: " + (((root.currentMaxTime - root.currentMinTime) / (root.maxTime - root.minTime)) * 100).toFixed(1) + "%"
                    font.pixelSize: 9
                    Layout.fillWidth: true
                }
            }
        }
    }

    // Update from chart provider
    Connections {
        target: chartProvider
        function onRangeChanged() {
            if (chartProvider) {
                root.minTime = chartProvider.minTime
                root.maxTime = chartProvider.maxTime
                if (root.currentMinTime === 0 && root.currentMaxTime === 100) {
                    root.currentMinTime = root.minTime
                    root.currentMaxTime = root.maxTime
                    updateSliders()
                }
            }
        }
    }

    function updateSliders() {
        minTimeSlider.value = root.currentMinTime
        maxTimeSlider.value = root.currentMaxTime
    }

    Component.onCompleted: {
        if (chartProvider) {
            root.minTime = chartProvider.minTime || 0
            root.maxTime = chartProvider.maxTime || 100
            root.currentMinTime = root.minTime
            root.currentMaxTime = root.maxTime
        }
    }
} 