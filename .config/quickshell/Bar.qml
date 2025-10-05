import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            margins {
                bottom: 10
                top: 10
                left: 10
            }

            anchors {
                bottom: true
                top: true
                left: true
            }

            implicitWidth: 40

            color: "transparent"

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: Theme.get.backgroundColor
            }

            ColumnLayout {
                anchors.bottom: parent.bottom
                
                BatteryWidget {
                    Layout.alignment: Qt.AlignHCenter
                }

                ClockWidget {
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
