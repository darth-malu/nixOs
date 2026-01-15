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
        # preload =
        #   if osConfig.networking.hostName == "carthage" then
        #     [
        #       "$HOME/Pictures/wallpaperS/games/riot games/jinx.png"
        #       "$HOME/Pictures/wallpaperS/games/riot games/singed-HQ.jpg"
        #     ]
        #   else
        #     [
        #       "$HOME/Pictures/wallpaperS/games/riot games/singed-HQ.jpg"
        #     ];
        wallpaper = {
          monitor = "HDMI-A-1";
          path = "$HOME/Pictures/wallpaperS/games/riot games/singed-HQ.jpg";
          fit_mode = "fill"; # cover::, tile, contain
        };

        # wallpaper {
        #     monitor = DP-2
        #     path = ~/myFile2.jxl
        #     fit_mode = cover
        # }

        # wallpaper {
        #     monitor =
        #     path = ~/fallback.jxl
        #     fit_mode = cover
        # }
        #         wallpaper =
        #           if osConfig.networking.hostName == "carthage" then
        #             [
        #               "DP-3,$HOME/Pictures/wallpaperS/games/riot games/jinx.png"
        #               "HDMI-A-1,$HOME/Pictures/wallpaperS/games/riot games/singed-HQ.jpg"
        #             ]
        #           else
        #             [ "eDP-1,$HOME/Pictures/wallpaperS/games/riot games/singed.png" ];
      };
    };
  };
}
