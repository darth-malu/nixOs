{
  imports = [
    ./qemu
    ./n8n.nix
    ./docker.nix
  ];

  docker.enable = false;
  qemu.enable = false;
  n8n.enable = false;
}
