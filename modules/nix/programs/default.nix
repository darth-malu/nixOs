{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # ./nextcloud.nix
    # ./sync-thing
    ./android
    ./gaming
    ./gnupg.nix
    ./less.nix
    ./localsend.nix
    ./virtualisation
  ];

  # nextcloud.enable = true;

  steamy.enable = true;

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
        nvd
        app2unit
        #cpufrequtils
        lshw
        efibootmgr
        curl
        # dash
        procs
        # stacer
        fio
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
        # emacs
        # bc
        wl-clipboard # rust wl-clipboard better?
        dotool # test if working
        easyeffects
        mpc
        discord
        pv
        # ff2mpv-rust
        ff2mpv
        # gsmartcontrol
        # iotop #basic
        # perfomance monitoring
        # qdiskinfo
        # squirreldisk #kinda nice
        # superfile # kinda cool but dont need
        # testdisk-qt
        # utilities
        # warp-terminal # insane bloat
        # win-disk-writer
        # testdisk # also installs photorec
        # duc
        # dust
        duf
        ncdu
        file # need for yazi mimedetection etc.
        iftop # TODO seems powerful investigate more
        inxi
        iotop-c
        lm_sensors
        lsof # list open files/ports**
        mission-center
        nethogs
        pciutils # lspci
        usbutils # lsusb, usb-devices, usb-view(optional gui)
        util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
        # psmisc
        ripgrep-all
        dotool
        httrack
        modem-manager-gui
        modemmanager
        whatsapp-electron
        ventoy-full # usb imager #woeusb
        nautilus
        xdg-utils
        ffmpeg
        google-chrome
        # firefox
        # ungoogled-chromium
        vulkan-tools
        libva-utils
        zenith
        powershell
        localsend
      ]
      ++ lib.optionals config.programs.hyprland.enable [
        hyprpicker
        # hyprpolkitagent
        libappindicator-gtk3 # needed for discord icon
        # libsecret # secrets lul
        grimblast
        # file-roller
        # inputs.hyprswitch.packages.x86_64-linux.default
        # yelp
        slurp
        sushi
        viewnior
        kdePackages.kalk
        kdePackages.dolphin
        hyprsysteminfo
        hyprshutdown
        hyprpwcenter
        hyprland-autoname-workspaces
      ]
      ++ lib.optionals (config.networking.hostName == "tangier") [
        brightnessctl
      ];
  };
}
