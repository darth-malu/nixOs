{ pkgs }:

pkgs.writeShellScriptBin "mpris_vol" ''
  msgTag="mpris_volume"

  convert_to_percentage() {
    printf "%.0f" "$(bc <<< "scale=2; $1 * 100")" # printf "%.0f" "$(echo "scale=2; $1 * 100" | bc)"
  }

  get_volume() {
    convert_to_percentage "$(playerctl volume)"
  } # remove need for local volume in every case block

  player_volume() {

      local current_player=$(playerctl metadata --format '{{ playerName }}')

      case "$current_player" in
      "spotify")
          # needs to be absolute path for dunstify to work
          playerctl -p "$current_player" volume 0.02"$1"
          dunstify -t 1000 -a "changeVolume" -u low \
            -i $HOME/Shibuya/assets/icons/icons8-spotify-gradient/icons8-spotify-50.png \
            -h string:x-dunst-stack-tag:$msgTag "Spotify           " \
            -h int:value:"$(get_volume)"
            # -h string:x-dunst-stack-tag:$msgTag "Spotify            $(get_volume)" \
          ;;
      "Lollypop")
          playerctl -p "$current_player" volume 0.02"$1"
          volume=$(convert_to_percentage "$(playerctl volume)")
          dunstify -t 1000 -a "changeVolume" -u low \
            -i $HOME/Shibuya/assets/icons/icons8-candy-50.png \
            -h string:x-dunst-stack-tag:$msgTag "Lollypop                  " \
            -h int:value:"$(get_volume)"
          ;;
      "mpd")
          mpc volume "$1"2
          songart "ncmpcpp_volume"
          ;;
      "mpv")
          playerctl -p "$current_player" volume 0.02"$1"
          volume=$(convert_to_percentage "$(playerctl volume)")
          dunstify -t 1000 -a "changeVolume" -u low \
            -i $HOME/Shibuya/assets/icons/mpv.256x253.png \
            -h string:x-dunst-stack-tag:$msgTag "MPV                  " \
            -h int:value:"$(get_volume)"
            # -h string:x-dunst-stack-tag:$msgTag "MPV                  $(get_volume) " \
          ;;
      "chromium"*)
          playerctl -p "$current_player" volume 0.02"$1"
          volume=$(convert_to_percentage "$(playerctl volume)")
          dunstify -t 1000 -a "changeVolume" -u low \
            -i $HOME/Shibuya/assets/icons/icons8-chrome-office-l/icons8-chrome-30.png \
            -h string:x-dunst-stack-tag:$msgTag "Chrome                  " \
            -h int:value:"$(get_volume)"
            # -h string:x-dunst-stack-tag:$msgTag "Chrome                  $(get_volume)" \
          ;;
      *)
          playerctl -p "$current_player" volume 0.02"$1"
        # Optional: Add a generic notification for other players
         dunstify -t 1000 -a "changeVolume" -u low "Volume changed"
        ;;
      esac
  }

  player_volume "$1"
''
