{ pkgs }:

pkgs.writeShellScriptBin "volume_dunst" ''
    shibuya_icons="$HOME/Shibuya/assets/icons"
  # set -e # Exit immediately if a command exits with a non-zero status

    declare -A icons=(
        [unmute]="$shibuya_icons/mute-unmute/icons8-lol-office-m/icons8-lol-30.png"
        [mute]="$shibuya_icons/mute-unmute/silent/icons8-silent-30.png"
        [volume_zero]="$shibuya_icons/vol_zero.png"
    )

    function pic_ejecter() {
      echo "''${icons[$1]}"
    }

    # cache wpctl status once
    WPCTL_STATUS=$(wpctl status)

    mute_status() {
        wpctl get-volume @DEFAULT_SINK@ | grep -q '\[MUTED\]' # wpctl get-volume outputs -> volume: 0.00-1.00 || volume: 0.46 True if Muted, False Otherwise
    }

    mute_all() {
        local message icon

        case "$1" in
          mute)
            if mute_status; then
              wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
              icon=$(pic_ejecter unmute) # 🫢
              message="Unmuted"
            else
              wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
              icon=$(pic_ejecter mute)
              message="MUTED"
            fi
            notify-send -t 1000 -a "changeVolume" -i "$icon" "$message" -u low
            ;;
        esac
    }

     mute_all mute

''
