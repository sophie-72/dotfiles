import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.battery
import qs.clock
import qs.keyboard
import qs.systemUsage
import qs.updates
import qs.workspaces

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
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
                color: Theme.get.transparentBackgroundColor
            }

            ColumnLayout {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 5

                Workspaces {}
            }

            ColumnLayout {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 5

                Updates {
                    Layout.alignment: Qt.AlignHCenter
                }

                Volume {
                    Layout.alignment: Qt.AlignHCenter
                }

                SystemUsage {
                    Layout.alignment: Qt.AlignHCenter
                }

                Battery {
                    Layout.alignment: Qt.AlignHCenter
                }

                Keyboard {
                    Layout.alignment: Qt.AlignHCenter
                }

                ClockWidget {
                    Layout.alignment: Qt.AlignHCenter
                }

                Power {
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
