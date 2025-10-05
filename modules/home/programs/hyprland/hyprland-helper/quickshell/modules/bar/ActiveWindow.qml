import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import qs.customItems

BarText {
  property int chopLength:100
  property string activeWindowTitle

  /* chopLength: { */
  /*   var space = Math.floor(bar.width - (rightBlocks.implicitWidth + leftBlocks.implicitWidth)) */
  /*   return space * 0.08; */
  /* } */

  baseColor: "#FF6EC7"

  font {
      pixelSize: 13
      bold: false
      family: 'inter'
  }
  text: {
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
    Hyprland.rawEvent.connect(hyprEvent)
      /*
        rawEvent - socket2
       * */
  }

  function hyprEvent(e) {
    titleProc.running = true
  }
}
