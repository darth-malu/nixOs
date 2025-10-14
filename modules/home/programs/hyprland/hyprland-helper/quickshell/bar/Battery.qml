import Quickshell.Services.UPower
import qs.customItems

BarBlock {
    id: batBlock
    visible: Upower.devices.values.ready && Upower.devices.values.isPresent

    readonly property bool isBatteryPresent: Upower.onBattery
    property real batLevel: Upower.devices.values.percentage // charge level as %

    content: BarText {
        id: batText
        color: 'pink'
        symbolText: batLevel 
    }
}
