{pkgs, osConfig, ...}:

{
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      "$formated_rgba" = "$(hyprpicker -f rgb - | sed 's/^/(/; s/$/,1.0)/; y/ /,/' | wl-copy -n)";
      "$cl" = "Control_L";
      "$al" = "Alt_L";
      "$ar" = "Alt_R";
      "$cr" = "Control_R";
      "$sl" = "SHIFT_L";
      "$sr" = "SHIFT_R";
      "$date_short" = "`date +'%I:%M %p'`"; # add -u (utc)
      "$date_long" = "`date +'%a,%d %b%t%I:%M %p'`";
      "$kitty" = "uwsm app -s a -- kitty -1 --instance-group kitty";
      "$yazi_kitty" = "uwsm app -s a -- kitty -1 --instance-group yazi -e yazi";

      "$gaps" = "gaps toggle_gaps_out";
      "$emacs" = "uwsm app -s a -- emacsclient -c";

  "$file_browser_rofi" = "rofi -show filebrowser -filebrowser-command 'xdg-open' -filebrowser-directory '/home/malu' -theme '/home/malu/Shibuya/modules/home/programs/hyprland/keybinds/rofi-themes/fileBrowser.rasi'";
  "$rofi_open_windows" =  "rofi -show window -theme-str 'window {width : 920px;}' -theme-str 'listview {lines:15; dynamic: true;}' -theme-str 'element {background-image: linear-gradient(white/5%, white/10%);border-color: lightblue /15%;}'" ;
  "$menu_rofi" = "rofi -show drun -theme-str 'listview {require-input: true;}'";
  "$emoji_rofi" = "rofi -show emoji";
  "$clip_rofi" = "cliphist list | rofi -dmenu -theme-str 'window {width : 750px;}' -p '' | cliphist decode | wl-copy";
  "$calc_rofi" = "rofi -show calc -p '🪓' -theme-str 'listview {require-input: true;}'";

bindr = [

  "$mod, N, exec, [workspace emptym] uwsm app -s a -- nautilus"
  "$mod , Y, exec, [workspace emptym] $yazi_kitty"
  # "$mod $sl, Y, exec, [workspace special:magic;float true; size 80% 80%] $yazi_kitty"

"$mod $al, H, exec, hyprpicker -an"
# "$mod $al, R, exec, \"$(hyprpicker -f rgb - | sed 's/^/(/; s/$/,1.0)/; y/ /,/\' | wl-copy -n)\""

  # "$mod $al, Return, exec, $ghostty" #$terminal , wezterm, ghostty

  # copy save
  "$sl, Print, exec, grimblast --cursor --notify -e 2 copy output"
  ", Print, exec, grimblast --cursor --notify -e 2 copysave screen"
  # ", Scroll_Lock, exec, grimblast --cursor --notify copysave screen"

  # copy
  "SUPER, Print, exec, grimblast --cursor --notify -e 2  copysave output"
  "$al, Print, exec, grimblast --notify -e 2 copy area"
  "$cl, Print, exec, grimblast --cursor --notify -e 2 copy active"

];

bind =
  [
    # "$mod, F1,exec,  killall -9 spotify || [workspace emptym] uwsm app -- spotify"

  "$mod , T, exec, [workspace emptym] uwsm app -s a -- freetube"
  # "$mod, C, exec, [workspace emptym] uwsm app -s a -- google-chrome-stable"
  "$mod, C, exec, [workspace emptym] uwsm app -s a -- chromium"
  "$mod, B, exec, [workspace emptym] uwsm app -s a -- qutebrowser"
  "$mod, F, exec, [workspace emptym] uwsm app -s a -- firefox"

 # "$mod $sl, T, exec, youtubr"
 "$mod $sl, T, exec, /home/malu/.code/SkunkWorks/PySide6/youtubr/youtubr"

 "$mod , A, exec, ascii"

  "$mod, Return, exec, $kitty" #$terminal , wezterm, ghostty
  "$mod $sl, Return, exec, [workspace emptym] $kitty"

  ", XF86Tools, exec, pkill pwvucontrol ||  pwvucontrol"

# Menu
  "$mod , mouse:272, exec, pkill rofi || $menu_rofi"
  "$mod , P, exec, pkill rofi || $menu_rofi"

  # File browser
  "$mod , R, exec, pkill rofi || $file_browser_rofi"

    # Clipboard hist
  "$mod , BackSpace, exec, pkill rofi || $clip_rofi"

  # open windows
  "$mod, space, exec, pkill rofi || $rofi_open_windows"
  "$mod , mouse:273, exec, pkill rofi || $rofi_open_windows"

  # power menu
  "$mod, Delete, exec, pkill rofi || rofi_power"

  # calculator
  ", XF86Calculator, exec, pkill rofi || $calc_rofi"

  # emoji
  "$mod, period, exec, pkill rofi || $emoji_rofi"

# "$mod, D, exec, emacsclient -c -a 'emacs' %F" # launch emacs client with %F buffer?
  "$mod, E, exec, [workspace emptym] $emacs"
  "$mod $al, E, execr, notify-send 'restarting emacs' -i '/home/malu/Shibuya/assets/icons/icons8-emacs-color/icons8-emacs-48.png' ; systemctl --user restart emacs ; sleep 2 && notify-send 'restarted emacs' -i '/home/malu/Shibuya/assets/icons/icons8-emacs-color/icons8-emacs-48.png'  && $emacs"

# "$mod, D, exec, emacsclient -c -a 'emacs' %F" # launch emacs client with %F buffer?
  "$mod, D, exec, [workspace emptym] discord"

  "$mod ,Escape, killactive"

  "$al ,F4, killactive"
  "$mod, mouse:275, killactive,"

  # Workspaces
  "$mod $al, Return , workspace, emptym"
  "$mod $sl, V, exec, hyprctl --batch \"dispatch togglefloating ; dispatch resizeactive exact 80% 80%;dispatch centerwindow 1;\""
  "$mod, v, togglefloating"

  "$mod, KP_Divide, togglesplit" # dwindle
  "$mod, KP_Multiply, pseudo"

# "$mod $cl, KP_End, focuswindow, class:^(Emacs)$"
# "$mod $cl, D, focuswindow, class:^(emacs)$"
# "$mod $cl, D, focuswindow, initialTitle:(.*)(Doom Emacs)$"
  "$mod $cl, E, focuswindow, class:^(emacs)$"
  "$mod $al, E, execr, notify-send 'restarting emacs' -i '/home/malu/Shibuya/assets/icons/icons8-emacs-color/icons8-emacs-48.png' ; systemctl --user restart emacs ; sleep 2 && notify-send 'restarted emacs' -i '/home/malu/Shibuya/assets/icons/icons8-emacs-color/icons8-emacs-48.png'  && $emacs"

"$mod $cl, D, focuswindow, class:^(discord)$"

"$mod $cl, Y, focuswindow, title:^(Yazi)(.*)$"
  # "$mod , up, focuswindow, class:^(Emacs)$"

"$mod $cl, N, focuswindow, class:org.gnome.Nautilus"
  # "$mod , up, focuswindow, class:^(Emacs)$"

# "SUPER $cl, KP_Down, focuswindow, class:^(org.qutebrowser.qutebrowser)$"
# "$mod $cl, KP_Right, focuswindow, class:^(org.qutebrowser.qutebrowser)$"
"$mod $cl, B, focuswindow, class:^(org.qutebrowser.qutebrowser)$"
# "$mod , left, focuswindow, class:^(org.qutebrowser.qutebrowser)$"

# "$mod $cl, C, focuswindow, class:^(google-chrome)$"
"$mod $cl, c, focuswindow, class:^(chromium-browser)$"
"$mod , g, exec, chromium gemini.google.com"
"$mod g, g, exec, chromium gemini.google.com"

"$mod $cl, f, focuswindow, class:^(firefox)$"
"$mod g, f, exec, firefox gemini.google.com"

"$mod $cl, Return, focuswindow, class:^(kitty)$"

"$mod $cl, m, focuswindow, class:^(mpv)$"
# "$mod , down, focuswindow, class:^(mpv)$"

"$mod $cl, T, focuswindow, class:^(FreeTube)$"

"$mod, m, togglespecialworkspace, magic"
"$mod SHIFT, m, movetoworkspace, special:magic"

# "$mod, q, togglespecialworkspace, quanta"
# "$mod SHIFT, q, movetoworkspace, special:quanta"

"$mod, Next, togglespecialworkspace, easy"
"$mod SHIFT, Next, movetoworkspace, special:easy"

"$mod, i, togglespecialworkspace, nc"
#"$mod SHIFT, i, movetoworkspace, special:nc" no need to move shit into it using this for songart

"$mod, s, togglespecialworkspace, scratch"
"$mod SHIFT, S, movetoworkspace, special:scratch"

#"$mod, t, togglespecialworkspace, Tixati" #"$mod SHIFT, T, movetoworkspace, special:Tixati"

# move to empty
  "$mod , o, movetoworkspace, emptym"
  "$mod $al, o, movetoworkspacesilent, emptym"

  "$mod $cl, h, movefocus, l"
  "$mod $cl, l, movefocus, r"
  "$mod $cl, k, movefocus, u"
  "$mod $cl, j, movefocus, d"
  #bind="$mod SHIFT,Left,layoutmsg,swapnext"

"$mod ,up, togglegroup"
  "$mod ,down, lockactivegroup, toggle"

  "$mod ,right,changegroupactive,f"
  "$mod ,left,changegroupactive,b"

  "$mod ,apostrophe,changegroupactive,f"
  "$mod ,quotedbl,changegroupactive,b"

  "$mod $sl , right, movewindoworgroup, r"
  "$mod $sl , left, movewindoworgroup, l"

# Keypad navigation
# Switch workspaces with mod + [ numpad 0-9]
  "$mod, KP_End, focusworkspaceoncurrentmonitor, 1"#TODO: do for loop make this cleaner
  "$mod, KP_Down, focusworkspaceoncurrentmonitor, 2"
  "$mod, KP_Next, focusworkspaceoncurrentmonitor, 3"
  "$mod, KP_Left, focusworkspaceoncurrentmonitor, 4"
  "$mod, KP_Begin, focusworkspaceoncurrentmonitor, 5"
  "$mod, KP_Right, focusworkspaceoncurrentmonitor, 6"
  "$mod, KP_Home, focusworkspaceoncurrentmonitor, 7"
  "$mod, KP_Up, focusworkspaceoncurrentmonitor, 8"
  "$mod, KP_Prior, focusworkspaceoncurrentmonitor, 9"
  "$mod, KP_Insert, focusworkspaceoncurrentmonitor, 10"

  "$mod $sl, KP_End, movetoworkspace, 1"
  "$mod $sl, KP_Down, movetoworkspace, 2"
  "$mod $sl, KP_Next, movetoworkspace, 3"
  "$mod $sl, KP_Left, movetoworkspace, 4"
  "$mod $sl, KP_Begin, movetoworkspace, 5"
  "$mod $sl, KP_Right, movetoworkspace, 6"
  "$mod $sl, KP_Home, movetoworkspace, 7"
  "$mod $sl, KP_Up, movetoworkspace, 8"
  "$mod $sl, KP_Prior, movetoworkspace, 9"
  "$mod $sl, KP_Insert, movetoworkspace, 10"

# next/prev workspace
"$mod, mouse_up, workspace, m+1"
  "$mod, mouse_down, workspace, m-1"

  "$mod ,H, workspace,m-1"
  "$mod ,L, workspace,m+1"

  "$mod $al,Home,execr, qs ipc call bar toggleBar"

  "$mod $al,i,execr, qs ipc call notifications dismissAll"

  "$mod $al,End,execr, systemctl --user restart quickshell"

  "$mod , Delete, execr, qs -p $XDG_CONFIG_HOME/quickshell/notBar/wlogout/shell.qml"

  "$mod $cl, KP_Left, execr, qs ipc call netspeed toggleNet"
  "$mod $cl, KP_End, execr, qs ipc call resources toggleResources"

  "$mod $al, N, execr, qs ipc call netspeed toggleNet"
  "$mod $al, R, execr, qs ipc call resources toggleResources"

    # Playing | Mpris
  "$mod, F7, execr, qs ipc call mprisTog toggleMpris"
  "$mod $al, F7, execr, qs ipc call mprisTog toggleMprisIcon"
  "$mod $sl, F7, execr, qs ipc call mpris raise"

  ", F8, execr, qs ipc call mpris next"
  ", F6, execr, qs ipc call mpris previous"
  ", F7, execr, qs ipc call mprisTog togglePlaying"

  "$mod $sl, semicolon, swapnext"
  # "$mod , Up, exec, hyprctl --batch \"dispatch swapactiveworkspaces HDMI-A-1 $( hyprctl monitors | grep DP | cut -d ' ' -f2 ) ; dispatch focusmonitor +1;\""

# "$mod,K, Workspace, previous_per_monitor"
  "$mod,K, focuscurrentorlast"
  "$mod $sl, k, focusmonitor, +1"
  "$mod, mouse:276, Workspace, previous_per_monitor"
  "$mod, semicolon, cyclenext"
]

++ (
  builtins.concatLists (builtins.genList ( i:
      let
        ws = i + 1;
      in
        [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}" # this is genius 1-10, amazing
        ]
    ) 9
  )
)

