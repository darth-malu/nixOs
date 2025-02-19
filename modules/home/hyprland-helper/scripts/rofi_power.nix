{pkgs}:

# pkgs.writers.writeDashBin "rofi_power"
pkgs.writeShellScriptBin "rofi_power"
''
# upt="$(uptime | awk '{print $1}')"
upt="$(uptime | tr -s ' ' | cut -d ' ' -f2)"

shutdown="$(printf '⏻    Shutdown')"
reboot="$(printf '    Reboot')"
lock="$(printf '    Lock')"
suspend="$(printf '󰒲    Suspend')"
logout="$(printf '    Logout')"
timer="$(printf '󱫣    Timer')"
cancel="$(printf '󰔞    Cancel')"

yes='  ja'
no='  nein'
#no='  No'

rofi_main() {
  #-p "" \height:250px;
  rofi -dmenu \
    -p "$upt" \
    -theme-str 'window {location: west;  width: 550px; padding: 0; margin: 0;}' \
    -theme-str 'mainbox {children: [ "message","inputbar", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 3;cycle: true;}' \
    -theme-str 'inputbar {horizontal-align: 0.0; border: 0; children: [ "entry" ];}' \
    -theme-str 'entry {horizontal-align: 0.0; border: 0; blink: false;cursor-color: rgb(220,20,60);cursor-width: 0px;}' \
    -theme-str 'message {border: 0;}' \
    -theme-str 'element {orientation: horizontal;padding: 15px 0px 15px 0px; margin: 0; width: 10px;}' \
    -theme-str 'element-text {horizontal-align: 0.0;vertical-align: 0.5;}' \
    -i 
# -theme-str 'textbox {horizontal-align: 0.0;}' \
    #-mesg "$uptime" \
        #-theme-str 'element-icon { orientation: vertical;}' \
            #-theme-str 'mainbox {children: [ "message", "listview", "inputbar" ];}' 
        #for case insens :)
        #-theme-str 'mainbox {children: [ "message", "entry", "listview" ];}' \
        #-theme-str '#window {location: south west; fullscreen: false; width: 220px; font: "GeistMono Nerd Font 12"; padding: 4;border: 1;}' \
}

# default -sep is \n lul
run_rofi() {
  printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n" "$lock" "$logout" "$reboot" "$suspend" "$shutdown" "$timer" "$cancel"| rofi_main
}


confirm_exit() {
  printf '%s\n%s\n' "$yes" "$no" | confirm_actions
  #printf "%s\n%s\n" "$yes" "$no" | confirm_actions
}
#TODO: make better banner
restart_shut_timer_confirm() {
  rofi -dmenu \
    -theme-str 'window {  location: center; anchor: center; fullscreen: false; height:160;width: 220; padding:0;margin: 0;border: 0;orientation : horizontal;}' \
    -theme-str 'mainbox {children: [  "listview" ];}' \
    -theme-str 'listview { dynamic: false;columns: 2;fixed-columns : false; lines: 1; cycle: "true"; orientation : horizontal;}' \
    -theme-str 'element {horizontal-align: 0.9;border: 1;margin:0; orientation: vertical;}' \
    -theme-str 'element-text {font: "JetBrainsMono Nerd Font 38";padding: 0px 0px 25px 30px; horizontal-align: 0.0;}' \
    -theme-str 'message {border: 0;}' \
    -theme-str 'textbox {horizontal-align: 0.0;}' \
    -p 'Confirmation' \
    -mesg 'icons za restart ama zima'
}

confirm_actions() {
  rofi -dmenu \
    -theme-str 'window {location: center; anchor: west; fullscreen: false; border: 0; fixed-height: false; dynamic: false; height:90px; width: 300px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1; orientation : horizontal; fixed-columns: false;}' \
    -theme-str 'element {orientation: horizontal; padding: 0; margin: 4;}' \
    -theme-str 'element-text {horizontal-align: 0.0;orientation: horizontal;}' \
    -theme-str 'textbox {horizontal-align: 0.0;}' \
    -p 'Confirmation' \
    -mesg 'Uko sure bro?'
}

SHUT="$(printf '⏻ ')"
RESTART="$(printf ' ')"
# menu itselverticalf
shut_or_restart() {
 printf "%s\n%s" "$RESTART" "$SHUT"  | restart_shut_timer_confirm
}

# pass answer to function
# Execute Command
run_cmd() {
  case "$1" in
    # custom timer
      "timer")
        restart_shut="$(shut_or_restart)"
          case "$restart_shut" in
            "$RESTART")
              shutdown -r +5
              # systemctl reboot
              #notify-send "Restart in 5 min"
              notify-send "Restarting in 5min " \
                  -i "/home/malu/Downloads/ICONS/icons8-restart-windows-11-color/icons8-restart-96.png"#FIXME: replace with working icons
              canberra-gtk-play -i service-logout
              ;;
            "$SHUT")
              notify-send "Shutting Down in 5min  " \
                  -i "/home/malu/Downloads/ICONS/icons8-shutdown-windows-11-color/icons8-shutdown-100.png"
              shutdown +5 
              canberra-gtk-play -i service-logout
              #notify-send "Shutdown in 5 min"
            ;;
          esac
          ;;
      "cancel")
        shutdown -c
        notify-send "Shutdown -c  " \
            -i "/home/malu/Downloads/ICONS/icons8-multiply-windows-11-color/icons8-multiply-100.png"
        canberra-gtk-play -i window-attention
        ;;
      *)
        if [ "$(confirm_exit)" = "$yes" ]; then
            case "$1" in
                '--shutdown') systemctl poweroff ;;
                '--reboot') systemctl reboot ;;
                '--suspend') 
                    mpc -q pause
                    amixer set Master mute
                    systemctl suspend 
                    ;;
                '--logout') uwsm stop;; #hyprctl dispatch exit 
            esac
        else
            exit 0
        fi
        ;;
        esac
}

case "$(run_rofi)" in
  "$shutdown")run_cmd --shutdown;;
  "$reboot")run_cmd --reboot;;
  #"$lock")hyprlock;;
  "$lock")dash -c ~/.config/hypr/scripts/sway_lock_idle/lock.sh;;
  "$suspend")run_cmd --suspend;;
  "$logout")run_cmd --logout;;
  "$timer")run_cmd timer;;
  "$cancel")run_cmd cancel;;
esac
''
