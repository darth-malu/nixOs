import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.customItems

Item {
  implicitHeight: text.implicitHeight
  implicitWidth: text.implicitWidth

  property string percentUsed

  Process {
    id: cpuProc
    command: ["sh", "-c", "top -bn 1 | grep \"%Cpu(s)\" | awk '{usage=100-$8; printf \"%02d\", usage}'"]
    //command: ["sh", "-c", "awk -F': ' '/cpu MHz/ { sum += $2; count++ } END { if (count > 0) printf \"%.2f\", (sum / count) / 1000 }' /proc/cpuinfo"]
    running: true

    stdout: SplitParser {
      onRead: data => percentUsed = data
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: cpuProc.running = true
  }

  BarText {
    id: text
    font {
        pixelSize: 12
        bold: false
        family: "IBM plex mono"
    }
    color: '#ccccccff'
    //symbolText: ` ${Math.floor(percentUsed)}` //
    symbolText: "<div style = 'font-family: Symbols Nerd Font Mono'>%1</div>%2"
      .arg("🤖 ") // The rest of the string
      .arg(percentUsed) // Symbol needs its own font
  }
}
