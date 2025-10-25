pragma Singleton

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs

Singleton {
    id: root

    property bool visible
    readonly property int itemSize: 100
    readonly property int margin: 5
    readonly property int radius: 10
    readonly property int iconSize: 48

    PanelWindow {
        focusable: true
        implicitWidth: (root.itemSize * 3) + (root.margin * 8)
        implicitHeight: root.itemSize + (root.margin * 4)
        visible: root.visible
        color: "transparent"

        Rectangle {
            focus: true
            anchors.fill: parent
            color: Theme.get.transparentBackgroundColor
            radius: root.radius

            RowLayout {
                anchors.fill: parent
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: root.margin
                anchors.bottomMargin: root.margin
                anchors.leftMargin: root.margin
                anchors.rightMargin: root.margin

                Rectangle {
                    implicitWidth: root.itemSize
                    implicitHeight: root.itemSize
                    color: Theme.get.loveColor
                    radius: root.radius
                    Layout.alignment: Qt.AlignHCenter

                    PowerIcon {
                        color: Theme.get.backgroundColor
                        size: root.iconSize
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    implicitWidth: root.itemSize
                    implicitHeight: root.itemSize
                    color: Theme.get.roseColor
                    radius: root.radius
                    Layout.alignment: Qt.AlignHCenter

                    RebootIcon {
                        color: Theme.get.backgroundColor
                        size: root.iconSize
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    implicitWidth: root.itemSize
                    implicitHeight: root.itemSize
                    color: Theme.get.goldColor
                    radius: root.radius
                    Layout.alignment: Qt.AlignHCenter

                    LockIcon {
                        color: Theme.get.backgroundColor
                        size: root.iconSize
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Keys.onEscapePressed: () => {
                root.visible = false;
            }
        }
    }
}
