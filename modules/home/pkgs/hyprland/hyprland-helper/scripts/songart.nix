{ pkgs }:

pkgs.writeShellScriptBin "songart" ''
  msgTag="mpris_volume"

  generate_preview () {
    local current_file album
    local musicDir="/home/malu/Music"
    local previewDir="/home/malu/Music/ncmpcppStuff/previews"
    local preview_path="$previewDir/$album_base64"

    read -r current_file album <<< "$(${pkgs.mpc}/bin/mpc --format "$musicDir"/%file%'\t'%album% current)"
    album_base64="$(printf '%s' $album | base64).png"

    [ -f "$preview_path" ] || ${pkgs.ffmpeg}/bin/ffmpeg -y -i "$current_file" -an -vf scale=128:128 "$preview_path" &> /dev/null

    printf '%s' "$preview_path"
  }

  get_volume() {
    awk "BEGIN { printf \"%.0f\", $(playerctl volume) * 100 }"
  }

  spotify_artUrl() {
    playerctl -p spotify metadata --format '{{mpris:artUrl}}'

  }

  spotify_metadata_formatted() {
    printf '%b' "$(playerctl -p spotify metadata --format '󰎍    {{title}} \n   {{artist}} \n    {{album}} ')"
  }

  spotify_track_id() {
    playerctl -p spotify metadata --format '{{mpris:trackid}}' | awk -F/ '{print $NF}'
  }

  spotify_cover_path() {
    cover_dir="/tmp/spotify_covers"
    track_id=$(spotify_track_id)
    printf '%s' "$cover_dir/$track_id.jpeg"
  }

  spotify_title() {
    playerctl -p spotify metadata --format '     {{title}}\n    {{artist}}\n     {{album}}'
  }

  spotify() {
    local album_art="$(spotify_artUrl)"
    local cover_path="$(spotify_cover_path)"
    # download art if not exists
    if [[ ! -f "$cover_path" ]]; then
      # Create the directory if it doesn't exist
      mkdir -p "/tmp/spotify_covers"
      # curl
      curl -s "$album_art" -o "$cover_path"
    fi

    case $1 in
      "art")
        printf '%b' "$cover_path"
        ;;
      "title")
        spotify_metadata_formatted
        ;;
    esac
  }

  mpd_metadata_formatted() {
    mpc --format '[[󰎍    %title% \n][      %audioformat%] - %position% \n   %artist%  \n    %album%  ]] | [%file%]' current
  }

  dunstify_preview() {
    # check if mpd/ncmpcpp
    if [[ "$(playerctl -p mpd status)" == "Playing" ]]; then
      local mpd_album_art="$(generate_preview)"
      local mpd_format="$(mpd_metadata_formatted)"
      ${pkgs.libnotify}/bin/notify-send -h string:x-dunst-stack-tag:$msgTag \
        -t 1600 "$mpd_format" \
        -i "$mpd_album_art"
    # check spotify
    elif [[ "$(playerctl -p spotify status)" == "Playing" ]]; then
        local spotify_format=$(spotify_metadata_formatted)
        local spotify_art=$(spotify 'art')
        ${pkgs.libnotify}/bin/notify-send -h string:x-dunst-stack-tag:$msgTag \
          -t 1600 "$spotify_format" \
          -i "$spotify_art"
    fi
  }

  mode() {
    local volume album_art title_artist art title

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
            art="$(spotify 'art')"
            title=$(spotify 'title')
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
