{config, modulesPath, lib, pkgs, ...}:
{

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../modules/nix
    ./users
    ./storage-common.nix
    ./specialisations
    ./bluetooth.nix
    ./bootStuff.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    # allowUnfreePredicate =
    #   pkg:
    #   builtins.elem (lib.getName pkg) [
    #     "broadcom-sta"
    #     "n8n"
    #     "symbola"
    #     "steam-unwrapped"
    #     "nvidia-x11"
    #     "xone-dongle-firmware"
    #     "steam"
    #     "nvidia-x11-570.153.02-6.12.30"
    #     "nvidia-settings"
    #     "broadcom-bt-firmware"
    #     "facetimehd-calibration"
    #     "facetimehd-firmware"
    #     "b43-firmware"
    #     "discord"
    #     "aspell-dict-en-science"
    #     # ANDROID studio
    #     # --------------
    #     "android-studio"
    #     "android-sdk-cmdline-tools"
    #     "android-studio-beta"
    #     "android-sdk-platform-tools"
    #     "platform-tools"
    #     "android-sdk-tools"
    #     "android-sdk-emulator"
    #     "android-sdk-system-image-36-google_apis-arm64-v8a-system-image-36-google_apis-x86_64"
    #     "system-image-36-google_apis-x86_64"
    #     "system-image-36-google_apis-arm64-v8a"
        # "android-sdk-system-image-36-google_apis_playstore-arm64-v8a-system-image-36-google_apis_playstore-x86_64"
        # "system-image-36-google_apis_playstore-x86_64"
        # "system-image-36-google_apis_playstore-arm64-v8a"
        # "android-sdk-system-image-35-google_apis-arm64-v8a-system-image-35-google_apis-x86_64"
        # "system-image-35-google_apis-x86_64"
        # "system-image-35-google_apis-arm64-v8a"
        # "android-sdk-system-image-35-google_apis_playstore-arm64-v8a-system-image-35-google_apis_playstore-x86_64"
        # "system-image-35-google_apis_playstore-x86_64"
        # "system-image-35-google_apis_playstore-arm64-v8a"
        # "android-sdk-system-image-34-google_apis-arm64-v8a-system-image-34-google_apis-x86_64"
        # --------------
      # ];
    permittedInsecurePackages = [
        # "broadcom-sta-6.30.223.271-59-6.18.33"
        "broadcom-sta-6.30.223.271-59-7.0.10"
    ];
  };

  services = {
    libinput.enable = lib.mkIf (config.networking.hostName == "tangier") true; # touchpad, should be on by default
  };

hardware = {
  enableAllFirmware = true; # enable all firmware regardless of license #for bt to work in HSP/HFP mode
  # enableAllHardware = true; # Enable support for most hardware
};

  programs.nm-applet.enable = lib.mkIf config.hypr.enable true; # started automatically with the graphical session
  programs.nm-applet.indicator = lib.mkIf config.hypr.enable true;

  networking = {

  networkmanager = {
    enable = true; # add user to group
    dns = "none"; # dnsmasq, default::, systemd-resolved
    wifi = {
      powersave = true;
      # backend = "wpa_supplicant"; # wpa_supplicant::, iwd
    };
    logLevel = "WARN"; # "OFF", "ERR", "WARN"::, "INFO", "DEBUG", "TRACE"
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
  persistent = false; # true::
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
    # "@remotebuild"
    "malu"
  ];
  extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
  experimental-features = [ "nix-command" "flakes" ];
  substituters = [
    # "https://cache.nixos.org?priority=10"
    "https://hyprland.cachix.org"
    "https://yazi.cachix.org"
    "https://aseipp-nix-cache.global.ssl.fastly.net"
    "https://nix-community.cachix.org"
    # "https://konradmalik.cachix.org"
    #"https://cache.nixos.org" #used automatically by nix pkg mgr
  ];
  trusted-public-keys = [
    # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    #"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    # "konradmalik.cachix.org-1:9REXmCYRwPNL0kAB0IMeTxnMB1Gl9VY5I8w7UVBTtSI="
  ] ++
  lib.optionals (config.networking.hostName != "carthage") [
      # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9bmUGM+Vxix3N6UsxEPwOLmH1JmBiCcudWMb0ZIzcD darth-malu@github.com"
  ];

  extra-substituters = lib.mkIf (config.networking.hostName != "carthage") [
    # "ssh://malu@192.168.100.122"
  ];
};

  nix = {
    distributedBuilds = lib.mkIf (config.networking.hostName != "carthage") true;
    buildMachines = lib.mkIf (config.networking.hostName != "carthage") [
      {
        # makes it so i dont have to use --builders "ssh://myuser@builder <other builder specification>"
        sshUser = "remotebuild"; # NOTE special user that cant be sudo'd into
        sshKey = "/home/malu/.ssh/id_ed25519"; # path to remote key on client (tangier)
        hostName = "192.168.100.4"; # Replace by IP address, or add a ProxyCommand, see `man ssh_config` for full docs.
        protocol = "ssh-ng"; #ssh:: ssh-ng ( ssh next generation)
        maxJobs = 8;
        speedFactor = 2; # The relative speed of this builder. This is an arbitrary integer that indicates the speed of this builder, relative to other builders. Higher is faster.
        system = pkgs.stdenv.hostPlatform.system;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          # "kvm"
        ];
        mandatoryFeatures = [ ];
      }
    ];
    extraOptions = lib.mkIf (config.networking.hostName != "carthage") ''
      builders-use-substitutes = true
    '';
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

system.stateVersion = "26.05";

}
