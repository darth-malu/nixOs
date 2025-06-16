{ pkgs }:

pkgs.writeShellScriptBin "volume_dunst" ''
  msgTag="myvolume"
  shibuya_icons="$HOME/Shibuya/assets/icons"
# set -e # Exit immediately if a command exits with a non-zero status

  declare -A icons=(
      [unmute]="$shibuya_icons/mute-unmute/icons8-lol-office-m/icons8-lol-30.png"
      [mute]="$shibuya_icons/mute-unmute/silent/icons8-silent-30.png"
      [max_volume]="$shibuya_icons/icons8-audio-bubbles/icons8-audio-100.png"
      [volume_zero]="$shibuya_icons/vol_zero.png"
      [speaker]="$shibuya_icons/icons8-speaker-40.png"
      [bluetooth]="$shibuya_icons/icons8-bluetooth-windows-11-color/icons8-bluetooth-48.png"
      [earphones]="$shibuya_icons/icons8-airpods-pro-max-windows-11-color/icons8-airpods-pro-max-48.png"
  )

  function pic_ejecter() {
    echo "''${icons[$1]}"
  }

  # cache wpctl status once
  WPCTL_STATUS=$(wpctl status)

  sink_getter() {
      case "$1" in
        "speaker") grep -A3 -e Sinks <<< "$WPCTL_STATUS" | grep -e 'Family' -e 'Built' | grep -Po '\d+' | head -n1 ;;
        "bluetooth") grep -A3 -e Sinks <<< "$WPCTL_STATUS" | grep -e 'X100' | grep -Po '\d+' | head -n1 ;;
        "earphones") grep -A3 -e Sinks <<< "$WPCTL_STATUS" | grep -e 'Ellesmere' | grep -Po '\d+' | head -n1 ;; # FIXME: correct regex
        "easy") grep -A3 -e Sinks <<< "$WPCTL_STATUS" | grep -e 'Easy Effects' | grep -Po '\d+' | head -n1 ;;
      esac
  } # return sink number eg. 58

  unconverted_volume() {
      wpctl get-volume @DEFAULT_SINK@ # outputs volume: 0.00-1.00 eg. volume: 0.46
  }

  volume_percentage() {
      awk '{printf "%.0f\n", $2 * 100}' <<< "$(unconverted_volume)"
  }

  mute_status() {
      # cut -d ' ' -f3 <(unconverted_volume) | tr -d '[]' # outputs MUTED if true, blank otherwise
    # unconverted_volume | grep -q '\[MUTED\]' && printf "MUTED\n"
    unconverted_volume | grep -q '\[MUTED\]' # True if Muted, False Otherwise
  }

  current_sink() { # use * to match current
      wpctl status |grep -Eo '\*\s+[0-9]+\.' | tr -cd '[:digit:]'
  }

  sink_switcher() {
    local sink_id
    sink_id=$(sink_getter "$1")
    [[ -n $sink_id ]] && wpctl set-default "$sink_id"
    dunstify -t 1000 -a "changeVolume" -u low -i "$(pic_ejecter "$1")" -h string:x-dunst-stack-tag:$msgTag "Switched to ''${1^}"
  }

  dunst_func() {
    local int_volume current_sink_id
    # current_sink_id=$(current_sink)
    int_volume=$(volume_percentage)

    if [[ "$1" == "add_sub" ]]; then
        if [[ "$int_volume" -eq 0 ]]; then
            dunstify -t 1000 -a "changeVolume" -u low -i "$(pic_ejecter volume_zero)" -h string:x-dunst-stack-tag:$msgTag "Volume Zero"
        elif [ "$int_volume" -eq 100 ]; then
            dunstify -t 1000 -a "changeVolume" -u low -i "$(pic_ejecter max_volume)" -h string:x-dunst-stack-tag:$msgTag "Volume Maxxed"
        else
            dunstify -t 1000 -a "changeVolume" -u low -i "$(pic_ejecter speaker)" -h string:x-dunst-stack-tag:$msgTag -h int:value:"$int_volume" "$int_volume"
        fi
    elif [[ "$1" == "mute" ]]; then
      local icon message

      if mute_status; then
          wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
          icon=$(pic_ejecter unmute)
          message="Unmuted"
      else
          wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
          icon=$(pic_ejecter mute)
          message="MUTED"
      fi

      dunstify -t 1000 -a "changeVolume" -u low -i "$icon" -h string:x-dunst-stack-tag:$msgTag "$message"
    fi
  }

  set_volume() {
      case "$1" in
      "toggle_mute") dunst_func mute ;;
      speaker|earphones|easy|bluetooth) sink_switcher "$1" ;;
      *) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "$1" >/dev/null 2>&1; dunst_func add_sub ;;
      esac
  }

  set_volume "$1"
''
