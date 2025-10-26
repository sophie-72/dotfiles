import QtQuick
import QtQuick.Layouts
import qs

Item {
    id: powerWidget

    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Icon {
            color: Theme.get.loveColor
            size: 24
            iconName: "power-off"
            Layout.alignment: Qt.AlignCenter
        }
    }

    MouseArea {
        anchors.fill: powerWidget

        onClicked: () => {
            PowerMenu.visible = true;
        }
    }
}
