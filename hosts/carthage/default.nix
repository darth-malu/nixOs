{modulesPath, options, lib, config,...}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # ../specialisations #includes hyprland config and specialisations --common
    ./amd.nix
    ../common
    # ./drives.nix
  ];

  
  boot = {
    # supportedFilesystems = { ntfs-3g = true; ext4 = true; }; # can also be list # supportedFilesystems = [ "ntfs" ];
    initrd = {
      kernelModules = [ "dm-snapshot" ]; #load amd driver (amdgpu) early user space # Force loads to initrd
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ]; # available to initram but only loaded on demand
      systemd = {
        network = {
          wait-online.enable = false; # since using networkmanager not networkd;
        };
      };
    };
    kernelModules = ["kvm-amd" "wl"]; # second stage of boot process # not modules needed to boot root fs
    # kernelParams = [# parameterrs for kernel command line
    #   "video=HDMI-A-1:1920x1080@240"
    #   "video=DP-3:1920x1080@60"
    # ];
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # enableAllFirmware = true; # enable all firmware regardless of license #for bt to work in HSP/HFP mode
    # enableAllHardware = true; # Enable support for most hardware
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = "carthage"; # Define your hostname.
  };

  system.stateVersion = "24.05";
}
