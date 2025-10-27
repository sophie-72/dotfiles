import QtQuick
import QtQuick.Layouts
import qs

Item {
    id: networkWidget

    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Icon {
            color: Theme.get.goldColor
            size: 24
            iconName: "wifi"
            Layout.alignment: Qt.AlignCenter
        }
    }
}
