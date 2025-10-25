pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string totalMemory
    property string usedMemory

    Process {
        id: process
        command: ["sh", "-c", "free -h | grep Mem | awk '{print $2, $3}'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const values = this.text.replace("\n", "").split(" ");
                root.totalMemory = values[0];
                root.usedMemory = values[1];
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            process.running = true;
        }
    }
}
