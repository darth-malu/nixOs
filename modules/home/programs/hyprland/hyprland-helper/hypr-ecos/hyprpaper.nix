{
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
        ipc = true;
        splash = true;
        # splash_offset = 2.0; #20::
        splach_opacity = 0.7; # 0.8::
        wallpaper = {
          monitor = "HDMI-A-1";
          path = "$HOME/Pictures/wallpaperS/games/riot games/singed-LQ.png";
          # fit_mode = "fill"; # cover::, tile, contain
        };

        # hyprctl hyprpaper wallpaper '[mon], [path], [fit_mode]'

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
