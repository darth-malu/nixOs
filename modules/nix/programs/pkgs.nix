{
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [
    # ./sync-thing
    ./virtualisation
    ./gaming
  ];

  documentation = {
    dev.enable = true; # TODO see instance of this
    info.enable = true;
    doc.enable = true; # distributed in pkgs /share/doc
    nixos = {
      includeAllModules = false; # false::
    };
  };

  # steamy.enable = lib.mkIf (config.networking.hostName == "carthage") true;
  steamy.enable = true;

  programs = {
    ccache = {
      enable = true;
      packageNames = [
        # Nix top-level packages to be compiled using CCache.
        # "wxGTK32"
        # "ffmpeg"
        # "nuitka"
        # "libav_all"
      ];
      # owner = "root";
      # group = "nixblkd";
      # cacheDir = "/var/cache/ccache";
    };
  };

  services = {
    locate.enable = true;
    gvfs.enable = true; # sets GIO_EXTRA_MODULES, used for accessing trash/network filesystems
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
      #extraConfig.pipewire."92-low-latency" = {#FIXME: crackling
      #"context.properties" = {
      #"default.clock.rate" = 48000;
      #"default.clock.quantum" = 32;
      #"default.clock.min-quantum" = 32;
      #"default.clock.max-quantum" = 32;
      #};
      #};
    };
    # dbus = {
    #   implementation = lib.mkDefault "broker"; #"broker" , "dbus"
    # };
  };

  environment = {
    # List of packages installed in system profile. To search, run: $ nix search wget
    systemPackages =
      with pkgs;
      [
        libnotify # notify-send
        wget
        app2unit
        #cpufrequtils
        lshw
        efibootmgr
        curl
        # man-pages
        # dash
        procs
        killall
        nix-prefetch-git # nix-prefetch-scripts #includes git prefetch
        pipewire
        pwvucontrol
        playerctl
        lsof # list open files/ports**
        usbutils # lsusb, usb-devices, usb-view(optional gui)
        jmtpfs # mtp drivers - # TODO check if mtp-probe error is from this and how to mitigate
        pciutils # lspci
        util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock, more**
        kitty
        # bc
        wl-clipboard # rust wl-clipboard better?
        dotool # test if working
      ]
      ++ lib.optionals config.programs.hyprland.enable [
        hyprpicker
        # hyprpolkitagent
        libappindicator-gtk3 # needed for discord icon
        # libsecret # secrets lul
        # kdePackages.qt6ct
      ]
      ++ lib.mkIf (config.networking.hostName == "tangier") [
        brightnessctl
      ];
  };
}
