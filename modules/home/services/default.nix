{
  pkgs,
  lib,
  osConfig,
  ...
}:

{
  services = {
    # kdeconnect.enable = true;
    blueman-applet.enable = lib.mkIf osConfig.programs.hyprland.enable true;
    blanket.enable = true;
    udiskie = {
      enable = lib.mkIf osConfig.programs.hyprland.enable false;
      tray = "auto"; # works
      notify = true;
      automount = true; # better?
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
        file-manager = "xdg-open";
        menu = "flat"; # nested::
        terminal = "${pkgs.kitty}/bin/kitty -e yazi";
      };
    };
  };
}
