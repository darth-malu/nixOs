import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Io
import qs.services
import qs.customItems

WrapperMouseArea {
    id: root
		visible: MprisState.player != null

    //Layout.fillHeight: true
    hoverEnabled: true

    anchors.centerIn: parent

    acceptedButtons: Qt.RightButton | Qt.LeftButton | Qt.MiddleButton | Qt.ForwardButton | Qt.BackButton

    property bool showVolume: false

    property bool showPlayer: !!(
        MprisState.player?.isPlaying &&
        MprisState.player?.trackTitle !== "default" &&
        !(MprisState.player?.trackTitle || "").includes("default")
    )

    Timer {
        id: hideVolumeTimer
        interval: 1000
        repeat: false
        running: false
        onTriggered: root.showVolume = false
    }

    onExited: () => {
        hideVolumeTimer.restart()
    }

    onClicked: mouse => {
        mouse.accepted = true // Prevent background click
        if (mouse.button == Qt.LeftButton) {
            MprisState.player?.togglePlaying()
        } else if (mouse.button == Qt.RightButton) {
            MprisState.player?.next()
        } else if (mouse.button == Qt.MiddleButton) {
            MprisState.player?.raise()
        } else if (mouse.button == Qt.ForwardButton) {
            MprisState.player?.next() 
        } else if (mouse.button == Qt.BackButton) {
            MprisState.player?.previous() 
        }
    }

    onWheel: (event) => {
        if (!MprisState.player?.isPlaying)
            return

        let vol = MprisState.player.volume * 100 // Convert current volume (0.0–1.0) to percent

        vol += event.angleDelta.y > 0 ? 4 : -4 // Scroll up increases, down decreases

        vol = Math.max(0, Math.min(vol, 100)) // Clamp between 0% and 100%

        MprisState.player.volume = vol / 100 // Apply back to player

        root.showVolume = true
    }

    RowLayout {
        visible: showPlayer

        /* Layout.fillHeight: true */

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
            text: MprisState.player?.trackTitle || ""
            //baseColor: Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.78) //baseColor: '#ccccccff' , '#D1D2F9' (nice brightness)
            baseColor: '#bd93f9'
            font {pixelSize: 13;family: 'quicksand medium';bold: false}
        }

        BarText {
            id: volumePlayer
            visible: root.showVolume
            text: Math.round(MprisState.player?.volume * 100) ?? ""
            font {pixelSize: 13;family: 'lato';bold: false}
            opacity: root.showVolume ? 1 : 0
            color: '#ff79c6'
            Behavior on opacity { NumberAnimation { duration: 220 } }
        }

    }
}
