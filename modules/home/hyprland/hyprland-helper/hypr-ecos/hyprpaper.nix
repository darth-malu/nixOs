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
              "$HOME/Pictures/wallpapers/singed-4096x2305.jpg"
              "$HOME/Pictures/wallpapers/jinx.png"
              "$HOME/Pictures/wallpapers/thresh_purp.png"
            ]
          else if osConfig.networking.hostName == "tangier" then
            [ "$HOME/Pictures/wallpapers/vi_xander.png" ]
          else
            [ ];
        # wallpaper = wall;
        wallpaper =
          if osConfig.networking.hostName == "carthage" then
            [
              "HDMI-A-1,$HOME/Pictures/wallpapers/jinx.png"
              "DP-3,$HOME/Pictures/wallpapers/singed-4096x2305.jpg"
            ]
          else if osConfig.networking.hostName == "tangier" then
            [ "eDP-1,$HOME/Pictures/wallpapers/vi_xander.png" ]
          else
            [ ];
      };
    };
  };
}
