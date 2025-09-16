import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

BarBlock {
  id: text
  content: BarText {
    //font.family: "VictorMono Nerd Font"
    font.family: "quicksand"
    //font.family: "Mononoki Nerd Font"
    font.pixelSize: 12
    font.bold: true
    symbolText: `🧠 ${Math.floor(percentFree)}` //
    color: '#ccccccff'
    //color: Qt.rgba( 7/255 , 177/255 , 169/255, 0.88)
  }

  property real percentFree

  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem | awk '{print $3/$2 * 100.0}'"]
    running: true

    stdout: SplitParser {
      onRead: data => percentFree = data
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: memProc.running = true
  }
}
