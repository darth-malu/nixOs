{pkgs}:

pkgs.writeShellScriptBin "mpris_vol" ''
msgTag="mpris_volume"

convert_to_percentage() {
  # local value=$1
  # local percentage
  #
  # percentage=$(echo "scale=2; $value * 100 / 1" | bc)
  # printf "%.0f" "$percentage" # returns % eg 90
  echo "scale=2; $1 * 100" | bc | xargs printf '%.0f'
}

playerctl_add_sub () {
    playerctl -p "$1" volume 0.02"$2"
}

mpc_add_sub () 
{
    # mpc volume "$1"2 > /dev/null
    mpc volume "$1" > /dev/null
}

query_playerctl () {
    playerctl -l
}

current_volume () {
    convert_to_percentage "$(playerctl -p "$1" volume)"
}

player_volume () {
    local current_player
    local volume

    current_player=$(playerctl metadata --format '{{ playerName }}')
    local add_minus=$1

    case $current_player in
        "spotify")
            playerctl_add_sub "$current_player" "$add_minus" 
            volume=$(current_volume "$current_player")
            dunstify -t 1000 -a "changeVolume" -u low -i ~/.darth/iconss/spotify.png -h string:x-dunst-stack-tag:$msgTag "Spotify                  $volume   " -h int:value:"$volume"
            ;;
        "Lollypop")
            playerctl_add_sub "$current_player" "$add_minus" 
            volume=$(current_volume "$current_player")
            dunstify -t 1000 -a "changeVolume" -u low -i ~/.darth/iconss/lolly.png -h string:x-dunst-stack-tag:$msgTag "Lollypop                  $volume" -h int:value:"$volume"
            ;;
        "mpd")
            mpc_add_sub "$add_minus" && songart "ncmpcpp_volume" #TODO: cant display with no album art art feature lol
            ;;
        "chromium")
            playerctl_add_sub "$current_player" "$add_minus" 
            volume=$(current_volume "$current_player")
            dunstify -t 1000 -a "changeVolume" -u low -i ~/.darth/iconss/lolly.png -h string:x-dunst-stack-tag:$msgTag "Lollypop                  $volume" -h int:value:"$volume"
            ;;
    esac
}

player_volume "$1"
''
