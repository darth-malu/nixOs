{ pkgs, ... }:
{
  imports = [
    ./qemu
    ./n8n.nix
    ./docker.nix
    # ./kubernetes.nix
    # ./vmware.nix
    # ./virtualbox.nix
    ./tailscale.nix
  ];

  qemu.enable = false;
  docker.enable = true;
  n8n.enable = false;
  tailscale.enable = false;

  virtualisation.waydroid.enable = false;

  environment.systemPackages = [
    # pkgs.genymotion
  ];
}
