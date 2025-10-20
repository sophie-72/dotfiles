import QtQuick
import QtQuick.Layouts

Item {
    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize * 2

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        ColumnLayout {
            UpdatesIcon {
                color: Theme.get.pineColor
                size: 24
                Layout.alignment: Qt.AlignCenter
            }

            Text {
                text: UpdatesCount.count
                font.weight: Font.Bold
                color: Theme.get.textColor
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
