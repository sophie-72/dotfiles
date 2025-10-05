import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            margins {
                bottom: 10
                top: 10
                left: 10
            }

            anchors {
                bottom: true
                top: true
                left: true
            }

            implicitWidth: 40

            color: "transparent"

            Rectangle {
                width: parent.width
                height: parent.height
                radius: 10
                color: Theme.get.backgroundColor
            }

            ClockWidget {
                anchors.centerIn: parent
            }
        }
    }
}
