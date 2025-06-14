import QtQuick
import QtQuick.Controls
import QtQuick.Shapes 1.15

Rectangle {
    id: lifeDataQml
    width: 1920
    height: 958
    color: "transparent"
    property alias engineDataDsName6Text: engineDataDsName6.text
    property alias brakeSwitchStatusText: brakeSwitchStatus.text
    property alias difPressureSensorText: difPressureSensor.text
    property alias rearNoxDsName1Text: rearNoxDsName1.text
    property alias sCR_OutTemperatureSensorDsValue1Text: sCR_OutTemperatureSensorDsValue1.text
    property alias ureaPumpDsValue1Text: ureaPumpDsValue1.text
    property alias ureaPumpDsValue3Text: ureaPumpDsValue3.text
    property alias ureaPumpDsName3Text: ureaPumpDsName3.text
    property alias ureaPumpDsValue6Text: ureaPumpDsValue6.text
    property alias engineDataDsValue1Text: engineDataDsValue1.text
    property alias sCR_OutTemperatureSensorDsName1Text: sCR_OutTemperatureSensorDsName1.text
    property alias dPF_InTemperatureSensorDsValue1Text: dPF_InTemperatureSensorDsValue1.text
    property alias engineDataDsValue4Text: engineDataDsValue4.text
    property alias dPF_StatusText: dPF_Status.text
    property alias dOC_TemperatureSensorDsValue1Text: dOC_TemperatureSensorDsValue1.text
    property alias promptTitleText: promptTitle.text
    property alias difPressureSensorDsValue2Text: difPressureSensorDsValue2.text
    property alias engineDataDsName1Text: engineDataDsName1.text
    property alias dPF_InTemperatureSensorDsName1Text: dPF_InTemperatureSensorDsName1.text
    property alias frontNoxDsName1Text: frontNoxDsName1.text
    property alias difPressureSensorDsName2Text: difPressureSensorDsName2.text
    property alias eGR_ValveDsValue1Text: eGR_ValveDsValue1.text
    property alias frontNoxDsValue1Text: frontNoxDsValue1.text
    property alias ureaPumpDsName6Text: ureaPumpDsName6.text
    property alias engineDataDsValue6Text: engineDataDsValue6.text
    property alias promptTextText: promptText.text
    property alias ureaPumpDsValue5Text: ureaPumpDsValue5.text
    property alias ureaNozzleDsValue1Text: ureaNozzleDsValue1.text
    property alias eGR_CoolerText: eGR_Cooler.text
    property alias ureaPumpDsName5Text: ureaPumpDsName5.text
    property alias ureaPumpDsValue4Text: ureaPumpDsValue4.text
    property alias ureaTankDsName2Text: ureaTankDsName2.text
    property alias neutralSwitchStatusText: neutralSwitchStatus.text
    property alias difPressureSensorDsName1Text: difPressureSensorDsName1.text
    property alias difPressureSensorDsValue1Text: difPressureSensorDsValue1.text
    property alias brakeSwitchStatusValueText: brakeSwitchStatusValue.text
    property alias ureaTankDsValue3Text: ureaTankDsValue3.text
    property alias ureaTankDsName3Text: ureaTankDsName3.text
    property alias ureaTankDsValue2Text: ureaTankDsValue2.text
    property alias engineDataDsValue2Text: engineDataDsValue2.text
    property alias ureaNozzleDsName1Text: ureaNozzleDsName1.text
    property alias engineDataDsValue3Text: engineDataDsValue3.text
    property alias dOC_TemperatureSensorDsName1Text: dOC_TemperatureSensorDsName1.text
    property alias dPF_StatusValueText: dPF_StatusValue.text
    property alias acceleratorPedalStatusText: acceleratorPedalStatus.text
    property alias sCR_InTemperatureSensorDsName1Text: sCR_InTemperatureSensorDsName1.text
    property alias ureaTankDsValue1Text: ureaTankDsValue1.text
    property alias engineDataDsName2Text: engineDataDsName2.text
    property alias clutchSwitchStatusValueText: clutchSwitchStatusValue.text
    property alias engineDataDsValue7Text: engineDataDsValue7.text
    property alias ureaPumpDsName1Text: ureaPumpDsName1.text
    property alias engineDataDsName7Text: engineDataDsName7.text
    property alias outtakeThrottleValveDsName1Text: outtakeThrottleValveDsName1.text
    property alias engineDataDsName3Text: engineDataDsName3.text
    property alias engineDataText: engineData.text
    property alias ureaPumpDsName4Text: ureaPumpDsName4.text
    property alias ureaPumpDsName2Text: ureaPumpDsName2.text
    property alias engineDataDsName4Text: engineDataDsName4.text
    property alias engineDataDsName5Text: engineDataDsName5.text
    property alias neutralSwitchStatusValueText: neutralSwitchStatusValue.text
    property alias acceleratorPedalStatusValueText: acceleratorPedalStatusValue.text
    property alias eGR_ValveDsName1Text: eGR_ValveDsName1.text
    property alias boosterText: booster.text
    property alias engineDataDsValue5Text: engineDataDsValue5.text
    property alias sCR_InTemperatureSensorDsValue1Text: sCR_InTemperatureSensorDsValue1.text
    property alias rearNoxDsValue1Text: rearNoxDsValue1.text
    property alias ureaNozzleText: ureaNozzle.text
    property alias ureaTankDsName1Text: ureaTankDsName1.text
    property alias ureaPumpDsValue2Text: ureaPumpDsValue2.text
    property alias clutchSwitchStatusText: clutchSwitchStatus.text
    property alias ureaPumpText: ureaPump.text
    property alias outtakeThrottleValveDsValue1Text: outtakeThrottleValveDsValue1.text

    Item {
        id: cumminsBk_3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Item {
            id: group_25
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Shape {
                id: rectangular
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: rectangular_ShapePath_0
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: rectangular_PathSvg_0
                        path: "M 0 0 L 1920 0 L 1920 958 L 0 958 L 0 0 Z"
                    }
                    fillColor: "#dfe2e6"
                }
                antialiasing: true
            }

            Shape {
                id: rectangular1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1510
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 11
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: rectangular_ShapePath_1
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: rectangular_PathSvg_1
                        path: "M 14 0 L 386 0 C 393.73198652267456 0 400 6.2680134773254395 400 14 L 400 923 C 400 930.7319865226746 393.73198652267456 937 386 937 L 14 937 C 6.2680134773254395 937 0 930.7319865226746 0 923 L 0 14 C 0 6.2680134773254395 6.2680134773254395 0 14 0 Z"
                    }
                    fillColor: "#ffffff"
                }
                antialiasing: true
            }

            Shape {
                id: rectangularBk_2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 10
                anchors.rightMargin: 420
                anchors.topMargin: 10
                anchors.bottomMargin: 11
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: rectangularBk_2_ShapePath_0
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: rectangularBk_2_PathSvg_0
                        path: "M 14 0 L 1476 0 C 1483.7319865226746 0 1490 6.2680134773254395 1490 14 L 1490 923 C 1490 930.7319865226746 1483.7319865226746 937 1476 937 L 14 937 C 6.2680134773254395 937 0 930.7319865226746 0 923 L 0 14 C 0 6.2680134773254395 6.2680134773254395 0 14 0 Z"
                    }
                    fillColor: "#ffffff"
                }
                antialiasing: true
            }

            Text {
                id: promptTitle
                color: "#333333"
                text: qsTr("Prompt Information:")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1518
                anchors.rightMargin: 120
                anchors.topMargin: 34
                anchors.bottomMargin: 888
                font.pixelSize: 30
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.NoWrap
                font.weight: Font.Normal
                font.family: "Inter"
            }

            Text {
                id: promptText
                color: "#333333"
                text: qsTr("...")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1518
                anchors.rightMargin: 380
                anchors.topMargin: 88
                anchors.bottomMargin: 840
                font.pixelSize: 25
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.NoWrap
                font.weight: Font.Normal
                font.family: "Inter"
            }

            Shape {
                id: dOC_Color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 596
                anchors.rightMargin: 1201
                anchors.topMargin: 696
                anchors.bottomMargin: 198
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: dOC_Color_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#000000"
                    PathSvg {
                        id: dOC_Color_PathSvg_0
                        path: "M 82.2490234375 0 L 122.666015625 0 L 122.666015625 63.70001220703125 L 0 63.70001220703125 L 0 0 L 82.2490234375 0 Z"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "#ffc941"
                }
                antialiasing: true
            }

            Shape {
                id: dPF_Color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 830
                anchors.rightMargin: 1029
                anchors.topMargin: 694
                anchors.bottomMargin: 200
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: dPF_Color_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#000000"
                    PathSvg {
                        id: dPF_Color_PathSvg_0
                        path: "M 0 0 L 60.68899917602539 0 L 60.68899917602539 63.70000076293945 L 0 63.70000076293945 L 0 0 Z"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "#ffc941"
                }
                antialiasing: true
            }

            Shape {
                id: sCR_UP_Color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1026
                anchors.rightMargin: 720
                anchors.topMargin: 694
                anchors.bottomMargin: 200
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: sCR_UP_Color_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#000000"
                    PathSvg {
                        id: sCR_UP_Color_PathSvg_0
                        path: "M 0 0 L 174 0 L 174 63.70000076293945 L 0 63.70000076293945 L 0 0 Z"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "#ffc941"
                }
                antialiasing: true
            }

            Shape {
                id: sCR_Down_Color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1364
                anchors.rightMargin: 444
                anchors.topMargin: 695
                anchors.bottomMargin: 199
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: sCR_Down_Color_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#000000"
                    PathSvg {
                        id: sCR_Down_Color_PathSvg_0
                        path: "M 0 0 L 112 0 L 112 63.70000076293945 L 0 63.70000076293945 L 0 0 Z"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "#84ebff"
                }
                antialiasing: true
            }

            Shape {
                id: dOC_DPF_Color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 719
                anchors.rightMargin: 1090
                anchors.topMargin: 682
                anchors.bottomMargin: 185
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: dOC_DPF_Color_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#000000"
                    PathSvg {
                        id: dOC_DPF_Color_PathSvg_0
                        path: "M 26 91 L 0 77.35003662109375 L 0 13.6500244140625 L 26 0 L 85 0 L 111 13.6500244140625 L 111 77.35003662109375 L 85 91 L 26 91 Z"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "#ffc941"
                }
                antialiasing: true
            }

            Shape {
                id: dPF_DIFF_Color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 891
                anchors.rightMargin: 890
                anchors.topMargin: 682
                anchors.bottomMargin: 185
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: dPF_DIFF_Color_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#000000"
                    PathSvg {
                        id: dPF_DIFF_Color_PathSvg_0
                        path: "M 26 91 L 0 77.35003662109375 L 0 13.6500244140625 L 26 0 L 113 0 L 139 13.6500244140625 L 139 77.35003662109375 L 113 91 L 26 91 Z"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "#ffc941"
                }
                antialiasing: true
            }

            Shape {
                id: sCR_UP_DOWN_Color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1200
                anchors.rightMargin: 556
                anchors.topMargin: 680
                anchors.bottomMargin: 187
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: sCR_UP_DOWN_Color_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#000000"
                    PathSvg {
                        id: sCR_UP_DOWN_Color_PathSvg_0
                        path: "M 26 91 L 0 77.35003662109375 L 0 13.6500244140625 L 26 0 L 138 0 L 164 13.6500244140625 L 164 77.35003662109375 L 138 91 L 26 91 Z"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "#ffc941"
                }
                antialiasing: true
            }

            Shape {
                id: route_10Backup_4
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 887
                anchors.rightMargin: 969
                anchors.topMargin: 622
                anchors.bottomMargin: 252
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_10Backup_4_ShapePath_0
                    strokeWidth: 4
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#ff8800"
                    PathSvg {
                        id: route_10Backup_4_PathSvg_0
                        path: "M 25.75701904296875 83.89398193359375 L 1.20001220703125 51.06201171875 C 0.422309935092926 50.02507710456848 0.0012970343232154846 48.76418602466583 0 47.468017578125 L 0 25.5059814453125 C -1.1368683772161603e-13 23.914682507514954 0.6321669816970825 22.388584971427917 1.75738525390625 21.26336669921875 C 2.8826035261154175 20.138148427009583 4.408701062202454 19.5059814453125 6 19.5059814453125 L 57.77203369140625 19.5059814453125 C 59.363332629203796 19.5059814453125 60.88943016529083 18.873875498771667 62.0146484375 17.7486572265625 C 63.13986670970917 16.623438954353333 63.77203369140625 15.097280383110046 63.77203369140625 13.5059814453125 L 63.77203369140625 0"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: route_10Backup_5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 962
                anchors.rightMargin: 890
                anchors.topMargin: 622
                anchors.bottomMargin: 252
                rotation: 180
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_10Backup_5_ShapePath_0
                    strokeWidth: 4
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#ff8800"
                    PathSvg {
                        id: route_10Backup_5_PathSvg_0
                        path: "M 25.756999969482422 0 L 1.2000000476837158 32.832000732421875 C 0.42229777574539185 33.868935346603394 0.0012970343232154846 35.12983024120331 0 36.42599868774414 L 7.771561172376096e-16 58.38800048828125 C 2.1094237467877974e-15 59.979299426078796 0.6321409940719604 61.50542366504669 1.757359266281128 62.63064193725586 C 2.8825775384902954 63.75586020946503 4.408701062202454 64.38800048828125 6 64.38800048828125 L 61.665000915527344 64.38800048828125 C 63.25629985332489 64.38800048828125 64.78242027759552 65.02014458179474 65.90763854980469 66.1453628540039 C 67.03285682201385 67.27058112621307 67.66500091552734 68.7967015504837 67.66500091552734 70.38800048828125 L 67.66500091552734 83.89399719238281"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Item {
                id: group_8Backup_13
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1038
                anchors.rightMargin: 865
                anchors.topMargin: 648
                anchors.bottomMargin: 247
                Shape {
                    id: rectangularBk_25
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 53
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_25_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: rectangularBk_25_PathSvg_0
                            path: "M 0.8130000233650208 0 C 1.2620075345039368 0 1.6260000467300415 0.36399251222610474 1.6260000467300415 0.8130000233650208 L 1.6260000467300415 9.510000228881836 C 1.6260000467300415 9.959007740020752 1.2620075345039368 10.322999954223633 0.8130000233650208 10.322999954223633 C 0.36399251222610474 10.322999954223633 0 9.959007740020752 0 9.510000228881836 L 0 0.8130000233650208 C 0 0.36399251222610474 0.36399251222610474 0 0.8130000233650208 0 Z"
                        }
                        fillColor: "#000000"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 8
                    anchors.bottomMargin: 32
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_64_ShapePath_0
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_64_PathSvg_0
                            path: "M 4.86299991607666 0 C 5.184707522392273 0 5.493238657712936 0.12779733538627625 5.720720291137695 0.35527896881103516 C 5.948201924562454 0.5827606022357941 6.076000213623045 0.8912926912307739 6.076000213623047 1.2130002975463867 L 6.076000213623047 23.33099937438965 L 0 23.33099937438965 L 0 1.2130002975463867 C -8.881784197001252e-16 0.8912926912307739 0.12779781222343445 0.5827606022357941 0.35527944564819336 0.35527896881103516 C 0.5827610790729523 0.12779733538627625 0.8912926912307739 8.881784197001252e-16 1.2130002975463867 0 L 4.86299991607666 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_66
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 32
                    anchors.bottomMargin: 27
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_66_ShapePath_0
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_66_PathSvg_0
                            path: "M 1.6169999837875366 0 L 15.574000358581543 0 C 16.46704477071762 0 17.19099998474121 0.7239555716514587 17.19099998474121 1.6169999837875366 L 17.19099998474121 3.128000020980835 C 17.19099998474121 4.021044433116913 16.46704477071762 4.744999885559082 15.574000358581543 4.744999885559082 L 1.6169999837875366 4.744999885559082 C 0.7239555716514587 4.744999885559082 0 4.021044433116913 0 3.128000020980835 L 0 1.6169999837875366 C 0 0.7239555716514587 0.7239555716514587 0 1.6169999837875366 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_67
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 3
                    anchors.rightMargin: 2
                    anchors.topMargin: 36
                    anchors.bottomMargin: 18
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_67_ShapePath_0
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_67_PathSvg_0
                            path: "M 12.305000305175781 0 L 12.305000305175781 7.099998474121094 C 12.304735325509682 7.635919749736786 12.091724067926407 8.14981684088707 11.712770462036133 8.528770446777344 C 11.333816856145859 8.907724052667618 10.819920718669891 9.12073340290226 10.2839994430542 9.12099838256836 L 2.0220000743865967 9.12099838256836 C 1.4859055280685425 9.120998448129889 0.9717534780502319 8.90810751914978 0.5925836563110352 8.529125213623047 C 0.21341383457183838 8.150142908096313 0.00026513083139434457 7.636092960834503 0 7.099998474121094 L 0 0 L 12.305000305175781 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_68
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 46
                    anchors.bottomMargin: -1
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_68_ShapePath_0
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_68_PathSvg_0
                            path: "M 6.081000328063965 0 L 6.081000328063965 16.710002899169922 C 6.081000328063965 17.134349286556244 5.912429660558701 17.541315227746964 5.612371444702148 17.841373443603516 C 5.312313228845596 18.141431659460068 4.90534633398056 18.310001373291016 4.480999946594238 18.310001373291016 L 1.6000003814697266 18.310001373291016 C 1.1756539940834045 18.310001373291023 0.7686875760555267 18.141431659460068 0.4686293601989746 17.841373443603516 C 0.16857114434242249 17.541315227746964 0 17.134349286556244 0 16.710002899169922 L 0 0 L 6.081000328063965 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_8Backup_14
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1371
                anchors.rightMargin: 532
                anchors.topMargin: 648
                anchors.bottomMargin: 247
                Shape {
                    id: rectangularBk_26
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 53
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_25_ShapePath_1
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: rectangularBk_25_PathSvg_1
                            path: "M 0.8130000233650208 0 C 1.2620075345039368 0 1.6260000467300415 0.36399251222610474 1.6260000467300415 0.8130000233650208 L 1.6260000467300415 9.510000228881836 C 1.6260000467300415 9.959007740020752 1.2620075345039368 10.322999954223633 0.8130000233650208 10.322999954223633 C 0.36399251222610474 10.322999954223633 0 9.959007740020752 0 9.510000228881836 L 0 0.8130000233650208 C 0 0.36399251222610474 0.36399251222610474 0 0.8130000233650208 0 Z"
                        }
                        fillColor: "#000000"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_65
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 8
                    anchors.bottomMargin: 32
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_64_ShapePath_1
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_64_PathSvg_1
                            path: "M 4.86299991607666 0 C 5.184707522392273 0 5.493238657712936 0.12779733538627625 5.720720291137695 0.35527896881103516 C 5.948201924562454 0.5827606022357941 6.076000213623045 0.8912926912307739 6.076000213623047 1.2130002975463867 L 6.076000213623047 23.33099937438965 L 0 23.33099937438965 L 0 1.2130002975463867 C -8.881784197001252e-16 0.8912926912307739 0.12779781222343445 0.5827606022357941 0.35527944564819336 0.35527896881103516 C 0.5827610790729523 0.12779733538627625 0.8912926912307739 8.881784197001252e-16 1.2130002975463867 0 L 4.86299991607666 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_69
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 32
                    anchors.bottomMargin: 27
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_66_ShapePath_1
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_66_PathSvg_1
                            path: "M 1.6169999837875366 0 L 15.574000358581543 0 C 16.46704477071762 0 17.19099998474121 0.7239555716514587 17.19099998474121 1.6169999837875366 L 17.19099998474121 3.128000020980835 C 17.19099998474121 4.021044433116913 16.46704477071762 4.744999885559082 15.574000358581543 4.744999885559082 L 1.6169999837875366 4.744999885559082 C 0.7239555716514587 4.744999885559082 0 4.021044433116913 0 3.128000020980835 L 0 1.6169999837875366 C 0 0.7239555716514587 0.7239555716514587 0 1.6169999837875366 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_70
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 3
                    anchors.rightMargin: 2
                    anchors.topMargin: 36
                    anchors.bottomMargin: 18
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_67_ShapePath_1
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_67_PathSvg_1
                            path: "M 12.305000305175781 0 L 12.305000305175781 7.099998474121094 C 12.304735325509682 7.635919749736786 12.091724067926407 8.14981684088707 11.712770462036133 8.528770446777344 C 11.333816856145859 8.907724052667618 10.819920718669891 9.12073340290226 10.2839994430542 9.12099838256836 L 2.0220000743865967 9.12099838256836 C 1.4859055280685425 9.120998448129889 0.9717534780502319 8.90810751914978 0.5925836563110352 8.529125213623047 C 0.21341383457183838 8.150142908096313 0.00026513083139434457 7.636092960834503 0 7.099998474121094 L 0 0 L 12.305000305175781 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_71
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 46
                    anchors.bottomMargin: -1
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_68_ShapePath_1
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_68_PathSvg_1
                            path: "M 6.081000328063965 0 L 6.081000328063965 16.710002899169922 C 6.081000328063965 17.134349286556244 5.912429660558701 17.541315227746964 5.612371444702148 17.841373443603516 C 5.312313228845596 18.141431659460068 4.90534633398056 18.310001373291016 4.480999946594238 18.310001373291016 L 1.6000003814697266 18.310001373291016 C 1.1756539940834045 18.310001373291023 0.7686875760555267 18.141431659460068 0.4686293601989746 17.841373443603516 C 0.16857114434242249 17.541315227746964 0 17.134349286556244 0 16.710002899169922 L 0 0 L 6.081000328063965 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_8Backup_15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 670
                anchors.rightMargin: 1233
                anchors.topMargin: 649
                anchors.bottomMargin: 246
                Shape {
                    id: rectangularBk_27
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 53
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_25_ShapePath_2
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: rectangularBk_25_PathSvg_2
                            path: "M 0.8130000233650208 0 C 1.2620075345039368 0 1.6260000467300415 0.36399251222610474 1.6260000467300415 0.8130000233650208 L 1.6260000467300415 9.510000228881836 C 1.6260000467300415 9.959007740020752 1.2620075345039368 10.322999954223633 0.8130000233650208 10.322999954223633 C 0.36399251222610474 10.322999954223633 0 9.959007740020752 0 9.510000228881836 L 0 0.8130000233650208 C 0 0.36399251222610474 0.36399251222610474 0 0.8130000233650208 0 Z"
                        }
                        fillColor: "#000000"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_72
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 8
                    anchors.bottomMargin: 32
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_64_ShapePath_2
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_64_PathSvg_2
                            path: "M 4.86299991607666 0 C 5.184707522392273 0 5.493238657712936 0.12779733538627625 5.720720291137695 0.35527896881103516 C 5.948201924562454 0.5827606022357941 6.076000213623045 0.8912926912307739 6.076000213623047 1.2130002975463867 L 6.076000213623047 23.33099937438965 L 0 23.33099937438965 L 0 1.2130002975463867 C -8.881784197001252e-16 0.8912926912307739 0.12779781222343445 0.5827606022357941 0.35527944564819336 0.35527896881103516 C 0.5827610790729523 0.12779733538627625 0.8912926912307739 8.881784197001252e-16 1.2130002975463867 0 L 4.86299991607666 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_73
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 32
                    anchors.bottomMargin: 27
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_66_ShapePath_2
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_66_PathSvg_2
                            path: "M 1.6169999837875366 0 L 15.574000358581543 0 C 16.46704477071762 0 17.19099998474121 0.7239555716514587 17.19099998474121 1.6169999837875366 L 17.19099998474121 3.128000020980835 C 17.19099998474121 4.021044433116913 16.46704477071762 4.744999885559082 15.574000358581543 4.744999885559082 L 1.6169999837875366 4.744999885559082 C 0.7239555716514587 4.744999885559082 0 4.021044433116913 0 3.128000020980835 L 0 1.6169999837875366 C 0 0.7239555716514587 0.7239555716514587 0 1.6169999837875366 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_74
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 3
                    anchors.rightMargin: 2
                    anchors.topMargin: 36
                    anchors.bottomMargin: 18
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_67_ShapePath_2
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_67_PathSvg_2
                            path: "M 12.305000305175781 0 L 12.305000305175781 7.099998474121094 C 12.304735325509682 7.635919749736786 12.091724067926407 8.14981684088707 11.712770462036133 8.528770446777344 C 11.333816856145859 8.907724052667618 10.819920718669891 9.12073340290226 10.2839994430542 9.12099838256836 L 2.0220000743865967 9.12099838256836 C 1.4859055280685425 9.120998448129889 0.9717534780502319 8.90810751914978 0.5925836563110352 8.529125213623047 C 0.21341383457183838 8.150142908096313 0.00026513083139434457 7.636092960834503 0 7.099998474121094 L 0 0 L 12.305000305175781 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_75
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 46
                    anchors.bottomMargin: -1
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_68_ShapePath_2
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_68_PathSvg_2
                            path: "M 6.081000328063965 0 L 6.081000328063965 16.710002899169922 C 6.081000328063965 17.134349286556244 5.912429660558701 17.541315227746964 5.612371444702148 17.841373443603516 C 5.312313228845596 18.141431659460068 4.90534633398056 18.310001373291016 4.480999946594238 18.310001373291016 L 1.6000003814697266 18.310001373291016 C 1.1756539940834045 18.310001373291023 0.7686875760555267 18.141431659460068 0.4686293601989746 17.841373443603516 C 0.16857114434242249 17.541315227746964 0 17.134349286556244 0 16.710002899169922 L 0 0 L 6.081000328063965 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_8Backup_16
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 838
                anchors.rightMargin: 1065
                anchors.topMargin: 648
                anchors.bottomMargin: 247
                Shape {
                    id: rectangularBk_28
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 53
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_25_ShapePath_3
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: rectangularBk_25_PathSvg_3
                            path: "M 0.8130000233650208 0 C 1.2620075345039368 0 1.6260000467300415 0.36399251222610474 1.6260000467300415 0.8130000233650208 L 1.6260000467300415 9.510000228881836 C 1.6260000467300415 9.959007740020752 1.2620075345039368 10.322999954223633 0.8130000233650208 10.322999954223633 C 0.36399251222610474 10.322999954223633 0 9.959007740020752 0 9.510000228881836 L 0 0.8130000233650208 C 0 0.36399251222610474 0.36399251222610474 0 0.8130000233650208 0 Z"
                        }
                        fillColor: "#000000"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_76
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 8
                    anchors.bottomMargin: 32
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_64_ShapePath_3
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_64_PathSvg_3
                            path: "M 4.86299991607666 0 C 5.184707522392273 0 5.493238657712936 0.12779733538627625 5.720720291137695 0.35527896881103516 C 5.948201924562454 0.5827606022357941 6.076000213623045 0.8912926912307739 6.076000213623047 1.2130002975463867 L 6.076000213623047 23.33099937438965 L 0 23.33099937438965 L 0 1.2130002975463867 C -8.881784197001252e-16 0.8912926912307739 0.12779781222343445 0.5827606022357941 0.35527944564819336 0.35527896881103516 C 0.5827610790729523 0.12779733538627625 0.8912926912307739 8.881784197001252e-16 1.2130002975463867 0 L 4.86299991607666 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_77
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 32
                    anchors.bottomMargin: 27
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_66_ShapePath_3
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_66_PathSvg_3
                            path: "M 1.6169999837875366 0 L 15.574000358581543 0 C 16.46704477071762 0 17.19099998474121 0.7239555716514587 17.19099998474121 1.6169999837875366 L 17.19099998474121 3.128000020980835 C 17.19099998474121 4.021044433116913 16.46704477071762 4.744999885559082 15.574000358581543 4.744999885559082 L 1.6169999837875366 4.744999885559082 C 0.7239555716514587 4.744999885559082 0 4.021044433116913 0 3.128000020980835 L 0 1.6169999837875366 C 0 0.7239555716514587 0.7239555716514587 0 1.6169999837875366 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_78
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 3
                    anchors.rightMargin: 2
                    anchors.topMargin: 36
                    anchors.bottomMargin: 18
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_67_ShapePath_3
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_67_PathSvg_3
                            path: "M 12.305000305175781 0 L 12.305000305175781 7.099998474121094 C 12.304735325509682 7.635919749736786 12.091724067926407 8.14981684088707 11.712770462036133 8.528770446777344 C 11.333816856145859 8.907724052667618 10.819920718669891 9.12073340290226 10.2839994430542 9.12099838256836 L 2.0220000743865967 9.12099838256836 C 1.4859055280685425 9.120998448129889 0.9717534780502319 8.90810751914978 0.5925836563110352 8.529125213623047 C 0.21341383457183838 8.150142908096313 0.00026513083139434457 7.636092960834503 0 7.099998474121094 L 0 0 L 12.305000305175781 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_79
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 6
                    anchors.rightMargin: 5
                    anchors.topMargin: 46
                    anchors.bottomMargin: -1
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_68_ShapePath_3
                        strokeWidth: 0.809
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_68_PathSvg_3
                            path: "M 6.081000328063965 0 L 6.081000328063965 16.710002899169922 C 6.081000328063965 17.134349286556244 5.912429660558701 17.541315227746964 5.612371444702148 17.841373443603516 C 5.312313228845596 18.141431659460068 4.90534633398056 18.310001373291016 4.480999946594238 18.310001373291016 L 1.6000003814697266 18.310001373291016 C 1.1756539940834045 18.310001373291023 0.7686875760555267 18.141431659460068 0.4686293601989746 17.841373443603516 C 0.16857114434242249 17.541315227746964 0 17.134349286556244 0 16.710002899169922 L 0 0 L 6.081000328063965 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_9Backup_4
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1435
                anchors.rightMargin: 464
                anchors.topMargin: 629
                anchors.bottomMargin: 240
                Shape {
                    id: rectangular2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 5
                    anchors.rightMargin: 4
                    anchors.topMargin: 23
                    anchors.bottomMargin: 34
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangular_ShapePath_2
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangular_PathSvg_2
                            path: "M 12.392000198364258 0 L 12.804000854492188 32.111000061035156 L 0 32.111000061035156 L 0 0.41100120544433594 L 12.392000198364258 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_80
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 7
                    anchors.rightMargin: 6
                    anchors.topMargin: 64
                    anchors.bottomMargin: -1
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_72_ShapePath_0
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_72_PathSvg_0
                            path: "M 7.866000175476074 0 L 8.277999877929688 23.47500228881836 C 8.277999877929688 24.099852323532104 8.029779732227325 24.69910591840744 7.587944030761719 25.140941619873047 C 7.146108329296112 25.582777321338654 6.546849966049194 25.830997467041016 5.921999931335449 25.830997467041016 L 2.3559999465942383 25.830997467041016 C 1.7311499118804932 25.830997467041016 1.1318920254707336 25.582777321338654 0.690056324005127 25.140941619873047 C 0.24822062253952026 24.69910591840744 0 24.099852323532104 0 23.47500228881836 L 0 0.4119987487792969 L 7.866000175476074 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_81
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 55
                    anchors.bottomMargin: 25
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_70_ShapePath_0
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_70_PathSvg_0
                            path: "M 1.6480000019073486 0 L 19.673999786376953 0 C 20.584165036678314 0 21.32200050354004 0.7378347516059875 21.32200050354004 1.6480000019073486 L 21.32200050354004 7.239999771118164 C 21.32200050354004 8.150165021419525 20.584165036678314 8.887999534606934 19.673999786376953 8.887999534606934 L 1.6480000019073486 8.887999534606934 C 0.7378347516059875 8.887999534606934 0 8.150165021419525 0 7.239999771118164 L 0 1.6480000019073486 C 0 0.7378347516059875 0.7378347516059875 0 1.6480000019073486 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_82
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 11
                    anchors.rightMargin: 9
                    anchors.bottomMargin: 74
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_71_ShapePath_0
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_71_PathSvg_0
                            path: "M 0.5299999713897705 0 L 0.531000018119812 0 C 0.8237109482288361 0 1.0609999895095825 0.23728904128074646 1.0609999895095825 0.5299999713897705 L 1.0609999895095825 14.718000411987305 C 1.0609999895095825 15.010711342096329 0.8237109482288361 15.248000144958496 0.531000018119812 15.248000144958496 L 0.5299999713897705 15.248000144958496 C 0.23728904128074646 15.248000144958496 0 15.010711342096329 0 14.718000411987305 L 0 0.5299999713897705 C 0 0.23728904128074646 0.23728904128074646 0 0.5299999713897705 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#000000"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_83
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 7
                    anchors.rightMargin: 6
                    anchors.topMargin: 15
                    anchors.bottomMargin: 66
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_69_ShapePath_0
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_69_PathSvg_0
                            path: "M 8.104000091552734 8.182999610900879 L 8.104000091552734 0.4119987487792969 L 0.4120001792907715 0 L 0 8.181999206542969 L 8.104000091552734 8.182999610900879 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_13Backup_2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 912
                anchors.rightMargin: 937
                anchors.topMargin: 572
                anchors.bottomMargin: 336
                Shape {
                    id: rectangularBk_29
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 39
                    anchors.rightMargin: 28
                    anchors.topMargin: 35
                    anchors.bottomMargin: 0
                    rotation: 180
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_26_ShapePath_0
                        strokeWidth: 0.5
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_26_PathSvg_0
                            path: "M 4.5 14.600000381469727 L 4.5 0.671999990940094 C 4.499494555988349 0.5840143263339996 4.481559857726097 0.49700088798999786 4.447231769561768 0.4159865975379944 C 4.412903681397438 0.3349723070859909 4.36286287009716 0.26156311109662056 4.300000190734863 0.20000000298023224 C 4.1766920909285545 0.07391344010829926 4.008348599076271 0.0019718403927982964 3.8320000171661377 1.1102230246251565e-16 L 0.671999990940094 0 C 0.5840057656168938 0.00045031006447970867 0.4969758912920952 0.018360085785388947 0.41595399379730225 0.052691396325826645 C 0.3349320963025093 0.08702270686626434 0.26152945309877396 0.13709282130002975 0.20000000298023224 0.20000000298023224 C 0.13713732361793518 0.26156311109662056 0.0870964527130127 0.3349723070859909 0.052768364548683167 0.4159865975379944 C 0.018440276384353638 0.49700088798999786 0.000505444011650983 0.5840143263339996 3.469446951953614e-18 0.671999990940094 L 0 14.600000381469727 L 4.5 14.600000381469727 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_30
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 50
                    anchors.rightMargin: 17
                    anchors.topMargin: 35
                    anchors.bottomMargin: 0
                    rotation: 180
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_27_ShapePath_0
                        strokeWidth: 0.5
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_27_PathSvg_0
                            path: "M 4.5 14.600000381469727 L 4.5 0.671999990940094 C 4.49954968993552 0.5840057656168938 4.481639850884676 0.4969758912920952 4.447308540344238 0.41595399379730225 C 4.412977229803801 0.3349320963025093 4.362907372415066 0.26152945309877396 4.300000190734863 0.20000000298023224 C 4.1766920909285545 0.07391344010829926 4.008348599076271 0.0019718403927982964 3.8320000171661377 1.1102230246251565e-16 L 0.671999990940094 0 C 0.5840057656168938 0.00045031006447970867 0.4969758912920952 0.018360085785388947 0.41595399379730225 0.052691396325826645 C 0.3349320963025093 0.08702270686626434 0.26152945309877396 0.13709282130002975 0.20000000298023224 0.20000000298023224 C 0.13709282130002975 0.26152945309877396 0.08702270686626434 0.3349320963025093 0.052691396325826645 0.41595399379730225 C 0.018360085785388947 0.4969758912920952 0.00045031006447979194 0.5840057656168938 8.326672684688674e-17 0.671999990940094 L 0 14.600000381469727 L 4.5 14.600000381469727 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: shapeComb
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 22
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 15
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_0
                        strokeWidth: 0.5
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_0
                            path: "M 27.53999900817871 8.655641750010545e-7 C 28.363448679447174 -0.0004815376142914829 29.174489378929138 0.20068570971488953 29.902265548706055 0.5859277248382568 C 30.63004171848297 0.9711697399616241 31.25241380929947 1.5287655591964722 31.715002059936523 2.210000991821289 C 31.925121650099754 2.399618700146675 32.125384733080864 2.5998813062906265 32.31500244140625 2.8100008964538574 L 38.529998779296875 9.828001022338867 L 38.529998779296875 13.317001342773438 L 45.66099548339844 18.940000534057617 C 45.91717520356178 19.14203777909279 46.15815845131874 19.36263194680214 46.381996154785156 19.600000381469727 C 47.25065803527832 20.034197211265564 47.983328223228455 20.69871610403061 48.5 21.520999908447266 C 48.86874169111252 22.117968380451202 49.10900692641735 22.785242557525635 49.205467224121094 23.48025131225586 C 49.30192752182484 24.175260066986084 49.25246341526508 24.88274383544922 49.06023406982422 25.55756950378418 C 48.868004724383354 26.23239517211914 48.537232249975204 26.85974484682083 48.089012145996094 27.39959716796875 C 47.64079204201698 27.93944948911667 47.08496779203415 28.379952549934387 46.457000732421875 28.69300079345703 C 46.20527520775795 28.94537901878357 45.93986955285072 29.183736950159073 45.66199493408203 29.406999588012695 L 38.69499969482422 34.90700149536133 L 0 34.90700149536133 L 0 13.450000762939453 L 16.552000045776367 13.450000762939453 L 16.552000045776367 9.830000877380371 L 22.767000198364258 2.8120009899139404 C 22.93778456747532 2.6191206872463226 23.120121330022812 2.4367853552103043 23.31300163269043 2.266000986099243 C 23.778705298900604 1.5715806484222412 24.40753996372223 1.001911699771881 25.144453048706055 0.606869101524353 C 25.88136613368988 0.21182650327682495 26.703884422779083 0.003456112130038491 27.53999900817871 8.655641750010545e-7 Z M 44.19999694824219 20.770000457763672 C 43.41362780332565 20.76992669387255 42.65154606103897 21.042434573173523 42.04352569580078 21.541120529174805 C 41.43550533056259 22.039806485176086 41.01914966106415 22.733834266662598 40.86534881591797 23.505016326904297 C 40.71154797077179 24.276198387145996 40.82981866598129 25.07685023546219 41.20001983642578 25.770627975463867 C 41.57022100687027 26.464405715465546 42.1694552898407 27.008410394191742 42.89569091796875 27.31000328063965 C 43.6219265460968 27.611596167087555 44.430251121520996 27.652128472924232 45.183013916015625 27.424697875976562 C 45.935776710510254 27.197267279028893 46.58643087744713 26.71593600511551 47.02417755126953 26.062671661376953 C 47.461924225091934 25.409407317638397 47.65969257801771 24.62460297346115 47.58380889892578 23.841903686523438 C 47.50792521983385 23.059204399585724 47.16308581829071 22.327008605003357 46.608001708984375 21.770000457763672 C 46.29216831922531 21.45307233929634 45.916885405778885 21.201598063111305 45.50366973876953 21.029996871948242 C 45.09045407176018 20.85839568078518 44.647427558898926 20.770042428157467 44.19999694824219 20.770000457763672 Z M 27.53999900817871 1.6200008392333984 C 26.74684363603592 1.6209449006710202 25.978560209274292 1.896899938583374 25.366071701049805 2.400838613510132 C 24.753583192825317 2.9047772884368896 24.33479256927967 3.605513632297516 24.181074142456055 4.383631229400635 C 24.02735571563244 5.161748826503754 24.148221164941788 5.969094514846802 24.523069381713867 6.668083190917969 C 24.897917598485947 7.367071866989136 25.503551602363586 7.914446800947189 26.236764907836914 8.216927528381348 C 26.96997821331024 8.519408255815506 27.785394489765167 8.558276161551476 28.54405403137207 8.326906204223633 C 29.302713572978973 8.09553624689579 29.95766970515251 7.608247101306915 30.397302627563477 6.948081016540527 C 30.83693554997444 6.287914931774139 31.034041471779346 5.495725572109222 30.95503044128418 4.706514835357666 C 30.876019410789013 3.9173040986061096 30.525778472423553 3.179911494255066 29.963998794555664 2.6200008392333984 C 29.320454239845276 1.978597342967987 28.448595106601715 1.6189193732570857 27.53999900817871 1.6200008392333984 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangular3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 24
                    anchors.rightMargin: 13
                    anchors.topMargin: 16
                    anchors.bottomMargin: 17
                    rotation: 180
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangular_ShapePath_3
                        strokeWidth: 0.5
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangular_PathSvg_3
                            path: "M 3.6700000762939453 0 L 30.14299964904785 0 C 32.16988468170166 0 33.8129997253418 1.6431150436401367 33.8129997253418 3.6700000762939453 L 33.8129997253418 13.022000312805176 C 33.8129997253418 15.048885345458984 32.16988468170166 16.691999435424805 30.14299964904785 16.691999435424805 L 3.6700000762939453 16.691999435424805 C 1.6431150436401367 16.691999435424805 0 15.048885345458984 0 13.022000312805176 L 0 3.6700000762939453 C 0 1.6431150436401367 1.6431150436401367 0 3.6700000762939453 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_24
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 49
                    anchors.topMargin: 14
                    anchors.bottomMargin: 15
                    rotation: 180
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_24_ShapePath_0
                        strokeWidth: 0.5
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_24_PathSvg_0
                            path: "M 18.518999099731445 21.450002670288086 C 18.96800521016121 21.45052905549528 19.412706345319748 21.362479209899902 19.827634811401367 21.190895080566406 C 20.242563277482986 21.01931095123291 20.619569659233093 20.767562985420227 20.93706512451172 20.4500675201416 C 21.254560589790344 20.132572054862976 21.506308555603027 19.75556567311287 21.677892684936523 19.34063720703125 C 21.84947681427002 18.92570874094963 21.937526659865398 18.481007605791092 21.937000274658203 18.032001495361328 L 21.937000274658203 3.4180023670196533 C 21.937526659865398 2.9689962565898895 21.84947681427002 2.524296313524246 21.677892684936523 2.109367847442627 C 21.506308555603027 1.6944393813610077 21.254560589790344 1.3174328804016113 20.93706512451172 0.9999374151229858 C 20.619569659233093 0.6824419498443604 20.242563277482986 0.4306941330432892 19.827634811401367 0.2591100037097931 C 19.412706345319748 0.087525874376297 18.96800521016121 -0.0005240389500613674 18.518999099731445 0.0000023462571334675886 L 0 0.0000023462571334675886 L 0 21.450002670288086 L 18.518999099731445 21.450002670288086 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_10Backup_10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 575
                anchors.rightMargin: 1301
                anchors.topMargin: 712
                anchors.bottomMargin: 216
                Shape {
                    id: shapeComb1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_1
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_1
                            path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#ffee00"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_9Backup_5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 606
                anchors.rightMargin: 1293
                anchors.topMargin: 629
                anchors.bottomMargin: 240
                Shape {
                    id: rectangular4
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 5
                    anchors.rightMargin: 4
                    anchors.topMargin: 23
                    anchors.bottomMargin: 34
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangular_ShapePath_4
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangular_PathSvg_4
                            path: "M 12.392000198364258 0 L 12.804000854492188 32.111000061035156 L 0 32.111000061035156 L 0 0.41100120544433594 L 12.392000198364258 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_84
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 7
                    anchors.rightMargin: 6
                    anchors.topMargin: 64
                    anchors.bottomMargin: -1
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_72_ShapePath_1
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_72_PathSvg_1
                            path: "M 7.866000175476074 0 L 8.277999877929688 23.47500228881836 C 8.277999877929688 24.099852323532104 8.029779732227325 24.69910591840744 7.587944030761719 25.140941619873047 C 7.146108329296112 25.582777321338654 6.546849966049194 25.830997467041016 5.921999931335449 25.830997467041016 L 2.3559999465942383 25.830997467041016 C 1.7311499118804932 25.830997467041016 1.1318920254707336 25.582777321338654 0.690056324005127 25.140941619873047 C 0.24822062253952026 24.69910591840744 0 24.099852323532104 0 23.47500228881836 L 0 0.4119987487792969 L 7.866000175476074 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_85
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 55
                    anchors.bottomMargin: 25
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_70_ShapePath_1
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_70_PathSvg_1
                            path: "M 1.6480000019073486 0 L 19.673999786376953 0 C 20.584165036678314 0 21.32200050354004 0.7378347516059875 21.32200050354004 1.6480000019073486 L 21.32200050354004 7.239999771118164 C 21.32200050354004 8.150165021419525 20.584165036678314 8.887999534606934 19.673999786376953 8.887999534606934 L 1.6480000019073486 8.887999534606934 C 0.7378347516059875 8.887999534606934 0 8.150165021419525 0 7.239999771118164 L 0 1.6480000019073486 C 0 0.7378347516059875 0.7378347516059875 0 1.6480000019073486 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_86
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 11
                    anchors.rightMargin: 9
                    anchors.bottomMargin: 74
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_71_ShapePath_1
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_71_PathSvg_1
                            path: "M 0.5299999713897705 0 L 0.531000018119812 0 C 0.8237109482288361 0 1.0609999895095825 0.23728904128074646 1.0609999895095825 0.5299999713897705 L 1.0609999895095825 14.718000411987305 C 1.0609999895095825 15.010711342096329 0.8237109482288361 15.248000144958496 0.531000018119812 15.248000144958496 L 0.5299999713897705 15.248000144958496 C 0.23728904128074646 15.248000144958496 0 15.010711342096329 0 14.718000411987305 L 0 0.5299999713897705 C 0 0.23728904128074646 0.23728904128074646 0 0.5299999713897705 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#000000"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangularBk_87
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 7
                    anchors.rightMargin: 6
                    anchors.topMargin: 15
                    anchors.bottomMargin: 66
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_69_ShapePath_1
                        strokeWidth: 0.824
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: rectangularBk_69_PathSvg_1
                            path: "M 8.104000091552734 8.182999610900879 L 8.104000091552734 0.4119987487792969 L 0.4120001792907715 0 L 0 8.181999206542969 L 8.104000091552734 8.182999610900879 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b3b3b3"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_10Backup_11
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 842
                anchors.rightMargin: 1034
                anchors.topMargin: 711
                anchors.bottomMargin: 217
                Shape {
                    id: shapeComb2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_2
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_2
                            path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#ffee00"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_14Backup_8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 754
                anchors.rightMargin: 1122
                anchors.topMargin: 689
                anchors.bottomMargin: 195
                Item {
                    id: group_10Backup_6
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 44
                    anchors.bottomMargin: 0
                    Shape {
                        id: shapeComb3
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_3
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: shapeComb_PathSvg_3
                                path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ffee00"
                        }
                        antialiasing: true
                    }
                }

                Item {
                    id: group_10Backup_7
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 44
                    Shape {
                        id: shapeComb4
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_4
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: shapeComb_PathSvg_4
                                path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ffee00"
                        }
                        antialiasing: true
                    }
                }
            }

            Item {
                id: group_14Backup_9
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 938
                anchors.rightMargin: 938
                anchors.topMargin: 686
                anchors.bottomMargin: 198
                Item {
                    id: group_10Backup_8
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 44
                    anchors.bottomMargin: 0
                    Shape {
                        id: shapeComb5
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_5
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: shapeComb_PathSvg_5
                                path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ffee00"
                        }
                        antialiasing: true
                    }
                }

                Item {
                    id: group_10Backup_9
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 44
                    Shape {
                        id: shapeComb6
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_6
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: shapeComb_PathSvg_6
                                path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ffee00"
                        }
                        antialiasing: true
                    }
                }
            }

            Item {
                id: group_14Backup_10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1265
                anchors.rightMargin: 611
                anchors.topMargin: 686
                anchors.bottomMargin: 198
                Item {
                    id: group_10Backup_12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 44
                    anchors.bottomMargin: 0
                    Shape {
                        id: shapeComb7
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_7
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: shapeComb_PathSvg_7
                                path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ffee00"
                        }
                        antialiasing: true
                    }
                }

                Item {
                    id: group_10Backup_13
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 44
                    Shape {
                        id: shapeComb8
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_8
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: shapeComb_PathSvg_8
                                path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ffee00"
                        }
                        antialiasing: true
                    }
                }
            }

            Item {
                id: group_10Backup_14
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1123
                anchors.rightMargin: 753
                anchors.topMargin: 708
                anchors.bottomMargin: 220
                Shape {
                    id: shapeComb9
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_9
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_9
                            path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#ffee00"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_10Backup_15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1455
                anchors.rightMargin: 421
                anchors.topMargin: 708
                anchors.bottomMargin: 220
                Shape {
                    id: shapeComb10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_10
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_10
                            path: "M 23.756999969482422 0 C 24.06681403517723 0.00013728751218877733 24.368984937667847 0.09620323777198792 24.621999740600586 0.2749999761581421 L 43.856998443603516 13.86299991607666 C 44.0530356913805 14.001532554626465 44.21296460926533 14.185090512037277 44.32334518432617 14.398252487182617 C 44.433725759387016 14.611414462327957 44.49133682250977 14.84795467555523 44.491336822509766 15.088000297546387 C 44.49133682250977 15.328045919537544 44.433725759387016 15.564586132764816 44.32334518432617 15.777748107910156 C 44.21296460926533 15.990910083055496 44.0530356913805 16.174467086791992 43.856998443603516 16.312999725341797 L 24.62299919128418 29.899999618530273 C 24.39845098555088 30.058497443795204 24.134671926498413 30.152251666411757 23.860462188720703 30.1710262298584 C 23.586252450942993 30.18980079330504 23.312155470252037 30.132873713970184 23.068099975585938 30.006460189819336 C 22.824044480919838 29.880046665668488 22.61941370368004 29.689008370041847 22.476551055908203 29.45420265197754 C 22.333688408136368 29.21939693391323 22.25808540221624 28.94985094666481 22.257999420166016 28.674999237060547 L 22.257999420166016 22.551000595092773 L 1.5 22.551000595092773 C 1.1021752655506134 22.55100059509277 0.7206443846225739 22.3929645717144 0.439339816570282 22.11166000366211 C 0.1580352485179901 21.830355435609818 2.220446049250313e-16 21.44882532954216 0 21.051000595092773 L 0 9.12399959564209 C 1.1102230246251565e-16 8.726174861192703 0.1580352485179901 8.344644755125046 0.439339816570282 8.063340187072754 C 0.7206443846225739 7.782035619020462 1.1021752655506134 7.623999595642092 1.5 7.62399959564209 L 22.256999969482422 7.62399959564209 L 22.256999969482422 1.5 C 22.25699996948242 1.1021752655506134 22.415035992860794 0.7206443846225739 22.696340560913086 0.439339816570282 C 22.977645128965378 0.1580352485179901 23.359175235033035 3.3306690738754696e-16 23.756999969482422 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#ffee00"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: group_4
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1069
                anchors.rightMargin: 804
                anchors.topMargin: 603
                anchors.bottomMargin: 260
                Shape {
                    id: fill_1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 10
                    anchors.rightMargin: 7
                    anchors.topMargin: 68
                    anchors.bottomMargin: 0
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_1_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: fill_1_PathSvg_0
                            path: "M 21.718997955322266 27.11699676513672 L 7.799999237060547 27.11699676513672 C 3.4919991493225098 27.11699676513672 0 19.764999389648438 0 10.694999694824219 L 0 0 L 29.519001007080078 0 L 29.519001007080078 10.694999694824219 C 29.519001007080078 19.764999389648438 26.026998043060303 27.11699676513672 21.718997955322266 27.11699676513672 Z"
                        }
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: shapeComb11
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1
                    anchors.rightMargin: -1
                    anchors.bottomMargin: 42
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_11
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_11
                            path: "M 1.399999976158142 46.194000244140625 C 1.399999976158142 46.194000244140625 1.66799995303154 37.14299964904785 2.0139999389648438 25.437999725341797 C 2.2769999504089355 16.56599998474121 3.1999999284744263 7.629999876022339 3.6389999389648438 3.8259999752044678 C 3.7679999321699142 2.690999984741211 4.269999861717224 1.8530000448226929 4.876999855041504 1.75600004196167 C 7.799999952316284 1.2910000383853912 16.3439998626709 0 21.086999893188477 0 C 22.971999883651733 0 25.667999744415283 0.16300000250339508 28.44499969482422 0.38199999928474426 L 29.145000457763672 0.43799999356269836 L 29.145000457763672 4.138000011444092 C 30.391643404960632 3.532404839992523 31.770090579986572 3.24862626940012 33.15456771850586 3.3125574588775635 C 34.53904485702515 3.376488648355007 35.88547170162201 3.786094307899475 37.07099914550781 4.504000186920166 L 37.07099914550781 1.1829999685287476 C 39.006999135017395 1.3829999715089798 40.284000396728516 1.5299999713897705 40.284000396728516 1.5299999713897705 C 40.284000396728516 1.5299999713897705 41.54200154542923 8.630000591278076 42.518001556396484 16.020000457763672 L 42.611000061035156 16.736000061035156 C 42.88900005817413 18.886000156402588 43.13799859583378 21.042999267578125 43.321998596191406 23.035999298095703 C 43.48899859189987 24.85499930381775 43.63800100982189 26.873000860214233 43.76900100708008 28.93600082397461 L 43.814998626708984 29.666000366210938 L 43.83700180053711 30.031999588012695 L 43.880001068115234 30.764999389648438 C 44.32700106501579 38.464999198913574 44.53099822998047 46.18899917602539 44.53099822998047 46.18899917602539 L 45.430999755859375 46.18899917602539 C 45.91099974513054 46.18899917602539 46.29999923706055 46.93100064992905 46.29999923706055 47.84600067138672 L 46.29999923706055 52.71699905395508 L 0 52.71699905395508 L 0 47.85100173950195 C 0 46.93600171804428 0.3890000283718109 46.194000244140625 0.8690000176429749 46.194000244140625 L 1.399999976158142 46.194000244140625 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_11
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 34
                    anchors.bottomMargin: 21
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_11_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_11_PathSvg_0
                            path: "M 39.67417526245117 0.00299835205078125 L 39.67417526245117 1.8689994812011719 C 39.71616740524769 2.58870530128479 39.51892229914665 3.302089035511017 39.11317443847656 3.897998809814453 L 38.16017532348633 4.970996856689453 L 38.16017532348633 11.50799560546875 C 38.19079736247659 12.096314549446106 38.03507721424103 12.679304301738739 37.71517562866211 13.173995971679688 L 37.28217697143555 13.698997497558594 L 37.28217697143555 18.666000366210938 L 39.322174072265625 27.96599578857422 L 45.30717468261719 27.96599578857422 C 46.03417468070984 27.96599578857422 46.624176025390625 29.277996063232422 46.624176025390625 30.89599609375 L 46.624176025390625 37.525001525878906 C 46.624176025390625 39.143001556396484 46.03417468070984 40.45500183105469 45.30717468261719 40.45500183105469 L 41.775177001953125 40.45500183105469 C 40.84217393398285 40.42846605181694 39.9475639462471 40.07769066095352 39.245174407958984 39.46299743652344 C 38.34022933244705 38.669615149497986 37.187145709991455 38.21630376204848 35.98417663574219 38.180999755859375 L 17.084177017211914 38.180999755859375 C 16.20708292722702 38.19301382731646 15.350050270557404 38.445139676332474 14.60617733001709 38.909996032714844 L 12.974177360534668 39.887001037597656 C 12.397229850292206 40.24754512310028 11.732455909252167 40.442959980107844 11.052177429199219 40.451995849609375 L 3.4321768283843994 40.451995849609375 C 2.705176830291748 40.451995849609375 2.1161768436431885 39.13999557495117 2.1161768436431885 37.521995544433594 L 2.1161768436431885 27.96099853515625 L 1.7021770477294922 25.6199951171875 L 1.7021770477294922 4.970996856689453 L 0.6071769595146179 3.871997833251953 C 0.16963335871696472 3.2734315991401672 -0.042824184987694025 2.539746344089508 0.007176937069743872 1.7999992370605469 L 0.007176937069743872 0 L 39.67417526245117 0.00299835205078125 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: shapeComb12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 27
                    anchors.rightMargin: 8
                    anchors.topMargin: 11
                    anchors.bottomMargin: 44
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_12
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_12
                            path: "M 5.636775016784668 7.105427357601002e-15 C 6.684114933013916 3.552713678800501e-15 7.688559889793396 0.4160541296005249 8.4291410446167 1.1566352844238281 C 9.169722199440002 1.8972164392471313 9.585780143737793 2.9016594886779785 9.585780143737793 3.9489994049072266 L 9.585780143737793 21.048999786376953 L 10.343775749206543 21.048999786376953 C 10.580679282546043 21.057791187427938 10.805974334478378 21.15383632481098 10.976351737976074 21.318675994873047 C 11.14672914147377 21.483515664935112 11.250168222934008 21.705517455935478 11.266779899597168 21.942001342773438 L 11.27277660369873 22.060001373291016 C 11.283079961314797 22.31711208820343 11.19112092256546 22.567832961678505 11.017016410827637 22.757305145263672 C 10.842911899089813 22.94677732884884 10.600838869810104 23.059569381177425 10.343775749206543 23.070999145507812 L 9.585780143737793 23.070999145507812 L 9.585780143737793 40.28300094604492 L 1.6857787370681763 40.28300094604492 L 1.6857787370681763 23.075000762939453 L 0.9297820329666138 23.075000762939453 C 0.6928784996271133 23.06620936188847 0.46758344769477844 22.97016040980816 0.2972060441970825 22.805320739746094 C 0.1268286406993866 22.64048106968403 0.02338955132290721 22.418483093380928 0.006777874659746885 22.18199920654297 L 0.0007811705581843853 22.06399917602539 C -0.009522187057882547 21.806888461112976 0.08243685960769653 21.5561675876379 0.25654137134552 21.366695404052734 C 0.4306458830833435 21.177223220467567 0.6727189123630524 21.06443116813898 0.9297820329666138 21.053001403808594 L 1.6857787370681763 21.053001403808594 L 1.6857787370681763 3.9449996948242188 C 1.6854918536555488 2.9322633743286133 2.0742997527122498 1.9581251740455627 2.771845817565918 1.2239151000976562 C 3.469391882419586 0.48970502614974976 4.422356009483337 0.05154718831182237 5.433779716491699 7.105427357601002e-15 L 5.636775016784668 7.105427357601002e-15 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_13
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 25
                    anchors.rightMargin: 8
                    anchors.topMargin: 46
                    anchors.bottomMargin: 31
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_13_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_13_PathSvg_0
                            path: "M 6.8119964599609375 17.669002532958984 C 5.0053417682647705 17.669002532958984 3.272683620452881 16.95130681991577 1.9951858520507812 15.673809051513672 C 0.7176880836486816 14.396311283111572 1.4210854715202004e-14 12.663653135299683 1.4210854715202004e-14 10.856998443603516 L 1.4210854715202004e-14 1.3169975280761719 C 0 0.9677074253559113 0.13875678181648254 0.6327237784862518 0.3857421875 0.3857383728027344 C 0.6327275931835175 0.13875296711921692 0.9677112400531769 7.105427357601002e-15 1.3170013427734375 7.105427357601002e-15 L 12.306999206542969 7.105427357601002e-15 C 12.479950115084648 0 12.651211202144623 0.034064799547195435 12.810997009277344 0.100250244140625 C 12.970782816410065 0.16643568873405457 13.115963608026505 0.26344361901283264 13.238258361816406 0.3857383728027344 C 13.360553115606308 0.5080331265926361 13.457564860582352 0.6532177329063416 13.523750305175781 0.8130035400390625 C 13.58993574976921 0.9727893471717834 13.624000549316406 1.1440466195344925 13.624000549316406 1.3169975280761719 L 13.624000549316406 10.856998443603516 C 13.624000549316406 12.663653135299683 12.906312465667725 14.396311283111572 11.628814697265625 15.673809051513672 C 10.351316928863525 16.95130681991577 8.618651151657104 17.669002532958984 6.8119964599609375 17.669002532958984 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: shapeComb13
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 12
                    anchors.rightMargin: 24
                    anchors.topMargin: 16
                    anchors.bottomMargin: 39
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeComb_ShapePath_13
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeComb_PathSvg_13
                            path: "M 5.443000793457031 0 C 6.238650262355804 3.552713678800501e-15 7.001710474491119 0.3160720467567444 7.564319610595703 0.8786811828613281 C 8.126928746700287 1.4412903189659119 8.443000793457031 2.204350531101227 8.443000793457031 3 L 8.443000793457031 21.055999755859375 L 9.375999450683594 21.055999755859375 C 9.624933153390884 21.055972191967157 9.865128174424171 21.147785618901253 10.05057144165039 21.313854217529297 C 10.23601470887661 21.47992281615734 10.35366952046752 21.70857249200344 10.381000518798828 21.95600128173828 L 10.387001037597656 22.066001892089844 C 10.38700103759765 22.19876830279827 10.360850840806961 22.33023213595152 10.310043334960938 22.452892303466797 C 10.259235829114914 22.575552470982075 10.184765189886093 22.687007576227188 10.090885162353516 22.780887603759766 C 9.997005134820938 22.874767631292343 9.88555384427309 22.9492344558239 9.762893676757812 23.000041961669922 C 9.640233509242535 23.050849467515945 9.508765861392021 23.07699966430664 9.375999450683594 23.07699966430664 L 8.443000793457031 23.07699966430664 L 8.443000793457031 40.28700256347656 L 1.9430007934570312 40.28700256347656 L 1.9430007934570312 23.077999114990234 L 1.0110015869140625 23.077999114990234 C 0.7620678842067719 23.078026678882452 0.5218747705221176 22.986213251948357 0.33643150329589844 22.820144653320312 C 0.15098823606967926 22.65407605469227 0.03333151713013649 22.425430193543434 0.006000518798828125 22.178001403808594 L 3.552713678800501e-15 22.06800079345703 C -3.552713678800501e-15 21.799866914749146 0.10651659965515137 21.5427143573761 0.2961158752441406 21.35311508178711 C 0.4857151508331299 21.16351580619812 0.7428677082061768 21.05699920654297 1.0110015869140625 21.05699920654297 L 1.9430007934570312 21.05699920654297 L 1.9430007934570312 3 C 1.941681393305771 2.233925759792328 2.233480393886566 1.4963710308074951 2.7585678100585938 0.9385585784912109 C 3.2836552262306213 0.38074612617492676 4.002246141433716 0.04494195431470871 4.767002105712891 0 L 4.943000793457031 0 L 5.443000793457031 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_7
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 26
                    anchors.rightMargin: 18
                    anchors.topMargin: 1
                    anchors.bottomMargin: 86
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_7_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_7_PathSvg_0
                            path: "M 2.2350010871887207 8.249000549316406 L 4.4766375140170567e-7 8.249000549316406 L 4.4766375140170567e-7 1.1180003881454468 C -0.00013094956784698297 0.9712297320365906 0.02866445854306221 0.8258721083402634 0.08474013209342957 0.69023597240448 C 0.14081580564379692 0.5545998364686966 0.22307325899600983 0.4313446208834648 0.3268093764781952 0.3275156319141388 C 0.43054549396038055 0.22368664294481277 0.5537265539169312 0.1413196101784706 0.6893124580383301 0.08512258529663086 C 0.824898362159729 0.028925560414791107 0.9702303409576416 3.89252917898375e-7 1.1170010566711426 4.48069954472885e-7 C 1.2638558894395828 -0.00013108343216572393 1.4092972576618195 0.02869706228375435 1.5449986457824707 0.0848352313041687 C 1.680700033903122 0.14097340032458305 1.8039991185069084 0.2233196124434471 1.9078412055969238 0.3271616995334625 C 2.0116832926869392 0.43100378662347794 2.094027865678072 0.5543034374713898 2.1501660346984863 0.690004825592041 C 2.2063042037189007 0.8257062137126923 2.235132618690841 0.9711455553770065 2.2350010871887207 1.1180003881454468 L 2.2350010871887207 8.249000549316406 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_9
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 29
                    anchors.rightMargin: 15
                    anchors.topMargin: 1
                    anchors.bottomMargin: 86
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_9_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_9_PathSvg_0
                            path: "M 2.2355005741119385 8.282432556152344 L 0.0005000673700124025 8.282432556152344 L 0.0005000673700124025 1.151432752609253 C -0.003974537132307887 1.0018677860498428 0.021617505699396133 0.8529264032840729 0.07576404511928558 0.7134349942207336 C 0.12991058453917503 0.5739435851573944 0.21151204407215118 0.44674066454172134 0.3157237470149994 0.33936458826065063 C 0.4199354499578476 0.23198851197957993 0.5446436852216721 0.14662423729896545 0.6824535131454468 0.08833055198192596 C 0.8202633410692215 0.030036866664886475 0.9683685004711151 1.1102230246251565e-16 1.1180003881454468 0 C 1.2676322758197784 1.3877787807814457e-16 1.4157450646162033 0.030036866664886475 1.553554892539978 0.08833055198192596 C 1.6913647204637527 0.14662423729896545 1.8160652965307236 0.23198851197957993 1.9202769994735718 0.33936458826065063 C 2.02448870241642 0.44674066454172134 2.1060900576412678 0.5739435851573944 2.1602365970611572 0.7134349942207336 C 2.2143831364810467 0.8529264032840729 2.2399751786142588 1.0018677860498428 2.2355005741119385 1.151432752609253 L 2.2355005741119385 8.282432556152344 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_15
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 7
                    anchors.rightMargin: 15
                    anchors.topMargin: 41
                    anchors.bottomMargin: 27
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_15_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_15_PathSvg_0
                            path: "M 12.25200080871582 26.60900115966797 C 9.002568483352661 26.609001159667983 5.886223316192627 25.31816530227661 3.5885276794433594 23.020469665527344 C 1.2908320426940918 20.722774028778076 3.552713678800501e-15 17.60643458366394 0 14.357002258300781 L 0 2.5569992065429688 C -3.552713678800501e-15 1.8788406252861023 0.2693975567817688 1.22845858335495 0.7489280700683594 0.7489280700683594 C 1.22845858335495 0.2693975567817688 1.878842532634735 -7.105427357601002e-15 2.5570011138916016 0 L 21.94700050354004 0 C 22.625159084796906 -1.4210854715202004e-14 23.275541126728058 0.2693975567817688 23.75507164001465 0.7489280700683594 C 24.23460215330124 1.22845858335495 24.503999710083015 1.8788406252861023 24.503999710083008 2.5569992065429688 L 24.503999710083008 14.357002258300781 C 24.503999710082994 17.60643458366394 23.213167667388916 20.722774028778076 20.91547203063965 23.020469665527344 C 18.61777639389038 25.31816530227661 15.50143313407898 26.60900115966797 12.25200080871582 26.60900115966797 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_22
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 9
                    anchors.rightMargin: 18
                    anchors.topMargin: 54
                    anchors.bottomMargin: 22
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_22_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_22_PathSvg_0
                            path: "M 19.212003707885742 9.605995178222656 C 19.212003707885742 11.505882501602173 18.648624300956726 13.36311149597168 17.593103408813477 14.94281005859375 C 16.537582516670227 16.52250862121582 15.037326693534851 17.75373375415802 13.282059669494629 18.480789184570312 C 11.526792645454407 19.207844614982605 9.595346570014954 19.39806967973709 7.731965065002441 19.027420043945312 C 5.868583559989929 18.656770408153534 4.156960129737854 17.741891264915466 2.8135368824005127 16.398468017578125 C 1.4701136350631714 15.055044770240784 0.5552305728197098 13.343415379524231 0.1845809370279312 11.480033874511719 C -0.18606869876384735 9.616652369499207 0.0041620731353759766 7.685206294059753 0.7312175035476685 5.929939270019531 C 1.458272933959961 4.174672245979309 2.689497947692871 2.6744250059127808 4.269196510314941 1.6189041137695312 C 5.848895072937012 0.5633832216262817 7.706116437911987 1.4210854715202004e-14 9.606003761291504 0 C 12.15367341041565 1.4210854715202004e-14 14.596999287605286 1.012055516242981 16.398473739624023 2.8135299682617188 C 18.19994819164276 4.6150044202804565 19.212003707885742 7.058325529098511 19.212003707885742 9.605995178222656 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_24
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 29
                    anchors.rightMargin: 10
                    anchors.topMargin: 53
                    anchors.bottomMargin: 34
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_24_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_24_PathSvg_0
                            path: "M 8.088006019592285 4.043998718261719 C 8.088006019592271 4.843826353549957 7.850825011730194 5.625693321228027 7.406464576721191 6.2907257080078125 C 6.962104141712189 6.955758094787598 6.330520987510681 7.474085837602615 5.59157657623291 7.7801666259765625 C 4.852632164955139 8.08624741435051 4.039518654346466 8.166330680251122 3.2550594806671143 8.010292053222656 C 2.4706003069877625 7.854253426194191 1.750028133392334 7.4690974950790405 1.1844645738601685 6.903533935546875 C 0.6189010143280029 6.3379703760147095 0.23374513536691666 5.617398321628571 0.07770650833845139 4.832939147949219 C -0.07833211869001389 4.048479974269867 0.0017511546611785889 3.2353662252426147 0.30783194303512573 2.4964218139648438 C 0.6139127314090729 1.7574774026870728 1.132248044013977 1.1258942484855652 1.7972804307937622 0.6815338134765625 C 2.4623128175735474 0.23717337846755981 3.2441720366477966 0 4.043999671936035 0 C 5.116535186767578 0 6.145145416259766 0.4260587692260742 6.903542518615723 1.1844558715820312 C 7.66193962097168 1.9428529739379883 8.088006019592285 2.971463203430176 8.088006019592285 4.043998718261719 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: rectangular5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 23
                    anchors.rightMargin: 12
                    anchors.topMargin: 9
                    anchors.bottomMargin: 83
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangular_ShapePath_5
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: rectangular_PathSvg_5
                            path: "M 0 0 L 11.230999946594238 0 L 11.230999946594238 2.621999979019165 L 0 2.621999979019165 L 0 0 Z"
                        }
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }
            }

            Shape {
                id: route_14Backup_35
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 617
                anchors.rightMargin: 1245
                anchors.topMargin: 717
                anchors.bottomMargin: 110
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_14Backup_35_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#0770eb"
                    PathSvg {
                        id: route_14Backup_35_PathSvg_0
                        path: "M 58.48400115966797 0 L 0 130.63400268554688"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Item {
                id: group_10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 511
                anchors.rightMargin: 1075
                anchors.topMargin: 575
                anchors.bottomMargin: 314
                Shape {
                    id: route_14Backup_36
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 106
                    anchors.rightMargin: 228
                    anchors.topMargin: 30
                    anchors.bottomMargin: 6
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_14Backup_36_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#0770eb"
                        PathSvg {
                            id: route_14Backup_36_PathSvg_0
                            path: "M 0 0 L 0 33"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_25Backup_5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 23
                    Shape {
                        id: rectangularBk_31
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_30_ShapePath_0
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_30_PathSvg_0
                                path: "M 10 0 L 324.1520080566406 0 C 329.6748557090759 0 334.1520080566406 4.477152347564697 334.1520080566406 10 L 334.1520080566406 36 C 334.1520080566406 41.5228476524353 329.6748557090759 46 324.1520080566406 46 L 10 46 C 4.477152347564697 46 0 41.5228476524353 0 36 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: frontNoxDsName1
                        color: "#333333"
                        text: qsTr("Pre-NOx concentration:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 8
                        anchors.rightMargin: 78
                        anchors.topMargin: 8
                        anchors.bottomMargin: 11
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: frontNoxDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 250
                        anchors.rightMargin: 52
                        anchors.topMargin: 11
                        anchors.bottomMargin: 8
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }

                Shape {
                    id: ovalBk_53
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 103
                    anchors.rightMargin: 223
                    anchors.topMargin: 61
                    anchors.bottomMargin: 0
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: ovalBk_53_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: ovalBk_53_PathSvg_0
                            path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                        }
                        fillColor: "#0770eb"
                    }
                    antialiasing: true
                }
            }

            Shape {
                id: route_14Backup_37
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 846
                anchors.rightMargin: 1073
                anchors.topMargin: 716
                anchors.bottomMargin: 129
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_14Backup_37_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#0770eb"
                    PathSvg {
                        id: route_14Backup_37_PathSvg_0
                        path: "M 0 0 L 0.9350000023841858 112.55500030517578"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: route_14Backup_38
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1047
                anchors.rightMargin: 845
                anchors.topMargin: 716
                anchors.bottomMargin: 81
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_14Backup_38_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#0770eb"
                    PathSvg {
                        id: route_14Backup_38_PathSvg_0
                        path: "M 0 0 L 28 161"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: route_14Backup_39
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1376
                anchors.rightMargin: 540
                anchors.topMargin: 717
                anchors.bottomMargin: 141
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_14Backup_39_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#0770eb"
                    PathSvg {
                        id: route_14Backup_39_PathSvg_0
                        path: "M 3.759999990463257 0 L 0 100.02200317382812"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: route_14Backup_42
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 896
                anchors.rightMargin: 982
                anchors.topMargin: 555
                anchors.bottomMargin: 373
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_14Backup_42_ShapePath_0
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#0770eb"
                    PathSvg {
                        id: route_14Backup_42_PathSvg_0
                        path: "M 42 30 L 0 0"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Item {
                id: group_13
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 789
                anchors.rightMargin: 853
                anchors.topMargin: 294
                anchors.bottomMargin: 541
                Item {
                    id: group_14Backup_11
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    Shape {
                        id: rectangularBk_32
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_30_ShapePath_1
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_30_PathSvg_1
                                path: "M 10 0 L 268.03900146484375 0 C 273.56184911727905 0 278.03900146484375 4.477152347564697 278.03900146484375 10 L 278.03900146484375 113.41300201416016 C 278.03900146484375 118.93584966659546 273.56184911727905 123.41300201416016 268.03900146484375 123.41300201416016 L 10 123.41300201416016 C 4.477152347564697 123.41300201416016 0 118.93584966659546 0 113.41300201416016 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: ureaNozzle
                        color: "#333333"
                        text: qsTr("Urea nozzle")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 27
                        anchors.rightMargin: 126
                        anchors.topMargin: 12
                        anchors.bottomMargin: 84
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Shape {
                        id: oval
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 15
                        anchors.rightMargin: 255
                        anchors.topMargin: 22
                        anchors.bottomMargin: 93
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: oval_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: oval_PathSvg_0
                                path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                            }
                            fillColor: "#333333"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: ureaNozzleDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 174
                        anchors.rightMargin: 72
                        anchors.topMargin: 85
                        anchors.bottomMargin: 11
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaNozzleDsName1
                        color: "#333333"
                        text: qsTr("injection rate:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 9
                        anchors.rightMargin: 126
                        anchors.topMargin: 84
                        anchors.bottomMargin: 12
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsName1
                        color: "#333333"
                        text: qsTr("urea pressure:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 9
                        anchors.rightMargin: 119
                        anchors.topMargin: 48
                        anchors.bottomMargin: 48
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 164
                        anchors.rightMargin: 82
                        anchors.topMargin: 50
                        anchors.bottomMargin: 46
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }
            }

            Item {
                id: group_14
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1135
                anchors.rightMargin: 432
                anchors.topMargin: 585
                anchors.bottomMargin: 299
                Shape {
                    id: route_14Backup_44
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 265
                    anchors.rightMargin: 47
                    anchors.topMargin: 49
                    anchors.bottomMargin: 4
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_14Backup_44_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#0770eb"
                        PathSvg {
                            id: route_14Backup_44_PathSvg_0
                            path: "M 41.176998138427734 21.729000091552734 L 0 0"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_25Backup_4
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 26
                    Shape {
                        id: rectangularBk_33
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_30_ShapePath_2
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_30_PathSvg_2
                                path: "M 10 0 L 343.14300537109375 0 C 348.66585302352905 0 353.14300537109375 4.477152347564697 353.14300537109375 10 L 353.14300537109375 38 C 353.14300537109375 43.5228476524353 348.66585302352905 48 343.14300537109375 48 L 10 48 C 4.477152347564697 48 0 43.5228476524353 0 38 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: rearNoxDsName1
                        color: "#333333"
                        text: qsTr("Post NOx concentration:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 9
                        anchors.rightMargin: 88
                        anchors.topMargin: 10
                        anchors.bottomMargin: 11
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: rearNoxDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 261
                        anchors.rightMargin: 60
                        anchors.topMargin: 14
                        anchors.bottomMargin: 7
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }

                Shape {
                    id: ovalBk_61
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 298
                    anchors.rightMargin: 47
                    anchors.topMargin: 67
                    anchors.bottomMargin: -1
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: ovalBk_61_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: ovalBk_61_PathSvg_0
                            path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                        }
                        fillColor: "#0770eb"
                    }
                    antialiasing: true
                }
            }

            Item {
                id: set_8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 454
                anchors.rightMargin: 1088
                anchors.topMargin: 848
                anchors.bottomMargin: 69
                Shape {
                    id: rectangularBk_91
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_91_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#adbacc"
                        PathSvg {
                            id: rectangularBk_91_PathSvg_0
                            path: "M 10 0 L 368.46600341796875 0 C 373.98885107040405 0 378.46600341796875 4.477152347564697 378.46600341796875 10 L 378.46600341796875 31 C 378.46600341796875 36.5228476524353 373.98885107040405 41 368.46600341796875 41 L 10 41 C 4.477152347564697 41 0 36.5228476524353 0 31 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#f2f6fa"
                    }
                    antialiasing: true
                }

                Text {
                    id: dOC_TemperatureSensorDsName1
                    color: "#333333"
                    text: qsTr("DOC upstream temperature:")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 12
                    anchors.rightMargin: 72
                    anchors.topMargin: 7
                    anchors.bottomMargin: 7
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Text {
                    id: dOC_TemperatureSensorDsValue1
                    color: "#0770eb"
                    text: qsTr("---")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 285
                    anchors.rightMargin: 61
                    anchors.topMargin: 11
                    anchors.bottomMargin: 3
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }
            }

            Item {
                id: set_9
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 644
                anchors.rightMargin: 894
                anchors.topMargin: 796
                anchors.bottomMargin: 121
                Shape {
                    id: rectangularBk_92
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_92_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#adbacc"
                        PathSvg {
                            id: rectangularBk_92_PathSvg_0
                            path: "M 10 0 L 372.2860107421875 0 C 377.8088583946228 0 382.2860107421875 4.477152347564697 382.2860107421875 10 L 382.2860107421875 31 C 382.2860107421875 36.5228476524353 377.8088583946228 41 372.2860107421875 41 L 10 41 C 4.477152347564697 41 0 36.5228476524353 0 31 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#f2f6fa"
                    }
                    antialiasing: true
                }

                Text {
                    id: dPF_InTemperatureSensorDsName1
                    color: "#333333"
                    text: qsTr("DPF upstream temperature:")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 12
                    anchors.rightMargin: 82
                    anchors.topMargin: 7
                    anchors.bottomMargin: 7
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Text {
                    id: dPF_InTemperatureSensorDsValue1
                    color: "#0770eb"
                    text: qsTr("---")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 285
                    anchors.rightMargin: 65
                    anchors.topMargin: 9
                    anchors.bottomMargin: 5
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }
            }

            Item {
                id: set_10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 919
                anchors.rightMargin: 611
                anchors.topMargin: 877
                anchors.bottomMargin: 40
                Shape {
                    id: rectangularBk_93
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_93_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#adbacc"
                        PathSvg {
                            id: rectangularBk_93_PathSvg_0
                            path: "M 10 0 L 380.31201171875 0 C 385.8348593711853 0 390.31201171875 4.477152347564697 390.31201171875 10 L 390.31201171875 31.261999130249023 C 390.31201171875 36.784846782684326 385.8348593711853 41.262001037597656 380.31201171875 41.262001037597656 L 10 41.262001037597656 C 4.477152347564697 41.262001037597656 0 36.784846782684326 0 31.261999130249023 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#f2f6fa"
                    }
                    antialiasing: true
                }

                Text {
                    id: sCR_InTemperatureSensorDsName1
                    color: "#333333"
                    text: qsTr("SCR upstream temperature:")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 12
                    anchors.rightMargin: 88
                    anchors.topMargin: 8
                    anchors.bottomMargin: 6
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Text {
                    id: sCR_InTemperatureSensorDsValue1
                    color: "#0770eb"
                    text: qsTr("---")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 287
                    anchors.rightMargin: 71
                    anchors.topMargin: 9
                    anchors.bottomMargin: 5
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }
            }

            Item {
                id: group_6
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1090
                anchors.rightMargin: 429
                anchors.topMargin: 815
                anchors.bottomMargin: 103
                Shape {
                    id: rectangularBk_94
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_94_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#adbacc"
                        PathSvg {
                            id: rectangularBk_94_PathSvg_0
                            path: "M 10 0 L 391.4169921875 0 C 396.9398398399353 0 401.4169921875 4.477152347564697 401.4169921875 10 L 401.4169921875 30 C 401.4169921875 35.5228476524353 396.9398398399353 40 391.4169921875 40 L 10 40 C 4.477152347564697 40 0 35.5228476524353 0 30 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#f2f6fa"
                    }
                    antialiasing: true
                }

                Text {
                    id: sCR_OutTemperatureSensorDsName1
                    color: "#333333"
                    text: qsTr("SCR downstream temperature:")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 8
                    anchors.rightMargin: 72
                    anchors.topMargin: 6
                    anchors.bottomMargin: 7
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Text {
                    id: sCR_OutTemperatureSensorDsValue1
                    color: "#0770eb"
                    text: qsTr("---")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 305
                    anchors.rightMargin: 64
                    anchors.topMargin: 8
                    anchors.bottomMargin: 5
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }
            }

            Item {
                id: group_31Backup_2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 613
                anchors.rightMargin: 912
                anchors.topMargin: 432
                anchors.bottomMargin: 403
                Shape {
                    id: rectangularBk_34
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: rectangularBk_30_ShapePath_3
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#adbacc"
                        PathSvg {
                            id: rectangularBk_30_PathSvg_3
                            path: "M 10 0 L 385.49700927734375 0 C 391.01985692977905 0 395.49700927734375 4.477152347564697 395.49700927734375 10 L 395.49700927734375 113.41300201416016 C 395.49700927734375 118.93584966659546 391.01985692977905 123.41300201416016 385.49700927734375 123.41300201416016 L 10 123.41300201416016 C 4.477152347564697 123.41300201416016 0 118.93584966659546 0 113.41300201416016 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#f2f6fa"
                    }
                    antialiasing: true
                }

                Text {
                    id: difPressureSensor
                    color: "#333333"
                    text: qsTr("Differential pressure sensor")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 27
                    anchors.rightMargin: 80
                    anchors.topMargin: 8
                    anchors.bottomMargin: 88
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Shape {
                    id: oval1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 15
                    anchors.rightMargin: 372
                    anchors.topMargin: 22
                    anchors.bottomMargin: 93
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: oval_ShapePath_1
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: oval_PathSvg_1
                            path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                        }
                        fillColor: "#333333"
                    }
                    antialiasing: true
                }

                Text {
                    id: difPressureSensorDsName1
                    color: "#333333"
                    text: qsTr("DPF differential pressure:")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 15
                    anchors.rightMargin: 116
                    anchors.topMargin: 49
                    anchors.bottomMargin: 47
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Text {
                    id: difPressureSensorDsValue1
                    color: "#0770eb"
                    text: qsTr("---")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 302
                    anchors.rightMargin: 61
                    anchors.topMargin: 51
                    anchors.bottomMargin: 45
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Text {
                    id: difPressureSensorDsValue2
                    color: "#0770eb"
                    text: qsTr("---")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 193
                    anchors.rightMargin: 170
                    anchors.topMargin: 92
                    anchors.bottomMargin: 4
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Text {
                    id: difPressureSensorDsName2
                    color: "#333333"
                    text: qsTr("DPF carbon load:")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 15
                    anchors.rightMargin: 200
                    anchors.topMargin: 90
                    anchors.bottomMargin: 6
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }
            }

            Shape {
                id: ovalBk_52
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 672
                anchors.rightMargin: 1240
                anchors.topMargin: 708
                anchors.bottomMargin: 242
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ovalBk_52_ShapePath_0
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: ovalBk_52_PathSvg_0
                        path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                    }
                    fillColor: "#0770eb"
                }
                antialiasing: true
            }

            Shape {
                id: ovalBk_54
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 842
                anchors.rightMargin: 1070
                anchors.topMargin: 711
                anchors.bottomMargin: 239
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ovalBk_54_ShapePath_0
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: ovalBk_54_PathSvg_0
                        path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                    }
                    fillColor: "#0770eb"
                }
                antialiasing: true
            }

            Shape {
                id: ovalBk_55
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1043
                anchors.rightMargin: 869
                anchors.topMargin: 711
                anchors.bottomMargin: 239
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ovalBk_55_ShapePath_0
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: ovalBk_55_PathSvg_0
                        path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                    }
                    fillColor: "#0770eb"
                }
                antialiasing: true
            }

            Shape {
                id: ovalBk_56
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1376
                anchors.rightMargin: 536
                anchors.topMargin: 712
                anchors.bottomMargin: 238
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ovalBk_56_ShapePath_0
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: ovalBk_56_PathSvg_0
                        path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                    }
                    fillColor: "#0770eb"
                }
                antialiasing: true
            }

            Shape {
                id: ovalBk_59
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 935
                anchors.rightMargin: 977
                anchors.topMargin: 578
                anchors.bottomMargin: 372
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ovalBk_59_ShapePath_0
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: ovalBk_59_PathSvg_0
                        path: "M 4 0 C 5.060865998268127 5.551115123125783e-16 6.078281819820404 0.4214274287223816 6.828427314758301 1.1715729236602783 C 7.5785728096961975 1.921718418598175 7.999999999999999 2.9391340017318726 8 4 C 7.999999999999999 5.060865998268127 7.5785728096961975 6.078281819820404 6.828427314758301 6.828427314758301 C 6.078281819820404 7.5785728096961975 5.060865998268127 7.999999999999999 4 8 C 2.9503124952316284 7.964827459305525 1.9532057046890259 7.53210973739624 1.2105480432510376 6.789452075958252 C 0.4678903818130493 6.046794414520264 0.035172540694475174 5.049687504768372 0 4 C 0.035172540694475174 2.9503124952316284 0.4678903818130493 1.9532057046890259 1.2105480432510376 1.2105480432510376 C 1.9532057046890259 0.4678903818130493 2.9503124952316284 0.035172540694475174 4 0 Z"
                    }
                    fillRule: ShapePath.WindingFill
                    fillColor: "#0770eb"
                }
                antialiasing: true
            }

            Item {
                id: group_5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1388
                anchors.rightMargin: 435
                anchors.topMargin: 145
                anchors.bottomMargin: 658
                Shape {
                    id: fill_14
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 4
                    anchors.rightMargin: 75
                    anchors.topMargin: 70
                    anchors.bottomMargin: 81
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_13_ShapePath_1
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_13_PathSvg_1
                            path: "M 17.953998565673828 0.8489303588867188 L 9.296000480651855 0.8489303588867188 L 9.296000480651855 0.61492919921875 C 9.286780249327421 0.44877299666404724 9.21427919715643 0.29245758801698685 9.093392372131348 0.17809295654296875 C 8.972505547106266 0.06372832506895065 8.812411725521088 0 8.645999908447266 0 C 8.479588091373444 0 8.319494269788265 0.06372832506895065 8.198607444763184 0.17809295654296875 C 8.077720619738102 0.29245758801698685 8.005220521241426 0.44877299666404724 7.996000289916992 0.61492919921875 L 7.996000289916992 0.8489303588867188 L 1.6720001697540283 0.8489303588867188 C 1.2440811097621918 0.8340713940560818 0.8277380466461182 0.9895439147949219 0.5142934322357178 1.2812423706054688 C 0.20084881782531738 1.5729408264160156 0.015894722193479538 1.9770482778549194 0 2.4049301147460938 L 0 2.5239334106445312 C 0.015894722193479538 2.9518152475357056 0.20084881782531738 3.3559226989746094 0.5142934322357178 3.6476211547851562 C 0.8277380466461182 3.939319610595703 1.2440811097621918 4.094792131334543 1.6720001697540283 4.079933166503906 L 7.996000289916992 4.079933166503906 L 7.996000289916992 4.313926696777344 C 8.005220521241426 4.4800828993320465 8.077720619738102 4.636405937373638 8.198607444763184 4.750770568847656 C 8.319494269788265 4.865135200321674 8.479588091373444 4.928863525390625 8.645999908447266 4.928863525390625 C 8.812411725521088 4.928863525390625 8.972505547106266 4.865135200321674 9.093392372131348 4.750770568847656 C 9.21427919715643 4.636405937373638 9.286780249327421 4.4800828993320465 9.296000480651855 4.313926696777344 L 9.296000480651855 4.079933166503906 L 17.953998565673828 4.079933166503906 L 17.953998565673828 0.8489303588867188 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 34
                    anchors.rightMargin: 40
                    anchors.topMargin: 140
                    anchors.bottomMargin: 0
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_1_ShapePath_1
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_1_PathSvg_1
                            path: "M 16.887001037597656 0.0050048828125 L 0 0.0050048828125 L 0 12.105010986328125 C 0.00037185990368016064 12.408308744430542 0.08464117348194122 12.705579787492752 0.24348068237304688 12.963958740234375 C 0.4023201912641525 13.222337692975998 0.6295394897460938 13.431741520762444 0.9000015258789062 13.569000244140625 L 4.854999542236328 15.5880126953125 C 5.08665269613266 15.706151157617569 5.342962473630905 15.767822393507231 5.603000640869141 15.76800537109375 L 16.492000579833984 15.76800537109375 C 16.7520432472229 15.767860245119664 17.008361741900444 15.706186912953854 17.240001678466797 15.5880126953125 L 21.201000213623047 13.564010620117188 C 21.47146224975586 13.426751896739006 21.6986815482378 13.21734806895256 21.857521057128906 12.958969116210938 C 22.016360566020012 12.700590163469315 22.100629879598273 12.403303861618042 22.101001739501953 12.100006103515625 L 22.101001739501953 0 L 16.887001037597656 0.0050048828125 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 3
                    anchors.rightMargin: 23
                    anchors.bottomMargin: 97
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_3_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_3_PathSvg_0
                            path: "M 28.20199966430664 6.249335715580173e-9 L 40.753997802734375 6.249335715580173e-9 C 42.366512060165405 -0.00006990222826308568 43.92400646209717 0.586388111114502 45.13600158691406 1.649999976158142 L 53.63600158691406 9.112000465393066 C 54.10186719894409 9.520606070756912 54.47514343261719 10.02394562959671 54.73088836669922 10.588377952575684 C 54.98663330078125 11.152810275554657 55.11895663883115 11.765331506729126 55.11900329589844 12.385000228881836 L 55.11900329589844 13.939000129699707 L 66.23899841308594 24.326000213623047 C 66.77542579174042 24.82688844203949 67.20314458012581 25.432714879512787 67.49559020996094 26.10585594177246 C 67.78803583979607 26.778997004032135 67.93895978691216 27.505077064037323 67.93899536132812 28.23900032043457 L 67.93899536132812 53.96799850463867 L 69.46299743652344 53.96799850463867 C 69.85551783442497 53.96799850463867 70.23196002840996 54.12392780184746 70.50951385498047 54.40148162841797 C 70.78706768155098 54.67903545498848 70.94300079345702 55.05548146367073 70.94300079345703 55.448001861572266 L 70.94300079345703 58.04800033569336 L 10.942999839782715 58.04800033569336 L 10.942999839782715 55.084999084472656 C 10.942999839782717 54.69247868657112 11.098928183317184 54.316036492586136 11.376482009887695 54.038482666015625 C 11.654035836458206 53.760928839445114 12.030479937791824 53.60499954223633 12.42300033569336 53.60499954223633 L 13.03499984741211 53.60499954223633 L 13.03499984741211 35.29999923706055 L 3.8350000381469727 35.29999923706055 C 2.8178948163986206 35.299999237060554 1.8424472212791443 34.895955979824066 1.1232452392578125 34.176753997802734 C 0.4040432572364807 33.4575520157814 4.440892098500626e-16 32.48210537433624 0 31.46500015258789 L 0 22.132999420166016 C 0.00026022832025773823 21.62845265865326 0.10007856786251068 21.128917187452316 0.2937355041503906 20.663015365600586 C 0.48739244043827057 20.197113543748856 0.7710812091827393 19.774003595113754 1.1285457611083984 19.417932510375977 C 1.4860103130340576 19.0618614256382 1.9102240800857544 18.77982749044895 2.3768787384033203 18.58799171447754 C 2.8435333967208862 18.396155938506126 3.3434560894966125 18.29828884161543 3.8480000495910645 18.299999237060547 L 13.927999496459961 18.299999237060547 C 13.927999496459964 17.873265892267227 14.097519248723984 17.464011818170547 14.39926528930664 17.16226577758789 C 14.701011329889297 16.860519737005234 15.11026731133461 16.690999984741214 15.53700065612793 16.69099998474121 L 21.275999069213867 16.69099998474121 L 22.562999725341797 14.973999977111816 L 22.562999725341797 8.53499984741211 C 22.56271121406462 6.967818737030029 23.07080638408661 5.442831635475159 24.01099967956543 4.189000129699707 C 24.01152983296197 3.07799756526947 24.453177452087402 2.0126653909683228 25.238868713378906 1.2271616458892822 C 26.02455997467041 0.4416579008102417 27.090997099876404 0.00026497226573818367 28.20199966430664 6.249335715580173e-9 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: oval2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 42
                    anchors.rightMargin: 41
                    anchors.topMargin: 9
                    anchors.bottomMargin: 133
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: oval_ShapePath_2
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: oval_PathSvg_2
                            path: "M 13.633999824523926 6.816999912261963 C 13.633999824523926 10.5819251537323 10.5819251537323 13.633999824523926 6.816999912261963 13.633999824523926 C 3.052074670791626 13.633999824523926 0 10.5819251537323 0 6.816999912261963 C 0 3.052074670791626 3.052074670791626 0 6.816999912261963 0 C 10.5819251537323 0 13.633999824523926 3.052074670791626 13.633999824523926 6.816999912261963 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 25
                    anchors.rightMargin: 31
                    anchors.topMargin: 88
                    anchors.bottomMargin: 9
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_5_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_5_PathSvg_0
                            path: "M 31.91200065612793 58.991004943847656 L 9.011999130249023 58.991004943847656 C 6.621868133544922 58.99100494384763 4.329630970954895 58.04152595996857 2.6395530700683594 56.35144805908203 C 0.9494751691818237 54.661370158195496 7.105427357601002e-15 52.36912727355957 0 49.97899627685547 L 0 0 L 40.92400360107422 0 L 40.92400360107422 49.97899627685547 C 40.924003601074205 52.36912727355957 39.97452461719513 54.661370158195496 38.284446716308594 56.35144805908203 C 36.59436881542206 58.04152595996857 34.30213165283203 58.991004943847656 31.91200065612793 58.991004943847656 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_8
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 14
                    anchors.rightMargin: 23
                    anchors.topMargin: 59
                    anchors.bottomMargin: 67
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_7_ShapePath_1
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_7_PathSvg_1
                            path: "M 60 0 L 0 0 L 0 1.8720016479492188 C 0 2.5586471557617188 0.27276909351348877 3.2171698808670044 0.75830078125 3.7027015686035156 C 1.2438324689865112 4.188233256340027 1.9023542404174805 4.461002349853516 2.5889997482299805 4.461002349853516 L 5.296999931335449 4.461002349853516 L 5.296999931335449 27.28799819946289 C 5.296999931335453 27.90515697002411 5.542165189981461 28.497040182352066 5.978562355041504 28.93343734741211 C 6.414959520101547 29.369834512472153 7.006840825080872 29.615001678466797 7.62399959564209 29.615001678466797 L 53.64099884033203 29.615001678466797 C 54.25815761089325 29.61500167846681 54.85004082322121 29.369834512472153 55.28643798828125 28.93343734741211 C 55.72283515334129 28.497040182352066 55.96800231933592 27.90515697002411 55.96800231933594 27.28799819946289 L 55.96800231933594 4.461002349853516 L 57.41099548339844 4.461002349853516 C 58.09764099121094 4.461002349853516 58.75616753101349 4.188233256340027 59.24169921875 3.7027015686035156 C 59.72723090648651 3.2171698808670044 60 2.5586471557617188 60 1.8720016479492188 L 60 0 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 70
                    anchors.rightMargin: 0
                    anchors.topMargin: 74
                    anchors.bottomMargin: 69
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_9_ShapePath_1
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_9_PathSvg_1
                            path: "M 24.316001892089844 2.2040023803710938 L 18.8699951171875 2.177001953125 L 14.099998474121094 0 L 0 0 L 0 12.262001037597656 L 14.099998474121094 12.262001037597656 L 18.8699951171875 10.083999633789062 L 24.316001892089844 10.056999206542969 C 24.954112768173218 10.056999206542955 25.566083312034607 9.803515076637268 26.017295837402344 9.352302551269531 C 26.46850836277008 8.901090025901794 26.7220001220703 8.289111852645874 26.722000122070312 7.6510009765625 L 26.722000122070312 4.611000061035156 C 26.7220001220703 3.9728891849517822 26.46850836277008 3.360918641090393 26.017295837402344 2.9097061157226562 C 25.566083312034607 2.4584935903549194 24.954112768173218 2.204002380371108 24.316001892089844 2.2040023803710938 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_16
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 77
                    anchors.topMargin: 74
                    anchors.bottomMargin: 76
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_14_ShapePath_0
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_14_PathSvg_0
                            path: "M 20.018999099731445 1.0054931640625 L 10.364999771118164 1.0054931640625 L 10.364999771118164 0.7244949340820312 C 10.364999775128126 0.6293522343039513 10.346260223537683 0.5351431295275688 10.309850692749023 0.44724273681640625 C 10.273441161960363 0.3593423441052437 10.220074698328972 0.27947239577770233 10.152798652648926 0.21219635009765625 C 10.08552260696888 0.14492030441761017 10.005654565989971 0.09155479818582535 9.917754173278809 0.055145263671875 C 9.829853780567646 0.018735729157924652 9.73564276844263 1.4210854715202004e-14 9.64050006866455 0 C 9.54535736888647 1.4210854715202004e-14 9.451146356761456 0.018735729157924652 9.363245964050293 0.055145263671875 C 9.27534557133913 0.09155479818582535 9.195477530360222 0.14492030441761017 9.128201484680176 0.21219635009765625 C 9.06092543900013 0.27947239577770233 9.007558975368738 0.3593423441052437 8.971149444580078 0.44724273681640625 C 8.934739913791418 0.5351431295275688 8.916000362200974 0.6293522343039513 8.916000366210938 0.7244949340820312 L 8.916000366210938 1.0054931640625 L 1.8640002012252808 1.0054931640625 C 1.3696366548538208 1.0054931640625142 0.8955210745334625 1.2018848359584808 0.5459532737731934 1.55145263671875 C 0.1963854730129242 1.9010204374790192 2.6826498393528464e-7 2.375135660171509 2.6826498356058437e-7 2.8694992065429688 L 2.6826498356058437e-7 3.0114974975585938 C -0.00013109875683881 3.2563655972480774 0.0479857474565506 3.4988618344068527 0.14160169661045074 3.725128173828125 C 0.2352176457643509 3.9513945132493973 0.372498095035553 4.1569982171058655 0.5455995798110962 4.330192565917969 C 0.7187010645866394 4.503386914730072 0.92423115670681 4.64077503234148 1.1504472494125366 4.7345123291015625 C 1.3766633421182632 4.828249625861645 1.6191320717334747 4.876495396566071 1.8640002012252808 4.876495361328125 L 8.916000366210938 4.876495361328125 L 8.916000366210938 5.157493591308594 C 8.916000362200974 5.252636291086674 8.934739913791418 5.346853025257587 8.971149444580078 5.43475341796875 C 9.007558975368738 5.522653810679913 9.06092543900013 5.602516129612923 9.128201484680176 5.669792175292969 C 9.195477530360222 5.737068220973015 9.27534557133913 5.790441356599331 9.363245964050293 5.826850891113281 C 9.451146356761456 5.863260425627232 9.54535736888647 5.881996154785142 9.64050006866455 5.881996154785156 C 9.73564276844263 5.881996154785142 9.829853780567646 5.863260425627232 9.917754173278809 5.826850891113281 C 10.005654565989971 5.790441356599331 10.08552260696888 5.737068220973015 10.152798652648926 5.669792175292969 C 10.220074698328972 5.602516129612923 10.273441161960363 5.522653810679913 10.309850692749023 5.43475341796875 C 10.346260223537683 5.346853025257587 10.364999775128128 5.252636291086674 10.364999771118164 5.157493591308594 L 10.364999771118164 4.876495361328125 L 20.018999099731445 4.876495361328125 L 20.018999099731445 1.0054931640625 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_17
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 32
                    anchors.rightMargin: 38
                    anchors.topMargin: 60
                    anchors.bottomMargin: 68
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_15_ShapePath_1
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_15_PathSvg_1
                            path: "M 10.054343223571777 0.7181587219238281 C 12.763343334197998 0.07415872812271118 25.18834388256073 -1.8818416595458984 26.36034393310547 5.545158386230469 C 27.48634397983551 12.682158470153809 21.644344329833984 27.537155151367188 16.651344299316406 27.537155151367188 C 10.858344078063965 27.537155151367188 3.013343095779419 19.498159408569336 0.38434314727783203 11.182159423828125 C -1.871656894683838 4.045159339904785 6.385343313217163 1.5881587266921997 10.054343223571777 0.7181587219238281 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: fill_12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 20
                    anchors.rightMargin: 74
                    anchors.topMargin: 68
                    anchors.bottomMargin: 75
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: fill_11_ShapePath_1
                        strokeWidth: 1
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: fill_11_PathSvg_1
                            path: "M 0 12.229995727539062 L 2.427000045776367 12.229995727539062 L 2.427000045776367 0 L 0 0 L 0 12.229995727539062 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#939ead"
                    }
                    antialiasing: true
                }

                Shape {
                    id: shapeCombBackup
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 39
                    anchors.rightMargin: 43
                    anchors.topMargin: 65
                    anchors.bottomMargin: 76
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: shapeCombBackup_ShapePath_0
                        strokeWidth: 0.5
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#000000"
                        PathSvg {
                            id: shapeCombBackup_PathSvg_0
                            path: "M 6.636568069458008 10.625605583190918 L 6.946565628051758 13.311610221862793 C 6.964052405208349 13.464939907193184 6.94105189666152 13.620174497365952 6.879850387573242 13.76184368133545 C 6.818648878484964 13.903512865304947 6.7213860005140305 14.026669271290302 6.597757339477539 14.119036674499512 C 6.474128678441048 14.211404077708721 6.328449338674545 14.269755778834224 6.175241470336914 14.28827953338623 C 6.022033601999283 14.306803287938237 5.866645514965057 14.284846231341362 5.724565505981445 14.224604606628418 L 3.265565872192383 13.178606986999512 C 3.1235078275203705 13.118240136653185 2.9997805282473564 13.021648027002811 2.9067440032958984 12.898486137390137 C 2.8137074783444405 12.775324247777462 2.7546200584620237 12.629905581474304 2.7353878021240234 12.47675609588623 C 2.716155545786023 12.323606610298157 2.7374527156352997 12.168093726038933 2.797147750854492 12.025752067565918 C 2.8568427860736847 11.883410409092903 2.952846273779869 11.759223856031895 3.0755672454833984 11.665606498718262 L 5.224565505981445 10.025607109069824 C 5.348528303205967 9.931205980479717 5.495264917612076 9.871290236711502 5.649873733520508 9.85193920135498 C 5.80448254942894 9.832588165998459 5.961459010839462 9.854494005441666 6.104864120483398 9.915431022644043 C 6.248269230127335 9.97636803984642 6.37299482524395 10.074162982404232 6.466379165649414 10.198893547058105 C 6.559763506054878 10.323624111711979 6.61848190240562 10.470843702554703 6.636568069458008 10.625605583190918 Z M 8.699567794799805 10.289607048034668 C 8.679599883034825 10.134987115859985 8.700970385223627 9.977841332554817 8.761507034301758 9.8341703414917 C 8.822043683379889 9.690499350428581 8.919582642614841 9.565440855920315 9.044183731079102 9.471735954284668 C 9.168784819543362 9.378031052649021 9.315996035933495 9.319021793082356 9.470823287963867 9.30073070526123 C 9.62565053999424 9.282439617440104 9.782559216022491 9.30551989004016 9.925565719604492 9.367609977722168 L 12.40656852722168 10.43860912322998 C 12.54816760122776 10.500079672783613 12.671175457537174 10.597598269581795 12.763330459594727 10.72143840789795 C 12.855485461652279 10.845278546214104 12.91356741823256 10.99110871553421 12.931779861450195 11.144396781921387 C 12.94999230466783 11.297684848308563 12.927700079977512 11.453071594238281 12.867128372192383 11.595057487487793 C 12.806556664407253 11.737043380737305 12.709822304546833 11.86067033559084 12.586568832397461 11.953608512878418 L 10.446565628051758 13.562609672546387 C 10.323163747787476 13.65532086789608 10.177615240216255 13.714067101478577 10.024431228637695 13.732989311218262 C 9.871247217059135 13.751911520957947 9.715779215097427 13.730347093194723 9.573526382446289 13.670451164245605 C 9.43127354979515 13.610555235296488 9.307207264006138 13.514414586126804 9.213693618774414 13.391619682312012 C 9.12017997354269 13.268824778497219 9.060487762093544 13.1236642152071 9.040567398071289 12.970606803894043 L 8.699567794799805 10.289607048034668 Z M 1.2215672731399536 5.8386101722717285 L 3.715566635131836 6.88060998916626 C 3.8595460802316666 6.940550044178963 3.985056459903717 7.037594638764858 4.079305648803711 7.1618523597717285 C 4.173554837703705 7.286110080778599 4.233174649998546 7.4331310242414474 4.252080917358398 7.5879387855529785 C 4.270987184718251 7.74274654686451 4.248504225164652 7.899805620312691 4.186929702758789 8.04309368133545 C 4.125355180352926 8.186381742358208 4.026889607310295 8.310776308178902 3.9015674591064453 8.403605461120605 L 1.730566143989563 10.014605522155762 C 1.606653407216072 10.105957046151161 1.461010679602623 10.163323771208525 1.3080846071243286 10.181017875671387 C 1.1551585346460342 10.198711980134249 1.000265657901764 10.176123801618814 0.8587666749954224 10.11548137664795 C 0.7172676920890808 10.054838951677084 0.5940820127725601 9.958249524235725 0.5014287233352661 9.835307121276855 C 0.4087754338979721 9.712364718317986 0.34987438656389713 9.56733800470829 0.33056843280792236 9.414607048034668 L 0.006567117292433977 6.761606693267822 C -0.012227303814142942 6.6083595007658005 0.009487181901931763 6.452860072255135 0.06954777240753174 6.3106255531311035 C 0.1296083629131317 6.1683910340070724 0.22591664642095566 6.044395186007023 0.34885990619659424 5.950998783111572 C 0.4718031659722328 5.857602380216122 0.6170853525400162 5.79807392694056 0.7702161073684692 5.778353214263916 C 0.9233468621969223 5.758632501587272 1.078972190618515 5.779410723596811 1.2215672731399536 5.8386101722717285 Z M 7.191568374633789 5.119608402252197 C 7.592075526714325 5.119608402252183 7.98358553647995 5.238368988037109 8.316595077514648 5.460878849029541 C 8.649604618549347 5.683388710021973 8.90915434062481 5.999649077653885 9.062421798706055 6.369669437408447 C 9.2156892567873 6.73968979716301 9.255791246891022 7.146856069564819 9.177656173706055 7.53966760635376 C 9.099521100521088 7.9324791431427 8.906658291816711 8.293293833732605 8.623456954956055 8.576495170593262 C 8.340255618095398 8.859696507453918 7.979437589645386 9.052559316158295 7.586626052856445 9.130694389343262 C 7.193814516067505 9.208829462528229 6.786652058362961 9.168727472424507 6.416631698608398 9.015460014343262 C 6.046611338853836 8.862192556262016 5.730350971221924 8.602650463581085 5.507841110229492 8.269640922546387 C 5.2853312492370605 7.936631381511688 5.16656684875489 7.545117080211639 5.166566848754883 7.1446099281311035 C 5.16656684875489 6.607546508312225 5.379914820194244 6.092478692531586 5.759675979614258 5.712717533111572 C 6.139437139034271 5.332956373691559 6.654504954814911 5.119608402252197 7.191568374633789 5.119608402252197 Z M 14.053567886352539 4.8766045570373535 L 14.377565383911133 7.529604434967041 C 14.396059723570943 7.682818308472633 14.374077804386616 7.838202700018883 14.313806533813477 7.9802727699279785 C 14.253535263240337 8.122342839837074 14.157081939280033 8.246142841875553 14.034059524536133 8.339320182800293 C 13.911037109792233 8.432497523725033 13.765743255615234 8.491805722936988 13.61265754699707 8.511332511901855 C 13.459571838378906 8.530859300866723 13.304038926959038 8.509922314435244 13.161565780639648 8.450610160827637 L 10.661565780639648 7.4116082191467285 C 10.517586335539818 7.351668164134026 10.392075955867767 7.25462356954813 10.297826766967773 7.13036584854126 C 10.20357757806778 7.0061081275343895 10.143961580470204 6.85907955467701 10.125055313110352 6.7042717933654785 C 10.106149045750499 6.5494640320539474 10.128628190606833 6.392413064837456 10.190202713012695 6.249125003814697 C 10.251777235418558 6.105836942791939 10.350246623158455 5.981434747576714 10.475568771362305 5.88860559463501 L 12.646566390991211 4.2776055335998535 C 12.770479127764702 4.186254009604454 12.916121855378151 4.1288872845470905 13.069047927856445 4.1111931800842285 C 13.22197400033474 4.0934990756213665 13.376870691776276 4.116094883531332 13.518369674682617 4.176737308502197 C 13.659868657588959 4.2373797334730625 13.78305433690548 4.33396153151989 13.875707626342773 4.45690393447876 C 13.968360915780067 4.57984633743763 14.027261963114142 4.724873051047325 14.046567916870117 4.877604007720947 L 14.053567886352539 4.8766045570373535 Z M 3.9315662384033203 0.7316080331802368 C 4.055035896599293 0.6388782262802124 4.200665712356567 0.5801452938467264 4.353921890258789 0.5612741708755493 C 4.507178068161011 0.5424030479043722 4.6627024710178375 0.5640492178499699 4.80497932434082 0.6240564584732056 C 4.947256177663803 0.6840636990964413 5.071310296654701 0.7803379818797112 5.164762496948242 0.9032617807388306 C 5.258214697241783 1.02618557959795 5.317798839882016 1.1714674681425095 5.337568283081055 1.3246103525161743 L 5.682565689086914 4.00560998916626 C 5.702533600851893 4.160229921340942 5.681163098663092 4.3173757046461105 5.620626449584961 4.4610466957092285 C 5.56008980050683 4.6047176867723465 5.462550841271877 4.729776181280613 5.337949752807617 4.82348108291626 C 5.213348664343357 4.917185984551907 5.066137447953224 4.97618761472404 4.911310195922852 4.994478702545166 C 4.756482943892479 5.012769790366292 4.599574267864227 4.9896971471607685 4.456567764282227 4.92760705947876 L 1.976568341255188 3.8526103496551514 C 1.8349692672491074 3.7911398001015186 1.7119575962424278 3.693621203303337 1.6198025941848755 3.5697810649871826 C 1.5276475921273232 3.445940926671028 1.4695694502443075 3.3001031279563904 1.4513570070266724 3.146815061569214 C 1.4331445638090372 2.9935269951820374 1.4554329738020897 2.8381402492523193 1.5160046815872192 2.6961543560028076 C 1.5765763893723488 2.554168462753296 1.6733145639300346 2.4305491372942924 1.7965680360794067 2.337610960006714 L 3.9315662384033203 0.7316080331802368 Z M 8.658567428588867 0.07060494273900986 L 11.11756706237793 1.1166101694107056 C 11.259841904044151 1.1768948286771774 11.383783780038357 1.2734953239560127 11.476980209350586 1.396746277809143 C 11.570176638662815 1.5199972316622734 11.62935520708561 1.665571078658104 11.648595809936523 1.8188883066177368 C 11.667836412787437 1.9722055345773697 11.646462015807629 2.127884864807129 11.586610794067383 2.2703425884246826 C 11.526759572327137 2.4128003120422363 11.430532336235046 2.537038989365101 11.307565689086914 2.630610227584839 L 9.157567977905273 4.270609378814697 C 9.033605180680752 4.365010507404804 8.886868566274643 4.424926251173019 8.732259750366211 4.444277286529541 C 8.577650934457779 4.463628321886063 8.420674473047256 4.441722482442856 8.27726936340332 4.3807854652404785 C 8.133864253759384 4.319848448038101 8.009138658642769 4.2220535054802895 7.915754318237305 4.097322940826416 C 7.8223699778318405 3.9725923761725426 7.763651581481099 3.825373023748398 7.745565414428711 3.6706111431121826 L 7.435567855834961 0.9856058359146118 C 7.417596247047186 0.8319930732250214 7.440285600721836 0.6763536036014557 7.501367568969727 0.5342661142349243 C 7.562449537217617 0.39217862486839294 7.659779369831085 0.26863255351781845 7.78361701965332 0.17598214745521545 C 7.907454669475555 0.08333174139261246 8.053455501794815 0.024827260058373213 8.207006454467773 0.006334926467388868 C 8.360557407140732 -0.012157407123595476 8.51627366244793 0.010005075484514236 8.658567428588867 0.07060494273900986 Z"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "#b8c5d9"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_3
                    opacity: 0.3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 38
                    anchors.rightMargin: 45
                    anchors.topMargin: 103
                    anchors.bottomMargin: 13
                    Shape {
                        id: rectangular6
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 12
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_6
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangular_PathSvg_6
                                path: "M 0 0 L 1.284999966621399 0 L 1.284999966621399 39.8390007019043 L 0 39.8390007019043 L 0 0 Z"
                            }
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_4
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 13
                        anchors.rightMargin: -1
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_4_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangularBk_4_PathSvg_0
                                path: "M 0 0 L 1.284999966621399 0 L 1.284999966621399 39.8390007019043 L 0 39.8390007019043 L 0 0 Z"
                            }
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }
                }
            }

            Item {
                id: group_24
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 26
                anchors.rightMargin: 435
                anchors.topMargin: 34
                anchors.bottomMargin: 826
                Item {
                    id: set_6
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 558
                    anchors.rightMargin: 655
                    Shape {
                        id: rectangularBk_22
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_22_ShapePath_0
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_22_PathSvg_0
                                path: "M 14 0 L 232 0 C 239.73198652267456 0 246 6.2680134773254395 246 14 L 246 84 C 246 91.73198652267456 239.73198652267456 98 232 98 L 14 98 C 6.2680134773254395 98 0 91.73198652267456 0 84 L 0 14 C 0 6.2680134773254395 6.2680134773254395 0 14 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f0f7ff"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: acceleratorPedalStatus
                        color: "#333333"
                        text: qsTr("Accelerator")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 72
                        anchors.rightMargin: 31
                        anchors.topMargin: 14
                        anchors.bottomMargin: 53
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: acceleratorPedalStatusValue
                        color: "#666666"
                        text: qsTr("step on")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 72
                        anchors.rightMargin: 81
                        anchors.topMargin: 53
                        anchors.bottomMargin: 14
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Item {
                        id: group_21
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 7
                        anchors.rightMargin: 180
                        anchors.topMargin: 19
                        anchors.bottomMargin: 28
                        Shape {
                            id: rectangular7
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: rectangular_ShapePath_7
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: rectangular_PathSvg_7
                                    path: "M 0 0 L 59 0 L 59 51 L 0 51 L 0 0 Z"
                                }
                                fillColor: "transparent"
                            }
                            antialiasing: true
                        }

                        Item {
                            id: groupBackup_3
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 1
                            anchors.rightMargin: 0
                            Item {
                                id: group
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                Shape {
                                    id: acceleratorPedalColor
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.leftMargin: 1
                                    anchors.rightMargin: -1
                                    layer.samples: 16
                                    layer.enabled: true
                                    ShapePath {
                                        id: acceleratorPedalColor_ShapePath_0
                                        strokeWidth: 1
                                        strokeColor: "transparent"
                                        PathSvg {
                                            id: acceleratorPedalColor_PathSvg_0
                                            path: "M 3.91717529296875 22.66699981689453 C 4.1357008665800095 22.50591853260994 4.385917127132416 22.393035862594843 4.6512956619262695 22.3358097076416 C 4.916674196720123 22.27858355268836 5.191174894571304 22.27831742167473 5.456664562225342 22.335025787353516 C 5.722154229879379 22.391734153032303 5.972590237855911 22.504126876592636 6.191429615020752 22.66478157043457 C 6.410268992185593 22.825436264276505 6.592530518770218 23.030695736408234 6.726174831390381 23.267000198364258 L 23.258174896240234 43.650001525878906 L 23.442174911499023 43.88100051879883 C 23.755698561668396 44.32928228378296 23.922046762425452 44.86397224664688 23.918174743652344 45.4109992980957 C 23.924199625849724 45.79205331206322 23.844570860266685 46.1695970594883 23.685163497924805 46.5157585144043 C 23.525756135582924 46.8619199693203 23.290640830993652 47.16786064207554 22.997175216674805 47.4109992980957 L 20.924175262451172 49.77199935913086 C 20.679903864860535 50.140791952610016 20.35009416937828 50.44506238400936 19.96285057067871 50.65888214111328 C 19.57560697197914 50.8727018982172 19.142410427331924 50.98973286245018 18.700176239013672 51 L 3.976175308227539 51 C 3.628288984298706 50.99573152605444 3.2846623361110687 50.92287217080593 2.964977979660034 50.78559494018555 C 2.6452936232089996 50.64831770956516 2.355832740664482 50.449320659041405 2.1131751537323 50.20000076293945 L 1.8351752758026123 49.891998291015625 L 0.665175199508667 48.560001373291016 L 0.5181751847267151 48.40800094604492 L 0.45217517018318176 48.31399917602539 C 0.16626286506652832 47.87832024693489 0.009633322362788022 47.370556473731995 0.00043026183266192675 46.84952163696289 C -0.008772798697464168 46.32848680019379 0.12982723116874695 45.81550312042236 0.40017518401145935 45.369998931884766 C 0.40917518362402916 45.35999893210828 0.4141751816496253 45.34199963416904 0.42117518186569214 45.33399963378906 L 0.49417516589164734 45.257999420166016 L 7.683175086975098 36.70000076293945 L 1.014175295829773 29.100000381469727 C 0.7647053599357605 28.852209150791168 0.566716656088829 28.557514935731888 0.4316098392009735 28.23288917541504 C 0.296503022313118 27.90826341509819 0.22694705426692932 27.56011864542961 0.22694705426692963 27.208499908447266 C 0.22694705426692935 26.85688117146492 0.296503022313118 26.50873640179634 0.4316098392009735 26.184110641479492 C 0.566716656088829 25.859484881162643 0.7647053599357605 25.564790666103363 1.014175295829773 25.316999435424805 L 3.600175142288208 22.965999603271484 L 3.91717529296875 22.66699981689453 Z M 53.464176177978516 0 C 54.06571960449219 0.05034535378217697 54.6235066652298 0.33465906977653503 55.017677307128906 0.7918446660041809 C 55.411847949028015 1.2490302622318268 55.61094118654728 1.8425995111465454 55.572174072265625 2.444999933242798 L 55.572174072265625 2.5450000762939453 L 57.97217559814453 20.062000274658203 L 57.935176849365234 20.062000274658203 C 57.95784351602197 20.28533360362053 57.97484220378101 20.50833423435688 57.986175537109375 20.731000900268555 C 58.00985828600824 21.19745773077011 58.00685451179743 21.664886713027954 57.977176666259766 22.131000518798828 L 57.96217727661133 22.395000457763672 L 57.922176361083984 22.81999969482422 L 57.8931770324707 23.14299964904785 L 57.8421745300293 23.493999481201172 L 57.78317642211914 23.85300064086914 C 57.75050975382328 24.082333967089653 57.70684257149696 24.309000939130783 57.65217590332031 24.533000946044922 C 57.640175903216004 24.61800094693899 57.61717449873686 24.703000135719776 57.59917449951172 24.7810001373291 L 57.499176025390625 25.19700050354004 C 57.47904108837247 25.259895227849483 57.46300708595663 25.324029326438904 57.451175689697266 25.388999938964844 C 57.40017569065094 25.53799994289875 57.362176299095154 25.689000189304352 57.31117630004883 25.83300018310547 L 57.265174865722656 25.95800018310547 C 57.20917486399412 26.128000184893608 57.16517560184002 26.289000764489174 57.09717559814453 26.450000762939453 L 57.150177001953125 26.450000762939453 L 56.88417434692383 26.979999542236328 C 56.67728289961815 27.464616537094116 56.44358763098717 27.93734747171402 56.184173583984375 28.395999908447266 L 54.41417694091797 31.959999084472656 C 54.37931825220585 32.044463872909546 54.337855983525515 32.12604931741953 54.29017639160156 32.20399856567383 C 54.21886617690325 32.324715457856655 54.12253351509571 32.42876413464546 54.00765609741211 32.5091438293457 C 53.89277867972851 32.589523524045944 53.76201982796192 32.644370052963495 53.624176025390625 32.66999816894531 C 53.489367976784706 32.69067779928446 53.35162277519703 32.680451579391956 53.22134780883789 32.64008712768555 C 53.09107284247875 32.59972267597914 52.971676617860794 32.530277855694294 52.87217712402344 32.4370002746582 L 52.710174560546875 32.25400161743164 L 52.68917465209961 32.23400115966797 L 50.127174377441406 29.274999618530273 L 47.74417495727539 33.400001525878906 L 48.258174896240234 33.9900016784668 L 48.938175201416016 34.7760009765625 C 49.53817522525787 35.46300095319748 48.53317713737488 38.898000955581665 47.74717712402344 40.2760009765625 C 47.211177110672 41.20400094985962 44.11017465591431 45.298999547958374 42.175174713134766 47.83399963378906 C 42.01392860710621 48.13319888710976 41.78207975625992 48.38851375877857 41.49976348876953 48.5777702331543 C 41.217447221279144 48.76702670753002 40.893200129270554 48.88450129702687 40.55517578125 48.91999816894531 C 40.22074481844902 48.940239418298006 39.88660964369774 48.87580369412899 39.58369064331055 48.73264694213867 C 39.280771642923355 48.589490190148354 39.018853947520256 48.372241109609604 38.822174072265625 48.10100173950195 L 31.765174865722656 40.9739990234375 L 31.55317497253418 40.762001037597656 C 31.423111230134964 40.59612978994846 31.336667001247406 40.40032002329826 31.30173110961914 40.19245147705078 C 31.266795217990875 39.9845829308033 31.284481666982174 39.77127458155155 31.35317611694336 39.571998596191406 L 31.453174591064453 39.36000061035156 C 31.639174595475197 38.904000610113144 31.91617551445961 38.29800099134445 32.2431755065918 37.51900100708008 C 32.048175513744354 36.380000948905945 25.690175354480743 32.944998264312744 25.094175338745117 33.39899826049805 C 24.49817532300949 33.85299825668335 20.72017467021942 32.24999988079071 19.13017463684082 30.645999908447266 C 17.971174597740173 29.471999883651733 12.100175380706787 23.365000247955322 9.05417537689209 20.194000244140625 C 8.804910868406296 19.972842946648598 8.601907283067703 19.704514861106873 8.456876754760742 19.404499053955078 C 8.311846226453781 19.104483246803284 8.227659529075027 18.778717756271362 8.209175109863281 18.445999145507812 C 8.155333526432514 17.76491904258728 8.36712071299553 17.089425265789032 8.800175666809082 16.56100082397461 L 9.044175148010254 16.31999969482422 C 10.769175171852112 14.57699966430664 13.263175368309021 12.351000010967255 14.3701753616333 12.776000022888184 C 16.154175400733948 13.462999999523163 20.130175828933716 17.357999086380005 22.718175888061523 18.275999069213867 C 25.2210431098938 18.864596784114838 27.772180795669556 19.224741891026497 30.34017562866211 19.351999282836914 L 31.00017547607422 19.399999618530273 C 32.97517549991608 19.54899962246418 34.89117419719696 19.64699923619628 36.280174255371094 19.674999237060547 C 36.925207793712616 19.707016065716743 37.57166504859924 19.695658661425114 38.21517562866211 19.641000747680664 C 39.79917562007904 19.412000745534897 41.79017639160156 16.895000457763672 41.79017639160156 16.895000457763672 L 40.23717498779297 15.10200023651123 L 40.05117416381836 14.895000457763672 C 39.91290025413036 14.682266816496849 39.83990143169649 14.43371993303299 39.8411750793457 14.180000305175781 C 39.8407403442543 13.99584449827671 39.8802055940032 13.813779935240746 39.956851959228516 13.646331787109375 C 40.03349832445383 13.478883638978004 40.14550682902336 13.330026112496853 40.28517532348633 13.210000038146973 L 43.95217514038086 9.300000190734863 L 51.771175384521484 0.9829999804496765 C 51.94611890614033 0.688370943069458 52.19351214170456 0.44338394701480865 52.489837646484375 0.2713296115398407 C 52.78616315126419 0.09927527606487274 53.12157288193703 0.005872154608368874 53.464176177978516 0 Z"
                                        }
                                        fillRule: ShapePath.OddEvenFill
                                        fillColor: "#adbacc"
                                    }
                                    antialiasing: true
                                }
                            }
                        }
                    }
                }

                Item {
                    id: set_7
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 827
                    Shape {
                        id: rectangular8
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 270
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_8
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangular_PathSvg_8
                                path: "M 14 0 L 348 0 C 355.73198652267456 0 362 6.2680134773254395 362 14 L 362 84 C 362 91.73198652267456 355.73198652267456 98 348 98 L 14 98 C 6.2680134773254395 98 0 91.73198652267456 0 84 L 0 14 C 0 6.2680134773254395 6.2680134773254395 0 14 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f0f7ff"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular9
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 386
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_9
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangular_PathSvg_9
                                path: "M 14 0 L 232 0 C 239.73198652267456 0 246 6.2680134773254395 246 14 L 246 84 C 246 91.73198652267456 239.73198652267456 98 232 98 L 14 98 C 6.2680134773254395 98 0 91.73198652267456 0 84 L 0 14 C 0 6.2680134773254395 6.2680134773254395 0 14 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f0f7ff"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: neutralSwitchStatusValue
                        color: "#666666"
                        text: qsTr("engage")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 75
                        anchors.rightMargin: 464
                        anchors.topMargin: 53
                        anchors.bottomMargin: 14
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: neutralSwitchStatus
                        color: "#333333"
                        text: qsTr("parking brake")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 71
                        anchors.rightMargin: 391
                        anchors.topMargin: 14
                        anchors.bottomMargin: 53
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Shape {
                        id: neutralSwitchColor
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 9
                        anchors.rightMargin: 567
                        anchors.topMargin: 21
                        anchors.bottomMargin: 20
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: neutralSwitchColor_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: neutralSwitchColor_PathSvg_0
                                path: "M 28.200395584106445 0 C 35.71923303604126 0.0399421788752079 42.91426753997803 3.0650124549865723 48.2027587890625 8.409764289855957 C 53.49125003814697 13.754516124725342 56.44001669064164 20.981160640716553 56.400394439697266 28.5 C 56.44001669064164 36.01883935928345 53.49125003814697 43.245484828948975 48.2027587890625 48.59023666381836 C 42.91426753997803 53.934988498687744 35.71923303604126 56.96005782112479 28.200395584106445 57 C 20.68155813217163 56.96005782112479 13.486519813537598 53.934988498687744 8.198028564453125 48.59023666381836 C 2.9095373153686523 43.245484828948975 -0.03922805597539991 36.01883935928345 0.0003941949689760804 28.5 C -0.03922805597539991 20.981160640716553 2.9095373153686523 13.754516124725342 8.198028564453125 8.409764289855957 C 13.486519813537598 3.0650124549865723 20.68155813217163 0.0399421788752079 28.200395584106445 0 Z M 28.200395584106445 4.886000156402588 C 21.983542442321777 4.956072837114334 16.045101642608643 7.474874496459961 11.673687934875488 11.895837783813477 C 7.302274227142334 16.316801071166992 4.85056304931641 22.283251762390137 4.850563049316406 28.500499725341797 C 4.850563049316407 34.71774768829346 7.302274227142334 40.684200286865234 11.673687934875488 45.10516357421875 C 16.045101642608643 49.526126861572266 21.983542442321777 52.04492899775505 28.200395584106445 52.1150016784668 C 34.41724872589111 52.04492899775505 40.3556866645813 49.526126861572266 44.72710037231445 45.10516357421875 C 49.09851408004761 40.684200286865234 51.55022430419921 34.71774768829346 51.55022430419922 28.500499725341797 C 51.55022430419921 22.283251762390137 49.09851408004761 16.316801071166992 44.72710037231445 11.895837783813477 C 40.3556866645813 7.474874496459961 34.41724872589111 4.956072837114334 28.200395584106445 4.886000156402588 Z M 24.172395706176758 16.285999298095703 L 33.839393615722656 34.20000076293945 L 33.839393615722656 16.285999298095703 L 38.67339324951172 16.285999298095703 L 38.67339324951172 40.7140007019043 L 32.2283935546875 40.7140007019043 L 22.560394287109375 22.799999237060547 L 22.560394287109375 40.7140007019043 L 17.72539520263672 40.7140007019043 L 17.72539520263672 16.285999298095703 L 24.172395706176758 16.285999298095703 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#adbacc"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: dPF_Status
                        color: "#333333"
                        text: qsTr("DPF regeneration status")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 286
                        anchors.rightMargin: 47
                        anchors.topMargin: 14
                        anchors.bottomMargin: 53
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: dPF_StatusValue
                        color: "#333333"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 286
                        anchors.rightMargin: 309
                        anchors.topMargin: 53
                        anchors.bottomMargin: 14
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }

                Item {
                    id: set_5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 279
                    anchors.rightMargin: 924
                    Shape {
                        id: rectangularBk_35
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_28_ShapePath_0
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_28_PathSvg_0
                                path: "M 14 0 L 242 0 C 249.73198652267456 0 256 6.2680134773254395 256 14 L 256 84 C 256 91.73198652267456 249.73198652267456 98 242 98 L 14 98 C 6.2680134773254395 98 0 91.73198652267456 0 84 L 0 14 C 0 6.2680134773254395 6.2680134773254395 0 14 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f0f7ff"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: clutchSwitchStatus
                        color: "#333333"
                        text: qsTr("clutch switch")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 72
                        anchors.rightMargin: 20
                        anchors.topMargin: 14
                        anchors.bottomMargin: 53
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: clutchSwitchStatusValue
                        color: "#666666"
                        text: qsTr("not stepped on")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 66
                        anchors.rightMargin: 2
                        anchors.topMargin: 53
                        anchors.bottomMargin: 14
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Item {
                        id: group_22
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 7
                        anchors.rightMargin: 190
                        anchors.topMargin: 19
                        anchors.bottomMargin: 28
                        Shape {
                            id: rectangular10
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: rectangular_ShapePath_10
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: rectangular_PathSvg_10
                                    path: "M 0 0 L 59 0 L 59 51 L 0 51 L 0 0 Z"
                                }
                                fillColor: "transparent"
                            }
                            antialiasing: true
                        }

                        Item {
                            id: groupBackup_4
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 1
                            anchors.rightMargin: 0
                            Item {
                                id: group1
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                Shape {
                                    id: clutchSwitchColor
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    layer.samples: 16
                                    layer.enabled: true
                                    ShapePath {
                                        id: clutchSwitchColor_ShapePath_0
                                        strokeWidth: 1
                                        strokeColor: "transparent"
                                        PathSvg {
                                            id: clutchSwitchColor_PathSvg_0
                                            path: "M 3.91717529296875 22.66699981689453 C 4.1357008665800095 22.50591853260994 4.385917127132416 22.393035862594843 4.6512956619262695 22.3358097076416 C 4.916674196720123 22.27858355268836 5.191174894571304 22.27831742167473 5.456664562225342 22.335025787353516 C 5.722154229879379 22.391734153032303 5.972590237855911 22.504126876592636 6.191429615020752 22.66478157043457 C 6.410268992185593 22.825436264276505 6.592530518770218 23.030695736408234 6.726174831390381 23.267000198364258 L 23.258174896240234 43.650001525878906 L 23.442174911499023 43.88100051879883 C 23.755698561668396 44.32928228378296 23.922046762425452 44.86397224664688 23.918174743652344 45.4109992980957 C 23.924199625849724 45.79205331206322 23.844570860266685 46.1695970594883 23.685163497924805 46.5157585144043 C 23.525756135582924 46.8619199693203 23.290640830993652 47.16786064207554 22.997175216674805 47.4109992980957 L 20.924175262451172 49.77199935913086 C 20.679903864860535 50.140791952610016 20.35009416937828 50.44506238400936 19.96285057067871 50.65888214111328 C 19.57560697197914 50.8727018982172 19.142410427331924 50.98973286245018 18.700176239013672 51 L 3.976175308227539 51 C 3.628288984298706 50.99573152605444 3.2846623361110687 50.92287217080593 2.964977979660034 50.78559494018555 C 2.6452936232089996 50.64831770956516 2.355832740664482 50.449320659041405 2.1131751537323 50.20000076293945 L 1.8351752758026123 49.891998291015625 L 0.665175199508667 48.560001373291016 L 0.5181751847267151 48.40800094604492 L 0.45217517018318176 48.31399917602539 C 0.16626286506652832 47.87832024693489 0.009633322362788022 47.370556473731995 0.00043026183266192675 46.84952163696289 C -0.008772798697464168 46.32848680019379 0.12982723116874695 45.81550312042236 0.40017518401145935 45.369998931884766 C 0.40917518362402916 45.35999893210828 0.4141751816496253 45.34199963416904 0.42117518186569214 45.33399963378906 L 0.49417516589164734 45.257999420166016 L 7.683175086975098 36.70000076293945 L 1.014175295829773 29.100000381469727 C 0.7647053599357605 28.852209150791168 0.566716656088829 28.557514935731888 0.4316098392009735 28.23288917541504 C 0.296503022313118 27.90826341509819 0.22694705426692932 27.56011864542961 0.22694705426692963 27.208499908447266 C 0.22694705426692935 26.85688117146492 0.296503022313118 26.50873640179634 0.4316098392009735 26.184110641479492 C 0.566716656088829 25.859484881162643 0.7647053599357605 25.564790666103363 1.014175295829773 25.316999435424805 L 3.600175142288208 22.965999603271484 L 3.91717529296875 22.66699981689453 Z M 53.464176177978516 0 C 54.06571960449219 0.05034535378217697 54.6235066652298 0.33465906977653503 55.017677307128906 0.7918446660041809 C 55.411847949028015 1.2490302622318268 55.61094118654728 1.8425995111465454 55.572174072265625 2.444999933242798 L 55.572174072265625 2.5450000762939453 L 57.97217559814453 20.062000274658203 L 57.935176849365234 20.062000274658203 C 57.95784351602197 20.28533360362053 57.97484220378101 20.50833423435688 57.986175537109375 20.731000900268555 C 58.00985828600824 21.19745773077011 58.00685451179743 21.664886713027954 57.977176666259766 22.131000518798828 L 57.96217727661133 22.395000457763672 L 57.922176361083984 22.81999969482422 L 57.8931770324707 23.14299964904785 L 57.8421745300293 23.493999481201172 L 57.78317642211914 23.85300064086914 C 57.75050975382328 24.082333967089653 57.70684257149696 24.309000939130783 57.65217590332031 24.533000946044922 C 57.640175903216004 24.61800094693899 57.61717449873686 24.703000135719776 57.59917449951172 24.7810001373291 L 57.499176025390625 25.19700050354004 C 57.47904108837247 25.259895227849483 57.46300708595663 25.324029326438904 57.451175689697266 25.388999938964844 C 57.40017569065094 25.53799994289875 57.362176299095154 25.689000189304352 57.31117630004883 25.83300018310547 L 57.265174865722656 25.95800018310547 C 57.20917486399412 26.128000184893608 57.16517560184002 26.289000764489174 57.09717559814453 26.450000762939453 L 57.150177001953125 26.450000762939453 L 56.88417434692383 26.979999542236328 C 56.67728289961815 27.464616537094116 56.44358763098717 27.93734747171402 56.184173583984375 28.395999908447266 L 54.41417694091797 31.959999084472656 C 54.37931825220585 32.044463872909546 54.337855983525515 32.12604931741953 54.29017639160156 32.20399856567383 C 54.21886617690325 32.324715457856655 54.12253351509571 32.42876413464546 54.00765609741211 32.5091438293457 C 53.89277867972851 32.589523524045944 53.76201982796192 32.644370052963495 53.624176025390625 32.66999816894531 C 53.489367976784706 32.69067779928446 53.35162277519703 32.680451579391956 53.22134780883789 32.64008712768555 C 53.09107284247875 32.59972267597914 52.971676617860794 32.530277855694294 52.87217712402344 32.4370002746582 L 52.710174560546875 32.25400161743164 L 52.68917465209961 32.23400115966797 L 50.127174377441406 29.274999618530273 L 47.74417495727539 33.400001525878906 L 48.258174896240234 33.9900016784668 L 48.938175201416016 34.7760009765625 C 49.53817522525787 35.46300095319748 48.53317713737488 38.898000955581665 47.74717712402344 40.2760009765625 C 47.211177110672 41.20400094985962 44.11017465591431 45.298999547958374 42.175174713134766 47.83399963378906 C 42.01392860710621 48.13319888710976 41.78207975625992 48.38851375877857 41.49976348876953 48.5777702331543 C 41.217447221279144 48.76702670753002 40.893200129270554 48.88450129702687 40.55517578125 48.91999816894531 C 40.22074481844902 48.940239418298006 39.88660964369774 48.87580369412899 39.58369064331055 48.73264694213867 C 39.280771642923355 48.589490190148354 39.018853947520256 48.372241109609604 38.822174072265625 48.10100173950195 L 31.765174865722656 40.9739990234375 L 31.55317497253418 40.762001037597656 C 31.423111230134964 40.59612978994846 31.336667001247406 40.40032002329826 31.30173110961914 40.19245147705078 C 31.266795217990875 39.9845829308033 31.284481666982174 39.77127458155155 31.35317611694336 39.571998596191406 L 31.453174591064453 39.36000061035156 C 31.639174595475197 38.904000610113144 31.91617551445961 38.29800099134445 32.2431755065918 37.51900100708008 C 32.048175513744354 36.380000948905945 25.690175354480743 32.944998264312744 25.094175338745117 33.39899826049805 C 24.49817532300949 33.85299825668335 20.72017467021942 32.24999988079071 19.13017463684082 30.645999908447266 C 17.971174597740173 29.471999883651733 12.100175380706787 23.365000247955322 9.05417537689209 20.194000244140625 C 8.804910868406296 19.972842946648598 8.601907283067703 19.704514861106873 8.456876754760742 19.404499053955078 C 8.311846226453781 19.104483246803284 8.227659529075027 18.778717756271362 8.209175109863281 18.445999145507812 C 8.155333526432514 17.76491904258728 8.36712071299553 17.089425265789032 8.800175666809082 16.56100082397461 L 9.044175148010254 16.31999969482422 C 10.769175171852112 14.57699966430664 13.263175368309021 12.351000010967255 14.3701753616333 12.776000022888184 C 16.154175400733948 13.462999999523163 20.130175828933716 17.357999086380005 22.718175888061523 18.275999069213867 C 25.2210431098938 18.864596784114838 27.772180795669556 19.224741891026497 30.34017562866211 19.351999282836914 L 31.00017547607422 19.399999618530273 C 32.97517549991608 19.54899962246418 34.89117419719696 19.64699923619628 36.280174255371094 19.674999237060547 C 36.925207793712616 19.707016065716743 37.57166504859924 19.695658661425114 38.21517562866211 19.641000747680664 C 39.79917562007904 19.412000745534897 41.79017639160156 16.895000457763672 41.79017639160156 16.895000457763672 L 40.23717498779297 15.10200023651123 L 40.05117416381836 14.895000457763672 C 39.91290025413036 14.682266816496849 39.83990143169649 14.43371993303299 39.8411750793457 14.180000305175781 C 39.8407403442543 13.99584449827671 39.8802055940032 13.813779935240746 39.956851959228516 13.646331787109375 C 40.03349832445383 13.478883638978004 40.14550682902336 13.330026112496853 40.28517532348633 13.210000038146973 L 43.95217514038086 9.300000190734863 L 51.771175384521484 0.9829999804496765 C 51.94611890614033 0.688370943069458 52.19351214170456 0.44338394701480865 52.489837646484375 0.2713296115398407 C 52.78616315126419 0.09927527606487274 53.12157288193703 0.005872154608368874 53.464176177978516 0 Z"
                                        }
                                        fillRule: ShapePath.OddEvenFill
                                        fillColor: "#adbacc"
                                    }
                                    antialiasing: true
                                }
                            }
                        }
                    }
                }

                Item {
                    id: set_4
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 1203
                    Shape {
                        id: rectangularBk_36
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_29_ShapePath_0
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_29_PathSvg_0
                                path: "M 14 0 L 242 0 C 249.73198652267456 0 256 6.2680134773254395 256 14 L 256 84 C 256 91.73198652267456 249.73198652267456 98 242 98 L 14 98 C 6.2680134773254395 98 0 91.73198652267456 0 84 L 0 14 C 0 6.2680134773254395 6.2680134773254395 0 14 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f0f7ff"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: brakeSwitchStatus
                        color: "#333333"
                        text: qsTr("brake switch")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 81
                        anchors.rightMargin: 17
                        anchors.topMargin: 14
                        anchors.bottomMargin: 53
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: brakeSwitchStatusValue
                        color: "#666666"
                        text: qsTr("not stepped on")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 66
                        anchors.rightMargin: 2
                        anchors.topMargin: 53
                        anchors.bottomMargin: 14
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Item {
                        id: group_23
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 7
                        anchors.rightMargin: 190
                        anchors.topMargin: 19
                        anchors.bottomMargin: 28
                        Shape {
                            id: rectangular11
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: rectangular_ShapePath_11
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: rectangular_PathSvg_11
                                    path: "M 0 0 L 59 0 L 59 51 L 0 51 L 0 0 Z"
                                }
                                fillColor: "transparent"
                            }
                            antialiasing: true
                        }

                        Item {
                            id: group2
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 1
                            anchors.rightMargin: 0
                            Shape {
                                id: brakeSwitchColor
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                layer.samples: 16
                                layer.enabled: true
                                ShapePath {
                                    id: brakeSwitchColor_ShapePath_0
                                    strokeWidth: 1
                                    strokeColor: "transparent"
                                    PathSvg {
                                        id: brakeSwitchColor_PathSvg_0
                                        path: "M 3.919673204421997 22.66699981689453 C 4.138280689716339 22.505902349948883 4.3885743618011475 22.39300971850753 4.654028415679932 22.33577537536621 C 4.919482469558716 22.278541032224894 5.194058060646057 22.278267540037632 5.459625720977783 22.334972381591797 C 5.725193381309509 22.39167722314596 5.975711837410927 22.504070788621902 6.194640159606934 22.664731979370117 C 6.41356848180294 22.825393170118332 6.5959265530109406 23.030666932463646 6.729673385620117 23.267000198364258 L 23.269672393798828 43.64699935913086 L 23.453672409057617 43.87799835205078 C 23.767256200313568 44.32625061273575 23.933612419757992 44.86096405982971 23.92967414855957 45.40800094604492 C 23.93569903075695 45.789054960012436 23.85606835782528 46.16659489274025 23.6966609954834 46.51275634765625 C 23.537253633141518 46.85891780257225 23.302138328552246 47.16486229002476 23.0086727142334 47.40800094604492 L 20.934673309326172 49.76900100708008 C 20.68965882062912 50.13960042595863 20.358383774757385 50.44521635770798 19.969276428222656 50.65962600708008 C 19.580169081687927 50.87403565645218 19.144849747419357 50.99083527550101 18.700674057006836 51 L 3.978673219680786 51 C 3.630635440349579 50.995753658004105 3.2868521213531494 50.9229077398777 2.9670021533966064 50.7856330871582 C 2.6471521854400635 50.648358434438705 2.3575162440538406 50.4493512660265 2.114673376083374 50.20000076293945 L 1.8366731405258179 49.900001525878906 L 0.6656731963157654 48.56100082397461 L 0.5186731815338135 48.409000396728516 L 0.45267316699028015 48.314998626708984 C 0.1664457619190216 47.87925526499748 0.0096337549330201 47.37128680944443 0.00042981430306099355 46.85002517700195 C -0.008774126326898113 46.32876354455948 0.1300072968006134 45.81557539105415 0.40067318081855774 45.369998931884766 C 0.40967318043112755 45.35999893210828 0.4146731784567237 45.34199963416904 0.4216731786727905 45.33399963378906 L 0.4946731626987457 45.25699996948242 L 7.687673091888428 36.70000076293945 L 1.0156731605529785 29.100000381469727 C 0.7660829424858093 28.8522769510746 0.567987859249115 28.557606130838394 0.43280526995658875 28.23297119140625 C 0.2976226806640625 27.908336251974106 0.2280257791280752 27.560156226158142 0.22802577912807465 27.208499908447266 C 0.22802577912807553 26.85684359073639 0.2976226806640625 26.508663564920425 0.43280526995658875 26.18402862548828 C 0.567987859249115 25.859393686056137 0.7660829424858093 25.56472286581993 1.0156731605529785 25.316999435424805 L 3.600673198699951 22.965999603271484 L 3.919673204421997 22.66699981689453 Z M 53.49067306518555 0 C 54.0924768447876 0.050100259482860565 54.650613367557526 0.33427202701568604 55.0451545715332 0.7914536595344543 C 55.43969577550888 1.2486352920532227 55.63915242254734 1.8423417210578918 55.600669860839844 2.444999933242798 L 55.600669860839844 2.5450000762939453 L 58.00067138671875 20.059999465942383 L 57.96367263793945 20.059999465942383 C 57.986339304596186 20.28333279490471 58.00333799235523 20.50633342564106 58.014671325683594 20.729000091552734 C 58.03836716897786 21.19545665383339 58.03536338917911 21.66288635134697 58.005672454833984 22.128999710083008 L 57.99067306518555 22.39299964904785 L 57.9506721496582 22.81800079345703 L 57.92167282104492 23.141000747680664 L 57.870670318603516 23.492000579833984 L 57.81167221069336 23.85099983215332 C 57.7790055423975 24.080333158373833 57.73533836007118 24.307000130414963 57.68067169189453 24.5310001373291 C 57.66867169179022 24.61600013822317 57.64567028731108 24.700999327003956 57.62767028808594 24.77899932861328 L 57.527671813964844 25.19499969482422 C 57.50753687694669 25.257894419133663 57.49150287453085 25.322028517723083 57.479671478271484 25.386999130249023 C 57.42867147922516 25.53599913418293 57.39067208766937 25.68699938058853 57.33967208862305 25.83099937438965 L 57.293670654296875 25.95599937438965 C 57.23767065256834 26.125999376177788 57.19367139041424 26.286999955773354 57.12567138671875 26.447999954223633 L 57.178672790527344 26.447999954223633 L 56.91267013549805 26.97800064086914 C 56.70578995347023 27.462622821331024 56.47209820151329 27.935352474451065 56.21267318725586 28.393999099731445 L 54.440670013427734 31.959999084472656 C 54.40580755472183 32.04446214437485 54.364349249750376 32.12604729086161 54.316673278808594 32.20399856567383 C 54.24520553648472 32.32478643208742 54.14869926124811 32.428871005773544 54.03364944458008 32.50925064086914 C 53.918599627912045 32.58963027596474 53.787670254707336 32.64444082789123 53.6496696472168 32.66999816894531 C 53.51486159861088 32.69067779928446 53.37712021172047 32.680451579391956 53.24684524536133 32.64008712768555 C 53.11657027900219 32.59972267597914 52.997170239686966 32.530277855694294 52.89767074584961 32.4370002746582 L 52.73567199707031 32.25400161743164 L 52.71467208862305 32.23400115966797 L 50.15167236328125 29.274999618530273 L 47.767669677734375 33.400001525878906 L 48.28166961669922 33.9900016784668 L 48.961669921875 34.7760009765625 C 49.56166994571686 35.46300095319748 48.55667185783386 38.89900100231171 47.77067184448242 40.2760009765625 C 47.23467183113098 41.20400094985962 44.1316704750061 45.298999547958374 42.19667053222656 47.83399963378906 C 42.035262793302536 48.13327419757843 41.80324104428291 48.388625368475914 41.520751953125 48.577880859375 C 41.23826286196709 48.767136350274086 40.913847863674164 48.88457340747118 40.5756721496582 48.91999816894531 C 40.241088688373566 48.9403178896755 39.9067839384079 48.87592150270939 39.60369110107422 48.732765197753906 C 39.30059826374054 48.589608892798424 39.03850798308849 48.37232109904289 38.841670989990234 48.10100173950195 L 31.781673431396484 40.9739990234375 L 31.569673538208008 40.76100158691406 C 31.439609795808792 40.59513033926487 31.3531636595726 40.39932057261467 31.318227767944336 40.19145202636719 C 31.28329187631607 39.983583480119705 31.30097832530737 39.77027513086796 31.369672775268555 39.57099914550781 L 31.46967315673828 39.35900115966797 C 31.655673161149025 38.90300115942955 31.932670265436172 38.29700154066086 32.25967025756836 37.518001556396484 C 32.06467026472092 36.37900149822235 25.70367419719696 32.94399881362915 25.106674194335938 33.39799880981445 C 24.509674191474915 33.851998805999756 20.73067319393158 32.24900043010712 19.139673233032227 30.645000457763672 C 17.976673245429993 29.468000411987305 12.103673696517944 23.360000610351562 9.055673599243164 20.190000534057617 C 8.806183829903603 19.968965217471123 8.602964773774147 19.700683176517487 8.457756996154785 19.40065574645996 C 8.312549218535423 19.100628316402435 8.228230422362685 18.77480173110962 8.209672927856445 18.441999435424805 C 8.156884502619505 17.762263655662537 8.368610173463821 17.088398814201355 8.800673484802246 16.56100082397461 L 9.044672966003418 16.31999969482422 C 10.769672989845276 14.57699966430664 13.265673041343689 12.351000010967255 14.372673034667969 12.776000022888184 C 16.157673001289368 13.462999999523163 20.134674310684204 17.357999086380005 22.724674224853516 18.275999069213867 C 25.228891372680664 18.864614129066467 27.781358242034912 19.224757939577103 30.35067367553711 19.351999282836914 L 31.011672973632812 19.402999877929688 C 32.98767292499542 19.551999881863594 34.90467059612274 19.649999495595694 36.293670654296875 19.67799949645996 C 36.939037442207336 19.71001898497343 37.58582693338394 19.69865969568491 38.229671478271484 19.643999099731445 C 39.81467151641846 19.414999097585678 41.806671142578125 16.898000717163086 41.806671142578125 16.898000717163086 L 40.25267028808594 15.104999542236328 L 40.066673278808594 14.89799976348877 C 39.9283993691206 14.685266122221947 39.85539673198946 14.436719238758087 39.85667037963867 14.182999610900879 C 39.85623564454727 13.998843804001808 39.89570089429617 13.81678019464016 39.972347259521484 13.649332046508789 C 40.0489936247468 13.481883898377419 40.16100212931633 13.333026371896267 40.3006706237793 13.213000297546387 L 43.97467041015625 9.300000190734863 L 51.8006706237793 0.9829999804496765 C 51.9754202067852 0.6888621747493744 52.22235855460167 0.44419850409030914 52.51810073852539 0.272178053855896 C 52.81384292244911 0.10015760362148285 53.14860209822655 0.006474385503679514 53.49067306518555 0 Z"
                                    }
                                    fillRule: ShapePath.OddEvenFill
                                    fillColor: "#adbacc"
                                }
                                antialiasing: true
                            }
                        }
                    }
                }
            }

            Item {
                id: group_32
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 23
                anchors.rightMargin: 1239
                anchors.topMargin: 162
                anchors.bottomMargin: 20
                Item {
                    id: group_12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 26
                    anchors.rightMargin: 283
                    anchors.topMargin: 524
                    anchors.bottomMargin: 79
                    Shape {
                        id: shapeComb14
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 11
                        anchors.rightMargin: 329
                        anchors.topMargin: 24
                        anchors.bottomMargin: 54
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_14
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: shapeComb_PathSvg_14
                                path: "M 7.401895999908447 0.003871265798807144 L 7.5388970375061035 0.01087123528122902 C 8.658897042274475 0.13987122848629951 9.399896560236812 1.789871335029602 9.413896560668945 3.7328712940216064 C 9.425896560773253 5.465871334075928 9.413896560668945 7.200871825218201 9.413896560668945 8.93287181854248 L 9.413896560668945 91.5168685913086 C 9.404896561056376 93.27286863327026 8.825896620750427 94.87086883187294 7.813896656036377 95.21086883544922 C 6.891896665096283 95.51986882090569 6.226896941661835 94.65486800670624 5.62589693069458 93.51786804199219 C 4.988100528717041 92.27831590175629 4.434838771820068 90.99706184864044 3.9698967933654785 89.68286895751953 C 2.9401673078536987 86.78384017944336 2.123004734516144 83.81364488601685 1.5248969793319702 80.79586791992188 C 0.2982206344604492 74.64083480834961 -0.19122463464736938 68.36163854598999 0.06689682602882385 62.09086990356445 C 0.1907275840640068 58.82627868652344 0.5106377005577087 55.572084188461304 1.0248969793319702 52.34587478637695 C 1.3762371838092804 50.844287157058716 1.616222396492958 49.318803548812866 1.7428964376449585 47.7818717956543 C 1.6549000218510628 46.244853377342224 1.429670810699463 44.71878159046173 1.0698970556259155 43.22187423706055 C -0.9881030321121216 30.78987407684326 -0.030102968215942383 16.80487298965454 3.88789701461792 5.841872692108154 C 4.341323047876358 4.5430251359939575 4.875703155994415 3.273871421813965 5.48789644241333 2.0418732166290283 C 6.038896441459656 0.9548732042312622 6.658895909786224 -0.09512656554579735 7.540895938873291 0.006873432546854019 L 7.401895999908447 0.003871265798807144 Z"
                            }
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular12
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 32
                        anchors.rightMargin: 15
                        anchors.topMargin: 32
                        anchors.bottomMargin: 48
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_12
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangular_PathSvg_12
                                path: "M 10.956998825073242 0 L 297.7040100097656 0 C 298.9956142902374 7.105427357601002e-15 300.2343113422394 0.5130894184112549 301.1476135253906 1.4263916015625 C 302.06091570854187 2.339693784713745 302.5740051269531 3.578394651412964 302.5740051269531 4.869998931884766 L 302.5740051269531 92.78399658203125 L 10.956998825073242 92.78399658203125 C 8.051021814346313 92.78399658203126 5.264066457748413 91.62960410118103 3.209230422973633 89.57476806640625 C 1.1543943881988525 87.51993203163147 -3.552713678800501e-15 84.7329728603363 0 81.82699584960938 L 0 10.957000732421875 C 0.00026512067415751517 8.051278114318848 1.1546070575714111 5.264626979827881 3.209169387817383 3.2098770141601562 C 5.2637317180633545 1.1551270484924316 8.051276206970215 0.0005303260404616594 10.956998825073242 0 Z"
                            }
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_43
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 44
                        anchors.rightMargin: 34
                        anchors.topMargin: 50
                        anchors.bottomMargin: 48
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_43_ShapePath_0
                            strokeWidth: 2.435
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_43_PathSvg_0
                                path: "M 0 0 L 271.9289855957031 0 L 271.9289855957031 75.15299987792969 L 0 75.15299987792969 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#a8a8b3"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_57
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 44
                        anchors.rightMargin: 33
                        anchors.topMargin: 36
                        anchors.bottomMargin: 134
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_57_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_57_PathSvg_0
                                path: "M 0 0 L 273.1470031738281 0 L 273.1470031738281 3.134000062942505 L 0 3.134000062942505 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#a8a8b3"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_58
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 43
                        anchors.rightMargin: 32
                        anchors.topMargin: 23
                        anchors.bottomMargin: 141
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_58_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangularBk_58_PathSvg_0
                                path: "M 1.2179985046386719 6.750155989720952e-14 L 273.14697265625 6.750155989720952e-14 C 273.3068755567074 -5.398146640800405e-8 273.465257614851 0.0315127931535244 273.61297607421875 0.09273529052734375 C 273.7606945335865 0.1539577879011631 273.89485155791044 0.24369095265865326 274.00787353515625 0.35680580139160156 C 274.12089551240206 0.46992065012454987 274.2105663344264 0.604199692606926 274.27166748046875 0.7519683837890625 C 274.3327686265111 0.899737074971199 274.3641450629075 1.0580975711345673 274.364013671875 1.2180004119873047 L 274.364013671875 9.408000946044922 L 0 9.408000946044922 L 0 1.217000961303711 C 0.0002650743117555976 0.8941405713558197 0.12870703637599945 0.5845949798822403 0.3570976257324219 0.35639190673828125 C 0.5854882150888443 0.1281888335943222 0.8951379954814911 -1.0881534606710375e-7 1.2179985046386719 6.750155989720952e-14 Z"
                            }
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_61
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 308
                        anchors.topMargin: 70
                        anchors.bottomMargin: 87
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_61_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangularBk_61_PathSvg_0
                                path: "M 7.938000202178955 0.00099945068359375 L 42.14400100708008 0.00099945068359375 L 42.14400100708008 15.875999450683594 L 7.938000202178955 15.875999450683594 C 5.832711696624756 15.875999450683608 3.8136502504348755 15.039681553840637 2.324986457824707 13.551017761230469 C 0.8363226652145386 12.0623539686203 1.2212453270876722e-15 10.043292045593262 0 7.9380035400390625 C 4.440892098500626e-16 5.832715034484863 0.8363226652145386 3.8136531114578247 2.324986457824707 2.3249893188476562 C 3.8136502504348755 0.8363255262374878 5.832711696624756 0.00099945068359375 7.938000202178955 0.00099945068359375 Z"
                            }
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_62
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 57
                        anchors.rightMargin: 280
                        anchors.topMargin: 165
                        anchors.bottomMargin: 0
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_62_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangularBk_62_PathSvg_0
                                path: "M 0 0 L 12.599998474121094 0 L 12.599998474121094 5.9919891357421875 C 12.599998474121094 6.637791275978088 12.343461394309998 7.257139801979065 11.886810302734375 7.7137908935546875 C 11.430159211158752 8.17044198513031 10.810803055763245 8.426986694335938 10.165000915527344 8.426986694335938 L 2.44000244140625 8.426986694335938 C 1.7942003011703491 8.426986694335909 1.174847960472107 8.17044198513031 0.7181968688964844 7.7137908935546875 C 0.2615457773208618 7.257139801979065 0.00500106811522727 6.637791275978088 0.005001068115234375 5.9919891357421875 L 0.005001068115234375 0 L 0 0 Z"
                            }
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_63
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 334
                        anchors.rightMargin: -1
                        anchors.topMargin: 62
                        anchors.bottomMargin: 52
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_63_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_63_PathSvg_0
                                path: "M 8.358978271484375 0 C 10.45790147781372 1.4210854715202004e-14 12.470884680747986 0.8337920904159546 13.955047607421875 2.3179550170898438 C 15.439210534095764 3.802117943763733 16.272979736328125 5.815078258514404 16.272979736328125 7.91400146484375 L 16.272979736328125 51.361000061035156 C 16.272714580380125 53.45957684516907 15.438965439796448 55.472121596336365 13.955047607421875 56.95603942871094 C 12.471129775047302 58.43995726108551 10.458562135696411 59.27373691924731 8.3599853515625 59.27400207519531 L 0 59.27400207519531 L 0 0 L 8.358978271484375 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#909499"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_60
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 61
                        anchors.rightMargin: 259
                        anchors.bottomMargin: 163
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_60_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangularBk_60_PathSvg_0
                                path: "M 3.6529998779296875 2.3459272041224596e-15 L 26.35300064086914 2.3459272041224596e-15 C 27.32157129049301 2.7622608383568933e-15 28.25046944618225 0.38476312160491943 28.935352325439453 1.0696460008621216 C 29.620235204696655 1.7545288801193237 30.005001068115234 2.6834293007850647 30.005001068115234 3.6519999504089355 L 30.005001068115234 10.357999801635742 L 0 10.357999801635742 L 0 3.6519999504089355 C 0.0002651690738275647 2.683337390422821 0.3852517604827881 1.7544394731521606 1.0702934265136719 1.0695853233337402 C 1.7553350925445557 0.3847311735153198 2.6843372583389282 -3.6294698232382653e-8 3.6529998779296875 2.3459272041224596e-15 Z"
                            }
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_59
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 44
                        anchors.rightMargin: 33
                        anchors.topMargin: 8
                        anchors.bottomMargin: 150
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_59_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_59_PathSvg_0
                                path: "M 265.2860107421875 2.0994251670458652e-8 C 266.20903158187866 -0.00009158598966330089 267.1071091890335 0.2996097207069397 267.8450927734375 0.853999137878418 C 268.5830763578415 1.4083885550498962 269.1210487782955 2.187471926212311 269.3780212402344 3.074000358581543 L 272.7480163574219 14.656999588012695 L 0 14.656999588012695 L 3.3649978637695312 3.0719995498657227 C 3.6224769055843353 2.1859277486801147 4.160629093647003 1.4073795676231384 4.898548126220703 0.8533992767333984 C 5.636467158794403 0.29941898584365845 6.534273386001587 -0.000054594235349370024 7.456996917724609 2.0994251670458652e-8 L 265.2860107421875 2.0994251670458652e-8 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#565a61"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_44
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 269
                        anchors.rightMargin: 68
                        anchors.topMargin: 67
                        anchors.bottomMargin: 36
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_43_ShapePath_1
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_43_PathSvg_1
                                path: "M 0 0 L 12.61400032043457 0 L 12.61400032043457 69.9020004272461 L 0 69.9020004272461 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#5f6164"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_46
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 222
                        anchors.rightMargin: 115
                        anchors.topMargin: 67
                        anchors.bottomMargin: 36
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_46_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_46_PathSvg_0
                                path: "M 0 0 L 12.61400032043457 0 L 12.61400032043457 69.9020004272461 L 0 69.9020004272461 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#5f6164"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_51
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 267
                        anchors.rightMargin: 66
                        anchors.topMargin: 34
                        anchors.bottomMargin: 114
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_51_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_51_PathSvg_0
                                path: "M 11.71099853515625 0.007999475114047527 C 12.483222424983978 0.007408257573843002 13.245927035808563 0.17841875553131104 13.9439697265625 0.5086708664894104 C 14.642012417316437 0.8389229774475098 15.257929652929306 1.3201614618301392 15.747222900390625 1.9175910949707031 C 16.236516147851944 2.515020728111267 16.586944699287415 3.2137149572372437 16.773162841796875 3.9631500244140625 C 16.959380984306335 4.712585091590881 16.976730599999428 5.494034647941589 16.823974609375 6.250999450683594 L 12.97998046875 25.382999420166016 L 0 25.382999420166016 L 3.79998779296875 6.482997894287109 C 4.16715282201767 4.654323101043701 5.156253457069397 3.0092289447784424 6.59918212890625 1.8273582458496094 C 8.042110800743103 0.6454875469207764 9.849825739860535 -0.00021835183357410415 11.714996337890625 5.538826286510812e-8 L 11.71099853515625 0.007999475114047527 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_54
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 138
                        anchors.rightMargin: 195
                        anchors.topMargin: 34
                        anchors.bottomMargin: 114
                        rotation: 180
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_54_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_54_PathSvg_0
                                path: "M 11.710000038146973 25.378000259399414 C 12.48201835155487 25.377835096936906 13.244377374649048 25.206330716609955 13.94208812713623 24.875858306884766 C 14.639798879623413 24.545385897159576 15.255468875169754 24.06418251991272 15.744688987731934 23.46695899963379 C 16.233909100294113 22.86973547935486 16.58448453247547 22.171379446983337 16.771127700805664 21.42226219177246 C 16.957770869135857 20.673144936561584 16.97582821547985 19.89194166660309 16.823999404907227 19.135000228881836 L 12.979999542236328 0 L 0 0 L 3.799999952316284 18.899999618530273 C 4.167516261339188 20.728501439094543 5.156728744506836 22.373380184173584 6.599579811096191 23.555187225341797 C 8.042430877685547 24.73699426651001 9.849929928779602 25.382839347599656 11.71500015258789 25.382999420166016 L 11.710000038146973 25.378000259399414 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_52
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 234
                        anchors.rightMargin: 99
                        anchors.topMargin: 34
                        anchors.bottomMargin: 114
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_52_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_52_PathSvg_0
                                path: "M 11.708999633789062 0.007999475114047527 C 12.48101794719696 0.008164637576555833 13.243375062942505 0.17966711521148682 13.941085815429688 0.510139524936676 C 14.63879656791687 0.8406119346618652 15.254462748765945 1.32181715965271 15.743682861328125 1.9190406799316406 C 16.232902973890305 2.5162642002105713 16.583483174443245 3.2146202325820923 16.770126342773438 3.9637374877929688 C 16.95676951110363 4.712854743003845 16.974826857447624 5.494058012962341 16.822998046875 6.250999450683594 L 12.981002807617188 25.382999420166016 L 0 25.382999420166016 L 3.8000030517578125 6.482997894287109 C 4.167168080806732 4.654323101043701 5.156283974647522 3.0092289447784424 6.599212646484375 1.8273582458496094 C 8.042141318321228 0.6454875469207764 9.849825739860535 -0.00021835183357410415 11.714996337890625 5.538826286510812e-8 L 11.708999633789062 0.007999475114047527 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_55
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 105
                        anchors.rightMargin: 228
                        anchors.topMargin: 34
                        anchors.bottomMargin: 114
                        rotation: 180
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_55_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_55_PathSvg_0
                                path: "M 11.711000442504883 25.378000259399414 C 12.483224332332611 25.37859147693962 13.245929896831512 25.20757907629013 13.94397258758545 24.87732696533203 C 14.642015278339386 24.547074854373932 15.257950633764267 24.065836310386658 15.747243881225586 23.468406677246094 C 16.236537128686905 22.87097704410553 16.58696186542511 22.172284722328186 16.77318000793457 21.422849655151367 C 16.95939815044403 20.67341458797455 16.976755395531654 19.89196503162384 16.823999404907227 19.135000228881836 L 12.979999542236328 0 L 0 0 L 3.799999952316284 18.899999618530273 C 4.167164981365204 20.72867441177368 5.156280159950256 22.373770475387573 6.599208831787109 23.555641174316406 C 8.042137503623962 24.73751187324524 9.8498295545578 25.383217827387853 11.71500015258789 25.382999420166016 L 11.711000442504883 25.378000259399414 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_53
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 202
                        anchors.rightMargin: 131
                        anchors.topMargin: 34
                        anchors.bottomMargin: 114
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_53_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_53_PathSvg_0
                                path: "M 11.707000732421875 0.007999420166015625 C 12.479019045829773 0.008164582628523931 13.241376161575317 0.17966705560684204 13.9390869140625 0.5101394653320312 C 14.636797666549683 0.8406118750572205 15.252463847398758 1.32181715965271 15.741683959960938 1.9190406799316406 C 16.230904072523117 2.5162642002105713 16.581484273076057 3.2146202325820923 16.76812744140625 3.9637374877929688 C 16.954770609736443 4.712854743003845 16.972827956080437 5.494058012962341 16.820999145507812 6.250999450683594 L 12.979995727539062 25.382999420166016 L 0 25.382999420166016 L 3.7949981689453125 6.482997894287109 C 4.162514477968216 4.654496073722839 5.1517229080200195 3.0096192359924316 6.594573974609375 1.8278121948242188 C 8.03742504119873 0.6460051536560059 9.844921231269836 0.0001600725663593039 11.709991455078125 0 L 11.707000732421875 0.007999420166015625 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_56
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 73
                        anchors.rightMargin: 260
                        anchors.topMargin: 34
                        anchors.bottomMargin: 114
                        rotation: 180
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_56_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_56_PathSvg_0
                                path: "M 11.711000442504883 25.378000259399414 C 12.483076691627502 25.378015730275365 13.24552708864212 25.206630557775497 13.943328857421875 24.8762149810791 C 14.64113062620163 24.545799404382706 15.25687888264656 24.06459355354309 15.746135711669922 23.46732521057129 C 16.235392540693283 22.870056867599487 16.585956260561943 22.171623408794403 16.772525787353516 21.422428131103516 C 16.959095314145088 20.673232853412628 16.97701807320118 19.89196288585663 16.825000762939453 19.135000228881836 L 12.980999946594238 0 L 0 0 L 3.799999952316284 18.899999618530273 C 4.167340666055679 20.728587865829468 5.156504511833191 22.37357532978058 6.59939432144165 23.5554141998291 C 8.04228413105011 24.737253069877625 9.849879741668701 25.383028551093958 11.71500015258789 25.382999420166016 L 11.711000442504883 25.378000259399414 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_47
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 175
                        anchors.rightMargin: 162
                        anchors.topMargin: 67
                        anchors.bottomMargin: 36
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_47_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_47_PathSvg_0
                                path: "M 0 0 L 12.61400032043457 0 L 12.61400032043457 69.9020004272461 L 0 69.9020004272461 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#5f6164"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_48
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 128
                        anchors.rightMargin: 209
                        anchors.topMargin: 67
                        anchors.bottomMargin: 36
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_48_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_48_PathSvg_0
                                path: "M 0 0 L 12.61400032043457 0 L 12.61400032043457 69.9020004272461 L 0 69.9020004272461 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#5f6164"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_49
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 81
                        anchors.rightMargin: 256
                        anchors.topMargin: 67
                        anchors.bottomMargin: 36
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_49_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_49_PathSvg_0
                                path: "M 0 0 L 12.61400032043457 0 L 12.61400032043457 69.9020004272461 L 0 69.9020004272461 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#5f6164"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_50
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 72
                        anchors.rightMargin: 61
                        anchors.topMargin: 58
                        anchors.bottomMargin: 102
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_50_ShapePath_0
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_50_PathSvg_0
                                path: "M 6.73799991607666 0 L 209.89700317382812 0 C 213.61829781532288 0 216.63499450683594 3.016705274581909 216.63499450683594 6.73799991607666 C 216.63499450683594 10.459294557571411 213.61829781532288 13.47599983215332 209.89700317382812 13.47599983215332 L 6.73799991607666 13.47599983215332 C 3.016705274581909 13.47599983215332 0 10.459294557571411 0 6.73799991607666 C 0 3.016705274581909 3.016705274581909 0 6.73799991607666 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_45
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 44
                        anchors.rightMargin: 210
                        anchors.topMargin: 135
                        anchors.bottomMargin: 8
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_44_ShapePath_0
                            strokeWidth: 2.435
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_44_PathSvg_0
                                path: "M 95.260009765625 0 L 95.260009765625 20.628005981445312 C 95.25974465694162 23.210960149765015 94.23361814022064 25.688054084777832 92.40728759765625 27.514572143554688 C 90.58095705509186 29.341090202331543 88.10396528244019 30.367465903167613 85.52101135253906 30.367996215820312 L 9.740001678466797 30.367996215820312 C 7.156793117523193 30.367996215820312 4.67938756942749 29.341832637786865 2.852783203125 27.515228271484375 C 1.0261788368225098 25.688623905181885 -7.105427357601002e-15 23.211214542388916 0 20.628005981445312 L 0 0 L 95.260009765625 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#565a61"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_88
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 140
                        anchors.rightMargin: 32
                        anchors.topMargin: 139
                        anchors.bottomMargin: 23
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_45_ShapePath_0
                            strokeWidth: 3.652
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_45_PathSvg_0
                                path: "M 0 0 L 177.66299438476562 0 L 177.66299438476562 11.041000366210938 L 0 11.041000366210938 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#909499"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular13
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 317
                        anchors.rightMargin: 15
                        anchors.topMargin: 11
                        anchors.bottomMargin: 19
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_13
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangular_PathSvg_13
                                path: "M 0 0 L 12.621002197265625 0 C 15.310002088546753 0 17.490997314453125 2.4689993858337402 17.490997314453125 5.5149993896484375 L 17.490997314453125 137.45799255371094 C 17.490997314453125 140.50399255752563 15.310002088546753 142.97299194335938 12.621002197265625 142.97299194335938 L 4.8699951171875 142.97299194335938 C 2.180995225906372 142.97299194335938 0 140.50399255752563 0 137.45799255371094 L 0 0 Z"
                            }
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular14
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 324
                        anchors.rightMargin: 15
                        anchors.topMargin: 11
                        anchors.bottomMargin: 20
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_14
                            strokeWidth: 1.217
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_14
                                path: "M 6.084991455078125 0 C 6.659198701381683 0.006611108314245939 7.225307404994965 0.13634642958641052 7.745086669921875 0.3804512023925781 C 8.264865934848785 0.6245559751987457 8.726215481758118 0.9773481786251068 9.097991943359375 1.4150009155273438 C 9.91485744714737 2.3644264340400696 10.358426754362881 3.578590512275696 10.345977783203125 4.830997467041016 L 10.345977783203125 136.9239959716797 C 10.358303928747773 138.17668318748474 9.914765059947968 139.39113026857376 9.097991943359375 140.34100341796875 C 8.726215481758118 140.778656154871 8.264865934848785 141.13144454360008 7.745086669921875 141.37554931640625 C 7.225307404994965 141.61965408921242 6.659198701381683 141.74938559578732 6.084991455078125 141.75599670410156 L 0 141.75599670410156 L 0 0 L 6.084991455078125 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#909499"
                        }
                        antialiasing: true
                    }
                }

                Shape {
                    id: route_5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 19
                    anchors.rightMargin: 404
                    anchors.topMargin: 307
                    anchors.bottomMargin: 40
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_5_ShapePath_0
                        strokeWidth: 20
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#ff8000"
                        PathSvg {
                            id: route_5_PathSvg_0
                            path: "M 235.39700317382812 363.906005859375 L 235.39700317382812 411.0059814453125 C 235.39700317382812 420.76898097991943 228.90800285339355 428.6820068359375 220.89700317382812 428.6820068359375 L 14.5 428.6820068359375 C 6.494999885559082 428.6820068359375 0 420.76898097991943 0 411.0059814453125 L 0 17.675994873046875 C 0 7.912995338439941 6.489999771118164 0 14.5 0 L 45.69999694824219 0"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_7
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 622
                    anchors.topMargin: 325
                    anchors.bottomMargin: 427
                    Shape {
                        id: rectangularBk_5
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 12
                        anchors.rightMargin: -1
                        anchors.topMargin: 3
                        anchors.bottomMargin: 1
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_4_ShapePath_1
                            strokeWidth: 1.182
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_4_PathSvg_1
                                path: "M 0 0 L 23.75200080871582 2.9070000648498535 C 24.181815326213837 2.9595083221793175 24.57755634188652 3.1674923598766327 24.86456871032715 3.4917168617248535 C 25.151581078767776 3.8159413635730743 25.31002000343142 4.23399031162262 25.309999465942383 4.6670002937316895 L 25.309999465942383 15.42300033569336 C 25.31002000343142 15.85601031780243 25.151581078767776 16.274059265851974 24.86456871032715 16.598283767700195 C 24.57755634188652 16.922508269548416 24.181815326213837 17.1304903998971 23.75200080871582 17.182998657226562 L 0 20.090999603271484 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#aaaaaa"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular15
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 25
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_15
                            strokeWidth: 1.182
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_15
                                path: "M 2.364000082015991 0 L 9.425999641418457 0 C 10.731600761413574 0 11.789999961853027 1.058398962020874 11.789999961853027 2.364000082015991 L 11.789999961853027 21.729999542236328 C 11.789999961853027 23.035600662231445 10.731600761413574 24.0939998626709 9.425999641418457 24.0939998626709 L 2.364000082015991 24.0939998626709 C 1.058398962020874 24.0939998626709 0 23.035600662231445 0 21.729999542236328 L 0 2.364000082015991 C 0 1.058398962020874 1.058398962020874 0 2.364000082015991 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#aaaaaa"
                        }
                        antialiasing: true
                    }
                }

                Shape {
                    id: route_6
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 57
                    anchors.rightMargin: 180
                    anchors.topMargin: 26
                    anchors.bottomMargin: 210
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_6_ShapePath_0
                        strokeWidth: 20
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#20bddb"
                        PathSvg {
                            id: route_6_PathSvg_0
                            path: "M 28.413330078125 512.197021484375 L 0.0003272873000241816 512.197021484375 L 0.0003272873000241816 18.736000061035156 C -0.028934517817106098 13.796568393707275 1.9050204753875732 9.047786235809326 5.376814842224121 5.534172058105469 C 8.848609209060669 2.0205578804016113 13.573900699615479 0.029880337417125702 18.513328552246094 0 L 402.67132568359375 0 C 405.1171612739563 0.014533075504004955 407.53617811203003 0.5106936097145081 409.7902526855469 1.4601516723632812 C 412.0443272590637 2.4096097350120544 414.08929800987244 3.793768048286438 415.80841064453125 5.533588409423828 C 417.52752327919006 7.273408770561218 418.8871074318886 9.334816694259644 419.80950927734375 11.60009765625 C 420.7319111227989 13.865378618240356 421.1990782422945 16.290165662765503 421.184326171875 18.736000061035156 L 421.184326171875 539.4800415039062"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_9
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 181
                    anchors.rightMargin: 320
                    anchors.bottomMargin: 730
                    Shape {
                        id: rectangular16
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 2
                        anchors.rightMargin: 1
                        anchors.topMargin: 2
                        anchors.bottomMargin: -1
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_16
                            strokeWidth: 3
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_16
                                path: "M 0 0 L 154.5989990234375 0 L 154.5989990234375 44.01599884033203 L 0 44.01599884033203 L 0 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#5fd992"
                        }
                        antialiasing: true
                    }

                    Item {
                        id: group_8
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 11
                        anchors.rightMargin: 11
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        Shape {
                            id: route_7_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: -1
                            anchors.bottomMargin: 25
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }

                        Shape {
                            id: route_7Backup_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: 7
                            anchors.bottomMargin: 18
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7Backup_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7Backup_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }

                        Shape {
                            id: route_7Backup_2_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: 7
                            anchors.bottomMargin: 18
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7Backup_2_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7Backup_2_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }

                        Shape {
                            id: route_7Backup_5_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: 11
                            anchors.bottomMargin: 14
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7Backup_5_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7Backup_5_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }

                        Shape {
                            id: route_7Backup_7_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: 14
                            anchors.bottomMargin: 11
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7Backup_7_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7Backup_7_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }

                        Shape {
                            id: route_7Backup_8_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: 18
                            anchors.bottomMargin: 7
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7Backup_8_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7Backup_8_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }

                        Shape {
                            id: route_7Backup_9_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: 18
                            anchors.bottomMargin: 7
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7Backup_9_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7Backup_9_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }

                        Shape {
                            id: route_7Backup_10_Stroke_
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.topMargin: 25
                            anchors.bottomMargin: -1
                            layer.samples: 16
                            layer.enabled: true
                            ShapePath {
                                id: route_7Backup_10_Stroke__ShapePath_0
                                strokeWidth: 1
                                strokeColor: "transparent"
                                PathSvg {
                                    id: route_7Backup_10_Stroke__PathSvg_0
                                    path: "M 136.03125 0 L 136.03125 1 L 0 1 L 0 0 L 136.03125 0 Z"
                                }
                                fillRule: ShapePath.WindingFill
                                fillColor: "#000000"
                            }
                            antialiasing: true
                        }
                    }

                    Shape {
                        id: rectangular17
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 152
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_17
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangular_PathSvg_17
                                path: "M 0 0 L 5.252999782562256 0 L 5.252999782562256 45.51599884033203 L 0 45.51599884033203 L 0 0 Z"
                            }
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_6
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 153
                        anchors.rightMargin: -1
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_5_ShapePath_0
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: rectangularBk_5_PathSvg_0
                                path: "M 0 0 L 5.252999782562256 0 L 5.252999782562256 45.51599884033203 L 0 45.51599884033203 L 0 0 Z"
                            }
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }
                }

                Item {
                    id: group_19
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 69
                    anchors.rightMargin: 440
                    anchors.topMargin: 708
                    anchors.bottomMargin: 13
                    Shape {
                        id: rectangular18
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_18
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_18
                                path: "M 10 0 L 139 0 C 144.5228476524353 0 149 4.477152347564697 149 10 L 149 45 C 149 50.5228476524353 144.5228476524353 55 139 55 L 10 55 C 4.477152347564697 55 0 50.5228476524353 0 45 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#b3b3b3"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: eGR_Cooler
                        color: "#000000"
                        text: qsTr("EGR cooler")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 20
                        anchors.rightMargin: 13
                        anchors.topMargin: 14
                        anchors.bottomMargin: 14
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }

                Shape {
                    id: route_8
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 207
                    anchors.rightMargin: 135
                    anchors.topMargin: 548
                    anchors.bottomMargin: 103
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_8_ShapePath_0
                        strokeWidth: 20
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#ff8000"
                        PathSvg {
                            id: route_8_PathSvg_0
                            path: "M 316.053955078125 0 L 316.053955078125 108.89999389648438 C 316.053955078125 117.73699378967285 307.310977935791 124.89999389648438 296.5269775390625 124.89999389648438 L 19.526992797851562 124.89999389648438 C 8.742992401123047 124.89999389648438 0 117.73699378967285 0 108.89999389648438 L 0 26.519989013671875"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.OddEvenFill
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 442
                    anchors.rightMargin: 108
                    anchors.topMargin: 528
                    anchors.bottomMargin: 177
                    Shape {
                        id: rectangular19
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 21
                        anchors.bottomMargin: 19
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_19
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_19
                                path: "M 6 0 L 102.41300201416016 0 C 105.72671055793762 0 108.41300201416016 2.686291456222534 108.41300201416016 6 L 108.41300201416016 24.89699935913086 C 108.41300201416016 28.210707902908325 105.72671055793762 30.89699935913086 102.41300201416016 30.89699935913086 L 6 30.89699935913086 C 2.686291456222534 30.89699935913086 0 28.210707902908325 0 24.89699935913086 L 0 6 C 0 2.686291456222534 2.686291456222534 0 6 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#b3b3b3"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular20
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 70
                        anchors.topMargin: 21
                        anchors.bottomMargin: 19
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_20
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_20
                                path: "M 6 0 L 32.76300048828125 0 C 36.076709032058716 0 38.76300048828125 2.686291456222534 38.76300048828125 6 L 38.76300048828125 24.89699935913086 C 38.76300048828125 28.210707902908325 36.076709032058716 30.89699935913086 32.76300048828125 30.89699935913086 L 6 30.89699935913086 C 2.686291456222534 30.89699935913086 0 28.210707902908325 0 24.89699935913086 L 0 6 C 0 2.686291456222534 2.686291456222534 0 6 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#20bddb"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular21
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 22
                        anchors.rightMargin: 56
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_21
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_21
                                path: "M 11 0 L 19.541000366210938 0 C 25.616132736206055 0 30.541000366210938 4.924867630004883 30.541000366210938 11 L 30.541000366210938 59.952999114990234 C 30.541000366210938 66.02813148498535 25.616132736206055 70.9530029296875 19.541000366210938 70.9530029296875 L 11 70.9530029296875 C 4.924867630004883 70.9530029296875 0 66.02813148498535 0 59.952999114990234 L 0 11 C 0 4.924867630004883 4.924867630004883 0 11 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#20bddb"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangularBk_7
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 67
                        anchors.rightMargin: 11
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_6_ShapePath_0
                            strokeWidth: 1
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_6_PathSvg_0
                                path: "M 11 0 L 19.541000366210938 0 C 25.616132736206055 0 30.541000366210938 4.924867630004883 30.541000366210938 11 L 30.541000366210938 59.952999114990234 C 30.541000366210938 66.02813148498535 25.616132736206055 70.9530029296875 19.541000366210938 70.9530029296875 L 11 70.9530029296875 C 4.924867630004883 70.9530029296875 0 66.02813148498535 0 59.952999114990234 L 0 11 C 0 4.924867630004883 4.924867630004883 0 11 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#ff8000"
                        }
                        antialiasing: true
                    }
                }

                Shape {
                    id: route_14Backup
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 37
                    anchors.rightMargin: 582
                    anchors.topMargin: 82
                    anchors.bottomMargin: 439
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_14Backup_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#0770eb"
                        PathSvg {
                            id: route_14Backup_PathSvg_0
                            path: "M 0 255.1739959716797 L 14.553000450134277 161.9739990234375 L 36.5260009765625 21.264999389648438 L 39.84600067138672 0"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillRule: ShapePath.WindingFill
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Shape {
                    id: route_14Backup_2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 100
                    anchors.rightMargin: 542
                    anchors.topMargin: 411
                    anchors.bottomMargin: 247
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_14Backup_2_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#0770eb"
                        PathSvg {
                            id: route_14Backup_2_PathSvg_0
                            path: "M 0 117.68499755859375 L 16.75 0"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Item {
                    id: set_12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 268
                    anchors.rightMargin: -1
                    anchors.topMargin: 731
                    anchors.bottomMargin: 0
                    Shape {
                        id: rectangular22
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_22
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangular_PathSvg_22
                                path: "M 10 0 L 381 0 C 386.5228476524353 0 391 4.477152347564697 391 10 L 391 35 C 391 40.5228476524353 386.5228476524353 45 381 45 L 10 45 C 4.477152347564697 45 0 40.5228476524353 0 35 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: outtakeThrottleValveDsName1
                        color: "#333333"
                        text: qsTr("exhaust throttle position:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 9
                        anchors.rightMargin: 121
                        anchors.topMargin: 9
                        anchors.bottomMargin: 9
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: outtakeThrottleValveDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 295
                        anchors.rightMargin: 64
                        anchors.topMargin: 12
                        anchors.bottomMargin: 6
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }

                Item {
                    id: set_11
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 69
                    anchors.rightMargin: 243
                    anchors.topMargin: 64
                    anchors.bottomMargin: 668
                    Shape {
                        id: rectangularBk_37
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_30_ShapePath_4
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_30_PathSvg_4
                                path: "M 10 0 L 336 0 C 341.5228476524353 0 346 4.477152347564697 346 10 L 346 34 C 346 39.5228476524353 341.5228476524353 44 336 44 L 10 44 C 4.477152347564697 44 0 39.5228476524353 0 34 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: eGR_ValveDsName1
                        color: "#333333"
                        text: qsTr("EGR valve opening:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 10
                        anchors.rightMargin: 135
                        anchors.topMargin: 10
                        anchors.bottomMargin: 7
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: eGR_ValveDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 209
                        anchors.rightMargin: 105
                        anchors.topMargin: 14
                        anchors.bottomMargin: 3
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }

                Text {
                    id: booster
                    color: "#333333"
                    text: qsTr("supercharger")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 412
                    anchors.rightMargin: 106
                    anchors.topMargin: 496
                    anchors.bottomMargin: 253
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    wrapMode: Text.NoWrap
                    font.weight: Font.Normal
                    font.family: "Inter"
                }

                Item {
                    id: set_14
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 69
                    anchors.rightMargin: 197
                    anchors.topMargin: 137
                    anchors.bottomMargin: 277
                    Shape {
                        id: rectangularBk_38
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_30_ShapePath_5
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_30_PathSvg_5
                                path: "M 10 0 L 382 0 C 387.5228476524353 0 392 4.477152347564697 392 10 L 392 352 C 392 357.5228476524353 387.5228476524353 362 382 362 L 10 362 C 4.477152347564697 362 0 357.5228476524353 0 352 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: engineData
                        color: "#333333"
                        text: qsTr("Engine")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 27
                        anchors.rightMargin: 293
                        anchors.topMargin: 18
                        anchors.bottomMargin: 317
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Shape {
                        id: oval3
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 10
                        anchors.rightMargin: 374
                        anchors.topMargin: 28
                        anchors.bottomMargin: 326
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: oval_ShapePath_3
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: oval_PathSvg_3
                                path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                            }
                            fillColor: "#333333"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: engineDataDsName1
                        color: "#333333"
                        text: qsTr("engine status:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 4
                        anchors.rightMargin: 240
                        anchors.topMargin: 57
                        anchors.bottomMargin: 278
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 159
                        anchors.rightMargin: 201
                        anchors.topMargin: 60
                        anchors.bottomMargin: 275
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsName2
                        color: "#333333"
                        text: qsTr("engine speed:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 4
                        anchors.rightMargin: 240
                        anchors.topMargin: 100
                        anchors.bottomMargin: 235
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsValue2
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 147
                        anchors.rightMargin: 213
                        anchors.topMargin: 102
                        anchors.bottomMargin: 233
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsName3
                        color: "#333333"
                        text: qsTr("coolant temperature:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 4
                        anchors.rightMargin: 169
                        anchors.topMargin: 145
                        anchors.bottomMargin: 190
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsValue3
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 224
                        anchors.rightMargin: 136
                        anchors.topMargin: 147
                        anchors.bottomMargin: 188
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsName4
                        color: "#333333"
                        text: qsTr("ambient temperature:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 4
                        anchors.rightMargin: 162
                        anchors.topMargin: 187
                        anchors.bottomMargin: 148
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsValue4
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 225
                        anchors.rightMargin: 135
                        anchors.topMargin: 189
                        anchors.bottomMargin: 146
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsName5
                        color: "#333333"
                        text: qsTr("battery voltage:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 4
                        anchors.rightMargin: 222
                        anchors.topMargin: 234
                        anchors.bottomMargin: 101
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsValue5
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 182
                        anchors.rightMargin: 178
                        anchors.topMargin: 237
                        anchors.bottomMargin: 98
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsName6
                        color: "#333333"
                        text: qsTr("intake manifold pressure:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 4
                        anchors.rightMargin: 126
                        anchors.topMargin: 280
                        anchors.bottomMargin: 55
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsValue6
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 279
                        anchors.rightMargin: 81
                        anchors.topMargin: 282
                        anchors.bottomMargin: 53
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsName7
                        color: "#333333"
                        text: qsTr("intake manifold temperature:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 4
                        anchors.rightMargin: 88
                        anchors.topMargin: 320
                        anchors.bottomMargin: 15
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: engineDataDsValue7
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 311
                        anchors.rightMargin: 49
                        anchors.topMargin: 323
                        anchors.bottomMargin: 12
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }

                Shape {
                    id: ovalBk
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 34
                    anchors.rightMargin: 616
                    anchors.topMargin: 329
                    anchors.bottomMargin: 439
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: ovalBk_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: ovalBk_PathSvg_0
                            path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                        }
                        fillColor: "#0770eb"
                    }
                    antialiasing: true
                }

                Shape {
                    id: ovalBk_2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 93
                    anchors.rightMargin: 557
                    anchors.topMargin: 524
                    anchors.bottomMargin: 244
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: ovalBk_2_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: ovalBk_2_PathSvg_0
                            path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                        }
                        fillColor: "#0770eb"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_11
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 338
                    anchors.rightMargin: 289
                    anchors.topMargin: 674
                    anchors.bottomMargin: 77
                    rotation: -90.974
                    Shape {
                        id: rectangularBk_8
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 9
                        anchors.rightMargin: 0
                        anchors.topMargin: 6
                        anchors.bottomMargin: 5
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_4_ShapePath_2
                            strokeWidth: 1.182
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangularBk_4_PathSvg_2
                                path: "M 18.200000762939453 0 C 19.2969468832016 0.0002649627858772874 20.348902940750122 0.43607401847839355 21.12465476989746 1.211638331413269 C 21.9004065990448 1.9872026443481445 22.336469743400812 3.0390541553497314 22.336999893188477 4.136000156402588 L 22.336999893188477 9.435999870300293 C 22.337131230931845 9.979409754276276 22.23022872209549 10.517524421215057 22.022396087646484 11.019619941711426 C 21.81456345319748 11.521715462207794 21.50987121462822 11.9779591858387 21.125715255737305 12.362300872802734 C 20.74155929684639 12.74664255976677 20.285463273525238 13.051555871963501 19.78346824645996 13.259631156921387 C 19.281473219394684 13.467706441879272 18.743410646915436 13.574868503259495 18.200000762939453 13.574999809265137 L 0 13.574999809265137 L 0 0 L 18.200000762939453 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#aaaaaa"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular23
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 19
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_23
                            strokeWidth: 1.182
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_23
                                path: "M 2.364000082015991 0 L 9.425999641418457 0 C 10.731600761413574 0 11.789999961853027 1.058398962020874 11.789999961853027 2.364000082015991 L 11.789999961853027 21.729999542236328 C 11.789999961853027 23.035600662231445 10.731600761413574 24.0939998626709 9.425999641418457 24.0939998626709 L 2.364000082015991 24.0939998626709 C 1.058398962020874 24.0939998626709 0 23.035600662231445 0 21.729999542236328 L 0 2.364000082015991 C 0 1.058398962020874 1.058398962020874 0 2.364000082015991 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#aaaaaa"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular24
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 19
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_24
                            strokeWidth: 1.182
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_24
                                path: "M 2.364000082015991 0 L 9.425999641418457 0 C 10.731600761413574 0 11.789999961853027 1.058398962020874 11.789999961853027 2.364000082015991 L 11.789999961853027 21.729999542236328 C 11.789999961853027 23.035600662231445 10.731600761413574 24.0939998626709 9.425999641418457 24.0939998626709 L 2.364000082015991 24.0939998626709 C 1.058398962020874 24.0939998626709 0 23.035600662231445 0 21.729999542236328 L 0 2.364000082015991 C 0 1.058398962020874 1.058398962020874 0 2.364000082015991 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#aaaaaa"
                        }
                        antialiasing: true
                    }
                }
            }

            Shape {
                id: ureaTubeColor1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1010
                anchors.rightMargin: 519
                anchors.topMargin: 201
                anchors.bottomMargin: 739
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ureaTubeColor1_ShapePath_0
                    strokeWidth: 6
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#3b63ad"
                    PathSvg {
                        id: ureaTubeColor1_PathSvg_0
                        path: "M 390.99700927734375 17.53995132446289 L 380.77801513671875 4.939945697784424 C 379.4613493680954 3.3719671964645386 377.8131710290909 2.115659534931183 375.95233154296875 1.2615859508514404 C 374.0914920568466 0.407512366771698 372.06436586380005 -0.02304410608485341 370.01702880859375 0.0009505352936685085 L 0 0.0009505352936685085"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: ureaTubeColor2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1101
                anchors.rightMargin: 532
                anchors.topMargin: 223
                anchors.bottomMargin: 332
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ureaTubeColor2_ShapePath_0
                    strokeWidth: 5
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#3b63ad"
                    PathSvg {
                        id: ureaTubeColor2_PathSvg_0
                        path: "M 287.0489501953125 0 L 15.6490478515625 0 C 7.01304817199707 0 0 8.220991134643555 0 18.362991333007812 L 0 403.32598876953125"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: ureaTubeColor3
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1010
                anchors.rightMargin: 837
                anchors.topMargin: 222
                anchors.bottomMargin: 332
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ureaTubeColor3_ShapePath_0
                    strokeWidth: 5
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#3b63ad"
                    PathSvg {
                        id: ureaTubeColor3_PathSvg_0
                        path: "M 73 404.3710021972656 L 73 24.235015869140625 C 73 10.850015640258789 70.37199068069458 0 67.12799072265625 0 L 0 0"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillRule: ShapePath.OddEvenFill
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Item {
                id: group_29
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 897
                anchors.rightMargin: 911
                anchors.topMargin: 147
                anchors.bottomMargin: 664
                rotation: 180
                Item {
                    id: group_15
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    Shape {
                        id: rectangular25
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 77
                        anchors.rightMargin: 17
                        anchors.bottomMargin: 134
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_25
                            strokeWidth: 1.658
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_25
                                path: "M 18.05699920654297 13.822999954223633 L 18.05699920654297 2.4860000610351562 C 18.05699920654297 1.826671838760376 17.79508239030838 1.1943479776382446 17.328866958618164 0.7281325459480286 C 16.862651526927948 0.2619171142578125 16.23032832145691 4.163336342344337e-16 15.571000099182129 0 L 2.4860000610351562 3.3306690738754696e-16 C 1.826671838760376 4.996003610813204e-16 1.1943479776382446 0.2619171142578125 0.7281325459480286 0.7281325459480286 C 0.2619171142578125 1.1943479776382446 7.216449660063518e-16 1.826671838760376 0 2.4860000610351562 L 7.771561172376096e-16 13.822999954223633 L 18.05699920654297 13.822999954223633 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#d8d8d8"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: shapeComb15
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 7
                        anchors.bottomMargin: -1
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: shapeComb_ShapePath_15
                            strokeWidth: 1.658
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: shapeComb_PathSvg_15
                                path: "M 89.5999984741211 141.2550048828125 C 90.91852557659149 141.25394797697663 92.18282276391983 140.7300277352333 93.11563110351562 139.79815673828125 C 94.04843944311142 138.8662857413292 94.57361394143663 137.6025220155716 94.57599639892578 136.28399658203125 L 94.57599639892578 132.44700622558594 L 96.63300323486328 132.44700622558594 C 98.700430393219 132.44674373281305 100.74754989147186 132.03918397426605 102.65744018554688 131.24761962890625 C 104.56733047962189 130.45605528354645 106.30257189273834 129.29598879814148 107.76404571533203 127.83367919921875 C 109.22551953792572 126.37136960029602 110.38459175825119 124.6354706287384 111.17506408691406 122.72512817382812 C 111.96553641557693 120.81478571891785 112.37192165420856 118.76742386817932 112.37100219726562 116.69999694824219 L 112.37100219726562 15.748000144958496 C 112.3704718859517 11.571533679962158 110.71114253997803 7.5662760734558105 107.7579345703125 4.613068103790283 C 104.80472660064697 1.6598601341247559 100.79946756362915 0.0005303113139252247 96.62300109863281 1.7763568394002505e-15 L 15.748000144958496 0 C 11.571533679962158 0.0005303113139234483 7.5662760734558105 1.6598601341247559 4.613068103790283 4.613068103790283 C 1.6598601341247559 7.5662760734558105 0.0005304383581545835 11.571533679962158 1.2704423113518715e-7 15.748000144958496 L 1.2704421692433243e-7 116.69999694824219 C -0.0002625761493675327 118.76812767982483 0.40689224004745483 120.81605267524719 1.1982102394104004 122.726806640625 C 1.989528238773346 124.63756060600281 3.149507164955139 126.37371599674225 4.611896514892578 127.83610534667969 C 6.074285864830017 129.29849469661713 7.810436487197876 130.45846837759018 9.721190452575684 131.24978637695312 C 11.631944417953491 132.04110437631607 13.679869413375854 132.44826075006858 15.748000144958496 132.447998046875 L 63.60499954223633 132.447998046875 L 63.60499954223633 136.28500366210938 C 63.604999423311156 136.93805718421936 63.73367702960968 137.58471369743347 63.983680725097656 138.18801879882812 C 64.23368442058563 138.79132390022278 64.60011675953865 139.339447170496 65.0620346069336 139.80108642578125 C 65.52395245432854 140.2627256810665 66.07230252027512 140.62882407009602 66.6757583618164 140.8784637451172 C 67.2792142033577 141.12810342013836 67.9259489774704 141.2563908220909 68.5790023803711 141.25599670410156 L 89.5999984741211 141.2550048828125 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#e6e6e6"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: rectangular26
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 7
                        anchors.bottomMargin: 41
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangular_ShapePath_26
                            strokeWidth: 1.658
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#000000"
                            PathSvg {
                                id: rectangular_PathSvg_26
                                path: "M 112.37100219726562 98.96499633789062 L 112.37100219726562 15.748000144958496 C 112.3704718859517 11.571533679962158 110.71114253997803 7.5662760734558105 107.7579345703125 4.613068103790283 C 104.80472660064697 1.6598601341247559 100.79946756362915 0.0005303113139252247 96.62300109863281 1.7763568394002505e-15 L 15.748000144958496 0 C 11.571533679962158 0.0005303113139234483 7.5662760734558105 1.6598601341247559 4.613068103790283 4.613068103790283 C 1.6598601341247559 7.5662760734558105 0.0005303113139247806 11.571533679962158 1.3322676295501878e-15 15.748000144958496 L 0 98.96499633789062 L 112.37100219726562 98.96499633789062 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillRule: ShapePath.OddEvenFill
                            fillColor: "#6ba3ff"
                        }
                        antialiasing: true
                    }
                }

                Item {
                    id: group_18
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1
                    anchors.rightMargin: -1
                    anchors.topMargin: 18
                    anchors.bottomMargin: 52
                    Shape {
                        id: route_15_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 77
                        anchors.bottomMargin: 0
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15_Stroke__PathSvg_0
                                path: "M 4.498046875 0 L 4.498046875 0.94921875 L 0 0.94921875 L 0 0 L 4.498046875 0 Z M 20.4892578125 0 L 20.4892578125 0.94921875 L 11.494140625 0.94921875 L 11.494140625 0 L 20.4892578125 0 Z M 36.48046875 0 L 36.48046875 0.94921875 L 27.4853515625 0.94921875 L 27.4853515625 0 L 36.48046875 0 Z M 52.4716796875 0 L 52.4716796875 0.94921875 L 43.4765625 0.94921875 L 43.4765625 0 L 52.4716796875 0 Z M 68.462890625 0 L 68.462890625 0.94921875 L 59.4677734375 0.94921875 L 59.4677734375 0 L 68.462890625 0 Z M 84.455078125 0 L 84.455078125 0.94921875 L 75.4599609375 0.94921875 L 75.4599609375 0 L 84.455078125 0 Z M 100.4462890625 0 L 100.4462890625 0.94921875 L 91.451171875 0.94921875 L 91.451171875 0 L 100.4462890625 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 107.4423828125 0.94921875 L 107.4423828125 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_3_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 48
                        anchors.bottomMargin: 28
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_3_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_3_Stroke__PathSvg_0
                                path: "M 4.498046875 0 L 4.498046875 0.94921875 L 0 0.94921875 L 0 0 L 4.498046875 0 Z M 20.4892578125 0 L 20.4892578125 0.94921875 L 11.494140625 0.94921875 L 11.494140625 0 L 20.4892578125 0 Z M 36.48046875 0 L 36.48046875 0.94921875 L 27.4853515625 0.94921875 L 27.4853515625 0 L 36.48046875 0 Z M 52.4716796875 0 L 52.4716796875 0.94921875 L 43.4765625 0.94921875 L 43.4765625 0 L 52.4716796875 0 Z M 68.462890625 0 L 68.462890625 0.94921875 L 59.4677734375 0.94921875 L 59.4677734375 0 L 68.462890625 0 Z M 84.455078125 0 L 84.455078125 0.94921875 L 75.4599609375 0.94921875 L 75.4599609375 0 L 84.455078125 0 Z M 100.4462890625 0 L 100.4462890625 0.94921875 L 91.451171875 0.94921875 L 91.451171875 0 L 100.4462890625 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 107.4423828125 0.94921875 L 107.4423828125 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 67
                        anchors.bottomMargin: 9
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_Stroke__PathSvg_0
                                path: "M 4.498046875 0 L 4.498046875 0.94921875 L 0 0.94921875 L 0 0 L 4.498046875 0 Z M 18.490234375 0 L 18.490234375 0.94921875 L 9.4951171875 0.94921875 L 9.4951171875 0 L 18.490234375 0 Z M 32.482421875 0 L 32.482421875 0.94921875 L 23.4873046875 0.94921875 L 23.4873046875 0 L 32.482421875 0 Z M 46.4755859375 0 L 46.4755859375 0.94921875 L 37.4794921875 0.94921875 L 37.4794921875 0 L 46.4755859375 0 Z M 60.4677734375 0 L 60.4677734375 0.94921875 L 51.47265625 0.94921875 L 51.47265625 0 L 60.4677734375 0 Z M 74.4599609375 0 L 74.4599609375 0.94921875 L 65.46484375 0.94921875 L 65.46484375 0 L 74.4599609375 0 Z M 88.453125 0 L 88.453125 0.94921875 L 79.45703125 0.94921875 L 79.45703125 0 L 88.453125 0 Z M 102.4453125 0 L 102.4453125 0.94921875 L 93.4501953125 0.94921875 L 93.4501953125 0 L 102.4453125 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 107.4423828125 0.94921875 L 107.4423828125 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_4_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 38
                        anchors.bottomMargin: 38
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_4_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_4_Stroke__PathSvg_0
                                path: "M 4.498046875 0 L 4.498046875 0.94921875 L 0 0.94921875 L 0 0 L 4.498046875 0 Z M 18.490234375 0 L 18.490234375 0.94921875 L 9.4951171875 0.94921875 L 9.4951171875 0 L 18.490234375 0 Z M 32.482421875 0 L 32.482421875 0.94921875 L 23.4873046875 0.94921875 L 23.4873046875 0 L 32.482421875 0 Z M 46.4755859375 0 L 46.4755859375 0.94921875 L 37.4794921875 0.94921875 L 37.4794921875 0 L 46.4755859375 0 Z M 60.4677734375 0 L 60.4677734375 0.94921875 L 51.47265625 0.94921875 L 51.47265625 0 L 60.4677734375 0 Z M 74.4599609375 0 L 74.4599609375 0.94921875 L 65.46484375 0.94921875 L 65.46484375 0 L 74.4599609375 0 Z M 88.453125 0 L 88.453125 0.94921875 L 79.45703125 0.94921875 L 79.45703125 0 L 88.453125 0 Z M 102.4453125 0 L 102.4453125 0.94921875 L 93.4501953125 0.94921875 L 93.4501953125 0 L 102.4453125 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 107.4423828125 0.94921875 L 107.4423828125 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_2_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 57
                        anchors.bottomMargin: 19
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_2_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_2_Stroke__PathSvg_0
                                path: "M 2.3916015625 0 L 2.3916015625 0.94921875 L 0 0.94921875 L 0 0 L 2.3916015625 0 Z M 11.0029296875 0 L 11.0029296875 0.94921875 L 6.21875 0.94921875 L 6.21875 0 L 11.0029296875 0 Z M 19.61328125 0 L 19.61328125 0.94921875 L 14.830078125 0.94921875 L 14.830078125 0 L 19.61328125 0 Z M 28.224609375 0 L 28.224609375 0.94921875 L 23.4404296875 0.94921875 L 23.4404296875 0 L 28.224609375 0 Z M 36.8349609375 0 L 36.8349609375 0.94921875 L 32.05078125 0.94921875 L 32.05078125 0 L 36.8349609375 0 Z M 45.4453125 0 L 45.4453125 0.94921875 L 40.662109375 0.94921875 L 40.662109375 0 L 45.4453125 0 Z M 54.056640625 0 L 54.056640625 0.94921875 L 49.2724609375 0.94921875 L 49.2724609375 0 L 54.056640625 0 Z M 62.6669921875 0 L 62.6669921875 0.94921875 L 57.8837890625 0.94921875 L 57.8837890625 0 L 62.6669921875 0 Z M 71.2783203125 0 L 71.2783203125 0.94921875 L 66.494140625 0.94921875 L 66.494140625 0 L 71.2783203125 0 Z M 79.888671875 0 L 79.888671875 0.94921875 L 75.10546875 0.94921875 L 75.10546875 0 L 79.888671875 0 Z M 88.5 0 L 88.5 0.94921875 L 83.7158203125 0.94921875 L 83.7158203125 0 L 88.5 0 Z M 97.1103515625 0 L 97.1103515625 0.94921875 L 92.326171875 0.94921875 L 92.326171875 0 L 97.1103515625 0 Z M 105.720703125 0 L 105.720703125 0.94921875 L 100.9375 0.94921875 L 100.9375 0 L 105.720703125 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 109.5478515625 0.94921875 L 109.5478515625 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_5_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 28
                        anchors.bottomMargin: 48
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_5_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_5_Stroke__PathSvg_0
                                path: "M 2.3916015625 0 L 2.3916015625 0.94921875 L 0 0.94921875 L 0 0 L 2.3916015625 0 Z M 11.0029296875 0 L 11.0029296875 0.94921875 L 6.21875 0.94921875 L 6.21875 0 L 11.0029296875 0 Z M 19.61328125 0 L 19.61328125 0.94921875 L 14.830078125 0.94921875 L 14.830078125 0 L 19.61328125 0 Z M 28.224609375 0 L 28.224609375 0.94921875 L 23.4404296875 0.94921875 L 23.4404296875 0 L 28.224609375 0 Z M 36.8349609375 0 L 36.8349609375 0.94921875 L 32.05078125 0.94921875 L 32.05078125 0 L 36.8349609375 0 Z M 45.4453125 0 L 45.4453125 0.94921875 L 40.662109375 0.94921875 L 40.662109375 0 L 45.4453125 0 Z M 54.056640625 0 L 54.056640625 0.94921875 L 49.2724609375 0.94921875 L 49.2724609375 0 L 54.056640625 0 Z M 62.6669921875 0 L 62.6669921875 0.94921875 L 57.8837890625 0.94921875 L 57.8837890625 0 L 62.6669921875 0 Z M 71.2783203125 0 L 71.2783203125 0.94921875 L 66.494140625 0.94921875 L 66.494140625 0 L 71.2783203125 0 Z M 79.888671875 0 L 79.888671875 0.94921875 L 75.10546875 0.94921875 L 75.10546875 0 L 79.888671875 0 Z M 88.5 0 L 88.5 0.94921875 L 83.7158203125 0.94921875 L 83.7158203125 0 L 88.5 0 Z M 97.1103515625 0 L 97.1103515625 0.94921875 L 92.326171875 0.94921875 L 92.326171875 0 L 97.1103515625 0 Z M 105.720703125 0 L 105.720703125 0.94921875 L 100.9375 0.94921875 L 100.9375 0 L 105.720703125 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 109.5478515625 0.94921875 L 109.5478515625 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_8_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 19
                        anchors.bottomMargin: 57
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_8_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_8_Stroke__PathSvg_0
                                path: "M 4.498046875 0 L 4.498046875 0.94921875 L 0 0.94921875 L 0 0 L 4.498046875 0 Z M 20.4892578125 0 L 20.4892578125 0.94921875 L 11.494140625 0.94921875 L 11.494140625 0 L 20.4892578125 0 Z M 36.48046875 0 L 36.48046875 0.94921875 L 27.4853515625 0.94921875 L 27.4853515625 0 L 36.48046875 0 Z M 52.4716796875 0 L 52.4716796875 0.94921875 L 43.4765625 0.94921875 L 43.4765625 0 L 52.4716796875 0 Z M 68.462890625 0 L 68.462890625 0.94921875 L 59.4677734375 0.94921875 L 59.4677734375 0 L 68.462890625 0 Z M 84.455078125 0 L 84.455078125 0.94921875 L 75.4599609375 0.94921875 L 75.4599609375 0 L 84.455078125 0 Z M 100.4462890625 0 L 100.4462890625 0.94921875 L 91.451171875 0.94921875 L 91.451171875 0 L 100.4462890625 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 107.4423828125 0.94921875 L 107.4423828125 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_7_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 9
                        anchors.bottomMargin: 67
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_7_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_7_Stroke__PathSvg_0
                                path: "M 4.498046875 0 L 4.498046875 0.94921875 L 0 0.94921875 L 0 0 L 4.498046875 0 Z M 18.490234375 0 L 18.490234375 0.94921875 L 9.4951171875 0.94921875 L 9.4951171875 0 L 18.490234375 0 Z M 32.482421875 0 L 32.482421875 0.94921875 L 23.4873046875 0.94921875 L 23.4873046875 0 L 32.482421875 0 Z M 46.4755859375 0 L 46.4755859375 0.94921875 L 37.4794921875 0.94921875 L 37.4794921875 0 L 46.4755859375 0 Z M 60.4677734375 0 L 60.4677734375 0.94921875 L 51.47265625 0.94921875 L 51.47265625 0 L 60.4677734375 0 Z M 74.4599609375 0 L 74.4599609375 0.94921875 L 65.46484375 0.94921875 L 65.46484375 0 L 74.4599609375 0 Z M 88.453125 0 L 88.453125 0.94921875 L 79.45703125 0.94921875 L 79.45703125 0 L 88.453125 0 Z M 102.4453125 0 L 102.4453125 0.94921875 L 93.4501953125 0.94921875 L 93.4501953125 0 L 102.4453125 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 107.4423828125 0.94921875 L 107.4423828125 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }

                    Shape {
                        id: route_15Backup_6_Stroke_
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 0
                        anchors.bottomMargin: 77
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: route_15Backup_6_Stroke__ShapePath_0
                            strokeWidth: 0.95
                            strokeColor: "transparent"
                            PathSvg {
                                id: route_15Backup_6_Stroke__PathSvg_0
                                path: "M 2.3916015625 0 L 2.3916015625 0.94921875 L 0 0.94921875 L 0 0 L 2.3916015625 0 Z M 11.0029296875 0 L 11.0029296875 0.94921875 L 6.21875 0.94921875 L 6.21875 0 L 11.0029296875 0 Z M 19.61328125 0 L 19.61328125 0.94921875 L 14.830078125 0.94921875 L 14.830078125 0 L 19.61328125 0 Z M 28.224609375 0 L 28.224609375 0.94921875 L 23.4404296875 0.94921875 L 23.4404296875 0 L 28.224609375 0 Z M 36.8349609375 0 L 36.8349609375 0.94921875 L 32.05078125 0.94921875 L 32.05078125 0 L 36.8349609375 0 Z M 45.4453125 0 L 45.4453125 0.94921875 L 40.662109375 0.94921875 L 40.662109375 0 L 45.4453125 0 Z M 54.056640625 0 L 54.056640625 0.94921875 L 49.2724609375 0.94921875 L 49.2724609375 0 L 54.056640625 0 Z M 62.6669921875 0 L 62.6669921875 0.94921875 L 57.8837890625 0.94921875 L 57.8837890625 0 L 62.6669921875 0 Z M 71.2783203125 0 L 71.2783203125 0.94921875 L 66.494140625 0.94921875 L 66.494140625 0 L 71.2783203125 0 Z M 79.888671875 0 L 79.888671875 0.94921875 L 75.10546875 0.94921875 L 75.10546875 0 L 79.888671875 0 Z M 88.5 0 L 88.5 0.94921875 L 83.7158203125 0.94921875 L 83.7158203125 0 L 88.5 0 Z M 97.1103515625 0 L 97.1103515625 0.94921875 L 92.326171875 0.94921875 L 92.326171875 0 L 97.1103515625 0 Z M 105.720703125 0 L 105.720703125 0.94921875 L 100.9375 0.94921875 L 100.9375 0 L 105.720703125 0 Z M 111.9404296875 0 L 111.9404296875 0.94921875 L 109.5478515625 0.94921875 L 109.5478515625 0 L 111.9404296875 0 Z"
                            }
                            fillRule: ShapePath.WindingFill
                            fillColor: "#000000"
                        }
                        antialiasing: true
                    }
                }
            }

            Item {
                id: group_16
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1135
                anchors.rightMargin: 450
                anchors.topMargin: 230
                anchors.bottomMargin: 408
                Shape {
                    id: route_14Backup_45
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 159
                    anchors.rightMargin: 65
                    anchors.topMargin: 7
                    anchors.bottomMargin: 244
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_14Backup_45_ShapePath_0
                        strokeWidth: 2
                        strokeStyle: ShapePath.SolidLine
                        strokeColor: "#0770eb"
                        PathSvg {
                            id: route_14Backup_45_PathSvg_0
                            path: "M 110.50900268554688 0 L 0 69.13200378417969"
                        }
                        joinStyle: ShapePath.MiterJoin
                        fillColor: "transparent"
                    }
                    antialiasing: true
                }

                Shape {
                    id: ovalBk_62
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 267
                    anchors.rightMargin: 60
                    anchors.bottomMargin: 312
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: ovalBk_62_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: ovalBk_62_PathSvg_0
                            path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                        }
                        fillColor: "#0770eb"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_25Backup_6
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 77
                    anchors.bottomMargin: 0
                    Shape {
                        id: rectangularBk_39
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_30_ShapePath_6
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_30_PathSvg_6
                                path: "M 10 0 L 325 0 C 330.5228476524353 0 335 4.477152347564697 335 10 L 335 233.76199340820312 C 335 239.28484106063843 330.5228476524353 243.76199340820312 325 243.76199340820312 L 10 243.76199340820312 C 4.477152347564697 243.76199340820312 0 239.28484106063843 0 233.76199340820312 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: ureaPump
                        color: "#333333"
                        text: qsTr("Urea pump")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 27
                        anchors.rightMargin: 192
                        anchors.topMargin: 9
                        anchors.bottomMargin: 208
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Shape {
                        id: oval4
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 15
                        anchors.rightMargin: 312
                        anchors.topMargin: 15
                        anchors.bottomMargin: 221
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: oval_ShapePath_4
                            strokeWidth: 1
                            strokeColor: "transparent"
                            PathSvg {
                                id: oval_PathSvg_4
                                path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                            }
                            fillColor: "#333333"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: ureaPumpDsName2
                        color: "#333333"
                        text: qsTr("feeding capacity:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 27
                        anchors.rightMargin: 128
                        anchors.topMargin: 50
                        anchors.bottomMargin: 167
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsValue2
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 216
                        anchors.rightMargin: 87
                        anchors.topMargin: 52
                        anchors.bottomMargin: 165
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsName3
                        color: "#333333"
                        text: qsTr("test pre-time:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 27
                        anchors.rightMargin: 165
                        anchors.topMargin: 125
                        anchors.bottomMargin: 92
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsName4
                        color: "#333333"
                        text: qsTr("test timer:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 27
                        anchors.rightMargin: 201
                        anchors.topMargin: 162
                        anchors.bottomMargin: 55
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsName5
                        color: "#333333"
                        text: qsTr("feeding rate:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 27
                        anchors.rightMargin: 175
                        anchors.topMargin: 87
                        anchors.bottomMargin: 130
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsValue3
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 181
                        anchors.rightMargin: 122
                        anchors.topMargin: 126
                        anchors.bottomMargin: 91
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsValue4
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 149
                        anchors.rightMargin: 154
                        anchors.topMargin: 164
                        anchors.bottomMargin: 53
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsValue5
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 171
                        anchors.rightMargin: 132
                        anchors.topMargin: 90
                        anchors.bottomMargin: 127
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsName6
                        color: "#333333"
                        text: qsTr("test status:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 28
                        anchors.rightMargin: 189
                        anchors.topMargin: 203
                        anchors.bottomMargin: 14
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaPumpDsValue6
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 161
                        anchors.rightMargin: 142
                        anchors.topMargin: 207
                        anchors.bottomMargin: 10
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }
            }

            Item {
                id: group_17
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 569
                anchors.rightMargin: 1023
                anchors.topMargin: 166
                anchors.bottomMargin: 687
                Shape {
                    id: route_14Backup_41_Stroke_
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 261
                    anchors.rightMargin: 4
                    anchors.topMargin: 43
                    anchors.bottomMargin: 60
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: route_14Backup_41_Stroke__ShapePath_0
                        strokeWidth: 2
                        strokeColor: "transparent"
                        PathSvg {
                            id: route_14Backup_41_Stroke__PathSvg_0
                            path: "M 62.666015625 0 L 62.666015625 2 L 0 2 L 0 0 L 62.666015625 0 Z"
                        }
                        fillRule: ShapePath.WindingFill
                        fillColor: "#0770eb"
                    }
                    antialiasing: true
                }

                Shape {
                    id: ovalBk_58
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 320
                    anchors.rightMargin: 0
                    anchors.topMargin: 41
                    anchors.bottomMargin: 56
                    layer.samples: 16
                    layer.enabled: true
                    ShapePath {
                        id: ovalBk_58_ShapePath_0
                        strokeWidth: 1
                        strokeColor: "transparent"
                        PathSvg {
                            id: ovalBk_58_PathSvg_0
                            path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                        }
                        fillColor: "#0770eb"
                    }
                    antialiasing: true
                }

                Item {
                    id: group_30Backup_2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 36
                    Shape {
                        id: rectangularBk_40
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        layer.samples: 16
                        layer.enabled: true
                        ShapePath {
                            id: rectangularBk_30_ShapePath_7
                            strokeWidth: 2
                            strokeStyle: ShapePath.SolidLine
                            strokeColor: "#adbacc"
                            PathSvg {
                                id: rectangularBk_30_PathSvg_7
                                path: "M 10 0 L 281.24200439453125 0 C 286.76485204696655 0 291.24200439453125 4.477152347564697 291.24200439453125 10 L 291.24200439453125 95 C 291.24200439453125 100.5228476524353 286.76485204696655 105 281.24200439453125 105 L 10 105 C 4.477152347564697 105 0 100.5228476524353 0 95 L 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z"
                            }
                            joinStyle: ShapePath.MiterJoin
                            fillColor: "#f2f6fa"
                        }
                        antialiasing: true
                    }

                    Text {
                        id: ureaTankDsName1
                        color: "#333333"
                        text: qsTr("urea tank level:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 15
                        anchors.rightMargin: 118
                        anchors.topMargin: 7
                        anchors.bottomMargin: 71
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaTankDsValue1
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 192
                        anchors.rightMargin: 67
                        anchors.topMargin: 10
                        anchors.bottomMargin: 68
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaTankDsValue2
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 202
                        anchors.rightMargin: 57
                        anchors.topMargin: 42
                        anchors.bottomMargin: 36
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaTankDsValue3
                        color: "#0770eb"
                        text: qsTr("---")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 157
                        anchors.rightMargin: 102
                        anchors.topMargin: 74
                        anchors.bottomMargin: 4
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaTankDsName2
                        color: "#333333"
                        text: qsTr("urea temperature:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 15
                        anchors.rightMargin: 88
                        anchors.topMargin: 39
                        anchors.bottomMargin: 39
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }

                    Text {
                        id: ureaTankDsName3
                        color: "#333333"
                        text: qsTr("urea quality:")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 15
                        anchors.rightMargin: 147
                        anchors.topMargin: 71
                        anchors.bottomMargin: 7
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                        font.weight: Font.Normal
                        font.family: "Inter"
                    }
                }
            }

            Shape {
                id: route_14Backup_40
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1047
                anchors.rightMargin: 851
                anchors.topMargin: 418
                anchors.bottomMargin: 341
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_14Backup_38_ShapePath_1
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#0770eb"
                    PathSvg {
                        id: route_14Backup_38_PathSvg_1
                        path: "M 0 0 L 22 199.15199279785156"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: ovalBk_57
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 1067
                anchors.rightMargin: 845
                anchors.topMargin: 618
                anchors.bottomMargin: 332
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ovalBk_55_ShapePath_1
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: ovalBk_55_PathSvg_1
                        path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                    }
                    fillColor: "#0770eb"
                }
                antialiasing: true
            }

            Shape {
                id: route_14Backup_41
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 380
                anchors.rightMargin: 1511
                anchors.topMargin: 865
                anchors.bottomMargin: 69
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: route_14Backup_38_ShapePath_2
                    strokeWidth: 2
                    strokeStyle: ShapePath.SolidLine
                    strokeColor: "#0770eb"
                    PathSvg {
                        id: route_14Backup_38_PathSvg_2
                        path: "M 0 0 L 29.246000289916992 23.718000411987305"
                    }
                    joinStyle: ShapePath.MiterJoin
                    fillColor: "transparent"
                }
                antialiasing: true
            }

            Shape {
                id: ovalBk_60
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 375
                anchors.rightMargin: 1537
                anchors.topMargin: 860
                anchors.bottomMargin: 90
                layer.samples: 16
                layer.enabled: true
                ShapePath {
                    id: ovalBk_55_ShapePath_2
                    strokeWidth: 1
                    strokeColor: "transparent"
                    PathSvg {
                        id: ovalBk_55_PathSvg_2
                        path: "M 8 4 C 8 6.209139108657837 6.209139108657837 8 4 8 C 1.790860891342163 8 0 6.209139108657837 0 4 C 0 1.790860891342163 1.790860891342163 0 4 0 C 6.209139108657837 0 8 1.790860891342163 8 4 Z"
                    }
                    fillColor: "#0770eb"
                }
                antialiasing: true
            }
        }
    }

    Shape {
        id: ureaInjectionState
        opacity: 0.65
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 1081
        anchors.rightMargin: 813
        anchors.topMargin: 698
        anchors.bottomMargin: 228
        layer.samples: 16
        layer.enabled: true
        ShapePath {
            id: ureaInjectionState_ShapePath_0
            strokeWidth: 1
            strokeColor: "transparent"
            PathSvg {
                id: ureaInjectionState_PathSvg_0
                path: "M 13 0 L 26 32 L 0 32 L 13 0 Z"
            }
            fillRule: ShapePath.WindingFill
            fillColor: "#6ba3ff"
        }
        antialiasing: true
    }
}