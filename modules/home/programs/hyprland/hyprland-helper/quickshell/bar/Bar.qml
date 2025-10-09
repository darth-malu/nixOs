import Quickshell // PanelWindow
import QtQuick // Text
import Quickshell.Hyprland
import QtQuick.Layouts
import "./time"
import Quickshell.Wayland
import "./systemTray"
import qs.services
import qs.customItems
import Quickshell.Io

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            WlrLayershell.namespace: "tildeBar"
            required property var modelData
            screen: modelData   // ALl currently connected screens, updates as connected screens change. Reusing a window on every screen This creates an instance of your window once on every screen. As screens are added or removed your window will be created or destroyed on those screens.
            aboveWindows: false // true::
            color: "transparent"
            implicitHeight: 20
            margins { left: 12; right: 12 }
            anchors { top: true; left: true; right: true }
            //width: screen.geometry.width

            MouseArea {
                anchors.fill: parent
                onWheel: wheel => {
                    if (wheel.angleDelta.y > 0) {
                        Hyprland.dispatch("workspace m-1");
                    } else if (wheel.angleDelta.y < 0) {
                        Hyprland.dispatch("workspace m+1");
                    }
                }
            }

            IpcHandler {
                target: "bar"
                function toggle_bar(): void {
                    bar.visible = !bar.visible;
                }
            }

            Rectangle {
                id: mainBar
                anchors.fill: parent
                //spacing: 0
                radius: 16
                color: 'transparent'

                RowLayout {
                    id: leftBlock
                    spacing: 0.4
                    anchors.left:parent.left

                    Workspaces {}
                    ActiveWindow {}
                }


                RowLayout {
                  id: centerBlock
                  anchors.centerIn: parent
                  Rectangle {
                      //anchors.centerIn: parent
                      anchors.verticalCenter: parent.verticalCenter
                      Mpris {}
                  }
                }


                RowLayout {
                  id: rightBlock
                  spacing: 4
                  anchors.right: parent.right
                  anchors.verticalCenter: parent.verticalCenter

                  //modules
                  Pipewire {}
                  Resources {}
                  ClockWidget {}
                  SystemTrayy {}
              }
          }
        }
    }
}
