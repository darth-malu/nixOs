import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root
  property bool shouldShowOsd: false

  // Bind the pipewire node so its properties eg.volume will be tracked
  PwObjectTracker {objects: [ Pipewire.defaultAudioSink ]}

  Connections {
      target: Pipewire.defaultAudioSink?.audio ?? null // NOTE: patch work

      function onVolumeChanged() {
          root.shouldShowOsd = true;
        hideTimer.restart();
      }
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.shouldShowOsd = false
  }

  // PanelWindow.visible could be set instead of using a loader, but using a loader will reduce the memory overhead when the window isn't open.
  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      // Since the panel's screen is unset, it will be picked by the compositor when the window is created. Most compositors pick the current active monitor.

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
              implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
              radius: parent.radius
              //color: Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.98)
                color: '#bd93f9'
            }
          }
        }
      }
    }
  }
}
