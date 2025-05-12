{ pkgs }:

pkgs.writeShellScriptBin "songart" ''
  msgTag="mpris_volume"

  generate_preview () {
    local musicDir="/home/malu/Music"
    local previewDir="/home/malu/Music/ncmpcppStuff/previews"
    local current_file="$(${pkgs.mpc}/bin/mpc --format $musicDir/%file% current )"
    local album_base64="$(${pkgs.mpc}/bin/mpc --format %album% current | base64).png"
    local preview_path="$previewDir/$album_base64"
    [ -e "$preview_path" ] || ${pkgs.ffmpeg-full}/bin/ffmpeg -y -i "$current_file" -an -vf scale=128:128 "$preview_path" 2> /dev/null
    # echo "$preview_path" # ready image for dunst 🤪
    printf '%s' "$preview_path"
  }

  convert_to_percentage() {
    printf "%.0f" "$(bc <<< "scale=2; $1 * 100")" # printf "%.0f" "$(echo "scale=2; $1 * 100" | bc)"
  }

  get_volume() {
    convert_to_percentage "$(playerctl volume)"
  } # remove need for local volume in every case block, very neat 🫠

  spotify_art() {
    local cover_dir="/tmp/spotify_covers"
    local cover_path album_art track_id metadata

    # track_id=$(playerctl -p spotify metadata mpris:trackid | sed 's/.*\///') # Extract track ID
    metadata=$(playerctl -p spotify metadata)
    # track_id=$(awk -F'/' '/mpris:trackid/ {print $NF}' <<< "$metadata") #TODO learn awk well
    track_id=$(printf '%s\n' "$(grep 'trackid' <(playerctl -p spotify metadata))")
    track_id=''${track_id##*/}
    cover_path="$cover_dir/$track_id.jpeg"
    # album_art=$(grep 'artUrl' <(playerctl -p spotify metadata) | tr -s '[:space:]' | cut -f3 -d ' ')
    album_art=$(grep 'artUrl' <(playerctl -p spotify metadata))
    album_art=''${album_art##* }
    # track_id=$()
    # album_art=$(awk '/mpris:artUrl/ {print $2}' <<< "$metadata")
    # album_art=$(playerctl -p spotify metadata mpris:artUrl)

    # download art if not exists
    if [[ ! -f "$cover_path" ]]; then
      # Create the directory if it doesn't exist
      mkdir -p "$cover_dir"
      # curl
      curl -s "$album_art" -o "$cover_path"
    fi

    case $1 in
      "art")
        printf '%s' "$cover_path"
        ;;
      "title")
        local title="$(playerctl -p spotify metadata --format '󰎍    {{title}}\n    {{artist}}\n    {{album}}')"
        printf '%b' "$title"
        ;;
    esac
  }

  dunstify_preview() {
    local mpd_album_art="$(generate_preview)"
    local mpd_format="$(mpc --format '[[󰎍    %title%  \n][      %audioformat%]\n   %artist%  \n    %album%  ]] | [%file%]' current)"
    local spotify_format=$(printf '%b' "$(playerctl metadata --format '󰎍    {{title}}\n   {{artist}}\n    {{album}}')")
    # local spotify_album_art=$(playerctl -p spotify metadata mpris:artUrl)
    local art=$(spotify_art 'art')

    # check if mpd/ncmpcpp
    if [[ "$(playerctl -p mpd status)" == "Playing" ]]; then
      ${pkgs.libnotify}/bin/notify-send -h string:x-dunst-stack-tag:$msgTag \
        -t 1600 "$mpd_format" \
        -i "$mpd_album_art"
    # check spotify
    elif [[ "$(playerctl -p spotify status)" == "Playing" ]]; then
        ${pkgs.libnotify}/bin/notify-send -h string:x-dunst-stack-tag:$msgTag \
          -t 1600 "$spotify_format" \
          -i "$art"
    fi
  }


  mode() {
      local album_art art
      local volume
      local title_artist

      case $1 in
          "ncmpcpp_volume")
            album_art="$(generate_preview)"
            volume="$(${pkgs.mpc}/bin/mpc volume | tr -cd '[:digit:]')"
            title_artist="$(${pkgs.mpc}/bin/mpc --format "%title%\t󰎍\t$volume\t" current)"
            ${pkgs.libnotify}/bin/notify-send \
              -t 1000 -a "changeVolume" \
              -u low \
              -i "$album_art" \
              -h string:x-dunst-stack-tag:$msgTag \
              "$title_artist" \
              -h int:value:"$volume"
              ;;
          "spotify_volume")
              # echo "/tmp/cover.jpeg"
              art=$(spotify_art 'art')
              local title=$(spotify_art 'title')

              ${pkgs.libnotify}/bin/notify-send \
                -t 1000 -a "changeVolume" \
                -u low \
                -i "$art" \
                -h string:x-dunst-stack-tag:$msgTag \
                "$title" \
                -h int:value:"$(get_volume)"
                ;;
          *)
              dunstify_preview 2> /dev/null # no players found err bleed into ncmpcpp
              ;;
      esac
  }

  mode "$1"
''
