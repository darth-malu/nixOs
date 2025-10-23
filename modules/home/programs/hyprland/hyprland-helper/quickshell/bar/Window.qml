pragma Singleton
import QtQuick
import qs.customItems
import Quickshell
import Quickshell.Hyprland


Singleton {
    Rectangle {
      implicitWidth: 40
      property var acWindow: Hyprland.Toplevel

      BarText {
          id: myText
          text: acWindow.title
          color: 'white'
      }
    }
}
