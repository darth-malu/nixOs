{ config, ... }:
{
  programs.steam = {
    enable = if config.networking.hostName == "tangier" then false else true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.gamemode.enable = true;

  hardware.xone.enable = true; # support for the xbox controller USB dongle
}
