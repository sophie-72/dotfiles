import QtQuick
import QtQuick.Layouts
import qs

Item {
    id: keyboardWidget

    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize * 2

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        ColumnLayout {
            spacing: 0

            Icon {
                color: Theme.get.roseColor
                size: 24
                iconName: "keyboard"
                Layout.alignment: Qt.AlignCenter
            }

            Text {
                text: KeyboardLayout.layout
                font.weight: Font.Bold
                color: Theme.get.roseColor
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
