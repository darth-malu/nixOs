import QtQuick
import Quickshell.Hyprland

Rectangle {
  id: windowss
  anchors {
    centerIn: parent
    //verticalCenter: parent.verticalCenter
  }

  MouseArea { // scroll on whole bar
    anchors.fill: parent
    onWheel: (wheel) => {
        if (wheel.angleDelta.y > 0) {
          Hyprland.dispatch("workspace m-1")
        } else if (wheel.angleDelta.y < 0) {
          Hyprland.dispatch("workspace m+1")
        }
    }
  }

  Text {
    text: Hyprland.workspaces.values.id
    color: 'white'
    anchors {
      centerIn: parent
      verticalCenter: parent.verticalCenter
    }

  }

  /* Text { */
  /*   text: Hyprland.workspaces.id */
  /*   color: 'white' */
  /* } */
}
