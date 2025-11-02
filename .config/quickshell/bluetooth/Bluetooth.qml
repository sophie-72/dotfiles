import QtQuick
import QtQuick.Layouts
import qs

Item {
    id: bluetoothWidget

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
            iconName: "bluetooth-b"
            Layout.alignment: Qt.AlignCenter
        }
    }

    BluetoothPopup {
        id: bluetoothPopup
    }

    MouseArea {
        anchors.fill: bluetoothWidget
        hoverEnabled: true
        onEntered: () => bluetoothPopup.visible = true
        onExited: () => bluetoothPopup.visible = false
    }
}
