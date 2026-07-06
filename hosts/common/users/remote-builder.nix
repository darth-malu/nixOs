{
  config,
  lib,
  pkgs,
  ...
}:

let
  isBuilder = config.networking.hostName == "carthage";
  isClient = config.networking.hostName != "carthage";
in
{
  # client will use this account on the remote
  # ENable distributed builds on client
  # ==========================================
  # BUILDER CONFIGURATION (Carthage)
  # ==========================================

  # The client will log into this account on Carthage to run builds
  users.users.remotebuild = lib.mkIf isBuilder {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrwiQoWlBZ5OCuw8pF2CWM1iJjI4pW5FZvq5b5RktOH Tangier"
    ];
  };

  users.groups.remotebuild = lib.mkIf isBuilder { };

  # ==========================================
  # CLIENT CONFIGURATION (Tangier / Others)
  # ==========================================

  nix.distributedBuilds = lib.mkIf isClient true;

  nix.buildMachines = lib.mkIf isClient [
    {
      sshUser = "remotebuild";
      sshKey = "/home/malu/.ssh/id_ed25519";
      hostName = "192.168.1.4"; # IP address of Carthage
      protocol = "ssh-ng";
      maxJobs = 3;
      speedFactor = 2;
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
      ];
      mandatoryFeatures = [ ];
    }
  ];

  nix.extraOptions = lib.mkIf isClient ''
    builders-use-substitutes = true
  '';

  # ==========================================
  # GLOBAL NIX & SYSTEMD SETTINGS (Both Hosts)
  # ==========================================

  nix.nrBuildUsers = 64;

  nix.settings = {
    # 'remotebuild' needs to be a trusted user on Carthage so the
    # client's nix-daemon can talk to Carthage's nix-daemon.
    trusted-users = [
      "root"
      "remotebuild"
      "malu"
    ]; # have additional rights when connecting to nix daemon. specify additional binary caches, or to import unsigned NARs
    min-free = 10 * 1024 * 1024;
    max-free = 200 * 1024 * 1024;
    max-jobs = "auto";
    cores = 0;
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "90%";
    OOMScoreAdjust = 500;
  };
  # nixos-rebuild boot --target-host malu@192.168.100.3 --use-remote-sudo --flake ~/Shibuya#tangier --ask-sudo-password # from tangier
}
