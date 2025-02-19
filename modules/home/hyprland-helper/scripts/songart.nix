# {pkgs ? import <nixpkgs> {}}:
{pkgs}:

pkgs.writeShellScriptBin "songart" ''
msgTag='mpris'

generate_preview () {
    local filename
    local previewname
    local previewDir
    local musicDir

    musicDir="/home/malu/Music"
    previewDir="/home/malu/Music/ncmpcppStuff/previews"
    filename="${pkgs.mpc}/bin/mpc --format \"$musicDir\"/%file% current"
    previewname="$previewDir/$(${pkgs.mpc}/bin/mpc --format %album% current | base64).png"
    [ -e "$previewname" ] || ${pkgs.ffmpeg}/bin/ffmpeg -y -i "$filename" -an -vf scale=128:128 "$previewname" &> /dev/null 
    echo "$previewname"
}

dunstify_preview() {
  local album_art
  album_art="$(generate_preview)"
  ${pkgs.libnotify}/bin/notify-send -h string:x-dunst-stack-tag:$msgTag -t 1600 "$(mpc --format '[[󰎍    %title%  \n][      %audioformat%]\n   %artist%  \n    %album%  ]] | [%file%]' current)" -i "$album_art"
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
          ${pkgs.libnotify}/bin/notify-send -t 1000 -a "changeVolume" -u low -i "$album_art" -h string:x-dunst-stack-tag:$msgTag "$title_artist" -h int:value:"$volume"
            ;;
        *)
            dunstify_preview
            ;;
    esac
}

mode "$1"
''
