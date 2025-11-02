import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs

PopupWindow {
    id: networkPopup

    anchor.item: networkWidget
    anchor.rect.x: networkWidget.x + 40
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
                id: currentConnectedNetwork

                color: Theme.get.textColor
                font.weight: Font.Bold
            }
        }
    }

    Process {
        id: getNetworks

        running: true
        command: ["nmcli", "-g", "ACTIVE,SSID", "d", "w"]
        stdout: StdioCollector {
            onStreamFinished: {
                const networks = this.text.trim().split("\n").map(n => {
                    const network = n.split(":");
                    return {
                        active: network[0] === "yes",
                        ssid: network[1]
                    };
                }).filter(n => n.active);
                currentConnectedNetwork.text = networks[0].ssid;
            }
        }
    }
}
