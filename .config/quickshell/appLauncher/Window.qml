import Quickshell
import QtQuick
import qs

FloatingWindow {
  id: toplevel

  minimumSize: Qt.size(500, 400)
  maximumSize: Qt.size(500, 400)

  color: Theme.get.backgroundColor

  TextInput {
    text: "Test!"
    color: Theme.get.goldColor
    width: parent.width

    font {
      bold: true
      pointSize: 14
    }
  }
}
