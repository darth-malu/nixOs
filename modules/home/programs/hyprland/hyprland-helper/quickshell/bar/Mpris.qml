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

    acceptedButtons: Qt.RightButton | Qt.LeftButton | Qt.MiddleButton

    onClicked: mouse => {
        mouse.accepted = true // Prevent background click
        //if (mouse.button == Qt.LeftButton && MprisState.player.isPlaying) {
        if (mouse.button == Qt.LeftButton) {
            MprisState.player.togglePlaying()
        } else if (mouse.button == Qt.RightButton) {
            MprisState.player.next()
        } else if (mouse.button == Qt.MiddleButton) {
            MprisState.player.stop()
        }
    }

    /* onWheel: wheel => { */
    /*     if (wheel.angledelta.y > 0) { */
    /*         const step = 4; */
    /*         let volume = MprisState.player.volume; */
    /*         volume += event.angleDelta.y > 0 ? step : -step; */
    /*         volume = Math.max(0, Math.min(volume, 100)); // Clamp 0% - 100% even with continued scrolling */
    /*         MprisState.player.volume = volume; */
    /*     } else if (wheel.angledelta.y < 0) { */
    /*         MprisState.player.volume = 0.0; */
    /*     } */
    /* } */

    RowLayout {
        visible: MprisState.player && MprisState.player.isPlaying
        //visible: MprisState.player && MprisState.player.canControl

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
            baseColor: Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.68)
            //color: '#ccccccff'
            font {
                pixelSize: 13
                family: 'inter'
                bold: false
            }
        }

    }
}
