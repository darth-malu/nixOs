import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import qs.customItems

BarText {
  property int chopLength:100
  property string activeWindowTitle

  baseColor: {
    return Hyprland.focusedMonitor == Hyprland.monitorFor(screen)
      ? "#FF6EC7" : "#CCCCCC"
  }

  font {
      pixelSize: 13
      bold: false
      family: 'inter'
  }

  symbolText: {
    var str = activeWindowTitle
    return str.length > chopLength ? str.slice(0, chopLength) + '...' : str;
  }

  Process {
    id: titleProc
    command: ["sh", "-c", "hyprctl activewindow | grep title: | sed 's/^[^:]*: //'"]
    running: true

    stdout: SplitParser {
      onRead: data => activeWindowTitle = data
    }
  }

  Component.onCompleted: {
    Hyprland.rawEvent.connect(hyprEvent) // socket 2 hyprland
  }

  function hyprEvent(e) {
    titleProc.running = true
  }
}
