{ pkgs, ... }:

{

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        # makes it so i dont have to use --builders "ssh://myuser@builder <other builder specification>"
        sshUser = "remotebuild"; # NOTE special user that cant be sudo'd into
        sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9bmUGM+Vxix3N6UsxEPwOLmH1JmBiCcudWMb0ZIzcD darth-malu@github.com";
        # sshKey = "/home/malu/.ssh/id_ed25519"; # Path to the PRIVATE key on Tangier
        # hostName = "carthage";
        hostName = "192.168.100.122"; # # Replace by IP address, or add a ProxyCommand, see `man ssh_config` for full docs.
        # protocol = "ssh-ng"; #ssh:: ssh-ng ( ssh next generation)
        # maxJobs = 4;
        # speedFactor = 2; # The relative speed of this builder. This is an arbitrary integer that indicates the speed of this builder, relative to other builders. Higher is faster.
        system = pkgs.stdenv.hostPlatform.system;
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
