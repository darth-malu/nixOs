import Quickshell // PanelWindow
import QtQuick // Text
import Quickshell.Hyprland
import QtQuick.Layouts
import "./time"
import Quickshell.Wayland
import "./systemTray"

ShellRoot {
    //scope vs shellroot
    Variants {
        model: Quickshell.screens  //Returns all connected screens
        PanelWindow {
            id: mainPanel
            WlrLayershell.namespace: "tilde"
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
                //color: '#1a1a1a'
                //color: '#35a29fff'; //move this to rectangle
                //color: Qt.rgba(8/255, 41/255, 41/255, 0.58)
                color: 'transparent'
                radius: 16
                border.width: 0
                //border.color: "#333333"
                //Windows {}
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
                    anchors {
                        left: parent.left
                        //leftMargin: 1
                    }
                    Repeater {
                        //anchors.verticalCenter: parent.verticalCenter
                        model: Hyprland.workspaces.values.filter(w => !w.name.startsWith("special"))
                        Rectangle {
                            implicitWidth: 20
                            implicitHeight: 20
                            radius: 16
                            color: modelData.active ? "#b298dc" : "transparent" // Green -062726, 062726, 6247AA
                            MouseArea {
                                anchors.fill: parent
                                onClicked: Hyprland.dispatch("workspace " + modelData.id)
                            }
                            Text {
                                text: modelData.id
                                anchors {
                                    centerIn: parent
                                    verticalCenter: parent.verticalCenter
                                    //horizontalCenter: parent.horizontalCenter
                                }
                                color: modelData.active ? '#5c0099' : Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.82) //#d896ff/255 //D5E68D, #C8EAD3, 42BFDD, #B6DC76, 98B06F, 442B48(orange), 7C90A0(grey/silver), 7C90A0, 5D5179
                                font.pixelSize: 14
                                font.bold: true
                                //font.family: "quicksand"
                                font.family: "Mononoki Nerd Font"
                            }
                        }
                    }
                    //fallback if no workspace
                    Text {
                        visible: Hyprland.workspaces.length === 0
                        text: "No workspaces"
                        color: "#ffffff"
                        font.pixelSize: 12
                    }

                    ActiveWindow {
                        id: activeWorkspace
                        Layout.leftMargin: 10
                        anchors.centerIn: undefined //interesting behaviour
                        color: {
                          return Hyprland.focusedMonitor == Hyprland.monitorFor(screen)
                            ? "#FFFFFF" : "#CCCCCC"
                        }
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
                  //Mpris {}
                }

                // Without this filler item, the active window block will be centered
                // despite setting left alignment
                /* Item { */
                /*   Layout.fillWidth: true */
                /* } */
                //RHS
                RowLayout {
                  id: rightBlock
                  spacing: 2
                  anchors {
                      right: parent.right
                      verticalCenter: parent.verticalCenter
                      //leftMargin: 1
                  }
                  Pipewire {}
                  Memory {}
                  Cpu {}
                  ClockWidget {}
                  SystemTrayy {}
              }
            }
        }
    }
}
