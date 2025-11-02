pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string interfaces

    Process {
        running: true
        command: ["sh", "-c", "ip -o -f inet addr show | awk '{print $2, $4}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                let interfacesText = "";
                const interfaces = this.text.trim().split("\n").map(i => {
                    const data = i.split(" ");
                    interfacesText += data[0] + ": " + data[1] + "\n";
                });
                root.interfaces = interfacesText;
            }
        }
    }
}
