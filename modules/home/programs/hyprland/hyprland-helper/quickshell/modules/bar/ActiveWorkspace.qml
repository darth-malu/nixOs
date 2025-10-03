import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import "./blocks/styledObjects"

BarText {
  /* chopLength: { */
  /*   var space = Math.floor(bar.width - (rightBlocks.implicitWidth + leftBlocks.implicitWidth)) */
  /*   return space * 0.08; */
  /* } */

  font.pixelSize: 13
  font.bold: false
  //font.family: "quicksand"
  //font.family: "Mononoki Nerd Font"
  font.family: "inter"
  text: {
    var str = activeWindowTitle
    return str.length > chopLength ? str.slice(0, chopLength) + '...' : str;
  }

  property int chopLength:100
  property string activeWindowTitle

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
  }

  function hyprEvent(e) {
    titleProc.running = true
  }
}
