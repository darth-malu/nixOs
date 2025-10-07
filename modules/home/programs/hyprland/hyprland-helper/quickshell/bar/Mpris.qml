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

    onWheel: (event) => {
        /* if (!MprisState.player) */
        /*     return */

        // Convert current volume (0.0–1.0) to percent
        let vol = MprisState.player.volume * 100

        // Scroll up increases, down decreases
        vol += event.angleDelta.y > 0 ? 5 : -5

        // Clamp between 0% and 100%
        vol = Math.max(0, Math.min(vol, 100))

        // Apply back to player
        MprisState.player.volume = vol / 100
    }

    RowLayout {
        visible: MprisState.player &&
            MprisState.player.isPlaying &&
            MprisState.player.indentity !== "default" &&
            !MprisState.player.trackTitle.includes("default")
            /* !MprisState.player.trackArtUrl.includes("default") */
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
            text: MprisState.player?.trackTitle
            baseColor: Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.78)
            font {
                pixelSize: 13
                family: 'nunito'
                bold: false
            }
        }

    }
}
