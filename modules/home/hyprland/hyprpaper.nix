{inputs,pkgs, ...}:

{
  services.hyprpaper = {
    enable = true;
    # importantPrefixes = [];#TODO: make cleaner with this
    # package = inputs.hyprpaper.nixpkgs.hyprpaper; # set the flake package
    settings = {
      ipc = true; #true::
      splash = true;
      splash_offset = 2.0; # relative to bottom (% of height)
      splash_color = "#89B4FA"; #55ffffff::
      preload =
        [# hyprctl hyprpaper listloaded
          "/home/malu/Pictures/wallpapers/singed.png"
          "/home/malu/Pictures/wallpapers/thresh_purp.png"
          # "/home/malu/Pictures/wallpapers/wallhaven_chain.png"
          # "/home/malu/Pictures/wallpapers/1350152.png"
          # "/home/malu/Pictures/wallpapers/xayah2.png"
          # "/home/malu/Pictures/wallpapers/rakan-xayah.png"
        ];
      wallpaper = 
        [
          "HDMI-A-1,/home/malu/Pictures/wallpapers/singed.png"
          "DP-3,/home/malu/Pictures/wallpapers/thresh_purp.png"
          # "eDP-1,/home/malu/Pictures/wallpapers/singed.png"
      # if osConfig.networking.hostName == "carthage" then [
      #   "HDMI-A-1,/home/malu/Pictures/wallpapers/singed.png"
      #   "DP-3,/home/malu/Pictures/wallpapers/thresh_purp.png"
      # ] else
      #   (if osConfig.networking.hostName == "tangier" then [
      #     "eDP-1,/home/malu/Pictures/wallpapers/singed.png"
      #   ] else []);
        ];
    };
    };
}
