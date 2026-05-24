import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: launcher

    property var applications: []

    property var recentApps: []
    onRecentAppsChanged: {
        // Force update of the display slice
        displayRecentApps = recentApps.slice(0, 5)
    }

    property var displayRecentApps: []

    signal applicationsLoaded()

    Component.onCompleted: {
        loadApplications()
        loadRecentApps()
    }

    function parseDesktopFile(content) {
        const lines = content.split('\n')
        let app = { name: '', exec: '' }

        for (let line of lines) {
            if (line.startsWith('Name=')) {
                app.name = line.substring(5).trim()
            } else if (line.startsWith('Exec=')) {
                let exec = line.substring(5).trim()
                // Remove arguments like %F, %U, etc.
                exec = exec.replace(/%[a-zA-Z]/g, '').trim()
                app.exec = exec
            }
        }

        return app.name && app.exec ? app : null
    }

    function loadApplications() {
        findFilesProcess.running = true
    }

    property int appsLoadingCount: 0
    property var tempApps: []

    Process {
        id: findFilesProcess
        command: ["sh", "-c", "find /usr/share/applications -maxdepth 1 -name '*.desktop' 2>/dev/null | head -100"]

        stdout: StdioCollector {
            onStreamFinished: {
                const files = this.text.split('\n').filter(f => f.length > 0)
                launcher.tempApps = []
                launcher.appsLoadingCount = files.length

                if (files.length === 0) {
                    launcher.applicationsLoaded()
                    return
                }

                for (let i = 0; i < files.length; i++) {
                    let proc = readAppProcs.createObject(launcher, {
                        command: ["cat", files[i]],
                        fileIndex: i
                    })
                    proc.running = true
                }
            }
        }
    }

    Component {
        id: readAppProcs
        Process {
            property int fileIndex: 0

            stdout: StdioCollector {
                onStreamFinished: {
                    let app = launcher.parseDesktopFile(this.text)
                    if (app) {
                        launcher.tempApps.push(app)
                    }
                    launcher.appsLoadingCount--
                    if (launcher.appsLoadingCount === 0) {
                        launcher.applications = launcher.tempApps.sort((a, b) => a.name.localeCompare(b.name))
                        launcher.applicationsLoaded()
                    }
                    destroy()
                }
            }
        }
    }

    function saveRecentApps() {
        let content = recentApps.map(a => a.name + '|' + a.exec).join('\n')
        let cmd = "mkdir -p ~/.config/quickshell && printf '%s' '" + content.replace(/'/g, "'\\''") + "' > ~/.config/quickshell/recent_apps"

        saveProc.command = ["sh", "-c", cmd]
        saveProc.running = true
    }

    Process {
        id: saveProc
    }

    function loadRecentApps() {
        loadRecentProc.running = true
    }

    Process {
        id: loadRecentProc
        command: ["sh", "-c", "cat ~/.config/quickshell/recent_apps 2>/dev/null || true"]

        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text && this.text.length > 0) {
                    try {
                        recentApps = this.text.split('\n')
                            .filter(l => l.length > 0)
                            .map(l => {
                                const parts = l.split('|')
                                return { name: parts[0], exec: parts[1] }
                            })
                            .slice(0, 10)
                    } catch(e) {
                        console.log("Error loading recent apps:", e)
                    }
                }
            }
        }
    }

    function launchApplication(app) {
        let proc = launchProcs.createObject(launcher, {
            command: ["sh", "-c", app.exec + " &"]
        })
        proc.running = true

        // Update recent apps - create a new array to trigger property change
        let newRecent = recentApps.filter(a => a.name !== app.name)
        newRecent.unshift(app)
        if (newRecent.length > 10) {
            newRecent = newRecent.slice(0, 10)
        }
        recentApps = newRecent
        saveRecentApps()
    }

    Component {
        id: launchProcs
        Process {
            onRunningChanged: {
                if (!running) {
                    destroy()
                }
            }
        }
    }
}
