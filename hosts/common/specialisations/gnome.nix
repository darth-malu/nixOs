{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gnome = {
    enable = lib.mkEnableOption "Gnome";
  };

  config = lib.mkIf config.gnome.enable {
    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      gnome = {
        core-apps.enable = true;
        localsearch.enable = false;
        tinysparql.enable = false;
      };
      # xserver = {
      #   displayManager.gdm.enable = true;
      #   desktopManager.gnome.enable = true;
      # };
    };

    services.udev.packages = [ pkgs.gnome-settings-daemon ];

    programs.dconf.enable = true;

    environment = {
      systemPackages = [ pkgs.gnomeExtensions.appindicator ];
      gnome.excludePackages = with pkgs; [
        orca
        baobab
        epiphany
        gnome-console
        # gnome-contacts
        gnome-font-viewer
        gnome-logs
        gnome-maps
        # gnome-music
        # gnome-system-monitor
        # gnome-weather
        # loupe
        gnome-connections
        simple-scan
        snapshot
        totem
        yelp
        gnome-software
      ];
    };
  };
}
