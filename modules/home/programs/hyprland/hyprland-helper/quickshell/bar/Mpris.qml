import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.services
import qs.customItems

WrapperMouseArea {
    id: root

    Layout.fillHeight: true

    anchors.centerIn: parent

    //acceptedButtons: Qt.RightButton | Qt.LeftButton

    onClicked: mouse => {
        //mouse.accepted = true;
        //if (mouse.button == Qt.LeftButton && MprisState.player.isPlaying) {
        if (mouse.button == Qt.LeftButton) {
            MprisState.player.togglePlaying()
        } else if (mouse.button == Qt.RightButton) {
            MprisState.player.next()
        } else if (mouse.button == Qt.MiddleButton) {
            MprisState.player.stop()
        }
    }

    onWheel: wheel => {
        if (wheel.angledelta.y > 0) {
            MprisState.player.volume = 0.1;
        } else if (wheel.angledelta.y < 0) {
            MprisState.player.volume = 0.1;
        }
    }

    RowLayout {
        visible: MprisState.player

        Layout.fillHeight: true

        ClippingWrapperRectangle {
            radius: height / 2 // 6
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
            //text: MprisState.player?.trackTitle + " - " + MprisState.player?.trackArtist || ""
            text: MprisState.player?.trackTitle
            baseColor: Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.80)
            //color: '#ccccccff'
            font {
                pixelSize: 13
                family: 'inter'
                bold: false
            }
        }

    }
}
