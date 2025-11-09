{ pkgs }:

pkgs.writeShellScriptBin "pause_play" ''

  query_playerctl() {
      playerctl -l
  }

  music_playing_state() {
      #ingest ... eg mpd, then check if playing and return Playing/Paused
      for player in $(query_playerctl); do
          case $player in
          "mpd" | "spotify" | "lollypop")
              playerctl -p "$player" status
              ;;
          esac
      done
  }

  # check_running() {
  #     preg -xc "$@" >/dev/null || pgrep -fc "$@" >/dev/null
  # }

  player_active() {
      # output: mpd, spotify
      playerctl metadata --format '{{ playerName }}' | sed '/^$/d'
  }

  pause_player() {

      local active_player=$(player_active)

      case $active_player in
      "spotify")
          playerctl -p $active_player play-pause
          ;;
      "mpd")
          mpc toggle
          ;;
      firefox* | *brave* | chromium*)
          case $(music_playing_state) in
          "Playing")
              playerctl -ps spotify play-pause || mpc toggle
              notify-send -i /home/malu/Shibuya/assets/icons/icons8-pause-50.png "Music paused "
              ;;
          *)
              playerctl -ps firefox play-pause
              # notify-send "Nothing is playing right now"
              ;;
          esac
          ;;
      *)
          playerctl -ps "$(active_player)" play-pause
          ;;
      esac
  }

  pause_player
''
