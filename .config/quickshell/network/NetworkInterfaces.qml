pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    
    property var interfaceList: []

    Process {
        running: true
        command: ["sh", "-c", "ip -o -f inet addr show | awk '{print $2, $4}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.trim().split("\n");

                let parsedList = [];
                
                for (let line of lines) {
                    let data = line.split(" ");

                    if (data.length >= 2) {
                        parsedList.push({
                            "name": data[0],
                            "ip": data[1]
                        });
                    }
                }
                root.interfaceList = parsedList;
            }
        }
    }
}
