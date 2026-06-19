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

  nix =
    lib.mkIf (config.networking.hostName != "carthage") {
      distributedBuilds = true;

      buildMachines = [
        {
          sshUser = "remotebuild";
          sshKey = "/home/malu/.ssh/id_ed25519";
          hostName = "192.168.1.4";
          protocol = "ssh-ng";
          maxJobs = 3;
          speedFactor = 2;
          system = "x86_64-linux";
          supportedFeatures = [
            "nixos-test"
            "benchmark"
            "big-parallel"
          ];
          mandatoryFeatures = [ ];
        }
      ];

      # Removed the semicolons from the nix.conf string
      extraOptions = ''
        builders-use-substitutes = true
      '';
      # keep-outputs = true
      # keep-derivations = true
      # FIXME: invalid value 'true'
    }
    // {
      nrBuildUsers = 64;
      settings = {
        trusted-users = [
          "remotebuild"
          "malu"
        ]; # have additional rights when connecting to nix daemon. specify additional binary caches, or to import unsigned NARs
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
