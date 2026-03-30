{
  pkgs,
  osConfig,
  lib,
  config,
  ...
}:

{
  options.lutris-malu = {
    enable = lib.mkEnableOption "lutris custom carthage";
  };

  config = lib.mkIf config.lutris-malu.enable {
    programs.lutris = {
      enable = true;
      extraPackages =
        with pkgs;
        [
          mangohud
          winetricks
          gamescope
          gamemode
          umu-launcher
          protobuf # for battle.net
        ]
        ++ [
          # libgudev
          # speex
          # libtheora
          # gst_all_1.gstreamer
          # gst_all_1.gst-plugins-base
          # gst_all_1.gst-plugins-good
        ];
      # protonPackages = [ pkgs.proton-ge-bin ];
      steamPackage = osConfig.programs.steam.package;
      winePackages = [ pkgs.wineWow64Packages.waylandFull ];
      # defaultWinePackage = pkgs.proton-ge-bin;
      # runners = {
      #   cemu.package = pkgs.cemu;
      #   pcsx2.config = {
      #     system.disable_screen_saver = true;
      #     runner.runner_executable = "$\{pkgs.pcsx2}/bin/pcsx2-qt";
      #   };
      # };
    };
  };
}
