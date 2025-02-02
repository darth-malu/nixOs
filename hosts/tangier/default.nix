{modulesPath, pkgs, lib, options, ...}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./drives.nix
    ../../users/malu.nix
    ../../modules/nix
    # ./nvidia.nix
    ./enVars.nix # empty -check
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

  hardware = {
    enableAllFirmware = true; #for bt to work in HSP/HFP mode, test further
    bluetooth = {
      # enable = if config.networking.hostName == "tangier" then true else false;
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true; # battery percentage of btDevice
    };
  };

  networking = {
    hostId = "92d08a60"; #zfs so funny
    wireless.enable = false; # wpa_supplicant enable
    networkmanager = {
      enable = true; # might be on by default # add user to group
      dns = "none";
      wifi.powersave = false;
    };
    dhcpcd.enable = true;
    useDHCP = lib.mkDefault true;
    hostName = "tangier"; # Define your hostname.
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ]; #TODO: see more about options
    # firewall.enable = true;
    # firewall.allowedTCPPorts = [ 22 80 443]; # 22 auto open with ssh
    firewall = rec {
      enable = true;
       allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
       allowedUDPPortRanges = allowedTCPPortRanges;
       allowedTCPPorts = [ 22 ];
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      #"8.8.8.8"
      #"8.8.4.4"
    ];
  };
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  services.libinput.enable = true; # touchpad, should be on by default

  security = {
    rtkit.enable = true; # pipewire need?
    sudo = {
      enable = true;
      # wheelNeedsPassword = false;
      extraRules = [{
        commands = [
          #{
            #command = "${pkgs.systemd}/bin/systemctl suspend";
            #options = [ "NOPASSWD" ];
          #}

          {
            command = "${pkgs.systemd}/bin/systemctl status";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/systemctl start";
            options = [ "NOPASSWD" ];
          }

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

    polkit = {
      enable = true;
      extraConfig = ''
        # reboot/poweroff for non sudo users
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        });
      '';
    };
    };

  # };

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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        #dates = "03:15";
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
      '';# keep build-time dependencies around/be able to rebuild while being offline
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
          "https://yazi.cachix.org"
          #"https://cache.nixos.org" #used automatically by nix pkg mgr
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
          #"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };
    };

  time.timeZone = "Africa/Nairobi";

  system.stateVersion = "24.05";
}

