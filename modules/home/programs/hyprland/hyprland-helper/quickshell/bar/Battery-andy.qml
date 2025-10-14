import QtQuick
import Quickshell.Io
import qs.customItems
import Quickshell.Services.UPower

BarBlock {

  property string battery

  content: BarText {
    symbolText: battery
    color: 'red'
  }

  Process {
    id: batteryProc
    command: ["batteryQS"]
    running: true

    stdout: SplitParser {
      onRead: data => battery = data
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: batteryProc.running = true
  }
}
