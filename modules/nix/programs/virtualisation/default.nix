{ config, ... }:
{
  imports = [
    ./qemu
    ./n8n.nix
    ./docker.nix
  ];

  docker.enable = true;
  qemu.enable = false;
  n8n.enable = true;
}
