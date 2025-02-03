{
  wayland.windowManager.hyprland.settings = {
      general = {
        "col.active_border" = "rgba(00FFF5aa)";
        gaps_in = 6; gaps_out = 12;
        #gaps_in = 6;
        #gaps_out = 12;
        border_size = 1;
        resize_on_border = false; # false::
        layout = "dwindle";
        allow_tearing = false;
        no_border_on_floating = true;
        hover_icon_on_border = true;
        no_focus_fallback = true; #false, will not fall back to the next available window when moving focus in a direction where no window was found
        snap = {
          enabled = true;
          window_gap = 10;
          monitor_gap = 10;
          border_overlap = true; #false::, if true one borders worth btwn windows
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
          size = 2;#2,,
          passes = 3;#2,,
          # vibrancy = 0.1696; #0.1696::, [0.0-1.0] saturation of blurred colours
        };


        rounding = 5;
        rounding_power = 4.0; # 2.0::, larger is smoother, 2 is circle, 4 is squircle [2.0-10.0]
        active_opacity = 1;
        # inactive_opacity = 0.95;
        dim_special = 0.8; # 0.0 - 1.0
        dim_around = 0.7; # dimaround rule
        # dim_strength = 0.8;
        dim_inactive = false;
      };

      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "darthBez,0.5, 0, 0.75, 0"
          "easeOutBack, 0.34, 1.56, 0.64, 1"
          "custom, 0.65, 0.34, 0.49, 0.74" #5
          "easeInQuad, 0.55, 0.85, 0.68, 0.53"
          "easeOutQuad, 0.25, 0.46, 0.45, 0.94"
          "easeInOutQuad,0.65, 0, 0.35, 1"
        ];
        first_launch_animation = false;
        animation = [
          # default stable
          # "windows, 1, 4, custom"
          # "workspaces, 1, 4, default, slide"
          # "windows, 1, 5, myBezier, popin"
          # "windowsOut, 1, 2, default"
          # "windowsOut, 1, 2, myBezier, popin"
          # "workspaces, 1, 2, default, slide"

          # "windows, 1, 5, easeInOutQuad, popin 20%"
          # "windowsOut, 1, 7, default, popin 80%"
          # "windowsOut, 1, 2, easeOutQuad, fade"
          # "windowsOut, 1, 3, myBezier"
          # notes
          # poping % - not clean for windowsIn

          # "windowsIn, 1, 2, easeInOutQuad, popin"
          "windows, 1, 2, easeInOutQuad, popin"
          # "workspaces, 1, 4, myBezier, slide"

          # "border, 1, 4, myBezier"
          # "windows, 1, 5, easeInOutQuad, popin"
          # "borderangle, 1, 8, darthBez, loop" #loop,once? default
          # "borderangle, 1, 4, myBezier" #loop,once? default
          # "fade, 1, 7, default"

          # "fade, 0"

          # "fadeIn, 1, 6, easeInOutQuad"
          # experimental
          "workspaces, 1, 3, easeInOutQuad, slide"
          # "specialWorkspace, default, slidevert"
          # "specialWorkspaceIn, easeInOutQuad, slide bottom"
          # "specialWorkspaceOut, easeInOutQuad, slide up"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 0;
        split_bias = 1; #specifies which window will receive the larger half of a split. positional - 0, current window - 1, opening window - 2 [0/1/2]
      };
  };
}
