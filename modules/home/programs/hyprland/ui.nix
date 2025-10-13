{ osConfig, ... }:
{
  wayland.windowManager.hyprland.settings = {
    general = {
      # https://wiki.hyprland.org/Configuring/Variables/
      "col.active_border" = "rgba(00FFF5aa)";
      gaps_in = 6; # NOTE: space essential for gaps script
      gaps_out = 12;
      border_size = 1;
      resize_on_border = true;
      resize_corner = 3; # 0:: 1-4 clockwise
      hover_icon_on_border = true;
      layout = "dwindle";
      allow_tearing = true; # false:: - alternatively use immediate rule
      no_border_on_floating = true;
      no_focus_fallback = true; # false, will not fall back to the next available window when moving focus in a direction where no window was found
      snap = {
        enabled = true;
        window_gap = 10;
        monitor_gap = 10;
        border_overlap = true; # false::, if true one borders worth btwn windows
      };
    };

    decoration = {
      shadow = {
        enabled = if osConfig.networking.hostName == "carthage" then true else false;
        #"col.shadow" = "rgba(1E202966)";
        #shadow_range = 60;
        color = "0xee1a1a1a";
        #color_inactive = unset;
        range = 4;
        offset = "1 2";
        render_power = if osConfig.networking.hostName == "tangier" then 1 else 3;
        scale = 0.97;
      };
      blur = {
        enabled = true;
        size = 2; # 2,,
        passes = 3; # 1:: - more strain on gpu-help with higher blur sizes looking wrong
        xray = true; # if enabled, floating windows will ignore tiled windows in their blur. Only available if new_optimizations is true. Will reduce overhead on floating blur significantly.
        # vibrancy = 0.1696; #0.1696::, [0.0-1.0] saturation of blurred colours
        noise = 0.01;
      };

      rounding = 4; # 5, 0::
      rounding_power = 4.0; # 2.0::, larger is smoother, 2 is circle, 4 is squircle [2.0-10.0]
      active_opacity = 1;
      # inactive_opacity = 0.95;
      dim_special = 0.7; # 0.0 - 1.0
      dim_around = 0.4; # dimaround rule
      # dim_strength = 0.8; # how much inactive windows should be dimmed [0.0 - 1.0]
      dim_inactive = false;
      # screen_shader
    };

    # render = {
    # explicit-sync = 2; # 2-auto based on gpu driver::,1 - yes, 0-no
    # };
    group = {
      group_on_movetoworkspace = true; # false::whether using movetoworkspace[silent] will merge the window into the workspace’s solitary unlocked group
      groupbar = {
        font_family = "nunito"; # misc:font_family if not specified
        font_size = 14; # 8::
        # stacked = true; # render the groupbar as a vertical stack
        "col.active" = "0x8600FFF5"; # 0x66ffff00
        "col.inactive" = "0x3300FFF5";
        # col.locked_active
        # col.locked_inactive
        keep_upper_gap = false;
      };
    };
    misc = {
      # "col.splash" = "rgba(195,232,141,1.0)";
      # animate_manual_resizes = true; # false::
      # disable_xdg_env_checks = false; #false::
      # font_family = "quicksand";
      # force_default_wallpaper = if osConfig.networking.hostName == "carthage" then "0" else "1"; #anime mascot wallpapers
      # middle_click_paste = if osConfig.networking.hostName == "carthage" then false else true;
      mouse_move_focuses_monitor = true; # true::NOTE important for quickshell focus to work proper
      allow_session_lock_restore = true; # NOTE new
      # splash_font_family = "VictorMono Nerd Font"; # FIXME not working lol ofcourse
      #disable_splash_rendering = true
      #initial_workspace_tracking = 1; #0, 1::(single-shot), 2 -persistent/children
      close_special_on_empty = true;
      disable_hyprland_logo = true; # wallpaper + logo lol
      #background_colur = 0x111111; # with logo disabled
      focus_on_activate = true; # solves rofi issue lol # focus apps that request to be focused(activate request)
      initial_workspace_tracking = true; # NOTE new
      font_family = "JetBrainsMono Nerd Font";
      force_default_wallpaper = 2; # -1 random, 2 (anime), 0/1 - disable anime
      key_press_enables_dpms = true; # false:: #wakes monitor if key pressed
      # mouse_move_enables_dpms = true;
      layers_hog_keyboard_focus = true; # keyboard interactive layers keep focus on mouse move, fix bittorrent etc pop ups
      new_window_takes_over_fullscreen = 2; # 2 - unfullscreen, 1 -takes over, -nothing/staybehind -0
      vrr = if osConfig.networking.hostName == "carthage" then 3 else 0; # 1 -on,2 -fullscreen # adaptive sync
      # vfr = true;::
    };
    cursor = {
      # warp_back_after_non_mouse_input = true; # Warp the cursor back to where it was after using a non-mouse input to move it, and then returning back to mouse.
      #no_hardware_cursors = true; #invis cursor
      #persistent_warps = true; # maintain cursor position on switch rather than center
      #warp_on_change_workspace = true; # cursor to last focused window
      enable_hyprcursor = true;
      hide_on_key_press = true;
      no_warps = true; # false:: focusing, keybinds etc - dont warp cursor
      # warp_back_after_non_mouse_input = true; # false:: NOTE new
      # sync_gsettings_theme = true; # true::
      default_monitor = "HDMI-A-1"; # NOTE new
    };

    ecosystem = {
      no_donation_nag = true;
      # enforce_permissions = true; # false::
    };

    binds = {
      workspace_center_on = 1; # Whether switching workspaces should center the cursor on the workspace (0) or on the last active window for that workspace (1)
      workspace_back_and_forth = true; # false::
      hide_special_on_workspace_change = true; # false::
      allow_workspace_cycles = true; # false::           # NOTE new
      # disable_keybind_grabbing             # eg vm prevent shortcircuit keybinds global
    };

    animations = {
      enabled = false;
      bezier = [
        # TODO better animations
        "myBezier, 0.05, 0.9, 0.1, 1.05"
        "darthBez,0.5, 0, 0.75, 0"
        "easeOutBack, 0.34, 1.56, 0.64, 1"
        "custom, 0.65, 0.34, 0.49, 0.74" # 5
        "easeInQuad, 0.55, 0.85, 0.68, 0.53"
        "easeOutQuad, 0.25, 0.46, 0.45, 0.94"
        "easeInOutQuad,0.65, 0, 0.35, 1"
      ];
      # first_launch_animation = false;
      workspace_wraparound = true; # false::
      animation = [
        "windows, 1, 2, easeInOutQuad, popin"
        "workspaces, 1, 3, easeInOutQuad, slide"
      ];
    };

    dwindle = {
      pseudotile = false; # false:: Pseudotiled windows retain their floating size when tiled.
      preserve_split = true; # if enabled, the split (side/top) will not change regardless of what happens to the container. #TODO: test to restore float to usual size
      force_split = 0; # 0 -> split follows mouse, 1 -> always split to the left (new = left or top) 2 -> always split to the right (new = right or bottom)
      # split_bias = 1; #specifies which window will receive the larger half of a split. positional - 0, current window - 1, opening window - 2 [0/1/2]
    };
  };
}
