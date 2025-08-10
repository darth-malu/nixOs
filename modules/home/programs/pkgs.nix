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
      # MISCELLANEOUS
      # calc
      # icons
      # kdePackages.dolphin # FIXME launching shit not working on hyprland
      # libadwaita
      # qalculate-qt # #FIXME:for rofi?
      #aria2#NOTE: learn
      #rofimoji bemoji
      dotool
      libsecret
      modem-manager-gui
      modemmanager # saves the day with no internet
      pastel # color generator
      ventoy-full # usb imager #woeusb
      wev
      yaru-theme
    ]
    ++ (with pkgs; [
      # support
      # tokei
      # zip xz unzip p7zip
      # testing for yazi #
      # zip
      # xz
      # unzip
      # p7zip
    ])
    ++ (with pkgs; [
      jetbrains.pycharm-community-bin
      dotnet-sdk
      libgcc
      ed
      # vscodium-fhs
      # vscodium
    ])
    ++ (with pkgs; [
      # wpsoffice
      # libreoffice-qt-still
      libreoffice-still
      ripgrep-all
    ])
    ++ (with pkgs; [
      # utilities
      # warp-terminal # insane bloat
      file # need for yazi mimedetectionetc.
      lsof # list open files/ports**
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      pciutils # lspci
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
      lm_sensors
    ])
    ++ (with pkgs; [
      # perfomance monitoring
      iftop # TODO seems powerful investigate more
      iotop-c # laggy?
      # iotop #basic
      nethogs
      inxi
      duf
      ncdu
      # superfile # kinda cool but dont need
      #testdisk # also installs photorec
      # testdisk-qt
      # gsmartcontrol
      # squirreldisk #kinda nice
      # qdiskinfo
      # win-disk-writer
    ])
    ++ (with pkgs; [
      # google-chrome
      chromium
      telegram-desktop
      discord
      whatsapp-for-linux
    ])
    ++ (with pkgs; [
      # cantata # old af
      # davinci-resolve
      # digikam
      # lollypop # cantata better
      # smplayer
      spotube
      # ymuse # rudimentary
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      easyeffects
      helvum
      mpc-cli
      nautilus
      qbittorrent
      spotify
      spotify-cli-linux
      sway-audio-idle-inhibit
      trash-cli # for move to trash mpv
      vlc
      wf-recorder
    ])
    ++ (with pkgs; [
      # NOTE: MANGA stuff
      # komikku # broken
      mangal
      ani-cli
      # miru # issue launching -kde
      #syncyomi - sync tachiyomi progress across devices
    ])
    ++ (
      if osConfig.networking.hostName == "carthage" then
        with pkgs;
        [
          # heroic
          # mastodon
          # protonup-qt # GUI for installing custom Proton versions like GE_Proton
          # protonup-rs
          # steam-run
          # wine
          darktable
          ffmpeg-full # full vs vanilla?
          gimp
          blender-hip # Hardware accelerated rendering
          inkscape-with-extensions
          kdePackages.kdenlive
          kdePackages.mlt
          mediainfo
          # melt  #collison with mlt
          obs-cli
          obs-studio
          amdgpu_top
          mission-center
          nasm
          firebase-tools
          # davinci-resolve
        ]
        ++ (with pkgs-unstable; [
          # winetricks
          # davinci-resolve
          bottles
          heroic
          lutris
          mangohud
          protonplus
          # protonup
          wine64
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
          slurp
          sushi
          viewnior
          yelp
          inputs.quickshell.packages.${system}.default
        ]
      else
        [ ]
    );
}
