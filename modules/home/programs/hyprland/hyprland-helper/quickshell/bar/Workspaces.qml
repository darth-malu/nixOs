import QtQuick
import qs.services
import Quickshell.Hyprland

Repeater {
    model: Hyprland.workspaces.values.filter(w => !w.name.startsWith("special"))

    Rectangle {
        id: circleBackground
        property bool isFocusedMonitor: modelData.monitor?.name === Hyprland.focusedMonitor?.name
        property bool focusedActive: isFocusedMonitor && modelData.active
        property color activeTextColor: "#5c0099"
        property color inactiveTextColor: Qt.rgba(171/255, 141/255, 237/255, 0.88)

        implicitWidth: 20
        implicitHeight: 20
        radius: 16
        color: modelData.active ? isFocusedMonitor ? "#b298dc" : "transparent" : 'transparent' // Green -062726, 062726, 6247AA

        MouseArea { anchors.fill: parent; onClicked: Hyprland.dispatch("workspace " + modelData.id) }

        Text {
            id: numbers
            text: modelData.id
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            color: isFocusedMonitor ?  modelData.active ? '#5c0099' : Qt.rgba(171 / 255, 141 / 255, 237 / 255, 1) : '#5E5768'// Green -062726, 062726, 6247AA
            font.pixelSize: 13
            font.bold: true
            font.family: "lato"
        }
        Text {
            id: fallback
            visible: Hyprland.workspaces.length === 0
            text: "No workspaces"
            color: "#ffffff"
            font.pixelSize: 12
        }
    }
}
