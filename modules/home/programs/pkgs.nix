{
  config,
  osConfig,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    [
      # Quickshell stuffs https://quickshell.org/docs/v0.2.0/guide/install-setup/
      qt6.qtimageformats # webp & less common format support
      qt6.qt5compat # extra visual effects, notably gaussian blur. MultiEffect is usually preferable
      # qt6.qtsvg # support for SVG image loading (bundled with most packages) # NOTE its still fetched?
      qt6.qtmultimedia # support for playing videos, audio, etc
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
      # sound-theme-freedesktop # free sounds
      # pulseaudioFull # paplay
      libcanberra-gtk3
    ]
    ++ [
      # pastel # color generator
      # qalculate-qt # #FIXME:for rofi?
      # yaru-theme
      #aria2#NOTE: learn
      libsecret # TODO use
      ventoy-full # usb imager #woeusb
      # wev # NOTE use ./ascii
    ]
    ++ (with pkgs; [
      # testing for yazi #
      zip # Compressor/archiver for creating and modifying zipfiles.
      unzip # Extraction utility for archives compressed in .zip format
      xz # General-purpose data compression software, successor of LZMA
      p7zip # New p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projec…
      # unrar
      rar
    ])
    ++ (with pkgs; [
      ed
      # firebase-tools
      patchelf # TODO see useful nexx
      zlib
      # manim #FIXME failed
      socat
      cling
      cmake # vterm
      # libgcc
      # nasm
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
      # duc
      duf
      dust
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
      # wpsoffice
      # libreoffice-qt-still
      libreoffice-still
      ripgrep-all
      discord
      wasistlos # whatsapp-for-linux
      # modem-manager-gui
      # modemmanager # saves the day with no internet
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
      # xclip
      blanket
      easyeffects
      mpc
      nautilus
      qbittorrent
      gpu-screen-recorder-gtk
      spotify
      # spotube
      sway-audio-idle-inhibit
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
          # ffmpeg-full # full vs vanilla?
          gimp
          # glmark2
          # helvum
          # inkscape-with-extensions
          # inputs.quickshell.packages.${system}.default
          # kdePackages.mlt
          # mastodon
          # melt  #collison with mlt
          # unigine-heaven
          # unigine-superposition
          kdePackages.kdenlive
          darktable
          exiftool
          ffmpeg-full
          handbrake # FIXME lag on open
          libreoffice-still
          obs-cli
          obs-studio
          vlc
          # stremio
          telegram-desktop
          ungoogled-chromium
        ]
        ++ (with pkgs.gst_all_1; [
          # nautilus gst
          # gst-plugins-good
          # gst-plugins-bad
          # gst-plugins-ugly
          # gst-libav
        ])
      else
        [
<<<<<<< HEAD
=======
          gimp
>>>>>>> d3da8bf (backuper...fix ..remove mount logic(use external))
          ffmpeg
        ]
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
