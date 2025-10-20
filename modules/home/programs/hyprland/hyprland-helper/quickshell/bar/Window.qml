pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland


Singleton {
    Rectangle {
      Text {
          id: myText
          property var acWindow: Hyprland.Toplevel
          text: acWindow.title
      }
      implicitHeight: myText.height
      implicitWidth: myText.weight
    }

    Component.onCompleted: {
      console.log("acWindow working?", acWindow?.title)
    }
}
