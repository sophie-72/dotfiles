pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: launcher

    Process {
        id: getApplications
        command: ["sh", "-c", "ls /usr/share/applications/*.desktop"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const data = this.text;
            }
        }
    }
}
