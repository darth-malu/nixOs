{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

let
  vars = import ../layout.nix;
  isScrolling = vars.layout == "scrolling";
in
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
      "$kitty" = "app2unit -s a -- kitty -1 --instance-group kitty";
      "$yazi_kitty" = "app2unit -s a -- kitty -1 --instance-group yazi -e yazi";

      "$gaps" = "gaps toggle_gaps_out";
      "$emacs" = "app2unit -s a -- emacsclient -c";
      "$emacs_restart_ico" = "/home/malu/Shibuya/assets/icons/icons8-emacs-color/icons8-emacs-48.png";
      "$notify_send_emacs_restarting" = "notify-send 'restarting emacs' -i $emacs_restart_ico";
      "$notify_send_emacs_restarted" = "notify-send 'restarted emacs' -i $emacs_restart_ico";

      "$file_browser_rofi" =
        "rofi -show filebrowser -filebrowser-command 'xdg-open' -filebrowser-directory '/home/malu' -theme '/home/malu/Shibuya/modules/home/programs/hyprland/keybinds/rofi-themes/fileBrowser.rasi'";
      "$rofi_open_windows" =
        "rofi -show window -theme-str 'window {width : 920px;}' -theme-str 'listview {lines:15; dynamic: true;}' -theme-str 'element {background-image: linear-gradient(white/5%, white/10%);border-color: lightblue /15%;}'";
      "$menu_rofi" = "rofi -show drun -theme-str 'listview {require-input: true;}'";
      "$emoji_rofi" = "rofi -show emoji";
      "$clip_rofi" =
        "cliphist list | rofi -dmenu -theme-str 'window {width : 750px;}' -p '' | cliphist decode | wl-copy";
      "$calc_rofi" = "rofi -show calc -p '🪓' -theme-str 'listview {require-input: true;}'";

      bindr = [

        "$mod, N, exec, [workspace emptym] app2unit -s a -- nautilus"
        "$mod $cl, N, focuswindow, class:org.gnome.Nautilus"
        "$mod , Y, exec, [workspace emptym] $yazi_kitty"
        # "$mod $sl, Y, exec, [workspace special:magic;float true; size 80% 80%] $yazi_kitty"

        "$mod $sl, KP_End, exec, hyprpicker -an"
        # "$mod $al, R, exec, \"$(hyprpicker -f rgb - | sed 's/^/(/; s/$/,1.0)/; y/ /,/\' | wl-copy -n)\""

        # "$mod $al, Return, exec, $ghostty" #$terminal , wezterm, ghostty

        "SUPER, Print, exec, grimblast --cursor --notify -e 2  copy screen"
        ", Print, exec, grimblast --cursor --notify -e 2 copysave screen"
        # ", Scroll_Lock, exec, grimblast --cursor --notify copysave screen"
        "$sl, Print, exec, grimblast --cursor --notify -e 2 copy output"
        "$al, Print, exec, grimblast --notify -e 2 copy area"
        "$cl, Print, exec, grimblast --cursor --notify -e 2 copy active"

      ];

      bind = [

        # "$mod $sl, T, exec, youtubr"
        "$mod $sl, T, exec, /home/malu/.code/SkunkWorks/PySide6/youtubr/youtubr"

        "$mod , A, exec, ascii"

        "$mod, Return, exec, $kitty" # $terminal , wezterm, ghostty
        "$mod $cl, Return, focuswindow, class:^(kitty)$"
        "$mod $sl, Return, exec, [workspace emptym] $kitty"

        "$mod, F2, exec, [workspace emptym] footclient"
        # "$mod $sl, F2, exec, foot"

        "$mod $sl, D, focuswindow, class:^(dota2)$"

        "$mod $sl, f1, exec, pkill pwvucontrol ||   app2unit -s a -- pwvucontrol"

        "$mod $al, mouse:272, exec, pkill rofi || $menu_rofi"
        # "$mod , P, exec, pkill rofi || $menu_rofi"

        "$mod , R, exec, pkill rofi || $file_browser_rofi"

        "$mod , BackSpace, exec, pkill rofi || $clip_rofi"

        "$mod, comma, exec, pkill rofi || $rofi_open_windows"

        "$mod $al, mouse:273, exec, pkill rofi || $rofi_open_windows"

        ", XF86Calculator, exec, pkill rofi || $calc_rofi"

        "$mod, slash, exec, pkill rofi || $calc_rofi"

        "$mod, period, exec, pkill rofi || $emoji_rofi"

        # "$mod, D, exec, emacsclient -c -a 'emacs' %F" # launch emacs client with %F buffer?
        "$mod, E, exec, [workspace emptym] $emacs"
        # "$mod, space , sendshortcut, space, space, class:^(emacs)$" # TODO make script for better switching
        "$mod $al, E, execr, $notify_send_emacs_restarting ; systemctl --user restart emacs && $notify_send_emacs_restarted ; $emacs"

        # "$mod, D, exec, emacsclient -c -a 'emacs' %F" # launch emacs client with %F buffer?
        "$mod, D, exec, [workspace emptym] discord"

        "$mod ,Escape, killactive"

        "$al ,F4, killactive"
        "$mod, mouse:275, killactive,"

        # Workspaces
        "$mod $al, Return , workspace, emptym"
        "$mod $sl, V, exec, hyprctl --batch \"dispatch togglefloating ; dispatch resizeactive exact 80% 80%;dispatch centerwindow 1;\""
        "$mod, v, togglefloating"

        # "$mod, KP_Divide, togglesplit" # dwindle
        "$mod, KP_Multiply, pseudo"

        # "$mod $cl, KP_End, focuswindow, class:^(Emacs)$"
        # "$mod $cl, D, focuswindow, class:^(emacs)$"
        "$mod $cl, E, focuswindow, class:^(emacs)$"
        "$mod $sl, E, exec, app2unit -s a -- emacsclient --eval \"(emacs-everywhere)\""

        "$mod $cl, D, focuswindow, class:^(discord)$"

        "$mod $cl, Y, focuswindow, title:^([Yy]azi)(.*)$"
        # "$mod , up, focuswindow, class:^(Emacs)$"

        "$mod $cl $sl, N, focuswindow, class:org.kde.dolphin"
        "$mod $sl, N, exec, [workspace emptym] dolphin"

        # "SUPER $cl, KP_Down, focuswindow, class:^(org.qutebrowser.qutebrowser)$"
        # "$mod $cl, KP_Right, focuswindow, class:^(org.qutebrowser.qutebrowser)$"
        "$mod $cl, B, focuswindow, class:^(org.qutebrowser.qutebrowser)$"
        "$mod, B, exec, [workspace emptym] app2unit -s a -- qutebrowser"
        # "$mod , left, focuswindow, class:^(org.qutebrowser.qutebrowser)$"

        # "$mod $cl, C, focuswindow, class:^(google-chrome)$"
        "$mod $cl, c, focuswindow, class:^(google-chrome)$"
        "$mod, C, exec, [workspace emptym] app2unit -s a -- google-chrome"

        "$mod $cl, f, focuswindow, class:^(firefox)$"
        "$mod, F, exec, [workspace emptym] app2unit -s a -- firefox"

        "$mod $cl, z, focuswindow, class:^(zen)$"
        "$mod , z, exec,  [workspace emptym] app2unit -s a -- zen"

        "$mod $cl, m, focuswindow, class:^(mpv)$"
        # "$mod , down, focuswindow, class:^(mpv)$"

        "$mod $cl, T, focuswindow, initialtitle:^(FreeTube)$"
        "$mod , T, exec, [workspace 10] app2unit -s a -- freetube"

        "$mod, F1,exec,  [workspace 10] app2unit -s a -- spotify"

        "$mod, m, togglespecialworkspace, magic"
        "$mod SHIFT, m, movetoworkspace, special:magic"

        "$mod, q, togglespecialworkspace, quanta"
        "$mod SHIFT, q, movetoworkspace, special:quanta"

        "$mod, Next, togglespecialworkspace, easy"
        "$mod SHIFT, Next, movetoworkspace, special:easy"

        "$mod, i, togglespecialworkspace, nc"
        #"$mod SHIFT, i, movetoworkspace, special:nc" no need to move shit into it using this for songart

        # "$mod, s, togglespecialworkspace, scratch"
        # "$mod SHIFT, S, movetoworkspace, special:scratch"

        #"$mod, t, togglespecialworkspace, Tixati" #"$mod SHIFT, T, movetoworkspace, special:Tixati"

        # move to empty

        "$mod $cl, h, movefocus, l"
        "$mod $cl, l, movefocus, r"
        "$mod $cl, k, movefocus, u"
        "$mod $cl, j, movefocus, d"
        #bind="$mod SHIFT,Left,layoutmsg,swapnext"

        "$mod ,up, togglegroup"
        "$mod ,down, lockactivegroup, toggle"

        "$mod ,right,changegroupactive,f"
        "$mod ,left,changegroupactive,b"

        # "$mod ,apostrophe,changegroupactive,f"
        # "$mod ,quotedbl,changegroupactive,b"

        "$mod $sl , right, movewindoworgroup, r"
        "$mod $sl , left, movewindoworgroup, l"

        # 🇳​​​​​🇴​​​​​🇹​​​​​🇮​​​​​🇫​​​​​🇮​​​​​🇨​​​​​🇦​​​​​🇹​​​​​🇮​​​​​🇴​​​​​🇳​​​​​🇸​​​​​
        "$mod $al, x,execr, qs ipc call notifications dismissAll"

        "$mod $al, t, execr, qs ipc call Time currentDate"
        "$mod , backslash, execr, qs ipc call Time currentDate"

        # 🇷​​​​​🇪​​​​​🇸​​​​​🇴​​​​​🇺​​​​​🇷​​​​​🇨​​​​​🇪​​​​​🇸​​​​​
        # "$mod $cl, KP_Left, execr, qs ipc call netspeed toggleNet"
        # "$mod $cl, KP_End, execr, qs ipc call resources toggleResources"

        "$mod $al, N, execr, qs ipc call netspeed toggleNet"
        "$mod $al, R, execr, qs ipc call resources toggleResources"

        # 🇲​​​​​🇵​​​​​🇷​​​​​🇮​​​​​🇸​​​​​
        "$mod, F7, execr, qs ipc call mpris toggleMpris"
        "$mod $al, F7, execr, qs ipc call mpris toggleMprisIcon"
        "$mod $cl, i, execr, qs ipc call mpris raise"

        ", F8, execr, qs ipc call mpris next"
        ", F6, execr, qs ipc call mpris previous"
        ", F7, execr, qs ipc call mpris togglePlaying"

        "$mod $sl,i,execr, qs ipc call mpris songArt"

        # System Tray Toggle
        "$mod $al, s, execr, qs ipc call SysTray toggle"

        # 🇲​​​​​🇮​​​​​🇸​​​​​🇨​​​​​
        "$mod , Delete, execr, qs -p $XDG_CONFIG_HOME/quickshell/notBar/wlogout/shell.qml"

        "$mod , P, execr, qs -p $XDG_CONFIG_HOME/quickshell/notBar/appLauncher/AppLauncher.qml"

        # 65 %
        "$mod $al, 0,execr, systemctl --user restart quickshell"
        "$mod $al, 9,execr, qs ipc call bar toggleBar"
        "$mod $al, 1,execr, qs ipc call activate toggle"

        # "$mod,K, Workspace, previous_per_monitor"
        "$mod $sl, k, focusmonitor, +1"
        "$mod, mouse:276, Workspace, previous_per_monitor"
        "$mod,K, focuscurrentorlast"
      ]

      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 10
      ))

      ++ lib.optionals isScrolling [
        "$mod $sl, semicolon, layoutmsg, move -col"
        "$mod, semicolon, layoutmsg, move +col"

        "$mod $sl,H, layoutmsg, focus left"
        "$mod $sl,L, layoutmsg, focus right"

        "$mod $al,H, layoutmsg, colresize -conf"
        "$mod $al,L, layoutmsg, colresize +conf"
        "$mod $al, Return, layoutmsg, colresize 0.5"

        # Scrolling left/right in a scrolling workspace
        "$mod $sl, mouse_up, layoutmsg, focus right"
        "$mod $sl,mouse_down, layoutmsg, focus left"

        "$mod , grave, layoutmsg,  fit active"
        "$mod $sl, grave, layoutmsg,  promote"

        "$mod $sl, o, layoutmsg, promote"
        "$mod $sl, space, layoutmsg, swapcol"
      ]
      ++ lib.optionals (!isScrolling) [
        #
      ]
      ++ [
        # Universal
        "$mod $sl, space, swapnext"
        "$mod , space, cyclenext"
        "$mod ,H, workspace,m-1"
        "$mod ,L, workspace,m+1"
        "$mod, mouse_up, workspace, m+1"
        "$mod, mouse_down, workspace, m-1"
        "$mod , o, movetoworkspace, emptym"
        "$mod $al, o, movetoworkspacesilent, emptym"
      ];

      #mouse binds have one less arg
      bindm = [
        "$mod $cl, mouse:272, movewindow"
        "$mod $cl, mouse:273, resizewindow" # 1 - keep aspect ratio, 2 - ignore aspect
      ];

      bindc = [
        # "ALT, mouse:272, togglefloating"
      ];

      bindel = [
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
        ", XF86AudioNext, execr, qs ipc call mpris next" # TODO: check players script with quickshell
        ", XF86AudioPrev, execr, qs ipc call mpris previous"
        # ", XF86AudioPlay, execr, qs ipc call mpris togglePlaying"
      ];

      binde = [
        # Date
        "$mod, Prior, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-stopwatch-office-l/icons8-stopwatch-30.png'  \"$date_short  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
        "$mod $sl, Prior, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-today-windows-11-color/icons8-today-30.png' \"$date_long  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"

        # "$mod, backslash, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-stopwatch-office-l/icons8-stopwatch-30.png'  \"$date_short  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
        # "$mod $sl, backslash, execr, ${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/assets/icons/icons8-today-windows-11-color/icons8-today-30.png' \"$date_long  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
      ]
      ++ [
        #GAPS
        "$mod ,KP_Enter, exec, gaps reset_zero" # set according to hyprland config default

        # increase/decrease gaps
        "$mod,KP_Add, exec, gaps increment_gap"
        "$mod,KP_Subtract, exec, gaps decrease_gap"

        "$mod $al, KP_Enter, exec, gaps gaps_in_reset"
        "$mod $al, KP_Add, exec, gaps gaps_in_add"
        "$mod $al, KP_Subtract, exec, gaps gaps_in_sub"

        "$mod ,KP_Enter, exec, gaps reset_config"
        "$mod ,$ar, exec, gaps toggle_gaps_out" # gaps on/off
      ];
    };
  };
}
