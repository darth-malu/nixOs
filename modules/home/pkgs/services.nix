{
  lib,
  osConfig,
  pkgs,
  ...
}:

{
  services = {
    # kdeconnect.enable = true;
    blueman-applet.enable = lib.mkIf osConfig.programs.hyprland.enable true;
    udiskie = {
      enable = lib.mkIf osConfig.programs.hyprland.enable true;
      tray = "auto"; # works
      notify = true;
      automount = false; # better?
      # appindicator = true; # use if no icon shows...uses appindicator3
      settings = {
        # config written to .config/udiskie/config.yml
        # https://github.com/coldfix/udiskie/blob/master/doc/udiskie.8.txt#configuration
        # program_options = {
        #   udisks_version = 2;
        #   tray = true;
        # };
        # icon_names.media = [ "media-optical" ];
        # file-manager = "kitty -e 'yazi'";
        file-manager = "kitty -e 'yazi'";
        terminal = "${pkgs.kitty}/bin/kitty -e yazi";
        # file-manager = "/home/malu/.nix-profile/bin/yazi";
        # file-manager = "xdg-open";
      };
    };
  };
}
