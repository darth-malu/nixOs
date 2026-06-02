{ config, ... }:
{
  imports =
    if config.networking.hostName == "tangier" then
      [
      ]
    else
      [
        ./androidStudio.nix
      ];
}
