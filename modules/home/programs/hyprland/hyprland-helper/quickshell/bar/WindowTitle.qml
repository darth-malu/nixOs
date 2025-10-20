import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import qs.customItems

BarText {
    readonly property bool hasWindows: Hyprland.activeToplevel
    property int chopLength: {
              var space = Math.floor(panel.width - (rightBlock.implicitWidth + leftBlock.implicitWidth))
              return space * 0.08;
    }

    property string activeWindowTitle


    font {pixelSize: 13; bold: false ;family: 'inter'}

    //visible: true

    Layout.leftMargin: 15

    baseColor: '#ccccccff' //'#bd93f9'

    symbolText: {
        var str = activeWindowTitle
        if (!hasWindows || !str)
            return
        return str.length > chopLength ? str.slice(0, chopLength) + '...' : str;
    }

    Process {
      id: titleProc
        command: ["sh", "-c", "hyprctl activewindow | grep title: | sed 's/^[^:]*: //'"]; running: true

      stdout: SplitParser {
        onRead: data => activeWindowTitle = data
      }
    }

    Component.onCompleted: { Hyprland.rawEvent.connect(hyprEvent) } // socket 2 hyprland

    function hyprEvent(e) {titleProc.running = true}
}
