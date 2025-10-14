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

            // the screen from the screens list will be injected into this property
            required property var modelData

            screen: modelData   // ALl currently connected screens, updates as connected screens change. Reusing a window on every screen This creates an instance of your window once on every screen. As screens are added or removed your window will be created or destroyed on those screens.
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

            Rectangle {
                id: panel
                anchors.fill: parent
                //spacing: 0
                radius: 16
                color: 'transparent'

                RowLayout {
                    id: leftBlock
                    spacing: 0.4
                    anchors.left:parent.left
                    Workspaces {}
                    WindowTitle {}
                }

                Rectangle {
                    id: mpris
                    anchors.centerIn: parent
                    Mpris {}
                }

                RowLayout {
                  id: rightBlock
                  spacing: 4
                  anchors.right: parent.right
                  anchors.verticalCenter: parent.verticalCenter

                  Pipewire {}
                  Resources {}
                  ClockWidget {}
                  Battery {}
                  SystemTrayy {}
              }
          }
        }
    }
}
