{
  config,
  inputs,
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
      # Quickshell stuffs
      qt6.qtimageformats
      qt6.qt5compat # shader fx
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
      patchelf
      # clang
      gnumake
      zlib
      # libgcc
      # nasm
    ])
    ++ (with pkgs; [
      # wpsoffice
      # libreoffice-qt-still
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
      ncdu
      iotop-c # laggy?
      lm_sensors
      lsof # list open files/ports**
      mission-center
      nethogs
      pciutils # lspci
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
    ])
    ++ (with pkgs; [
      chromium
      telegram-desktop
      discord
      whatsapp-for-linux
      modem-manager-gui
      modemmanager # saves the day with no internet
      dotool
    ])
    ++ (with pkgs; [
      cantata # old af
      digikam
      # lollypop # cantata better
      # smplayer
      # ymuse # rudimentary
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      easyeffects
      mpc-cli
      nautilus
      qbittorrent
      spotify
      # spotify-cli-linux
      sway-audio-idle-inhibit
      # clapper
      # wf-recorder
      # gpu-screen-recorder
      audacity
      # tenacity
      # kando
      # pipeline # flatpak better?
      # qqmusic
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
          # mastodon
          spotube # FIXME issues tu
          libreoffice-still
          # melt  #collison with mlt
          # protonup-qt # GUI for installing custom Proton versions like GE_Proton
          # protonup-rs
          # steam-run
          # wine
          # blender-hip # Hardware accelerated rendering NOTE later after pos
          darktable
          # davinci-resolve # NOTE RX580 not being detected
          # davinci-resolve-studio # NOTE RX580 not being detected
          handbrake # FIXME lag on open
          vlc
          helvum
          #coppwr
          ffmpeg-full # full vs vanilla?
          gimp
          # unigine-heaven
          # unigine-superposition
          # glmark2
          inkscape-with-extensions
          obs-cli
          obs-studio
          # kdePackages.kdenlive # FIXME see if flatpak better
          # kdePackages.mlt
          # mediainfo
          # inputs.quickshell.packages.${system}.default
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
          # inputs.hyprswitch.packages.x86_64-linux.default
          cliphist
          # file-roller
          grimblast
          # inputs.quickshell.packages.${system}.default
          slurp
          sushi
          viewnior
          # yelp
        ]
      else
        [ ]
    );
}
