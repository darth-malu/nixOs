{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  programs.lutris = {
    enable = true;
    extraPackages = [
      "with pkgs; [mangohud winetricks gamescope gamemode umu-launcher]"
    ];
    protonPackages = [ pkgs.proton-ge-bin ];
    steamPackage = osConfig.programs.steam.package;
    winePackages = [ pkgs.wineWow64Packages.full ];
    defaultWinePackage = pkgs.proton-ge-bin;
    # runners = {
    #   cemu.package = pkgs.cemu;
    #   pcsx2.config = {
    #     system.disable_screen_saver = true;
    #     runner.runner_executable = "$\{pkgs.pcsx2}/bin/pcsx2-qt";
    #   };
    # };
  };
}
