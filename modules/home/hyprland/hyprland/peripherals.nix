{ osConfig, lib,...}:

let
  settings = if osConfig.networking.hostName == "carthage" then
  {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "HDMI-A-1,1920x1080@240,1920x0,1"#"HDMI-A-1,1920x1080@239.76,0x0,1"
        # "DP-3,highrr,0x0,1"
        "DP-3,1920x1080@60,0x0,1"
      ];

      cursor = {
        no_warps = true;
        enable_hyprcursor = true;
        #no_hardware_cursors = true; #invis cursor
        #persistent_warps = true; # maintain cursor position on switch rather than center
        hide_on_key_press = true;
        #warp_on_change_workspace = true; # cursor to last focused window
        # sync_gsettings_theme = true;# on by default
      };
      input = {
        mouse_refocus = true; # default = if true mouse must cross boundary for focus change 
        kb_layout = "us";
        numlock_by_default = true;
        kb_options = "caps:swapescape";
        follow_mouse = 1; #  1- cursor changes focus to window under cursor # 2- cursor focus detached from keyboard foocus # 3 - completely detach,click wont change focus # 0-cursor movement will not change focus
        # special_fallthrough= true; # floating will not block focus to regular workspace
        float_switch_override_focus = 2; # 2 - follow_mouse on switch; #TODO: test further
        scroll_factor = 1.6; #1.2
      };

      device = [
        {
          name = "razer-razer-viper-mini";
          sensitivity = "-0.8";
        }
        {
          name = "sino-wealth-usb-keyboard" ;
          repeat_delay = 380; # 400, ;;380
          repeat_rate = 30; # ;;25 || nice: 39
        }
      ];
    };
  }
  else
    lib.mkIf (osConfig.networking.hostName == "tangier") {
      # Default or pc settings here
      wayland.windowManager.hyprland.settings = {
        monitor = [
          "eDP-1,highres,auto,1.333333"
        ];
      xwayland = {
        force_zero_scaling = true;
      };
      input = {#https://wiki.hyprland.org/Configuring/Variables/
        mouse_refocus = true; # default = true, cross window boundary for focus to change
        kb_layout = "us";
        numlock_by_default = true;
        kb_options = "caps:swapescape";
        follow_mouse = 1; 
          # Follow Mouse legend
          # 0 - Cursor movement will not change focus.
          # 1- Cursor movement will always change focus to the window under the cursor,
          # 2- Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
          # 3 - completely detach,click wont change focus,0-cursor movement will not change focus
        focus_on_close = 1; # 0 - next window candidate::, 1 - under cursor
        special_fallthrough= true; # floating will not block focus to regular workspace
        float_switch_override_focus = 2; # 2 - follow_mouse on switch; #TODO: test further
        # scroll_factor = 1.2;
        touchpad = {
            disable_while_typing = true;
            natural_scroll = true;
            #clickfinger_behaviour = true; # LMB,RMB,MMB to taps #nice spelling vaxry lol
            clickfinger_behavior = true; # LMB,RMB,MMB to taps
            drag_lock = false;
            tap-and-drag = true; #nice syntax consistency vax lol
            scroll_factor = 1.2;
        };
        };
        gestures = {
          workspace_swipe = true;
          # workspace_swipe_fingers = 2;
          workspace_swipe_distance = 260; # def: 300
          workspace_swipe_create_new = false; # new empty after last workspace
          # workspace_swipe_use_r = true; # r instead of m
          workspace_swipe_forever = true;
        };
        device = [
          {
            name = "at-translated-set-2-keyboard" ;
            repeat_delay = 380;
            repeat_rate = 39;
          }
        ];
      binde = [
        # ", XF86MonBrightnessUp, exec, ~/.darth/scripts/brightness_dunst.sh +"
        # "bind = , XF86MonBrightnessDown, exec, ~/.darth/scripts/brightness_dunst.sh -"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
      };
    };
in
  settings
