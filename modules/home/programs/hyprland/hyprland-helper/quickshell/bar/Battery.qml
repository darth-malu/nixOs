import Quickshell.Services.UPower
import qs.customItems

BarBlock {
    id: batBlock
    visible: isBatteryPresent

    readonly property UPowerDevice battery: UPower.displayDevice

    readonly property bool isBatteryPresent: UPower.displayDevice.isLaptopBattery

    property real batLevel: Math.floor(UPower.displayDevice.percentage * 100) // charge level as %

    content: BarText {
        id: batText
        color: 'pink'
        font { pointSize: 10; family: 'lato'; bold: true}
        symbolText: batLevel 
    }
}
