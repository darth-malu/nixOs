{osConfig, inputs, pkgs, lib, ...}:
{
  imports = [
    ./keybinds
    ./peripherals.nix
    ./ui.nix
    # ./environment_variables.nix # avoid use .conf/uwsm/env - check file
    ./windowWorkspaceRules.nix
    ./autoStart.nix
    # ./plugins.nix
  ];

  wayland.windowManager.hyprland = {
    enable = lib.mkDefault true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # xwayland.enable = true;
    systemd = {
      enable = false; # import to systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE
      # enableXdgAutostart = true;
      # extraCommands = []; # extra commands to run after dbus activation
      variables = [ # imported to systemd dbus enviroments
        # "SLURP_ARGS, -d -b -B F050F022 -b 10101022 -c ff00ff"
        # "HYPRCURSOR_THEME,hypr_Bibata-Modern-Ice"
        # "HYPRCURSOR_SIZE,24"
        # "QT_QPA_PLATFORM,wayland"
        "--all" # dbus-update-activation-environment --systemd --all
      ];
    };

    extraConfig = /*jsonc*/''
      # █▀█ █▀▀ █▀ █ ▀█ █▀▀
      # █▀▄ ██▄ ▄█ █ █▄ ██▄

      bind = $al, R, submap, resize
      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # █▀▄▀█ █▀█ █░█ █▀▀ ▄▀█ █▀▀ ▀█▀ █ █░█ █▀▀
      # █░▀░█ █▄█ ▀▄▀ ██▄ █▀█ █▄▄ ░█░ █ ▀▄▀ ██▄
      bind=ALT,M,submap,moveactive
      submap=moveactive
      binde=,right,moveactive,10 0
      binde=,left,moveactive,-10 0
      binde=,up,moveactive,0 -10
      binde=,down,moveactive,0 10
      bind=,escape,submap,reset
      submap=reset
    '';

    settings = {
      misc = {
        font_family = "JetBrainsMono Nerd Font";
        # font_family = "quicksand";
        # force_default_wallpaper = if osConfig.networking.hostName == "carthage" then "0" else "1"; #anime mascot wallpapers
        force_default_wallpaper = 0; # -1 random, 2 (anime), 0/1 - disable anime
        vfr = true; # lower the amount of sent frames when nothing is happening on-screen.
        vrr = if osConfig.networking.hostName == "carthage" then 1 else 0; # 1 -on,2 -fullscreen
        new_window_takes_over_fullscreen = "2"; # 2 - unfullscreen, 1 -takes over, -nothing/staybehind -0
        close_special_on_empty = true;
        disable_hyprland_logo = true; #wallpaper + logo lol
        #disable_splash_rendering = true
        splash_font_family = "quicksand";
        key_press_enables_dpms = true;#false:: #wakes monitor if key pressed
        middle_click_paste = if osConfig.networking.hostName == "carthage" then false else true;
        # animate_manual_resizes = true;
        focus_on_activate = true; #solves rofi issue lol # focus apps that request to be focused(activate request)
        #mouse_move_enables_dpms = true
        # mouse_move_focuses_monitor = true; #true::
        #initial_workspace_tracking = 1; #0, 1::(single-shot), 2 -persistent/children
        # disable_xdg_env_checks = false; #false::
        layers_hog_keyboard_focus = true; # keyboard interactive layers keep focus on mouse move, fix bittorrent etc pop ups
        #background_colur = 0x111111;
      };

      # cursor.no_hardware_cursors = true; # nvidia lul
      cursor = {
        no_warps = true;
        enable_hyprcursor = true;
        #no_hardware_cursors = true; #invis cursor
        #persistent_warps = true; # maintain cursor position on switch rather than center
        hide_on_key_press = true;
        #warp_on_change_workspace = true; # cursor to last focused window
        #sync_gsettings_theme = true;# true::
      };

      binds = {
        workspace_center_on = 1;#Whether switching workspaces should center the cursor on the workspace (0) or on the last active window for that workspace (1)
        workspace_back_and_forth = true;
      };
    };
  };
}
