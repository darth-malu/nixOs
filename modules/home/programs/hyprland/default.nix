{
  # imports = [
  #   ./keybinds
  #   ./monitors-peripherals.nix
  #   ./ui.nix
  #   ./hyprland-environment-variables.nix # avoid use .conf/uwsm/env - check file
  #   ./window-workspace-rules.nix
  #   ./autoStart.nix
  #   # ./plugins.nix
  # ];

  config = {
    wayland.windowManager.hyprland = {
      # configures Hyprland and adds it to your user’s PATH, but does not make certain system-level changes. the NixOS module makes system-level changes such as adding a desktop session entry.
      enable = true;
      package = null;
      portalPackage = null;
      systemd = {
        # Whether to enable hyprland-session.target on hyprland startup. This links to graphical-session.target. Some important environment variables will be imported to systemd and D-Bus user environment before reaching the target, including
        # DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE.
        enable = false; # true:: confilicts with uwsm
        # enableXdgAutostart = true;
        # extraCommands = [
        #   # Extra commands to be run after D-Bus activation.
        #   "systemctl --user stop hyprland-session.target"
        #   "systemctl --user start hyprland-session.target"
        # ];
        # variables = [
        #   # imported to systemd dbus enviroments
        #   "--all" # does dbus-update-activation-environment --systemd --all
        # ];
      };
    };
  };
}
