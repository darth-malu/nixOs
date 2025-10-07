import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root
  property bool shouldShowOsd: false

  // Bind the pipewire node so its volume will be tracked
  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

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
            /* source: Quickshell.iconPath("audio-volume-high-symbolic") */
            source: "root:assets/speaker/icons8-speaker-30-4.png"
            asynchronous: true
            //anchors.verticalCenter: parent.verticalCenter
          }

          Rectangle {//outer
            // Stretches to fill all left-over space
            Layout.fillWidth: true
            anchors.verticalCenter: parent.verticalCenter
            implicitHeight: 4
            radius: 20
            color: "#80000000"
              Rectangle {//inner - white  (current volume)
                anchors {
                  left: parent.left
                  top: parent.top
                  bottom: parent.bottom
                  /* verticalCenter: parent.verticalCenter */
                }
                implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                radius: parent.radius
                color: Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.98)
            }
          }
        }
      }
    }
  }
}
