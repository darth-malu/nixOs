import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root
  property bool shouldShowOsd: false

  property var defaultSink:  Pipewire.defaultAudioSink
  property var currentVolume: defaultSink?.audio.volume ?? 0
  property var volumeColor:currentVolume > 90 ? "#F88DAD" : currentVolume > 70 ? "#FFD966" : "#A1FF9F"

  PwObjectTracker {
    objects: [ defaultSink ]
  }

  Connections {
    target: defaultSink?.audio

    function onVolumeChanged() {
      //root.currentVolume = defaultSink?.audio.volume ?? 0;
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.shouldShowOsd = false
  }

  // The OSD window will be created and destroyed based on shouldShowOsd.
  // PanelWindow.visible could be set instead of using a loader, but using
  // a loader will reduce the memory overhead when the window isn't open.
  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      // Since the panel's screen is unset, it will be picked by the compositor
      // when the window is created. Most compositors pick the current active monitor.

      anchors.bottom: true
      margins.bottom: screen.height / 5
      exclusiveZone: 0

      implicitWidth: 200
      implicitHeight: 16
      color: "transparent"

      // An empty click mask prevents the window from blocking mouse events.
      mask: Region {}

      Rectangle {// RowLayout (iconImage + Rectangle (inner + outer))
        anchors.fill: parent
        radius: height / 2
        color: "#80000000"

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 1
            rightMargin: 8
            verticalCenter: parent.verticalCenter
          }

          IconImage {
            implicitSize: 17
            source: "root:assets/speaker/icons8-speaker-30-4.png"
            asynchronous: true
          }

          Rectangle {//outer
            Layout.fillWidth: true // Stretches to fill all left-over space
            implicitHeight: 4
            radius: 20
            color: "#80000000"
            Rectangle {//inner - white  (current volume)
              anchors {left: parent.left;top: parent.top; bottom: parent.bottom}
              implicitWidth: parent.width * root.currentVolume
              radius: parent.radius
              color: volumeColor
            }
          }
        }
      }
    }
  }
}
