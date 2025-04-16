{ pkgs }:

pkgs.writeShellScriptBin "songart" ''
  msgTag='mpris'

  generate_preview () {
      local musicDir="/home/malu/Music"
      local previewDir="/home/malu/Music/ncmpcppStuff/previews"
      local current_file="$(${pkgs.mpc}/bin/mpc --format $musicDir/%file% current )"
      local album_base64="$(${pkgs.mpc}/bin/mpc --format %album% current | base64).png"
      local preview_path="$previewDir/$album_base64"

      [ -e "$preview_path" ] || ${pkgs.ffmpeg-full}/bin/ffmpeg -y -i "$current_file" -an -vf scale=128:128 "$preview_path" > /dev/null 2>&1
      echo "$preview_path" # ready image for dunst 🤪

      # NOTE: works beautifully
      # ffmpeg -y -i "$(mpc --format $HOME/Music/%file% current)" -an -vf scale=128:128 "/home/malu/Music/ncmpcppStuff/previews/$(mpc --format %album% current |base64).png" &> /dev/null
  }

  dunstify_preview() {
    local album_art
    album_art="$(generate_preview)"
    ${pkgs.libnotify}/bin/notify-send -h string:x-dunst-stack-tag:$msgTag \
      -t 1600 "$(mpc --format '[[󰎍    %title%  \n][      %audioformat%]\n   %artist%  \n    %album%  ]] | [%file%]' current)" \
      -i "$album_art"
  }

  mode() {
      local album_art
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
              -h string:x-dunst-stack-tag:$msgTag "$title_artist" \
              -h int:value:"$volume"
              ;;
          *)
              dunstify_preview
              ;;
      esac
  }

  mode "$1"
''
