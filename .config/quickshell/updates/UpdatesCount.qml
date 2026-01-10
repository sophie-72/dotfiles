pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int count

    Process {
        id: updatesCountProcess
        command: ["sh", "-c", "paru -Qu | wc -l"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.count = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            updatesCountProcess.running = true;
        }
    }
}
