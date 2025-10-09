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
            height: 20
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
                /* Layout.fillHeight: true */
                /* Layout.fillWidth: true */

                RowLayout {
                    id: leftBlock
                    spacing: 0.4
                    anchors.left:parent.left

                    Workspaces {}
                    ActiveWindow {}
                }

                //Item { Layout.fillWidth: true } // expands to push centerBlock to middle

                RowLayout {
                  id: centerBlock
                  anchors.centerIn: parent.center
                  Rectangle {
                      //anchors.centerIn: parent
                      anchors.verticalCenter: parent.verticalCenter
                      Mpris {}
                  }
                  //Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                //Item { Layout.fillWidth: true } // expands to push rightBlock to edge

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
