{ pkgs, ... }:

{

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        # makes it so i dont have to use --builders "ssh://myuser@builder <other builder specification>"
        sshUser = "remotebuild"; # NOTE special user that cant be sudo'd into
        # sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJXqFrWf3rqkudQ6+aBFXkWpZcAm9HW9oHZclRwtGI8G justinmalu@gmail.com"; # carthage
        sshKey = "~/.ssh/remotebuild.pub";
        hostName = "carthage";
        # protocol = "ssh-ng"; #ssh:: ssh-ng ( ssh next generation)
        # maxJobs = 4;
        # speedFactor = 2; # The relative speed of this builder. This is an arbitrary integer that indicates the speed of this builder, relative to other builders. Higher is faster.
        system = pkgs.stdenv.hostPlatform.system;
        # system = "x86_64-linux";
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        mandatoryFeatures = [ ];
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  /*
    The builders-use-substitutes instructs all remote builders to obtain dependencies from its own binary caches instead of from the local machine.
      This assumes that the remote builders’ internet connection is at least as fast as the local machine’s internet connection.
  */

}
