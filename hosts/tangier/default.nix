{config,modulesPath, pkgs, lib, options, ...}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../common
    ./nvidia.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci" # usb 3.0
      "ehci_pci" # usb 2.0
      "ahci" # sata
      "usb_storage"  # usb mass storage devices - hdd, flash
      "sd_mod" #scsi device and some sata
      "sr_mod" ]; # cd drive
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };
  nix = {
    distributedBuilds = true;
    buildMachines = [ {
      sshUser = "malu";
      sshKey = "$HOME/.ssh/id_ed25519"; # must be a local path not pointing to the nix store
      hostName = "carthage";
      system = "x86_64-linux";
      protocol = "ssh"; #ssh:: ssh-ng (improved protocol?TODO:)
      maxJobs = 1;
      speedFactor = 2; # The relative speed of this builder. This is an arbitrary integer that indicates the speed of this builder, relative to other builders. Higher is faster.
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }] ;
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave"; # TODO: test effects of this
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    hostName = "tangier"; # Define your hostname.
    networkmanager = {
      wifi.powersave = lib.mkForce false;
    };
  };
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  services = {
    libinput.enable = true; # touchpad, should be on by default
    zfs = {
      autoSnapshot.enable = true; #TODO: see sanoid in man configuration.nix
      trim.enable = true; # true::
    };
  };

  time.timeZone = "Africa/Nairobi";

  system.stateVersion = "24.05";
}

