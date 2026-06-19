{
  config,
  lib,
  pkgs,
  ...
}:

{
  # client will use this account on the remote
  # ENable distributed builds on client
  users.users.remotebuild = lib.mkIf (config.networking.hostName == "carthage") {
    # users.users.remotebuild = {
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

  nix = {
    distributedBuilds = lib.mkIf (config.networking.hostName != "carthage") true;
    buildMachines = lib.mkIf (config.networking.hostName != "carthage") [
      {
        # makes it so i dont have to use --builders "ssh://myuser@builder <other builder specification>"
        sshUser = "remotebuild"; # NOTE special user that cant be sudo'd into
        sshKey = "/home/malu/.ssh/id_ed25519"; # path to remote key on client (tangier)
        hostName = "192.168.1.4"; # Replace by IP address, or add a ProxyCommand, see `man ssh_config` for full docs.
        protocol = "ssh-ng"; # ssh:: ssh-ng ( ssh next generation)
        maxJobs = 3; # 1::
        speedFactor = 2; # The relative speed of this builder. This is an arbitrary integer that indicates the speed of this builder, relative to other builders. Higher is faster.
        # system = pkgs.stdenv.hostPlatform.system;
        system = "x86_64-linux";
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          # "kvm"
        ];
        mandatoryFeatures = [ ];
      }
    ];
    extraOptions = lib.mkIf (config.networking.hostName != "carthage") ''
      builders-use-substitutes = true
      keep-outputs = true;
      keep-derivations = true;
    ''; # optional, useful when the builder has a faster internet connection than yours
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "90%";
    OOMScoreAdjust = 500;
  };
  # nixos-rebuild boot --target-host malu@192.168.100.3 --use-remote-sudo --flake ~/Shibuya#tangier --ask-sudo-password # from tangier
}
