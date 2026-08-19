{
  lib,
  osConfig,
  config,
  ...
}:

{
  # systemd.user.services.udiskie.Unit.After = lib.mkForce "graphical-session.target";
  services = {
    # kdeconnect.enable = true;
    # blueman-applet.enable = lib.mkIf osConfig.programs.hyprland.enable false;
    # blanket.enable = true;
    clipman = {
      enable = false;
      # extraArgs = '''';
      # systemdTarget = "hyprland-session.target";
      systemdTarget = "graphical-session.target";
    };
    cliphist = {
      enable = true;
      # allowImages = true;       # true::
      extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "500"
      ];
      systemdTargets = [
        config.wayland.systemd.target
        "hyprland-session.target"
      ];
    };
    udiskie = {
      enable = lib.mkIf osConfig.programs.hyprland.enable true;
      tray = "auto";
      notify = true;
      automount = true;
      settings = {
        # config written to .config/udiskie/config.yml
        # https://github.com/coldfix/udiskie/blob/master/doc/udiskie.8.txt#configuration
        # program_options = {
        #   udisks_version = 2;
        #   tray = true;
        # };
        # icon_names.media = [
        #   "media-optical"
        #   "drive-removable-media"
        # ];
        # file-manager = "kitty -e 'yazi'";
        # file-manager = "xdg-open";
        menu = "flat"; # nested::
        # terminal = "${pkgs.kitty}/bin/kitty -e yazi";
      };
    };
  };
}
