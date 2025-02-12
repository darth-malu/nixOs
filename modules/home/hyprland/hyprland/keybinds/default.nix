{pkgs, osConfig, ...}:

{
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      "$formated_rgba" = "$(hyprpicker -f rgb - | sed \"s/^/(/; s/$/,1.0)/; y/ /,/\" | wl-copy -n)";
      "$cl" = "Control_L";
      "$al" = "Alt_L";
      "$ar" = "Alt_R";
      "$cr" = "Control_R";
      "$sl" = "SHIFT_L";
      "$sr" = "SHIFT_R";
      "$date_short" = "$(date +'%I:%M %p')"; # add -u (utc)
      "$date_long" = "$(date +'%a,%d %b%t%I:%M %p')"; 
      "$kitty" = "uwsm app -s a -- kitty -1 --instance-group kitty";
      "$ghostty" = "uwsm app -s a -- ghostty";
      "$wezterm" = "uwsm app -s a -- kitty -1 --instance-group kitty";
      "$yazi_kitty" = "uwsm app -s a -- kitty -1 --instance-group yazi -e yazi";
      "$yazi_ghostty" = "uwsm app -s a -- ghostty -e yazi";

      #"$rofi_open_windows" =  "rofi -show window -theme-str \"window {font: \"quicksand 12\"; width: 55%;}\"";#FIXME: fonts not working with rofi parser
      "$file_browser_rofi" = "rofi -show filebrowser -sidebar-mode -theme-str 'window {height: 620px; width : 800px;}' -theme-str 'element-icon {size: calc(((100% - 8em) / 7 ));horizontal-align: 0.5;vertical-align: 0.5;}'";
      "$rofi_open_windows" =  "rofi -show window -theme-str 'window {width : 800px;}' -theme-str 'listview {lines: 8; dynamic: true;}' -theme-str 'element {background-image: linear-gradient(white/5%, white/10%);border-color: lightblue /15%;}'" ;
          # "-theme-str 'window {width : 800px; fullscreen: true;}" + 
          # " -theme-str 'element {background-image: linear-gradient(white/5%, white/20%);border-color: lightblue /15%;}'";
      "$menu_rofi" = "rofi -show drun -run-command \"uwsm app -s a -- {cmd}\"";
      # "$emoji_rofi" = "rofi -show emoji";
      "$clip_rofi" = "cliphist list | rofi -dmenu | cliphist decode | wl-copy";
      # "$calc_rofi" = "rofi -show calc";
      # "$obsidian_rofi" = "rofi -show obsidian";
      "$gaps" = "gaps toggle_gaps_out";

      bind =
        [
          # app launch
          # "$mod, F1,exec,  killall -9 spotify || [workspace emptym] uwsm app -- spotify"

          # browswers
          # "$mod, F, exec, [workspace emptym] uwsm app -s a -- firefox"
          "$mod, C, exec, [workspace emptym] uwsm app -s a -- google-chrome-stable"

          #kitty
          "$mod, Return, exec, $ghostty" #$terminal , wezterm, ghostty
          "$mod $sl, Return, exec, [workspace emptym] $ghostty"

          # productivity
          # "$mod $cl, O, exec, [workspace emptym] uwsm app -s a -- obsidian"
          "$mod, N, exec, [workspace emptym] uwsm app -s a -- nautilus"
          # "$mod, D, exec, [workspace emptym] uwsm app -s a -- dolphin"
          "$mod, Y, exec, [workspace emptym] $yazi_ghostty"

          # rofi
          "$mod, mouse:272, exec, pkill rofi || $menu_rofi"
          "$mod, P, exec, $menu_rofi"
          "$mod $cl, space, exec, pkill rofi || $file_browser_rofi"
          # "$mod $cl, e, exec, pkill rofi || $emoji_rofi"
          # "$mod $cl, m, exec, pkill rofi || $calc_rofi"
          # "$mod $cl, p, exec, pkill rofi || $obsidian"
          "$mod , BackSpace, exec, pkill rofi || $clip_rofi"

          # open windows
          "$mod, TAB, exec, pkill rofi || $rofi_open_windows"
          "$mod, mouse:273, exec, pkill rofi || $rofi_open_windows"

          # hyprpicker
          "$mod $al, C, exec, hyprpicker -an"
          "$mod $al, R, exec, $formated_rgba"

          # power menu
          "$mod, Delete, exec, pkill rofi || rofi_power"

          # copysave
          # ", Print, exec, grimblast --cursor --notify copysave output"
          ", Print, exec, grimblast --cursor --notify copy output"
          "$sl, Print, exec, grimblast --cursor --notify copysave screen"

          # copy
          "SUPER, Print, exec, grimblast --cursor --notify copysave output"
          "$al, Print, exec, grimblast --cursor --notify copy area"
          "$cl, Print, exec, grimblast --cursor --notify copy active"

          # Workspaces
          "$al, KP_Enter,workspace ,emptym"
          "$mod, V, exec, hyprctl --batch \"dispatch togglefloating ; dispatch resizeactive exact 80% 80%;dispatch centerwindow 1;\""
          
          "$mod, KP_Divide, togglesplit" # dwindle
          "$mod, KP_Multiply, pseudo"# dwindle

          #█▄▀ █ █░░ █░░   ▄▀█ █▀▀ ▀█▀ █ █░█ █▀▀
          #█░█ █ █▄▄ █▄▄   █▀█ █▄▄ ░█░ █ ▀▄▀ ██▄
          "$mod ,space, killactive"
          # "$mod ,Space, killactive"
          "$mod, mouse:275, killactive,"


          #█▀ █▀▀ █▀█ ▄▀█ ▀█▀ █▀▀ █░█
          #▄█ █▄▄ █▀▄ █▀█ ░█░ █▄▄ █▀█
          "$mod, m, togglespecialworkspace, magic"
          "$mod SHIFT, m, movetoworkspace, special:magic"

          "$mod, q, togglespecialworkspace, quanta"
          "$mod SHIFT, q, movetoworkspace, special:quanta"

          "$mod, e, togglespecialworkspace, easy"
          "$mod SHIFT, e, movetoworkspace, special:easy"

          "$mod, i, togglespecialworkspace, nc"
          #"$mod SHIFT, i, movetoworkspace, special:nc" no need to move shit into it

          "$mod, s, togglespecialworkspace, scratch"
          "$mod SHIFT, S, movetoworkspace, special:scratch"

          #"$mod, t, togglespecialworkspace, Tixati" #"$mod SHIFT, T, movetoworkspace, special:Tixati"

          # move to empty
          "$mod , o, movetoworkspace, emptym"
          "$mod $sl, o, movetoworkspacesilent, emptym"

          #█▀▀ █▀█ █▀▀ █░█ █▀
          #█▀░ █▄█ █▄▄ █▄█ ▄█
          "$mod $cl, h, movefocus, l"
          "$mod $cl, l, movefocus, r"
          "$mod $cl, k, movefocus, u"
          "$mod $cl, j, movefocus, d"
          #Scroll throught windows in a workspace
          #bind="$mod SHIFT,Left,layoutmsg,swapnext"

          # next/prev workspace
          "$mod, mouse_up, workspace, m+1"
          "$mod, mouse_down, workspace, m-1"

          "$mod ,left, workspace,m-1"
          "$mod ,right,workspace,m+1"

          "$mod ,H, workspace,m-1"
          "$mod ,L,workspace,m+1"

          # Keypad navigation
          # Switch workspaces with mod + [ numpad 0-9]
          "$mod, KP_End, workspace, 1"#TODO: do for loop make this cleaner
          "$mod, KP_Down, workspace, 2"
          "$mod, KP_Next, workspace, 3"
          "$mod, KP_Left, workspace, 4"
          "$mod, KP_Begin, workspace, 5"
          "$mod, KP_Right, workspace, 6"
          "$mod, KP_Home, workspace, 7"
          "$mod, KP_Up, workspace, 8"
          "$mod, KP_Prior, workspace, 9"
          "$mod, KP_Insert, workspace, 10"

          # Move active window to a workspace with mod + SHIFT + [ numpad 0-9]
          # --> movetoworkspacesilent exists
          #KEYPAD
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

          "SUPER ,Home,execr, killall -SIGUSR1 .waybar-wrapped" # toggle waybar
          "SUPER ,End,execr, killall .waybar-wrapped || uwsm app waybar" 

          # gaps
          "SUPER $sl,KP_Enter, exec, gaps reset"
          "SUPER ,KP_Enter, exec, gaps custom"
          "SUPER ,$ar, exec, gaps toggle_gaps_out"#toggle gaps on/off

                
          # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
          # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
          "$mod ,bracketleft, movecurrentworkspacetomonitor, 0" # DP-3
          "$mod ,bracketright, movecurrentworkspacetomonitor, 1" # HDMI-A-1
          "$mod $sl, bracketright, swapnext"
          "$mod $sl, bracketleft, exec, hyprctl --batch \"dispatch swapactiveworkspaces HDMI-A-1 DP-3 ; dispatch focusmonitor +1;\"" # TODO: only in nvim? or tmux
          "$mod , Up, exec, hyprctl --batch \"dispatch swapactiveworkspaces HDMI-A-1 DP-3 ; dispatch focusmonitor +1;\"" # TODO: only in nvim? or tmux
          # "$mod , [, exec, hyprctl --batch \"dispatch swapactiveworkspaces HDMI-A-1 DP-3 ; dispatch focusmonitor +1;\"" # TODO: only in nvim? or tmux
          # "$mod $sl, k, exec, dispatch swapactiveworkspaces HDMI-A-1 DP-3 ;"
          # "$mod $sl,l, focusmonitor, HDMI-A-1"
          # "$mod $sl,h, focusmonitor, DP-3"

          #█▀▀ █▀█ █▀▀ █░█ █▀ █▀▀ █░█ █▀█ █▀█ █▀▀ █▄░█ ▀█▀
          #█▀░ █▄█ █▄▄ █▄█ ▄█ █▄▄ █▄█ █▀▄ █▀▄ ██▄ █░▀█ ░█░
          "$mod,K, Workspace, previous_per_monitor"
          "$mod, mouse:276, Workspace, previous_per_monitor"
          "$mod $sl, k, focusmonitor, +1"
          "$mod, semicolon, cyclenext"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (#TODO: learn more about builtins
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}" # this is genius 1-10, amazing
              ]
            ) 9
          )
        );

      #mouse binds have one less arg
      bindm = [
        "$mod $cl, mouse:272, movewindow"
        "$mod $cl, mouse:273, resizewindow" # 1 - keep aspect ratio, 2 - ignore aspect
      ];

      bindel = 
        if osConfig.networking.hostName == "tangier" then
          import ./laptop_bindings.nix
        else 
          import ./pc_bindings.nix;
      bindl = 
        [
          #-----------------------PLAY/PAUSE------------------#
          ", XF86AudioPlay, execr, pause_play"
          # mute
          ",  F4, execr, volume_dunst toggle_mute"

          ##---------------Sink-Switch--------------#
          "$mod, F12, execr, volume_dunst earphones"
          "$mod, F11, execr, volume_dunst speaker"
          "$mod, F10, execr, volume_dunst bluetooth"
        ];


      binde =
        [# Date
        # ", Insert, execr,${pkgs.libnotify}/bin/notify-send -r 20 -i '$HOME/.local/darth/iconDownload/iconsLinuxHdd/time-color-hand-drawn/icons8-time-60.png'  \"$date_short  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
        # "$mod, Insert, execr,${pkgs.libnotify}/bin/notify-send -r 20 -i '$HOME/.local/darth/iconDownload/iconsLinuxHdd/time-color-hand-drawn/icons8-time-60.png' \"$date_long  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
        # "$mod, Prior, execr,${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/modules/home/scripts/assets/icons8-stopwatch-office-l/icons8-stopwatch-30.png'  \"$date_short  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
        "$mod, T, execr,${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/modules/home/scripts/assets/icons8-stopwatch-office-l/icons8-stopwatch-30.png'  \"$date_short  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
        "$mod $sl, T, execr,${pkgs.libnotify}/bin/notify-send -r 20 -i '/home/malu/Shibuya/modules/home/scripts/assets/icons8-today-windows-11-color/icons8-today-30.png' \"$date_long  \" ; ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i message"
        ]
        ++[
        #dunst pop
        "$mod $sl,i,exec, songart"
        ", Pause, exec, songart"
        "$mod, Next, exec, songart"
        ]++
        [#rest
        "SUPER ,KP_Enter, exec, gaps custom" # set according to hyprland config default

        # increase/decrease gaps
        # "SUPER,KP_Add, exec, ~/.darth/scripts/gaps.sh increment_gap"
        # "SUPER,KP_Subtract, exec, ~/.darth/scripts/gaps.sh decrease_gap"
        "SUPER,KP_Add, exec, gaps increment_gap"
        "SUPER,KP_Subtract, exec, gaps decrease_gap"

        "SUPER $al,KP_Enter, exec, gaps gaps_in_reset"
        "SUPER $al,KP_Add, exec, gaps gaps_in_add"
        "SUPER $al,KP_Subtract, exec, gaps gaps_in_sub"
      ];
    };
  };
}
