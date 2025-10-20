pragma Singleton

import QtQuick
import QtQuick.Layouts
import Quickshell

Singleton {
    id: root

    property bool visible

    PanelWindow {
        focusable: true
        implicitWidth: 400
        implicitHeight: 110
        visible: root.visible
        color: "transparent"

        Rectangle {
            focus: true
            anchors.fill: parent
            color: Theme.get.transparentBackgroundColor
            radius: 10

            RowLayout {
                anchors.fill: parent
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                anchors.leftMargin: 5
                anchors.rightMargin: 5

                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 100
                    color: Theme.get.mutedColor

                    PowerIcon {
                        color: Theme.get.loveColor
                        size: 24
                        Layout.alignment: Qt.AlignCenter
                    }
                }

                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 100
                    color: Theme.get.mutedColor

                    RebootIcon {
                        color: Theme.get.roseColor
                        size: 24
                        Layout.alignment: Qt.AlignCenter
                    }
                }

                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 100
                    color: Theme.get.mutedColor

                    LockIcon {
                        color: Theme.get.goldColor
                        size: 24
                        Layout.alignment: Qt.AlignCenter
                    }
                }
            }

            Keys.onEscapePressed: () => {
                root.visible = false;
            }
        }
    }
}
