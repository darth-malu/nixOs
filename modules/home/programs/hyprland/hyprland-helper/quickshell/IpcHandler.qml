import qs.services
import QtQuick
/* import qs */
import qs.bar
import Quickshell.Io

Item {
    id: root

    IpcHandler {
        target: 'bar'

        function toggle_bar(): void {
            bar.visible = !bar.visible;
        }
    }

    IpcHandler {
        target: 'mpris'

        function toggleMpris(): void {
            root.visible = !root.visible;
        }

        function pauseAll() {
            for (const player of Mpris.players.values) {
                if (player.canPause)
                    player.pause();
            }
        }

        function togglePlaying() {
            const player = MprisState.player;
            if (player && player.canTogglePlaying)
                player.togglePlaying();
        }

        function previous() {
            const player = MprisState.player;
            if (player && player.canGoPrevious)
                player.previous();
        }

        function next() {
            const player = MprisState.player;
            if (player && player.canGoNext)
                player.next();
        }

        function raise() {
            const player = MprisState.player;
            if (player && player.canRaise)
                player.raise();
        }
    }
}

