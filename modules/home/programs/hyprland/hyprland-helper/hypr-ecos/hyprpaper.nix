{
  osConfig,
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

{
  options.hyprpaper = {
    enable = lib.mkEnableOption "hyprpaper";
  };

  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      package = inputs.hyprpaper.packages.${pkgs.system}.hyprpaper;
      settings = {
        # ipc = false;
        splash = true;
        # splash_offset = 2.0;
        preload =
          if osConfig.networking.hostName == "carthage" then
            [
              "$HOME/Pictures/wallpaperS/games/riot games/jinx.png"
              "$HOME/Pictures/wallpaperS/games/riot games/singed-HQ.jpg"
            ]
          else
            [
              "$HOME/Pictures/wallpaperS/games/riot games/singed-HQ.jpg"
            ];
        wallpaper =
          if osConfig.networking.hostName == "carthage" then
            [
              "DP-3,$HOME/Pictures/wallpaperS/games/riot games/jinx.png"
              "HDMI-A-1,$HOME/Pictures/wallpaperS/games/riot games/singed-HQ.jpg"
            ]
          else
            [ "eDP-1,$HOME/Pictures/wallpaperS/games/riot games/singed.png" ];
      };
    };
  };
}
