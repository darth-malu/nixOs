{config, lib, options,...}:

{
  imports = [
    ./enVars.nix
    ./amd.nix
    ./drives.nix
    ./enVars.nix
    ../../../modules/nix
    ../../../users/malu.nix
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
    #kernelParams = [# parameterrs for kernel command line
    #"video=HDMI-A-1:1920x1080@240"
    #"video=DP-3:1920x1080@60"
    #];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };
  hardware = {
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
      network = {
          General = {
            DisableSecurity = false; # Disable link encryption: default=false
          };
      };
      input = {#Set configuration for the input service (/etc/bluetooth/input.conf). See https://github.com/bluez/bluez/blob/master/profiles/input/input.conf for full list of options.
        General = {
          ClassicBondedOnly = false; #true:: # # Limit HID connections to bonded devices
          IdleTimeout = 30;# 0 (disabled)::
          #UserspaceHID=true; #true:: # # Enable HID protocol handling in userspace input profile - true,false, persist
          #LEAutoSecurity=true; # true::
        };
      };
    };
  };

  networking = {
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true; # might be on by default # add user to group
      # dns = "none";
      wifi.powersave = true;
    };
    dhcpcd.enable = true;
    useDHCP = lib.mkDefault true;
    hostName = "carthage"; # Define your hostname.
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

  # services.libinput.enable = true; # touchpad, should be on by default

  # users.groups.students.gid = 1000; # creates group called students, gid optional

  # config= lib.mkIf (config.specialisation != {}) {
  security = {
    rtkit.enable = true; # pipewire need?
    sudo = {
      enable = true;
        extraRules = [{
          commands = [
            #{
              #command = "${pkgs.systemd}/bin/systemctl suspend";
              #options = [ "NOPASSWD" ];
            #}

            {
              command = "/run/current-system/sw/bin/nixos-rebuild";
              options = [ "NOPASSWD" ];
            }

            #{
              #command = "${pkgs.systemd}/bin/reboot";
              #options = [ "NOPASSWD" ];
            #}
            #{
              #command = "${pkgs.systemd}/bin/poweroff";
              #options = [ "NOPASSWD" ];
            #}
            #{
              #command = "${pkgs.fdisk} -l";
              #options = [ "NOPASSWD" ];
            #}
          ];
          #groups = [ "wheel" ];
        }];
    };
  };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      #dates = "03:15";
      options = "--delete-older-than 7d";
    };
    #extraOptions = ''
      #keep-outputs = true
      #keep-derivations = true
    #'';# keep build-time dependencies around/be able to rebuild while being offline
    settings = {
      #auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://helix.cachix.org"
        "https://yazi.cachix.org"
      ]; #"https://cache.nixos.org" #used automatically by nix pkg mgr "https://konradmalik.cachix.org"
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        #"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        # "konradmalik.cachix.org-1:9REXmCYRwPNL0kAB0IMeTxnMB1Gl9VY5I8w7UVBTtSI="
      ];
    };
  };
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  time.timeZone = "Africa/Nairobi";
  system.stateVersion = "24.05";
}
