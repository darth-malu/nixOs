{ pkgs }:

pkgs.writeShellScriptBin "songart" ''
  mkdir -p "/tmp/spotify_covers"
  msgTag="mpris_volume"

  generate_preview () {
    local current_file album album_base64 preview_path musicDir
    current_file="$(mpc --format /home/malu/Music/%file% current)"
    album="$(mpc --format %album% current)"
    album_base64="$(printf '%s' $album | base64).png"
    previewDir="/home/malu/Music/ncmpcpp/previews"
    preview_path="$previewDir/$album_base64"

    [ -f "$preview_path" ] || ffmpeg -y -i "$current_file" -an -vf scale=128:128 "$preview_path" 2> /dev/null

    printf '%s' "$preview_path"
  }

  get_volume() {
    # awk "BEGIN { printf \"%.0f\", $(playerctl volume) * 100 }"
    local vol=$(playerctl volume)
    printf '%.0f' "$(echo "$vol * 100" | bc)"
  }

  spotify_artUrl() {
    playerctl -p spotify metadata --format '{{mpris:artUrl}}'
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
    playerctl -p spotify metadata --format '     {{title}}\n     {{artist}}\n     {{album}}'
  }

  spotify() {
    local album_art="$(spotify_artUrl)"
    local cover_path="$(spotify_cover_path)"


    # download art if not exists
    if [[ ! -f "$cover_path" ]]; then
      # Create the directory if it doesn't exist
      curl -s "$album_art" -o "$cover_path"
    fi

    case $1 in
      "art")
        printf '%s' "$cover_path"
        ;;
      "title")
        printf '%b' "$(playerctl -p spotify metadata --format '󰎍    {{title}} \n    {{artist}} \n    {{album}} ')"
        ;;
    esac
  }

  mpd_metadata_formatted() {
    local position=$(mpc | awk '/#/ {print $2}')
    mpc --format "[[󰎍    %title% \n] [     %audioformat%]  $position\n    %artist%  \n    %album%  ]] | [%file%]" current
  }

  songAlbumArt_preview() {
    status_playerctl="$(playerctl -p mpd status 2> /dev/null)"
    status_spotify="$(playerctl -p spotify status 2> /dev/null)"

    # check if mpd/ncmpcpp
    if [[ "$status_playerctl" == "Playing" ]]; then
      local mpd_album_art="$(generate_preview)"
      local mpd_format="$(mpd_metadata_formatted)"
      ${pkgs.libnotify}/bin/notify-send \
        -t 2 "$mpd_format" \
        -i "$mpd_album_art"
    # check spotify
    elif [[ "$status_spotify" == "Playing" ]]; then
        local spotify_format=$(spotify 'title')
        local spotify_art=$(spotify 'art')
        ${pkgs.libnotify}/bin/notify-send \
          -t 2 "$spotify_format" \
          -i "$spotify_art"
    fi
  }

  songAlbumArt_preview 2> /dev/null
''
