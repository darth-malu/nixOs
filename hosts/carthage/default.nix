{modulesPath, options, lib, config,...}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # ../specialisations #includes hyprland config and specialisations --common
    ./amd.nix
    ./common
    ./drives.nix
  ];

  
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
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
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # enableAllFirmware = true; # enable all firmware regardless of license #for bt to work in HSP/HFP mode
    # enableAllHardware = true; # Enable support for most hardware
    enableRedistributableFirmware = true; # enable firmware with a license allowing redistribution
    bluetooth = {
      # enable = lib.mkIf config.networking.hostName == "tangier" true; # works lol..maajabu
      # hsphfpd = true; #Whether to enable support for hsphfpd[-prototype] implementation.
      enable =  true; # works lol..maajabu
      powerOnBoot = true; #power on default controller on boot
      settings = {#Set configuration for system-wide bluetooth (/etc/bluetooth/main.conf). See https://github.com/bluez/bluez/blob/master/src/main.conf for full list of options.
        General = {
          Experimental = true; #battery %
          # ControllerMode = "bredr";
        };
      };
      # package = pkgs-unstable.bluez;
      # network = {
      #     General = {
      #       DisableSecurity = false; # Disable link encryption: default=false
      #     };
      # };
      # input = {#Set configuration for the input service (/etc/bluetooth/input.conf). See https://github.com/bluez/bluez/blob/master/profiles/input/input.conf for full list of options.
        # General = {
          # ClassicBondedOnly = false; #true:: # # Limit HID connections to bonded devices
          # IdleTimeout = 30;# 0 (disabled)::
          #UserspaceHID=true; #true:: # # Enable HID protocol handling in userspace input profile - true,false, persist
          #LEAutoSecurity=true; # true::
        # };
      # };
    };
  };

  networking = {
    hostName = "carthage"; # Define your hostname.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true; # might be on by default # add user to group
      # dns = "none";
      wifi.powersave = true;
    };
    dhcpcd.enable = true;
    useDHCP = lib.mkDefault true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ]; #TODO: see more about options
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ]; # 22 auto open with ssh
    # nameservers = [ "1.1.1.1" "1.0.0.1" ]; #"8.8.8.8" #"8.8.4.4" ];
    # firewall = let kdeConnectAttrRange = { from = 1714; to = 1764; } ; in rec {
    #   enable = true;
    #    allowedTCPPortRanges = [ kdeConnectAttrRange ];
    #    allowedUDPPortRanges =  allowedTCPPortRanges ;
    #    allowedUDPPorts = [ 22000 21027 ];
    #    allowedTCPPorts = [ 22 80 443 8384 22000 ];
    # };
  };
}
