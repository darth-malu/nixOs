import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
//import "../"

BarBlock {
  id: text
  visible: Pipewire.ready

  property PwNode sink: Pipewire.defaultAudioSink
  property string volume: Pipewire.ready ? `${Math.floor(sink.audio.volume * 100)}` : ""

  PwObjectTracker { objects: [ sink ] }

  MouseArea {
    anchors.fill: parent
    //onClicked: Hyprland.dispatch("workspace 1")
    onWheel: (event) => {
      if (!Pipewire.defaultAudioSink?.audio) return;
      const step = 2;
      let volume = Pipewire.defaultAudioSource.audio.volume * 100;
      volume += event.angleDelta.y > 0 ? step : -step;
      volume = Math.max(0, Math.min(volume, 125)); // Clamp 0% - 125%
      Pipewire.defaultAudioSink.audio.volume = volume / 100;
    }
    //acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
  }

  content: BarText {
    symbolText: `🔈 ${volume}`
    font.family: "quicksand"
    //font.family: "Mononoki Nerd Font"
    font.pixelSize: 12
    font.bold: true
    color: '#ccccccff'
  //font.family: "VictorMono Nerd Font"

  }
}