++ (if osConfig.networking.hostName == "tangier" then []
  else [

    # "$mod ,bracketleft, movecurrentworkspacetomonitor, 0" # DP-3
    # "$mod ,bracketright, movecurrentworkspacetomonitor, 1" # HDMI-A-1

    "$mod ,bracketleft, movewindow, mon:0"
    "$mod ,bracketright, movewindow, mon:1"

    "$mod $cl,bracketleft, movewindow, mon:0 silent"
    "$mod $cl,bracketright, movewindow, mon:1 silent"

    "$mod $sl, bracketright, execr, hyprctl dispatch -- swapactiveworkspaces HDMI-A-1 $(hyprctl monitors | awk '/^Monitor DP/ {print $2}')"
    "$mod $sl, bracketleft, execr, hyprctl --batch \"dispatch swapactiveworkspaces HDMI-A-1 $(hyprctl monitors | awk '/^Monitor DP/ {print $2}'); dispatch focusmonitor +1;\""
  ]);

#mouse binds have one less arg
bindm = [
  "$mod $cl, mouse:272, movewindow"
  # "$mod , mouse:272, pass, class:^(dota2)$"
  "$mod $cl, mouse:273, resizewindow" # 1 - keep aspect ratio, 2 - ignore aspect
  # "ALT, mouse:272, movewindow"
];

