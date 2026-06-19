{ config, lib, ... }:

{
  # client will use this account on the remote
  # ENable distributed builds on client
  # users.users.remotebuild = lib.mkIf (config.networking.hostName == "carthage") {
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrwiQoWlBZ5OCuw8pF2CWM1iJjI4pW5FZvq5b5RktOH Tangier"
    ]; # tangier/remote machine ssh key
  };

  users.groups.remotebuild = { };

  nix = {
    nrBuildUsers = 64;
    settings = {
      trusted-users = [
        "remotebuild"
        "malu"
      ];
      min-free = 10 * 1024 * 1024;
      max-free = 200 * 1024 * 1024;

      max-jobs = "auto";
      cores = 0;
    };
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "90%";
    OOMScoreAdjust = 500;
  };
  # nixos-rebuild boot --target-host malu@192.168.100.3 --use-remote-sudo --flake ~/Shibuya#tangier --ask-sudo-password # from tangier
}
