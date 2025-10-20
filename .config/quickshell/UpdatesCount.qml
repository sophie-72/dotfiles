pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int count

    Process {
        command: ["sh", "-c", "paru -Qu | wc -l"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.count = this.text
        }
    }
}
