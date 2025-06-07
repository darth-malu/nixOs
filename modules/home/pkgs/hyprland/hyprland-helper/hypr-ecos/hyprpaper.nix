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
      # enable = lib.mkIf (osConfig.kde.enable == false) true;
      enable = true;
      settings = {
        ipc = true;
        splash = true;
        preload =
          if osConfig.networking.hostName == "carthage" then
            [
              "$HOME/Pictures/wallpaperS/jinx.png"
              "$HOME/Pictures/wallpaperS/thresh_purp.png"
              "$HOME/Pictures/wallpaperS/singed-4096x2305.jpg"
            ]
          else if osConfig.networking.hostName == "tangier" then
            [ "$HOME/Pictures/wallpaperS/vi_xander.png" ]
          else
            [ ];
        # wallpaper = wall;
        wallpaper =
          if osConfig.networking.hostName == "carthage" then
            [
              "HDMI-A-1,$HOME/Pictures/wallpaperS/jinx.png"
              "DP-3,$HOME/Pictures/wallpaperS/singed-4096x2305.jpg"
            ]
          else if osConfig.networking.hostName == "tangier" then
            [ "eDP-1,$HOME/Pictures/wallpaperS/vi_xander.png" ]
          else
            [ ];
      };
    };
  };
}
