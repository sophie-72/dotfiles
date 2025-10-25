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

                PowerButton {
                    buttonSize: root.itemSize
                    buttonRadius: root.radius
                    iconSize: root.iconSize
                }

                RebootButton {
                    buttonSize: root.itemSize
                    buttonRadius: root.radius
                    iconSize: root.iconSize
                }

                LockButton {
                    buttonSize: root.itemSize
                    buttonRadius: root.radius
                    iconSize: root.iconSize
                }
            }

            Keys.onEscapePressed: () => {
                root.visible = false;
            }
        }
    }
}
