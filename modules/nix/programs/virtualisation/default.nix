{ config, ... }:
{
  imports = [
    ./qemu
    ./n8n.nix
    ./docker.nix
  ];

  docker.enable = if config.networking.hostName == "tangier" then false else true;
  qemu.enable = if config.networking.hostName == "tangier" then false else false;
  n8n.enable = if config.networking.hostName == "tangier" then false else false;
}
