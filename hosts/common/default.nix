{config, modulesPath, lib, pkgs, ...}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../modules/nix
    ./users/malu.nix
    ./users/remote-builder.nix
    ./storage-common.nix
    ./specialisations
  ];

  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "broadcom-sta"
        # "ciscoPacketTracer8"
        "n8n"
        # "android-studio-stable"
        "steam-unwrapped"
        "nvidia-x11"
        "xow_dongle-firmware"
        "steam"
        "nvidia-x11-570.153.02-6.12.30"
      ];
    permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-57-6.12.55"
      "libxml2-2.13.8" # for cisco?
    ];
  };

  boot = {
    plymouth = {
      enable = false;
    };
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    loader = {
      systemd-boot = {
        enable = true;
        # editor = false; # true:: allow editing kernel commandline before boot
        # windows
        # sortKey = "nixos"; #https://uapi-group.org/specifications/specs/boot_loader_specification/#sorting
      };
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    initrd.kernelModules =
      if config.networking.hostName == "carthage" then
        [
          # "dm-snapshot"               # lvm
          # "amdgpu"
        ]
      else
        [ ];
    initrd.availableKernelModules =
      if config.networking.hostName == "carthage" then
        [
          "nvme"
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
        ]
      else
        [
          "xhci_pci" # usb 3.0
          "ehci_pci" # usb 2.0
          "ahci" # sata
          "usb_storage" # usb mass storage devices - hdd, flash
          "sd_mod" # scsi device and some sata
          "sr_mod" # cd drive
        ];
    initrd.systemd.network = {
      enable = false;
      wait-online.enable = false; # since using networkmanager not networkd;
    };
    kernelModules =
      if config.networking.hostName == "tangier" then
        [
          "kvm-intel"
          "wl"
        ]
      else
        [
          "kvm-amd"
          "wl" # broadcomm closed source
        ];
    kernelParams = [# parameterrs for kernel command line
    #   "video=HDMI-A-1:1920x1080@240"
    #   "video=DP-3:1920x1080@60"
      "nohibernate" # because zfs
    ];
    # supportedFilesystems = { ntfs-3g = true; ext4 = true; }; # can also be list # supportedFilesystems = [ "ntfs" ];
  };

  services = {
    libinput.enable = if config.networking.hostName == "tangier" then true else false; # touchpad, should be on by default
    zfs = {
      autoSnapshot.enable = true; # TODO: see sanoid in man configuration.nix
      autoScrub.enable = true;
      trim.enable = true; # true:: - zpool trim, different from autorim pool property
    };
  };

  hardware.usbStorage.manageShutdown = true;

  programs.nm-applet.enable = false; # started automatically with the graphical session

  networking = {

  networkmanager = {
    enable = true; # add user to group
    dns = "none"; # dnsmasq, default::, systemd-resolved
    wifi = {
      powersave = true; # TODO see if has issues?
      # backend = "wpa_supplicant"; # wpa_supplicant::, iwd
    };
    logLevel = "WARN"; # "OFF", "ERR", "WARN"::, "INFO", "DEBUG", "TRACE"
    unmanaged = [
      # "*"
      # "except:type:wwan"
      # "except:type:gsm"
    ];
  };

  modemmanager = {
    enable = true;
  };

  timeServers = [
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
  ];

# dhcpcd.enable = true; # true::
# useDHCP =  false;
# interfaces.enp5s0.useDHCP = if config.networking.hostName == "carthage" then true else false; #overrides default in useDHCP unless null
# interfaces.wlo1.useDHCP = if config.networking.hostName == "tangier" then true else false;

# Manual DNS config
nameservers = [ "1.1.1.1" "1.0.0.1"  "8.8.8.8" "8.8.4.4" ];

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
    # package = pkgs.bluez;
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

# users.groups.students.gid = 1000; # creates group called students, gid optional

# config= lib.mkIf (config.specialisation != {}) {
security = {
  rtkit.enable = true; # pipewire need?

sudo = {
  enable = true;
  extraRules = [
    { commands = [
      #{
      #command = "${pkgs.systemd}/bin/systemctl suspend";
      #options = [ "NOPASSWD" ];
      #}

      # {
        # command = "/run/current-system/sw/bin/nixos-rebuild";
      #   command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
      #   options = [ "NOPASSWD" ];
      # }

      #{
      #command = "${pkgs.systemd}/bin/reboot";
      #options = [ "NOPASSWD" ];
      #}
      #{
      #command = "${pkgs.systemd}/bin/poweroff";
      #options = [ "NOPASSWD" ];
      #}
      {
        command = "${pkgs.util-linux}/bin/fdisk -l";
        options = [ "SETENV" "NOPASSWD" ];
      }
    ];
    # groups = [ "wheel" ];
    users = ["malu"];
  }
  ];
};

polkit = {
  enable = true;

extraConfig = ''

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

polkit.addRule(function(action, subject) {
  if ((action.id == "org.blueman.network.setup" ||
       action.id == "org.blueman.dhcp.client" ||
       action.id == "org.blueman.rfkill.setstate" ||
       action.id == "org.blueman.pppd.pppconnect") &&
  subject.isInGroup("wheel")) {
    return polkit.Result.YES;
  }
});

'';

};

}; # end of security

# Automatically run the nix store optimiser at a specific time.
nix.optimise = {
  automatic = true; # false::
  dates = ["weekly"];
  #dates = ["03:15" "00:00"]; # see systemd.time(7) for specification
  randomizedDelaySec = "30min"; # 1800:: systemd.time(7)
  # persistent = false; # true::
};

nix.settings.auto-optimise-store = true;#optimise with everybuild nix-store --optimise (manual) # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy. #false::

nix.gc = {
  automatic = true;
  dates = "weekly"; # "03:15";
  options = "--delete-older-than 14d";
  # randomizedDelaySec = "30min"; # 1800:: systemd.time(7)
  # persistent = false; # true::
};

nix.settings = {
  # warn-dirty = false;
  allowed-users = [             # Allowed to connect with the nix daemon. All users with *:: Trusted users always allowed to connect
    "@wheel"
    "malu"
    "@darth"
    "sumbi"
  ];
  trusted-users = [ # have additional rights when connecting to nix daemon. specify additional binary caches, or to import unsigned NARs
    "remotebuild"
    "remotebuild"
    "@remotebuild"
    "malu"
  ];
  extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
  experimental-features = [ "nix-command" "flakes" ];
  substituters = [
    "https://cache.nixos.org?priority=10"
    "https://hyprland.cachix.org"
    "https://nix-community.cachix.org"
    "https://yazi.cachix.org"
    # "https://konradmalik.cachix.org"
    #"https://cache.nixos.org" #used automatically by nix pkg mgr
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    #"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    # "konradmalik.cachix.org-1:9REXmCYRwPNL0kAB0IMeTxnMB1Gl9VY5I8w7UVBTtSI="
  ];
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

time.timeZone = "Africa/Nairobi";

nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; # ignored with nixpkgs.pkgs set

system.stateVersion = "24.11";
}
