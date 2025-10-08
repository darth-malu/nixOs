import Quickshell // PanelWindow
import QtQuick // Text
import Quickshell.Hyprland
import QtQuick.Layouts
import "./time"
import Quickshell.Wayland
import "./systemTray"
import qs.services
import qs.customItems

ShellRoot {
    Variants {
        model: Quickshell.screens  //Returns all connected screens

        PanelWindow {
            id: mainPanel
            WlrLayershell.namespace: "tildeBar"
            required property var modelData
            screen: modelData   // ALl currently connected screens, updates as connected screens change. Reusing a window on every screen This creates an instance of your window once on every screen. As screens are added or removed your window will be created or destroyed on those screens.
            aboveWindows: false // true::
            color: "transparent"
            implicitHeight: 20

            margins {
                left: 12
                right: 12
            }

            anchors {
                top: true
                left: true
                right: true
            }

            //main bar -> Houses Everything
            Rectangle {
                id: mainBar
                anchors.fill: parent
                color: 'transparent'
                radius: 16

                border {
                    width: 0
                    //color: "#333333"
                    //color: Qt.rgba(8/255, 41/255, 41/255, 0.58)
                }

                MouseArea {
                    // scroll on whole bar
                    anchors.fill: parent
                    onWheel: wheel => {
                        if (wheel.angleDelta.y > 0) {
                            Hyprland.dispatch("workspace m-1");
                        } else if (wheel.angleDelta.y < 0) {
                            Hyprland.dispatch("workspace m+1");
                        }
                    }
                }

                RowLayout {
                    id: leftBlock
                    spacing: 0.4
                    anchors.left:parent.left
                    Workspaces {}
                    ActiveWindow {
                        id: activeWorkspace
                        Layout.leftMargin: 10
                        //anchors.centerIn: undefined //interesting behaviour
                    }
                }

                RowLayout {
                  id: centerBlock
                  anchors {
                      centerIn: parent
                  }
                    Rectangle {
                        anchors {
                            centerIn: parent
                            verticalCenter: parent.verticalCenter
                        }
                        Mpris {}
                    }
                }

                RowLayout {
                  id: rightBlock
                  spacing: 2
                  anchors {
                      right: parent.right
                      verticalCenter: parent.verticalCenter
                      //leftMargin: 1
                  }
                  Pipewire {
                    /* Separator { */
                    /*     color: parent.volumeColor */
                    /* } */
                  }
                  //Separator {}
                  Resources {
                        Layout.leftMargin: 5
                        Layout.rightMargin:5
                  }
                  ClockWidget {}
                  Battery {}
                  SystemTrayy {}
              }
            }
        }
    }
}
