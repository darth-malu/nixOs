{config, modulesPath, lib, pkgs, ...}:
{

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../modules/nix
    ./users
    ./storage-common.nix
    ./specialisations
    ./bluetooth.nix
  ];

  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "broadcom-sta"
        # "ciscoPacketTracer8"
        "n8n"
        "symbola"
        # "android-studio-stable"
        "steam-unwrapped"
        "nvidia-x11"
        "xone-dongle-firmware"
        "steam"
        "nvidia-x11-570.153.02-6.12.30"
        "nvidia-settings"
        "broadcom-bt-firmware"
        "facetimehd-calibration"
        "facetimehd-firmware"
        "b43-firmware"
      ];
    permittedInsecurePackages = [
        "broadcom-sta-6.30.223.271-59-6.18.22"
      # "libxml2-2.13.8" # for cisco?
    ];
  };

  boot = {
    plymouth.enable = true;
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
    libinput.enable = lib.mkIf (config.networking.hostName == "tangier") true; # touchpad, should be on by default
  };

hardware = {
  enableAllFirmware = true; # enable all firmware regardless of license #for bt to work in HSP/HFP mode
  # enableAllHardware = true; # Enable support for most hardware
};

  programs.nm-applet.enable = lib.mkIf config.hyprland.enable true; # started automatically with the graphical session
  programs.nm-applet.indicator = lib.mkIf config.hyprland.enable true;

  networking = {

  networkmanager = {
    enable = true; # add user to group
    dns = "none"; # dnsmasq, default::, systemd-resolved
    wifi = {
      powersave = false; # TODO what it does
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
  # dates = ["03:15" "00:00"];
  # dates = ["Sat, 17:48"];
  randomizedDelaySec = "30min"; # 1800:: systemd.time(7) - Delay btwn 0-thisValue
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
    # "remotebuild"
    # "remotebuild"
    # "@remotebuild"
    "malu"
  ];
  extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
  experimental-features = [ "nix-command" "flakes" ];
  substituters = [
    # "https://cache.nixos.org?priority=10"
    "https://hyprland.cachix.org"
    "https://nix-community.cachix.org"
    "https://yazi.cachix.org"
    # "https://konradmalik.cachix.org"
    #"https://cache.nixos.org" #used automatically by nix pkg mgr
  ];
  trusted-public-keys = [
    # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
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

system.stateVersion = if config.networking.hostName == "tangier" then "24.11" else "25.11";

}
