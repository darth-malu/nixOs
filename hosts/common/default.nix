{config, lib, options, ...}:

{
  imports = [
    ../../modules/nix
    ../../users/malu.nix
    ./common-drive.nix
  ];

  # nixpkgs.pkgs = import <nixpkgs> {}; #TODO: investigate how to make this work

  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "discord" "microsoft-edge" "google-chrome" "bluemail" "spotify" "obsidian" "wpsoffice" "broadcom-sta" "nvidia-x11" "whatsapp-emoji-linux"
  ];


  boot = {
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };

  networking = {
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    hostId = if config.networking.hostName == "tangier" then "92d08a60" else "245e3df3"; #ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine.#head -c 8 /etc/machine-id
    # hostId = (lib.mkIf config.networking.hostName == "tangier") "92d08a60"; #FIXME: see syntax on this attempt to call something which is not a function but a Boolean: false
    networkmanager = {
      enable = true; # might be on by default # add user to group
      # dns = "none";
      wifi.powersave = true;
    };
    dhcpcd.enable = true;
    useDHCP = lib.mkDefault true;
    # interfaces.enp5s0.useDHCP = lib.mkDefault true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ]; #TODO: see more about options
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ]; # 22 auto open with ssh
    nameservers = [ "1.1.1.1" "1.0.0.1" ]; #"8.8.8.8" #"8.8.4.4" ];
    # firewall = let kdeConnectAttrRange = { from = 1714; to = 1764; } ; in rec {
    #   enable = true;
    #    allowedTCPPortRanges = [ kdeConnectAttrRange ];
    #    allowedUDPPortRanges =  allowedTCPPortRanges ;
    #    allowedUDPPorts = [ 22000 21027 ];
    #    allowedTCPPorts = [ 22 80 443 8384 22000 ];
    # };
  };

  hardware = {
    # enableAllFirmware = true; # enable all firmware regardless of license #for bt to work in HSP/HFP mode # for bt to work in HSP/HFP mode, test further
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
  nix = {
    optimise = {# Automatically run the nix store optimiser at a specific time.
      automatic = true; # false::
      dates = ["weekly"];
      #dates = ["03:15" "00:00"]; # see systemd.time(7) for specification
    };
    gc = {
      automatic = true;
      dates = "weekly";
      #dates = "03:15";
      options = "--delete-older-than 14d";
    };
    settings = {
      auto-optimise-store = true; # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy. #false::
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
    # extra options
    #keep-outputs = true
    #keep-derivations = true# keep build-time dependencies around/be able to rebuild while being offline
    extraOptions = ''
    '';
    distributedBuilds = true; # for remote builds
    # buildMachines = [];
    settings = {
      allowed-users = [
        # "@wheel"
        "@builders"
        "malu"
        "sumbi"
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
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; # ignored with nixpkgs.pkgs set
  time.timeZone = "Africa/Nairobi";
  system.stateVersion = "24.05";
}
