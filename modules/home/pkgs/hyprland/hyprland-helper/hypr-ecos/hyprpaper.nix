{
  osConfig,
  lib,
  config,
  ...
}:

{
  options.hyprpaper = {
    enable = lib.mkEnableOption "hyprpaper";
  };

  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = false;
        splash = true;
        preload =
          if osConfig.networking.hostName == "carthage" then
            [
              "$HOME/Pictures/wallpaperS/games/riot games/jinx.png"
              # "$HOME/Pictures/wallpaperS/games/riot games/thresh_purp.png"
              "$HOME/Pictures/wallpaperS/games/riot games/singed-4096x2305.jpg"
              # "$HOME/Pictures/wallpaperS/games/riot games/zaun_boy.png"
            ]
          else
            [
              "$HOME/Pictures/wallpaperS/games/riot games/singed.png"
            ];
        wallpaper =
          if osConfig.networking.hostName == "carthage" then
            [
              "DP-3,$HOME/Pictures/wallpaperS/games/riot games/jinx.png"
              "HDMI-A-1,$HOME/Pictures/wallpaperS/games/riot games/singed-4096x2305.jpg"
            ]
          else if osConfig.networking.hostName == "tangier" then
            [ "eDP-1,$HOME/Pictures/wallpaperS/games/riot games/singed.png" ]
          else
            [ ];
      };
    };
  };
}
