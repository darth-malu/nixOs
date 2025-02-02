{pkgs, ...}:
{
  home.packages = with pkgs; [
    grimblast slurp viewnior feh vlc cliphist
    nautilus sushi yelp file-roller
  ];
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
