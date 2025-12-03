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
      # local currentPlayer=$(playerctl metadata --format '{{ playerName }}' | sed '/^$/d')
      local currentPlayer=$(playerctl metadata --format '{{ playerName }}')
      printf '%s' "$currentPlayer"
      # if [[ $currentPlayer == 'com*' ]];then
      #     return 0;
      # else echo "$currentPlayer"
      # fi
  }

  pause_player() {

      local active_player=$(player_active)

      case "$active_player" in
      "spotify" | "mpd")
          # playerctl -p $active_player play-pause
          playerctl -ps spotify play-pause || playerctl -ps mpd play-pause
          ;;
      # "mpd")
      #     mpc toggle
      #     ;;
      "com*")
          playerctl -ps spotify play-pause || playerctl -ps mpd play-pause
          ;;
      firefox* | chromium*)
          case $(music_playing_state) in
          "[Pp]laying")
              # playerctl -ps spotify play-pause || mpc toggle
              playerctl -ps spotify play-pause || playerctl -ps mpd play-pause
              # playerctl -a play-pause
              notify-send -i /home/malu/Shibuya/assets/icons/icons8-pause-50.png "Music paused "
              ;;
          *)
              playerctl -ps firefox play-pause || playerctl -ps chromium play-pause
              # notify-send "Nothing is playing right now"
              ;;
          esac
          ;;
      *)
          playerctl -ps "$active_player" play-pause
          ;;
      esac
  }

  pause_player
''
