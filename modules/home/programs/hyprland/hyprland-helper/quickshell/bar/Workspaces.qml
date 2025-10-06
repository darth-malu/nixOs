import QtQuick
import Quickshell.Hyprland

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
            color: modelData.active ? '#5c0099' : Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.88) //#d896ff/255 //D5E68D, #C8EAD3, 42BFDD, #B6DC76, 98B06F, 442B48(orange), 7C90A0(grey/silver), 7C90A0, 5D5179
            //color: modelData.active ? '#5c0099' :  '#ccccccff' //#d896ff/255 //D5E68D, #C8EAD3, 42BFDD, #B6DC76, 98B06F, 442B48(orange), 7C90A0(grey/silver), 7C90A0, 5D5179
            //color: '#ccccccff'
            font.pixelSize: 14
            font.bold: true
            //font.family: "quicksand"
            font.family: "Mononoki Nerd Font"
        }
        Text {
            //fallback if no workspace
            visible: Hyprland.workspaces.length === 0
            text: "No workspaces"
            color: "#ffffff"
            font.pixelSize: 12
        }
    }
}
