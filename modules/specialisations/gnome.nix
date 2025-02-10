{pkgs,lib,...}:
{
    services = {
      # gnome.core-utilities.enable = false; # disable all gnome apps
      gnome = {
        core-utilities.enable = false;
        localsearch.enable = false;
        tinysparql.enable = false;
      };
      xserver = {
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        };
      };
      programs = {
        hyprland.enable = lib.mkForce false;
        hyprland.withUWSM = lib.mkDefault false;
      };

      environment.systemPackages = [ pkgs.gnomeExtensions.appindicator ];
      services.udev.packages = [ pkgs.gnome-settings-daemon ];

      environment.gnome.excludePackages = with pkgs; [
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
}
