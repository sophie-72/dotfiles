import Quickshell

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                bottom: true
                top: true
                left: true
            }

            implicitWidth: 40

            color: Theme.get.backgroundColor

            ClockWidget {
                anchors.centerIn: parent
            }
        }
    }
}
