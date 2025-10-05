import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland

import qs.customItems

BarBlock {
  id: text
  visible: Pipewire.ready

  // properties
  property PwNode outputSink: Pipewire.defaultAudioSink
  property PwNode inputSink: Pipewire.defaultAudioSource
  property string volume: Pipewire.ready ? `${Math.floor(outputSink.audio.volume * 100)}` : ""

  PwObjectTracker { objects: [ outputSink,inputSink ] }

  MouseArea {
    anchors.fill: parent
    //onClicked: Hyprland.dispatch("workspace 1")
    onWheel: (event) => {
      if (!outputSink?.audio) return;
      const step = 4;
      let volume = outputSink.audio.volume * 100;
      volume += event.angleDelta.y > 0 ? step : -step;
      volume = Math.max(0, Math.min(volume, 100)); // Clamp 0% - 100% even with continued scrolling
      Pipewire.defaultAudioSink.audio.volume = volume / 100;
    }
    //acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
  }

  content: BarText {
    symbolText: `🔈 ${volume}`
    //font.family: "quicksand"
    font.pixelSize: 11
    font.family: "inter"
    font.bold: false
    color: '#ccccccff'
  //font.family: "VictorMono Nerd Font"

  }
}
