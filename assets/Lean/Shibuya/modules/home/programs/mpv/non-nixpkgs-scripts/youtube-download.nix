{
  home.file = {
    "youtube-download" = {
      enable = true;
      source = ./lua/youtube-download.lua;
      target = ".config/mpv/scripts/youtube-download.lua";
    };
    "youtube-search" = {
      enable = true;
      source = ./lua/youtube-search.lua;
      target = ".config/mpv/scripts/youtube-search.lua";
    };
  };
}
