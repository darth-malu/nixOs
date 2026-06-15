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

  qemu.enable = true;
  docker.enable = true;
  n8n.enable = false;

  virtualisation.waydroid.enable = false;

  # For VBOX
  users.extraGroups.vboxusers.members = [ "malu" ];

  environment.systemPackages = [
    pkgs.genymotion
  ];
}
