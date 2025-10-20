pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

Singleton {
    id: root

    property MprisPlayer player: null
    property MprisPlayer lastPlayer: null
    property var players: new Set()

    function updatePlayer() {
        let leader = null;
        // Filter out mpv from the previous selection
        let backup = (lastPlayer && lastPlayer.identity !== "mpv" && lastPlayer.desktopEntry !== "mpv")
            ? lastPlayer : null;
        for (let player of Mpris.players.values) {

            //if (player.identity === "mpv" || player.desktopEntry === "mpv") continue;

            const ignored = ["mpv"];

            if (ignored.includes(player?.identity) || ignored.includes(player?.desktopEntry))
                continue;

            if (player.isPlaying) {
                backup = player;
                if (player?.trackArtist && player.trackArtist !== "")
                    leader = player;
            }
        }

        player = leader != null ? leader : backup;
    }

    function handlePlayerChanged(player: MprisPlayer) {
        if (!player.isPlaying) return;

        players.delete(player);
        players.add(player);
        lastPlayer = player ?? null;

        updatePlayer();
    }

    function playerDestroyed(player: MprisPlayer) {
        players.delete(player);
        lastPlayer = players[players.size] ?? null;

        updatePlayer();
    }

    Instantiator {
        model: Mpris.players

        Connections {
            required property MprisPlayer modelData
            target: modelData

            Component.onCompleted: root.handlePlayerChanged(modelData)
            Component.onDestruction: root.playerDestroyed(modelData)

            function onPlaybackStateChanged() {
                root.handlePlayerChanged(modelData);
            }
        }
    }
}
