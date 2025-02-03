{pkgs, pkgs-unstable, ...}:
{
  home.packages = with pkgs; [
    grimblast slurp viewnior vlc cliphist
    nautilus sushi yelp file-roller
  ];

  programs.feh = {
    enable = true;
    package = pkgs-unstable.feh;
    keybindings = {
      prev_img = [
        "h"
        "Left"
      ];
      zoom_in = "plus";
      zoom_out = "minus";
    };
    buttons = {
      prev_img = [
        3
        "C-3"
      ];
      zoom_in = 4;
      zoom_out = "C-4";
    };
    themes = {
      booth = [
        "--full-screen"
        "--hide-pointer"
        "--slideshow-delay"
        "20"
      ];
      example = [
        "--info"
        "foo bar"
      ];
      feh = [
        "--image-bg"
        "black"
      ];
      imagemap = [
        "-rVq"
        "--thumb-width"
        "40"
        "--thumb-height"
        "30"
        "--index-info"
        "%n\\n%wx%h"
      ];
      present = [
        "--full-screen"
        "--sort"
        "name"
        "--hide-pointer"
      ];
      webcam = [
        "--multiwindow"
        "--reload"
        "20"
      ];
    };
  };
  services = {
    # kdeconnect.enable = true;
    udiskie = {
      enable = true;
      tray = "auto";
      notify = true;
      automount = true;
      settings = {
        program_options = {
          # udisks_version = 2;
          tray = true;
        };
        icon_names.media = [ "drive-removable-media" ];
        menu = "flat";
        file_manager = "uwsm app -s a kitty -e yazi";
        # quickmenu_actions: [mount, unmount, unlock, terminal, detach, delete]
      };
    };
  };
}
