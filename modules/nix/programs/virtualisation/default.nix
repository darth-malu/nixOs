{ pkgs, ... }:
{
  imports = [
    ./qemu
    ./n8n.nix
    ./docker.nix
    ./vmware.nix
    # ./virtualbox.nix
    ./tailscale.nix
  ];

  qemu.enable = false;
  docker.enable = false;
  n8n.enable = false;

  virtualisation.waydroid.enable = false;

  environment.systemPackages = [
    pkgs.genymotion
  ];
}
