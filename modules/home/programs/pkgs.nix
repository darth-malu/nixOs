{
  config,
  inputs,
  osConfig,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  home.packages =
    with pkgs;
    [
      # pastel # color generator
      # qalculate-qt # #FIXME:for rofi?
      # yaru-theme
      #aria2#NOTE: learn
      libsecret # TODO use
      ventoy-full # usb imager #woeusb
      wev
    ]
    ++ (with pkgs; [
      # support
      # zip xz unzip p7zip
      # testing for yazi #
      # zip
      # xz
      # unzip
      # p7zip
    ])
    ++ (with pkgs; [
      # jetbrains.pycharm-community-bin
      # tokei
      # vscodium
      # vscodium-fhs
      dotnet-sdk
      ed
      firebase-tools
      libgcc
      nasm
    ])
    ++ (with pkgs; [
      # wpsoffice
      # libreoffice-qt-still
      libreoffice-still
      ripgrep-all
    ])
    ++ (with pkgs; [
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
      #testdisk # also installs photorec
      duf
      file # need for yazi mimedetectionetc.
      iftop # TODO seems powerful investigate more
      inxi
      iotop-c # laggy?
      lm_sensors
      lsof # list open files/ports**
      mission-center
      ncdu
      nethogs
      pciutils # lspci
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
    ])
    ++ (with pkgs-unstable; [
      chromium
      telegram-desktop
      discord
      whatsapp-for-linux
      modem-manager-gui
      modemmanager # saves the day with no internet
      dotool
    ])
    ++ (with pkgs; [
      # cantata # old af
      # davinci-resolve #NOTE crash on stable
      # digikam
      # lollypop # cantata better
      # smplayer
      # ymuse # rudimentary
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      easyeffects
      helvum
      mpc-cli
      nautilus
      spotify
      spotify-cli-linux
      sway-audio-idle-inhibit
      trash-cli # for move to trash mpv
      vlc
      wf-recorder
      kdePackages.kdenlive
      kdePackages.mlt
    ])
    ++ (with pkgs-unstable; [
      spotube
      qbittorrent
    ])
    ++ (with pkgs-unstable; [
      # komikku # broken
      mangal
      ani-cli
      # miru # issue launching -kde
      #syncyomi - sync tachiyomi progress across devices
    ])
    ++ (
      if osConfig.networking.hostName == "carthage" then
        with pkgs-unstable;
        [
          # mastodon
          # melt  #collison with mlt
          # protonup-qt # GUI for installing custom Proton versions like GE_Proton
          # protonup-rs
          # steam-run
          # wine
          blender-hip # Hardware accelerated rendering
          darktable
          davinci-resolve
          ffmpeg-full # full vs vanilla?
          gimp
          inkscape-with-extensions
          mediainfo
          obs-cli
          obs-studio
        ]
        ++ ([
          # davinci-resolve
        ])
      else
        [ ffmpeg ]
    )
    ++ (
      if config.homeHyprland.enable then
        with pkgs;
        [
          # inputs.hyprswitch.packages.x86_64-linux.default
          cliphist
          file-roller
          grimblast
          inputs.quickshell.packages.${system}.default
          slurp
          sushi
          viewnior
          yelp
        ]
      else
        [ ]
    );
}
