{ pkgs }:

pkgs.writeShellScriptBin "mpris_vol" ''
  msgTag="mpris_volume"

  convert_to_percentage() {
    printf "%.0f" "$(bc <<< "scale=2; $1 * 100")" # printf "%.0f" "$(echo "scale=2; $1 * 100" | bc)"
  }

  get_volume() {
    convert_to_percentage "$(playerctl volume)"
  } # remove need for local volume in every case block, very neat 🫠

  player_volume() {
      local current_player=$(playerctl metadata --format '{{ playerName }}')

      case "$current_player" in
      "spotify")
          playerctl -p "$current_player" volume 0.04"$1"
          album_art=$(playerctl -p spotify metadata mpris:artUrl)
          track_id=$(playerctl -p spotify metadata mpris:trackid | sed 's/.*\///') # Extract track ID
          local cover_dir="/tmp/spotify_covers"
          local cover_path="$cover_dir/''${track_id}.jpeg"

          # Create the directory if it doesn't exist
          mkdir -p "$cover_dir"

          # download art if not exists
          if [[ ! -f "$cover_path" ]]; then
            curl -s "$album_art" --output "$cover_path"
          fi

          # echo "/tmp/cover.jpeg"
          dunstify -t 1000 -a "changeVolume" -u low \
            -i "$cover_path" \
            -h string:x-dunst-stack-tag:$msgTag "$track_id " \
            -h int:value:"$(get_volume)"
          ;;
      "Lollypop")
          playerctl -p "$current_player" volume 0.02"$1"
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
          playerctl -p "$current_player" volume 0.04"$1"
          dunstify -t 1000 -a "changeVolume" -u low \
            -i $HOME/Shibuya/assets/icons/mpv.256x253.png \
            -h string:x-dunst-stack-tag:$msgTag "MPV                  " \
            -h int:value:"$(get_volume)"
            # -h string:x-dunst-stack-tag:$msgTag "MPV                  $(get_volume) " \
          ;;
      "chromium"*)
          playerctl -p "$current_player" volume 0.02"$1"
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
