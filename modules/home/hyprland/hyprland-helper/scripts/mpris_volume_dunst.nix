{ pkgs }:

pkgs.writeShellScriptBin "mpris_vol" ''
  msgTag="mpris_volume"

  convert_to_percentage() {
      # local value=$1
      # local percentage
      #
      # percentage=$(echo "scale=2; $value * 100 / 1" | bc)
      # printf "%.0f" "$percentage" # returns % eg 90
      # echo "scale=2; $1 * 100" | bc | xargs printf '%.0f'
      # printf "%.0f%" "echo $(scale=2 $1 * 100 | bc)"
      printf "%.0f" "echo $(scale=2 $1 * 100 | bc)"
  }

  playerctl_add_sub() {
      playerctl -p "$1" volume 0.02"$2"
  }

  mpc_add_sub() {
      mpc volume "$1"2 >/dev/null
  }

  # query_playerctl() {
  #     playerctl -l
  # }

  # current_volume() {
  # convert_to_percentage "$(playerctl -p "$1" volume)" # convert %0.2f (eg. 0.54000) into percentage out of 1
  # specific player not needed since it will auto pick current one
  # }

  player_volume() {
      local current_player=$(playerctl metadata --format '{{ playerName }}')
      # local volume=$(current_volume "$current_player")
      local volume=$(convert_to_percentage$(playerctl volume))

      # local add_minus=$1 # intakes + or -

      case $current_player in
      "spotify")
          # volume=$(current_volume "$current_player")
          playerctl -p "$current_player" volume 0.02"$1"
          dunstify -t 1000 -a "changeVolume" -u low \
            -i ../../../../assets/icons/icons8-spotify-gradient/icons8-spotify-50.png \
            -h string:x-dunst-stack-tag:$msgTag "Spotify                  $volume   " \
            -h int:value:"$volume"
          ;;
      "Lollypop")
          # playerctl_add_sub "$current_player" "$add_minus"
          # volume=$(current_volume "$current_player")
          playerctl -p "$current_player" volume 0.02"$1"
          dunstify -t 1000 -a "changeVolume" -u low \
            -i ../../../../assets/icons/icons8-spotify-gradient/icons8-spotify-50.png \
            -h string:x-dunst-stack-tag:$msgTag "Lollypop                  $volume" \
            -h int:value:"$volume"
          ;;
      "mpd")
          mpc volume "$1"1 && songart "ncmpcpp_volume"
          # mpc volume "+1" "$1" && songart "ncmpcpp_volume" >/dev/null # TODO: cant display with no album art art feature lol unless use playerctl
          ;;
      "mpv")
          # playerctl_add_sub "$current_player" "$add_minus"
          playerctl -p "$current_player" volume 0.02"$1"
          dunstify -t 1000 -a "changeVolume" -u low \
            -i ../../../../assets/icons/icons8-spotify-gradient/icons8-spotify-50.png \
            -h string:x-dunst-stack-tag:$msgTag "MPV                  $volume" \
            -h int:value:"$volume"
          ;;
      "chromium"*)
          # playerctl_add_sub "$current_player" "$add_minus"
          # volume=$(current_volume "$current_player")
          playerctl -p "$current_player" volume 0.02"$1"
          dunstify -t 1000 -a "changeVolume" -u low \
            -i ../../../../assets/icons/icons8-spotify-gradient/icons8-spotify-50.png \
            -h string:x-dunst-stack-tag:$msgTag "Chrome                  $volume" \
            -h int:value:"$volume"
          ;;
      *)
          playerctl -p "$current_player" volume 0.02"$1"
      esac
  }

  player_volume "$1"
''
