{
  pkgs,
  # lib,
  inputs,
  system,
  config,
  ...
}:

{
  imports = [
    ./sync-thing
    ./virtualisation
    ./gaming
  ];

  documentation = {
    nixos = {
      includeAllModules = true; # false::
    };
  };
  # qemuNix.enable = if config.networking.hostName == "carthage" then false else false;

  steamy.enable = if config.networking.hostName == "carthage" then true else false;

  programs = {

    # gpu-screen-recorder.enable = true;  # FIXME: does not work lol

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
      (with pkgs; [
        libnotify # notify-send
        wget
        #cpufrequtils
        lshw
        efibootmgr
        curl
        # dash
        procs
        #glib
        #gsettings-qt
        killall
        nix-prefetch-git # nix-prefetch-scripts #includes git prefetch
        pipewire
        pwvucontrol
        playerctl
        wireplumber
        # ntfs3g
        lsof # list open files/ports**
        usbutils # lsusb, usb-devices, usb-view(optional gui)
        jmtpfs # mtp drivers
        pciutils # lspci
        util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock, more**
        kitty
        bc
        wl-clipboard # rust wl-clipboard better?
        # tldr # emacs better
        dotool # test if working
        inputs.nix-qml.packages.${system}.tree-sitter-qmljs
        inputs.nix-qml.packages.${system}.qml-ts-mode
      ])
      ++ (
        if config.programs.hyprland.enable then
          with pkgs;
          [
            hyprpicker
            # hyprpolkitagent
            libappindicator-gtk3 # needed for discord icon
            # libsecret # secrets lul
            # kdePackages.qt6ct
            # kdePackages.qtwayland
          ]
          ++ (
            if config.networking.hostName == "tangier" then
              [
                brightnessctl
              ]
            else
              [ ]
          )
        else
          (
            if config.services.desktopManager.plasma6.enable then
              # with pkgs.kdePackages;
              [
                # hello
                # filelight
                # ghostwriter
                # plan # watch
                # calindori
                # pkgs.labplot
              ]
            else
              [ ]
          )
      );
  };
}
