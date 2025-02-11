{config,modulesPath, pkgs, lib, options, ...}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./drives.nix
    # ../common
    # ../../users/malu.nix -- in common
    # ../../modules/nix -- in common
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

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
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

  services.libinput.enable = true; # touchpad, should be on by default

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  time.timeZone = "Africa/Nairobi";

  system.stateVersion = "24.05";
}

