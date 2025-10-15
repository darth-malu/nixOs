import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

import qs.customItems

BarBlock {
  id: text
  visible: Pipewire.ready
  property PwNode outputSink: Pipewire.defaultAudioSink
  property PwNode inputSink: Pipewire.defaultAudioSource
  property string volume: Pipewire.ready ? `${Math.floor(outputSink.audio.volume * 100)}` : ""
  property color volumeColor: "#ccccccff"

  //underline: true
  property int textSize: 8
  property string textFont: 'inter'
  property bool textBold: true

  PwObjectTracker { objects: [ outputSink] }

  MouseArea {
    anchors.fill: parent
    onClicked: Hyprland.dispatch("workspace 1")
    onWheel: (event) => {
      if (!outputSink?.audio) return;
      const step = 4;
      let volume = outputSink.audio.volume * 100;
      volume += event.angleDelta.y > 0 ? step : -step;
      volume = Math.max(0, Math.min(volume, 100)); // Clamp 0% - 100% even with continued scrolling
      Pipewire.defaultAudioSink.audio.volume = volume / 100;
    }
  }

  content: BarText {
      id: volumeOut
      symbolText: `🔈 ${text.volume}`
      color: text.volumeColor
      font {
          pixelSize: 12
          bold: false
          family: "quicksand medium"
      }
  }
}
