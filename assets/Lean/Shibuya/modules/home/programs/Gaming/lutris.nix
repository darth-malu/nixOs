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
      enable = false;
      extraPackages = with pkgs; [
        mangohud
        winetricks
        gamescope
        gamemode
        umu-launcher
        protobuf # for battle.net
      ];
      # protonPackages = [ pkgs.proton-ge-bin ];
      steamPackage = osConfig.programs.steam.package;
      winePackages = [ pkgs.wineWow64Packages.waylandFull ];
      # defaultWinePackage = pkgs.proton-ge-bin;
    };
  };
}
