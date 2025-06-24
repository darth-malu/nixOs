{ osConfig, ... }:
{
  wayland.windowManager.hyprland.settings = {
    general = {
      # https://wiki.hyprland.org/Configuring/Variables/
      "col.active_border" = "rgba(00FFF5aa)";
      gaps_in = 6; # NOTE: space essential for gaps script
      gaps_out = 12;
      #gaps_in = 6;
      #gaps_out = 12;
      border_size = 1;
      resize_on_border = true;
      hover_icon_on_border = false;
      layout = "dwindle";
      allow_tearing = false;
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
        enabled = true;
        #"col.shadow" = "rgba(1E202966)";
        #shadow_range = 60;
        color = "0xee1a1a1a";
        #color_inactive = unset;
        range = 4;
        offset = "1 2";
        render_power = 3;
        scale = 0.97;
      };

      blur = {
        enabled = true;
        size = 2; # 2,,
        passes = 3; # 2,,
        xray = true; # if enabled, floating windows will ignore tiled windows in their blur. Only available if new_optimizations is true. Will reduce overhead on floating blur significantly.
        # vibrancy = 0.1696; #0.1696::, [0.0-1.0] saturation of blurred colours
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
    #   explicit-sync = 2; # 2-auto based on gpu driver::,1 - yes, 0-no
    # };
    misc = {
      font_family = "JetBrainsMono Nerd Font";
      # font_family = "quicksand";
      # force_default_wallpaper = if osConfig.networking.hostName == "carthage" then "0" else "1"; #anime mascot wallpapers
      force_default_wallpaper = 2; # -1 random, 2 (anime), 0/1 - disable anime
      # vfr = true; # true:: recommend leave on# lower the amount of sent frames when nothing is happening on-screen.
      vrr = if osConfig.networking.hostName == "carthage" then 1 else 0; # 1 -on,2 -fullscreen # adaptive sync
      new_window_takes_over_fullscreen = 2; # 2 - unfullscreen, 1 -takes over, -nothing/staybehind -0
      close_special_on_empty = true;
      disable_hyprland_logo = true; # wallpaper + logo lol
      #disable_splash_rendering = true
      "col.splash" = "rgba(195,232,141,1.0)";
      splash_font_family = "VictorMono Nerd Font"; # FIXME not working lol ofcourse
      key_press_enables_dpms = true; # false:: #wakes monitor if key pressed
      # middle_click_paste = if osConfig.networking.hostName == "carthage" then false else true;
      middle_click_paste = true;
      # animate_manual_resizes = true;
      focus_on_activate = true; # solves rofi issue lol # focus apps that request to be focused(activate request)
      #mouse_move_enables_dpms = true
      # mouse_move_focuses_monitor = true; #true::
      #initial_workspace_tracking = 1; #0, 1::(single-shot), 2 -persistent/children
      # disable_xdg_env_checks = false; #false::
      layers_hog_keyboard_focus = true; # keyboard interactive layers keep focus on mouse move, fix bittorrent etc pop ups
      #background_colur = 0x111111;
    };

    cursor = {
      no_warps = true;
      enable_hyprcursor = true;
      #no_hardware_cursors = true; #invis cursor
      #persistent_warps = true; # maintain cursor position on switch rather than center
      hide_on_key_press = true;
      #warp_on_change_workspace = true; # cursor to last focused window
      sync_gsettings_theme = true; # true::
    };

    binds = {
      workspace_center_on = 1; # Whether switching workspaces should center the cursor on the workspace (0) or on the last active window for that workspace (1)
      workspace_back_and_forth = true;
    };

    animations = {
      enabled = true;
      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
        "darthBez,0.5, 0, 0.75, 0"
        "easeOutBack, 0.34, 1.56, 0.64, 1"
        "custom, 0.65, 0.34, 0.49, 0.74" # 5
        "easeInQuad, 0.55, 0.85, 0.68, 0.53"
        "easeOutQuad, 0.25, 0.46, 0.45, 0.94"
        "easeInOutQuad,0.65, 0, 0.35, 1"
      ];
      first_launch_animation = false;
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
