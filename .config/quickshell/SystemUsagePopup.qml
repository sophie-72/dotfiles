import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

PopupWindow {
    id: systemUsagePopup

    anchor.item: systemUsageWidget
    anchor.rect.x: systemUsageWidget.x + 40
    implicitWidth: 250
    implicitHeight: 75
    visible: false
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.get.transparentBackgroundColor
        radius: 10

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 10

            Text {
                text: "RAM usage: " + MemoryUsage.usedMemory + "/" + MemoryUsage.totalMemory
                font.weight: Font.Bold
                color: Theme.get.textColor
            }
        }
    }
}
