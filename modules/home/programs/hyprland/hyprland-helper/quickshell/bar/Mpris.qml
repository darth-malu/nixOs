import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.services
import qs.customItems

WrapperMouseArea {
    id: root

    Layout.fillHeight: true

    anchors {
        centerIn: parent
    }

    acceptedButtons: Qt.RightButton | Qt.LeftButton

    onClicked: event => {
        event.accepted = true;
        MprisState.player.togglePlaying();
    }

    RowLayout {
        visible: MprisState.player

        Layout.fillHeight: true

        ClippingWrapperRectangle {
            //radius: height / 2
            radius: 6
            implicitWidth: 24
            implicitHeight: 24
            Image {
                id: artwork
                anchors.fill: parent
                source: MprisState.player?.trackArtUrl || ""
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }
        }

        BarText {
            id: title
            text: MprisState.player?.trackTitle || ""
            baseColor: '#3798B9'
            font {
                pixelSize: 14
                //family: 'lekton nerd font'
                family: 'nunito'
                bold: false
            }

            MouseArea {
              onClicked: mouse => {
                  if (mouse.button == Qt.LeftButton && MprisState.player.isPlaying) {
                      MprisPlayer.next()
                  } else if (mouse.button == Qt.RightButton) {
                      MprisPlayer.next()
                  } else if (mouse.button == Qt.MiddleButton) {
                      MprisPlayer.next()
                  }
              }
            }
        }

    }
}
