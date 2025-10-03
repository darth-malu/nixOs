pragma singleton

import Quickshell.Services.Mpris
import QtQuick
import Quickshell

Singleton {
    id: root

    property var currentPlayer: null
    property real currentPosition: 0
    property bool isSeeking: false
    property int selectedPlayerIndex: 0
    property bool isPlaying: currentPlayer ? (currentPlayer.playbackState === MprisPlaybackState.Playing || currentPlayer.isPlaying) : false
    property string trackTitle: currentPlayer ? (currentPlayer.trackTitle || "") : ""
    property string trackArtist: currentPlayer ? (currentPlayer.trackArtist || "") : ""
    property string trackAlbum: currentPlayer ? (currentPlayer.trackAlbum || "") : ""
    property string trackArtUrl: currentPlayer ? (currentPlayer.trackArtUrl || "") : ""
    property real trackLength: currentPlayer ? ((currentPlayer.length < infiniteTrackLength) ? currentPlayer.length : 0) : 0
    property bool canPlay: currentPlayer ? currentPlayer.canPlay : false
    property bool canPause: currentPlayer ? currentPlayer.canPause : false
    property bool canGoNext: currentPlayer ? currentPlayer.canGoNext : false
    property bool canGoPrevious: currentPlayer ? currentPlayer.canGoPrevious : false
    property bool canSeek: currentPlayer ? currentPlayer.canSeek : false
    property real infiniteTrackLength: 922337203685
}
