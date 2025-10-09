import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import qs.customItems

BarText {
    property int chopLength: {
              var space = Math.floor(bar.width - (rightBlock.implicitWidth + leftBlock.implicitWidth))
              return space * 0.08;
            }
    property string activeWindowTitle

    Layout.leftMargin: 15

    baseColor: {
      return Hyprland.focusedMonitor == Hyprland.monitorFor(screen)
        ? Qt.rgba(171/255, 141/255, 237/255, 0.86) : "#CCCCCC" //"#FF6EC7"
    }

    color: '#ccccccff'

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
