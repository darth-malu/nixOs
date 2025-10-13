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
    //Variants {
        //model: Quickshell.screens
        Socket {
            // Create and connect a Socket to the hyprland event socket.
            // https://wiki.hyprland.org/IPC/
            path: `${Quickshell.env("XDG_RUNTIME_DIR")}/hypr/${Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")}/.socket2.sock`
            connected: true

            parser: SplitParser {
              // Regex that will return the newly focused monitor when it changes.
              property var regex: new RegExp("focusedmon>>(.+),.*");

              // Sent for every line read from the socket
              onRead: msg => {
                const match = regex.exec(msg);

                if (match != null) {
                  // Filter out the right screen from the list and update the panel.
                  // match[1] will always be the monitor name captured by the regex.
                  panel.screen = Quickshell.screens.filter(screen => screen.name == match[1])[0];
                }
              }
            }
          }

        PanelWindow {
            id: panel
            WlrLayershell.namespace: "tildeBar"

            // the screen from the screens list will be injected into this property
            // ALl currently connected screens, updates as connected screens change. Reusing a window on every screen This creates an instance of your window once on every screen. As screens are added or removed your window will be created or destroyed on those screens. modelData
            required property var modelData

            //screen: modelData   
            aboveWindows: false // true::
            color: "transparent"
            implicitHeight: 20
            margins { left: 12; right: 12 }
            anchors { top: true; left: true; right: true }

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
                radius: 16
                color: 'transparent'

                RowLayout {
                    id: leftBlock
                    spacing: 0.4
                    anchors.left:parent.left
                    Workspaces {}
                    WindowTitle {}
                }

                RowLayout {
                  id: centerBlock
                  anchors.centerIn: parent
                  Rectangle {
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
    //}
}
