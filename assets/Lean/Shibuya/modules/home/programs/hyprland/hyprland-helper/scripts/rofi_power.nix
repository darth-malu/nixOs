{ pkgs }:

pkgs.writeShellScriptBin "rofi_power" ''
  shutdown="⏻  Shutdown"
  reboot="  Reboot"
  lock="🔒 Lock" #
  suspend="💤  Suspend" # 󰒲
  timer="⏰ Timer" #󱫣󰔞
  cancel="❌  Cancel"

  yes="✅"
  no="⛔"
  # yes='  ja'
  # no='  nein'

  RESTART="⏻"
  SHUT=""

  main_window() {
    rofi -dmenu \
      -p "$(uptime | awk '{print $1}')" \
      -theme-str 'window {anchor: west; location: west; fixed-columns: false;  width: 350px; padding: 0px; margin: 0px; border: 0px;}' \
      -theme-str 'listview {columns: 2; lines: 3; fixed-column: false; cycle: true; padding: 0px; margin: 0px; border: 0px;}' \
      -theme-str 'inputbar {horizontal-align: 0.0; border: 0px; children: [ "prompt","entry" ];}' \
      -theme-str 'prompt {font: "Monofur Nerd Font 13";}' \
      -theme-str 'entry {expand: false; horizontal-align: 0.0; border: 0; blink: false;cursor-color: rgb(220,20,60);cursor-width: 0px;}' \
      -theme-str 'element {padding: 6px 0px;}' \
      -theme-str 'element-text {vertical-align: 0.5; horizontal-align: 0.0; padding: 0px;}' \
      -i
  }

  main_window_options() {
    printf "%s\n%s\n%s\n%s\n%s\n%s\n" \
      "$lock" "$reboot" "$suspend" "$shutdown" "$timer" "$cancel" | main_window
  }

  restart_shutdown_timer_picker() {
    rofi -dmenu \
      -theme-str 'window {location: west; anchor: west;  fullscreen: false; padding:0px; margin: 0px; border: 0px;}' \
      -theme-str 'mainbox {children: [ "listview" ];}' \
      -theme-str 'listview {dynamic: false; columns: 2; fixed-columns: false; cycle: "true"; layout: horizontal;}' \
      -theme-str 'element {horizontal-align: 0.0;border: 0;width: 130px; margin:0;}' \
      -theme-str 'element-text {font: "Symbols Nerd Font 38"; padding: 0px 0px; horizontal-align: 0.0;}'
  }

  ndio_au_la() {
    rofi -dmenu \
      -theme-str 'window {location: west; anchor: west; fullscreen: false; border: 0px; fixed-height: false; dynamic: false; width: 200px;}' \
      -theme-str 'mainbox {children: [ "message", "listview" ];}' \
      -theme-str 'listview {columns: 2; lines: 1; layout : horizontal; fixed-columns: false;}' \
      -theme-str 'element {orientation: horizontal; padding: 0; margin: 4;}' \
      -theme-str 'element-text {horizontal-align: 0.0; orientation: horizontal; width: 100px;}' \
      -theme-str 'textbox {horizontal-align: 0.0;}' \
      -mesg 'Uko sure?'
  }

  confirm_exit() {
    printf '%s\n%s\n' "$yes" "$no" | ndio_au_la
  }

  shut_or_restart() {
    printf "%s\n%s\n" "$RESTART" "$SHUT" | restart_shutdown_timer_picker
  }

  run_cmd() {
    local icons_dir="/home/malu/Shibuya/assets/icons/"
    local icon_cancel="$icons_dir/icons8-cancel-3d-plastilina/icons8-cancel-45.png"
    local icon_shutdown="$icons_dir/icons8-shutdown-office-l/icons8-shutdown-40.png"
    local icon_restart="$icons_dir/icons8-restart-50.png"

    case $1 in
    "timer") #TODO add timers for 2...10 timers and custom one
      case "$(shut_or_restart)" in
      "$RESTART")
        #notify-send "Restart in 5 min"
        notify-send "Restarting in 5min " -i "$icon_restart"
        canberra-gtk-play -i service-logout
        shutdown -r +3
        ;;
      "$SHUT")
        notify-send "Shutting Down in 5min  " -i "$icon_shutdown"
        canberra-gtk-play -i service-logout
        shutdown +3
        ;;
      esac
      ;;
    "cancel")
      notify-send "Shutdown -c (cancelled)  " -i "$icon_cancel"
      canberra-gtk-play -i window-attention
      shutdown -c
      ;;
    *)
      if [ "$(confirm_exit)" = "$yes" ]; then
        case $1 in
        '--shutdown') systemctl poweroff ;;
        '--reboot') systemctl reboot ;;
        '--suspend')
          mpc -q pause
          amixer set Master mute
          systemctl suspend
          ;;
        esac
      else
        exit 0
      fi
      ;;
    esac
  }

  case "$(main_window_options)" in
  "$shutdown") run_cmd --shutdown ;;
  "$reboot") run_cmd --reboot ;;
  "$lock") hyprlock ;;
  "$suspend") run_cmd --suspend ;;
  "$timer") run_cmd timer ;;
  "$cancel") run_cmd cancel ;;
  esac
''
