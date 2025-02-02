{pkgs}:

pkgs.writeShellScriptBin "volume_dunst" ''
msgTag="myvolume"
# msg="audio_device"

sink_getter() {
  # wpctl status | grep -A3 Sinks | sed '/--/q' | grep -e "$1" -e "$2" | grep -Eo '[0-9]+\.\s+[a-zA-Z]+' | tr -cd '[:digit:]'
  # wpctl status | grep -A3 Sinks | grep -e "$1" -e "$2" | grep -Eo '[0-9]+\.\s+[a-zA-Z]+' | tr -cd '[:digit:]'
  # wpctl status | grep -A3 Sinks | grep -e "$1" -e "$2" | grep -Eo '[0-9]+\.\s+[a-zA-Z]+' | tr -cd '[:digit:]'
  # wpctl status | grep -A3 Sinks | grep -e "$1" -e "$2" | grep -Eo '[0-9]+\.\s+[a-zA-Z]+' | tr -cd '[:digit:]'
  # wpctl status | grep -A3 Sinks | sed /--/q | grep -e "$1" -e "$2"| grep -Eo '\s+[0-9]+.\s+' | tr -cd '[:digit:]'
  #
  # wpctl status | grep -A3 Sinks | sed /--/q | grep -e "$1" -e "$2"| grep -Eo '^|.+\s+[0-9]+\.\s' | tr -cd '[:digit:]'
  wpctl status | grep -e "$1" -e "$2" | grep -Eo '\*\s+[0-9]+' | tr -cd '[:digit:]'
} # return sink number eg. 58

speaker_ID=$(sink_getter 'Family 17h' 'Built-in')
bt_ID=$(sink_getter 'X100' 'null')
earphones_ID=$(sink_getter 'Ellesmere HDMI' 'null')
easy_sink_ID=$(sink_getter 'Easy Effects' 'null')

shibuya_assets="/home/malu/Shibuya/modules/home/scripts/assets/"
speaker_pic="$shibuya_assets/icons8-speaker-40.png"
bt_pic="$shibuya_assets/icons8-bluetooth-windows-11-color/icons8-bluetooth-30.png"
ear_pic="$shibuya_assets/icons8-airpods-pro-max-windows-11-color/icons8-airpods-pro-max-30.png"

unmute_pic="$shibuya_assets/icons8-lol-office-m/icons8-lol-30.png"
mute_pic="$shibuya_assets/silent/icons8-silent-30.png"
max_volume="$shibuya_assets/icons8-audio-40.png"
volume_zero="$shibuya_assets/vol_zero.png"

get_volume () {
  wpctl get-volume @DEFAULT_SINK@ | awk '{printf "%.0f\n", $2 * 100}'
}

get_mute_status () {
  wpctl get-volume @DEFAULT_SINK@ | cut -d ' ' -f3 | tr -d '[]' # outputs MUTED if true, blank otherwise
}

get_current_sink () { # use * to match current
  # wpctl status |grep -A3 Sinks|sed "/--/q"| grep -Eo "\*\s+[0-9]+" | tr -cd '[:digit:]' #simplify with sed only instead?
  wpctl status | grep -A3 -e Sinks | sed /--/q | grep -Eo '\* +[0-9]+' | tr -cd '[:digit:]'
}

sink_switcher (){
    case $1 in
        "speaker")
            wpctl set-default "$speaker_ID"
            dunstify -t 1000 -a "changeVolume" -u low -i  "$speaker_pic" -h string:x-dunst-stack-tag:$msgTag "         Speakers "
            ;;
        "earphones")
            wpctl set-default "$earphones_ID"
            dunstify -t 1000 -a "changeVolume" -u low -i  "$ear_pic" -h string:x-dunst-stack-tag:$msgTag "        Earphones  "
            ;;
        "bluetooth")
            wpctl set-default "$bt_ID"
            dunstify -t 1000 -a "changeVolume" -u low -i  "$bt_pic" -h string:x-dunst-stack-tag:$msgTag "        Bluetooth  "
            ;;
    esac
}

dunst_func() {
    local int_volume
    local output_medium
    local mute_status
    # local mute_pic
    output_medium=$(get_current_sink)
    int_volume=$(get_volume)
    mute_status=$(get_mute_status)

    case $1 in
        "add_sub")
            if [ "$int_volume" -eq 0 ];then
                dunstify -t 1000 -a "changeVolume" -u low -i "$volume_zero" -h string:x-dunst-stack-tag:$msgTag "Volume Zero "
            elif [ "$int_volume" -eq 100 ];then
                dunstify -t 1000 -a "changeVolume" -u low -i "$max_volume" -h string:x-dunst-stack-tag:$msgTag "Volume Maxxed out "
            else
                case $output_medium in
                # case $(get_current_sink) in
                    "$speaker_ID")#TODO: add volume ranges
                        dunstify -t 1000 -a "changeVolume" -u low -i "$speaker_pic" -h string:x-dunst-stack-tag:$msgTag -h int:value:"$int_volume" "$int_volume"
                        ;;
                    "$earphones_ID")
                        dunstify -t 1000 -a "changeVolume" -u low -i "$ear_pic" -h string:x-dunst-stack-tag:$msgTag -h int:value:"$int_volume" "$int_volume"
                        ;;
                    "$bt_ID")
                        dunstify -t 1000 -a "changeVolume" -u low -i "$bt_pic" -h string:x-dunst-stack-tag:$msgTag -h int:value:"$int_volume" "$int_volume"
                        ;;
                esac
            fi
            ;;
        "mute")
            if [ "$mute_status" = "MUTED" ];then
                wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 > /dev/null
                dunstify -t 1000 -a "changeVolume" -u low -i "$unmute_pic" -h string:x-dunst-stack-tag:$msgTag "Unmuted "
            else
                wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 > /dev/null
                dunstify -t 1000 -a "changeVolume" -u low -i $mute_pic -h string:x-dunst-stack-tag:$msgTag "MUTED "
            fi
            ;;
    esac
}

set_volume () {
    # local amount=2
    case "$1" in
        "toggle_mute")
            dunst_func mute
            ;;
        "speaker")
            sink_switcher speaker
            ;;
        "earphones")
            sink_switcher earphones
            ;;
        "bluetooth")
            sink_switcher bluetooth
            ;;
        "easy")
            sink_switcher easy
            ;;
        *)
            wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "$1" 2> /dev/null # 1.0 is 100%
            dunst_func add_sub
    esac
}

set_volume "$1"
''
