{ config, ... }:
{
  imports = [
    ./qemu
    ./n8n.nix
    ./docker.nix
  ];

  qemu.enable = false;
  docker.enable = true;
  n8n.enable = false;
}
