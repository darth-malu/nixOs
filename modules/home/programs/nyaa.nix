{ inputs, ... }:
{
  imports = [
    inputs.nyaa.homeManagerModule
  ];
  #https://github.com/Beastwick18/nyaa/wiki/General-Configuration
  programs.nyaa = {
    enable = false;
    default_theme = "Gruvbox"; # Dracula, Gruvbox, Catppuccin Macchiato, Default - also user themes FIXME: theme does not exist
    # default_source = "Nyaa"; # Nyaa:: , TorrentGalaxy, Sukebei
    download_client = "qBittorrent";
    timeout = 30; # request timeout for sources and clients (measured in seconds)
    cursor_padding = 4; # cursor padding for input fields
    scroll_padding = 6; # scroll padding for results table
    # notifications = {
    #   position = "TopRight";
    #   duration = 3.0;
    #   max_width = 75;
    #   animation_speed = 4.0;
    # };
  };
}
