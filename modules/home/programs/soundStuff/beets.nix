{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.beets = {
    enable = true;
    settings = {
      directory = "~/Music/Spotubae";
      library = "~/.local/share/beets/beetsMusic.db";
      plugins = [
        "musicbrainz"
        "fetchart"
        "embedart"
        "lastgenre"
      ];
      fetchart = {
        auto = true;
        sources = [
          "filesystem"
          "coverart"
          "itunes"
          "amazon"
        ];
      };
    };

  };
}
