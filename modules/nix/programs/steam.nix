{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.steamy = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf config.steamy.enable {
    programs.steam = {
      enable = if config.networking.hostName == "tangier" then false else true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true; # Integrates with programs.steam
    };

    programs.gamemode.enable = true;

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    hardware.xone.enable = true; # support for the xbox controller USB dongle

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    hardware.graphics = {
      enable32Bit = true; # radv - freedesktop
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
  };
}
