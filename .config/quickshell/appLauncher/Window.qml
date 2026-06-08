import Quickshell
import QtQuick
import QtQuick.Controls
import qs

FloatingWindow {
  id: toplevel

  minimumSize: Qt.size(500, 600)
  maximumSize: Qt.size(500, 600)

  color: Theme.backgroundColor

  property var launcher
  property int selectedIndex: -1

  function getTotalItems() {
    let recentCount = (launcher.displayRecentApps.length > 0 && searchInput.text === "") ? launcher.displayRecentApps.length : 0
    let appsCount = appsListView.model ? appsListView.model.length : 0
    return recentCount + appsCount
  }

  function getItemAt(index) {
    let recentCount = (launcher.displayRecentApps.length > 0 && searchInput.text === "") ? launcher.displayRecentApps.length : 0
    if (index < recentCount) {
      return launcher.displayRecentApps[index]
    }
    return appsListView.model[index - recentCount]
  }

  function selectNextApp() {
    let total = getTotalItems()
    if (total > 0) {
      selectedIndex = Math.min(selectedIndex + 1, total - 1)
    }
  }

  function selectPrevApp() {
    let total = getTotalItems()
    if (total > 0) {
      selectedIndex = Math.max(selectedIndex - 1, 0)
    }
  }

  function launchSelectedApp() {
    if (selectedIndex >= 0) {
      let item = getItemAt(selectedIndex)
      if (item) {
        launcher.launchApplication(item)
        searchInput.text = ""
        searchInput.focus = true
        selectedIndex = -1
      }
    }
  }

  FocusScope {
    anchors.fill: parent
    focus: true

    Keys.onEscapePressed: {
      Qt.quit()
    }

  Column {
    anchors.fill: parent
    anchors.margins: 16
    spacing: 12

    // Search input
    Rectangle {
      width: parent.width
      height: 40
      color: Theme.overlayColor
      radius: 8

      TextInput {
        id: searchInput
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 12
        anchors.rightMargin: 12

        font.pointSize: 12
        color: Theme.textColor

        onTextChanged: {
          appsListView.filterText = text
          toplevel.selectedIndex = -1
        }

        Keys.onReturnPressed: {
          if (toplevel.selectedIndex >= 0) {
            toplevel.launchSelectedApp()
          } else {
            let item = toplevel.getItemAt(0)
            if (item) {
              launcher.launchApplication(item)
              searchInput.text = ""
              searchInput.focus = true
            }
          }
        }

        Keys.onDownPressed: {
          toplevel.selectNextApp()
        }

        Keys.onUpPressed: {
          toplevel.selectPrevApp()
        }
      }

      Text {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        text: "Search apps..."
        color: Theme.mutedColor
        font.pointSize: 12
        visible: searchInput.text === ""
      }
    }

    // Recent apps section
    Column {
      width: parent.width
      spacing: 8
      visible: launcher.displayRecentApps.length > 0 && searchInput.text === ""

      Text {
        text: "Recent"
        color: Theme.subtleColor
        font.pointSize: 10
        font.bold: true
      }

      Column {
        width: parent.width
        spacing: 4

        Repeater {
          model: launcher.displayRecentApps

          delegate: Rectangle {
            width: parent.width
            height: 36
            color: {
              let totalRecents = launcher.displayRecentApps.length
              if (index < totalRecents && index === toplevel.selectedIndex) {
                return Theme.overlayColor
              }
              return "transparent"
            }
            radius: 6

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: {
                parent.color = Theme.overlayColor
                toplevel.selectedIndex = index
              }
              onExited: {
                if (index !== toplevel.selectedIndex) {
                  parent.color = "transparent"
                }
              }
              onClicked: {
                launcher.launchApplication(modelData)
                searchInput.text = ""
                searchInput.focus = true
                toplevel.selectedIndex = -1
              }
            }

            Text {
              anchors.left: parent.left
              anchors.leftMargin: 8
              anchors.verticalCenter: parent.verticalCenter
              text: modelData.name
              color: Theme.textColor
              font.pointSize: 11
            }
          }
        }
      }
    }

    // Divider
    Rectangle {
      width: parent.width
      height: 1
      color: Theme.overlayColor
      visible: launcher.displayRecentApps.length > 0 && searchInput.text === ""
    }

    // Applications list
    Rectangle {
      width: parent.width
      height: parent.height - 64 - (launcher.displayRecentApps.length > 0 && searchInput.text === "" ? 120 : 0)
      color: "transparent"

      ListView {
        id: appsListView
        anchors.fill: parent
        clip: true

        property string filterText: ""

        model: {
          if (filterText === "") {
            return launcher.applications
          }
          return launcher.applications.filter(app =>
            app.name.toLowerCase().includes(filterText.toLowerCase())
          )
        }

        delegate: Rectangle {
          width: appsListView.width
          height: 36
          color: {
            let recentCount = (launcher.displayRecentApps.length > 0 && searchInput.text === "") ? launcher.displayRecentApps.length : 0
            if (index + recentCount === toplevel.selectedIndex) {
              return Theme.overlayColor
            }
            return "transparent"
          }
          radius: 6

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
              let recentCount = (launcher.displayRecentApps.length > 0 && searchInput.text === "") ? launcher.displayRecentApps.length : 0
              parent.color = Theme.overlayColor
              toplevel.selectedIndex = index + recentCount
            }
            onExited: {
              let recentCount = (launcher.displayRecentApps.length > 0 && searchInput.text === "") ? launcher.displayRecentApps.length : 0
              if (index + recentCount !== toplevel.selectedIndex) {
                parent.color = "transparent"
              }
            }
            onClicked: {
              launcher.launchApplication(modelData)
              searchInput.text = ""
              searchInput.focus = true
              toplevel.selectedIndex = -1
            }
          }

          Text {
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            text: modelData.name
            color: Theme.textColor
            font.pointSize: 11
          }
        }

        ScrollBar.vertical: ScrollBar {
          width: 6
        }
      }

      // "No results" message
      Text {
        anchors.centerIn: parent
        text: "No applications found"
        color: Theme.mutedColor
        font.pointSize: 11
        visible: appsListView.model.length === 0 && appsListView.filterText !== ""
      }
    }
  }

  // Auto-focus search on window open
  Component.onCompleted: {
    searchInput.focus = true
  }
  }
}
