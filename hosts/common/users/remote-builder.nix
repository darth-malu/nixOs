{
  config,
  lib,
  pkgs,
  ...
}:

# NOTE: test with: # ssh remotebuild@remotemachine -i /root/.ssh/remotebuild "echo hello"

let
  isBuilder = config.networking.hostName == "carthage";
  isClient = config.networking.hostName != "carthage";
in
{
  # ENable distributed builds on client
  # ==========================================
  # BUILDER CONFIGURATION (Carthage)
  # ==========================================

  # The client will log into this account on Carthage to run builds
  users.users.remotebuild = lib.mkIf isBuilder {
    # isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrwiQoWlBZ5OCuw8pF2CWM1iJjI4pW5FZvq5b5RktOH Tangier"
    ];

    # --nix.dev
    isSystemUser = true;
    useDefaultShell = true;
  };

  users.groups.remotebuild = lib.mkIf isBuilder { };

  # ==========================================
  # CLIENT CONFIGURATION (Tangier / Others)
  # ==========================================

  nix.distributedBuilds = lib.mkIf isClient true;

  nix.buildMachines = lib.mkIf isClient [
    # NOTE: ignored if distributedBuilds is off?
    {
      sshUser = "remotebuild";
      sshKey = "/home/malu/.ssh/id_ed25519";
      hostName = "carthage"; # Carthage - 192.168.1.2
      protocol = "ssh-ng"; # Modern protocol — streams derivation info over SSH directly. Faster than legacy ssh which copies the entire derivation closure first.
      maxJobs = 3; # max parallel builds
      speedFactor = 2; # how fast is the builder compared to other remote builders
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = [
        "nixos-test" # Machine can run NixOs tests
        "benchmark" # Machine can generate metrics (means the builds usually takes the same amount of time)
        "big-parallel" # NOTE?? big-parallel allows derivations with many parallel build steps (e.g., chromium). Without it, some heavy builds won't be sent to carthage.
        "kvm" # Everything which builds inside a vm, like NixOS tests
      ];
      mandatoryFeatures = [ ];
    }
  ];

  # optional, true => useful when the builder has a faster internet connection than yours
  nix.settings.builders-use-substitutes = lib.mkIf isClient false;

  # 'remotebuild' needs to be a trusted user on Carthage so the client's nix-daemon can talk to Carthage's nix-daemon.
  nix.settings.trusted-users = lib.mkIf isBuilder [
    "remotebuild"
  ];
  # nixos-rebuild boot --target-host malu@192.168.100.3 --use-remote-sudo --flake ~/Shibuya#tangier --ask-sudo-password # from tangier
  # nixos-rebuild boot --target-host remotebuild@192.168.100.4 --elevate=sudo --flake ~/Shibuya#tangier --ask-sudo-password

  # nixos-rebuild boot --target-host remotebuild@tangier --sudo --ask-sudo-password --flake ~/Shibuya#tangier
  # https://wiki.nixos.org/wiki/Nixos-rebuild#Deploying_on_other_machines
}
