{
  config,
  osConfig,
  pkgs,
  ...
}:

{
  programs = {
    gcc = {
      enable = true;
      colors = {
        error = "01;31";
      };
    };
  };

  home.packages =
    with pkgs;
    [
      # Quickshell stuffs https://quickshell.org/docs/v0.2.0/guide/install-setup/
      qt6.qtimageformats # webp & less common format support
      qt6.qt5compat # shader fx
      # qt6.qtsvg # load SVG image
      qt6.qtmultimedia # flicko shell
      qt6.qtdeclarative # qtdecl types in path
      grim
      imagemagick # screenshot
      # (inputs.quickshell.packages.${system}.default.override (prevqs: {
      #   debug = true;
      #   qt6 = prevqs.qt6.overrideScope (
      #     _: prevqt: {
      #       qtdeclarative = prevqt.qtdeclarative.overrideAttrs (prev: {
      #         cmakeBuildType = "Debug";
      #         dontStrip = true;
      #       });
      #     }
      #   );
      # }))
    ]
    ++ [
      # pastel # color generator
      # qalculate-qt # #FIXME:for rofi?
      # yaru-theme
      #aria2#NOTE: learn
      libsecret # TODO use
      ventoy-full # usb imager #woeusb
      wev
    ]
    ++ (with pkgs; [
      # testing for yazi #
      zip # Compressor/archiver for creating and modifying zipfiles.
      xz # General-purpose data compression software, successor of LZMA
      unzip # Extraction utility for archives compressed in .zip format
      p7zip # New p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projec…
    ])
    ++ (with pkgs; [
      ed
      # firebase-tools
      patchelf # TODO see useful nexx
      zlib
      # manim #FIXME failed
      socat
      cling
      # libgcc
      # nasm
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
    ++ (with pkgs; [
      # chromium
      ungoogled-chromium
      telegram-desktop
      # discord-ptb
      discord
      wasistlos # whatsapp-for-linux
      modem-manager-gui
      modemmanager # saves the day with no internet
      dotool
    ])
    ++ (with pkgs; [
      # cantata # old af
      # digikam
      # clapper
      # kando
      # lollypop # cantata better
      # pipeline # flatpak better?
      # qqmusic
      # smplayer
      # spotify-cli-linux
      # tenacity
      # wf-recorder
      # ymuse # rudimentary
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      audacity
      blanket
      easyeffects
      mpc # mpc-cli
      nautilus
      qbittorrent
      spotify
      spotube # FIXME issues tu
      sway-audio-idle-inhibit
    ])
    ++ (with pkgs; [
      # kdePackages.audiotube
      # fooyin
    ])
    ++ (with pkgs; [
      # komikku # broken
      mangal
      ani-cli
      # kazumi # watch anime online with danmaku support
      # miru # issue launching -kde
      #syncyomi - sync tachiyomi progress across devices
    ])
    ++ (
      if osConfig.networking.hostName == "carthage" then
        with pkgs;
        [
          # blender-hip # Hardware accelerated rendering NOTE later after pos
          # coppwr
          # davinci-resolve # NOTE RX580 not being detected
          # davinci-resolve-studio # NOTE RX580 not being detected
          # ffmpeg-full # full vs vanilla?
          # gimp
          # glmark2
          # helvum
          # inkscape-with-extensions
          # inputs.quickshell.packages.${system}.default
          # kdePackages.kdenlive # FIXME see if flatpak better
          # kdePackages.mlt
          # mastodon
          # melt  #collison with mlt
          # protonup-qt # GUI for installing custom Proton versions like GE_Proton
          # protonup-rs
          # steam-run
          # unigine-heaven
          # unigine-superposition
          # wine
          darktable
          exiftool
          ffmpeg-full
          # handbrake # FIXME lag on open
          libreoffice-still
          obs-cli
          obs-studio
          vlc
        ]
        ++ (with pkgs.gst_all_1; [
          # nautilus gst
          # gst-plugins-good
          # gst-plugins-bad
          # gst-plugins-ugly
          # gst-libav
        ])
      else
        [ ffmpeg ]
    )
    ++ (
      if config.homeHyprland.enable then
        with pkgs;
        [
          # file-roller
          # inputs.hyprswitch.packages.x86_64-linux.default
          # yelp
          cliphist
          grimblast
          slurp
          sushi
          viewnior
        ]
      else
        [ ]
    );
}
