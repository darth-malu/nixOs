{
  osConfig,
  inputs,
  pkgs,
  ...
}:

{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.hyprpaper;
    settings = {
      ipc = true;
      splash = true;
      # splash_offset = 2.0; #20::
      splash_opacity = 0.7; # 0.8::
      wallpaper =
        if osConfig.networking.hostName == "carthage" then
          [
            {
              monitor = "HDMI-A-1";
              path = "$HOME/Pictures/wallpaperS/games/riot games/singed.png";
              # path = "$HOME/Pictures/wallpaperS/art/camp-night-vk.jpg";
            }
            {
              monitor = "DP-3";
              path = "$HOME/Pictures/wallpaperS/games/riot games/jinx.png";
              # fit_mode = "fill"; # cover::, tile, contain
            }
          ]
        else
          {
            monitor = "eDP-1";
            path = "$HOME/Pictures/Wallpapers/singed-LQ.png";
          };
    };
  };
}
