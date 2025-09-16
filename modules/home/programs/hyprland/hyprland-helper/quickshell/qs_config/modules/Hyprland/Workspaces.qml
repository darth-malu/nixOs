pragma Singleton
import QtQuick.Layouts
import Quickshell // PanelWindow
import QtQuick // Text
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell
import "../time"

Singleton {
    //id: root
    //main bar
    Row {
        id: hyprlandWorkspacesRow
        spacing: 2.3
        anchors {
        left : parent.left
        verticalCenter: parent.verticalCenter
        leftMargin: 1
        }
        Repeater {
        //model: Hyprland.workspaces
        model: Hyprland.workspaces.values.filter(w => !w.name.startsWith("special"))
        Rectangle {
            implicitWidth: 19
            implicitHeight: 19
            radius: 6
            color: modelData.active ? "#4a9eff" : "transparent"
            border.color: "#da195b57"
            MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + modelData.id)
            }
            Text {
            text: modelData.id
            anchors.centerIn: parent
            color: modelData.active ? "#ffffff" : "#cccccc"
            font.pixelSize: 13
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
    }
}
