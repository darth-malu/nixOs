{
  lib,
  config,
  ...
}:
{
  imports = [
    ./keybinds
    ./monitors-peripherals.nix
    ./ui.nix
    ./environment_variables.nix # avoid use .conf/uwsm/env - check file
    ./window-workspace-rules.nix
    ./autoStart.nix
    ./hyprland-helper
    # ./plugins.nix
  ];

  options.homeHyprland = {
    enable = lib.mkEnableOption "Enable Hyprland home config";
  };

  config = lib.mkIf config.homeHyprland.enable {

    waybar.enable = true;
    dunst.enable = true;
    rofi.enable = true;
    hyprpaper.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;

    wayland.windowManager.hyprland = {
      # configures Hyprland and adds it to your user’s PATH, but does not make certain system-level changes. the NixOS module makes system-level changes such as adding a desktop session entry.
      enable = true;
      package = null;
      portalPackage = null;
      # systemd = {
      # enable = false; # import to systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE #WARN: last change true -> false
      # enableXdgAutostart = true;
      # extraCommands = [# Extra commands to be run after D-Bus activation.
      # "systemctl --user stop hyprland-session.target"
      # "systemctl --user start hyprland-session.target"
      # ];
      # variables = [
      # imported to systemd dbus enviroments
      # "--all" # does dbus-update-activation-environment --systemd --all
      # ];
      # };
      extraConfig = ''
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
        binde=,right,moveactive,20 0
        binde=,left,moveactive,-20 0
        binde=,up,moveactive,0 -20
        binde=,down,moveactive,0 20
        bind=,escape,submap,reset
        submap=reset
      '';
      settings = {
      };
    };
  };
}