bindc = [
  # "ALT, mouse:272, togglefloating"
];

bindel =
  [
    ", XF86AudioPlay, execr, pause_play"
    # mute
    ", XF86AudioMute, execr, volume_dunst toggle_mute"

    # "$mod, F12, execr, volume_dunst earphones"
    # "$mod, F11, execr, volume_dunst speaker"
    # "$mod, F10, execr, volume_dunst bluetooth"

    # ", XF86AudioRaiseVolume, execr, volume_dunst 2%+"
    # ", XF86AudioLowerVolume, execr, volume_dunst 2%-"

    ", XF86AudioRaiseVolume, execr, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+ >/dev/null 2>&1 "
    ", XF86AudioLowerVolume, execr, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%- >/dev/null 2>&1 "

    # ", XF86AudioNext, execr, playerctl -p spotify next || playerctl next " # TODO test for spotify running
    ", XF86AudioNext, execr, qs ipc call mpris next" # TODO test for spotify running
    ", XF86AudioPrev, execr, qs ipc call mpris previous"
    ", XF86AudioPlay, execr, qs ipc call mprisTog togglePlaying"
   ];

binde =
  [# Date
    "$mod, Prior, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-stopwatch-office-l/icons8-stopwatch-30.png'  \"$date_short  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
    "$mod $sl, Prior, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-today-windows-11-color/icons8-today-30.png' \"$date_long  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"

    "$mod, backslash, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-stopwatch-office-l/icons8-stopwatch-30.png'  \"$date_short  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
    "$mod $sl, backslash, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-today-windows-11-color/icons8-today-30.png' \"$date_long  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
  ]
  ++[
    "$mod $sl,i,execr, songart"
    ", Pause, execr, songart"
  ]++
  [
    #GAPS
    "$mod ,KP_Enter, exec, gaps reset_zero" # set according to hyprland config default

    # increase/decrease gaps
    "$mod,KP_Add, exec, gaps increment_gap"
    "$mod,KP_Subtract, exec, gaps decrease_gap"

    "$mod $al, KP_Enter, exec, gaps gaps_in_reset"
    "$mod $al, KP_Add, exec, gaps gaps_in_add"
    "$mod $al, KP_Subtract, exec, gaps gaps_in_sub"

    "$mod ,KP_Enter, exec, gaps reset_config"
    "$mod ,$ar, exec, gaps toggle_gaps_out"# gaps on/off
  ];
};
 };
}
