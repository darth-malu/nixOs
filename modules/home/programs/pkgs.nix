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
      # sound-theme-freedesktop # free sounds
      # pulseaudioFull # paplay
      libcanberra-gtk3
      kdePackages.qt6ct
      kdePackages.kservice
      kdePackages.dolphin
      kdePackages.konsole
      # KIO is a library that provides file manipulation and copying, remote file access, thumbnail previews, the Trash, the Places panel, and various other common file-related user interface components.
      kdePackages.kio-fuse # FUSE Interface for KIO
      kdePackages.kio-extras # Additional components to increase the functionality of KIO
      kdePackages.kio-admin # Manage files as administrator using the admin:// KIO protocol
      # kdePackages.kio-gdrive
      kdePackages.qtwayland # allows Qt-based applications to run on the Wayland display protocol
      xdg-utils
    ]
    ++ [
      # pastel # color generator
      # qalculate-qt # #FIXME:for rofi?
      # yaru-theme
      # aria2#NOTE: learn
      libsecret # TODO use
      ventoy-full # usb imager #woeusb
      wev # NOTE use ./ascii
    ]
    ++ (with pkgs; [
      # testing for yazi #
      zip # Compressor/archiver for creating and modifying zipfiles.
      unzip # Extraction utility for archives compressed in .zip format
      xz # General-purpose data compression software, successor of LZMA
      p7zip # New p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projec…
      rar # also has unrar
    ])
    ++ (with pkgs; [
      # DEVELOPER 🛠️
      # cling
      # firebase-tools
      # manim #FIXME failed
      # nasm
      # qtcreator
      # beekeeper-studio
      cryptsetup
      ed
      pass-wayland
      patchelf # TODO see useful nexx
      socat
      zlib
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
      # testdisk # also installs photorec
      # duc
      # dust
      duf
      ncdu
      file # need for yazi mimedetection etc.
      iftop # TODO seems powerful investigate more
      inxi
      iotop-c # laggy?
      lm_sensors
      lsof # list open files/ports**
      mission-center
      nethogs
      pciutils # lspci
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
      # psmisc # TODO need?
      ripgrep-all
      dotool
      httrack
      # modem-manager-gui
      # modemmanager # saves the day with no internet
    ])
    ++ (with pkgs; [
      # chromium
      # wpsoffice
      # libreoffice-qt-still
      libreoffice-still
      discord
      wasistlos # whatsapp-for-linux
      # telegram-desktop
    ])
    ++ (with pkgs; [
      # SOUND
      # cantata # old af
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
      alarm-clock-applet
      spotify
      castero
      # spotube
      sway-audio-idle-inhibit
      # digikam #TODO diff with darktable
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
          # coppwr
          # ffmpeg-full # full vs vanilla?
          # glmark2
          # helvum
          # inkscape-with-extensions
          # inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
          # kdePackages.mlt
          # mastodon
          # melt  #collison with mlt
          # unigine-heaven
          # unigine-superposition
          # kdePackages.kdenlive
          # davinci-resolve
          exiftool
          # ffmpeg-full
          # handbrake # FIXME lag on open
          # obs-cli
          obs-studio
          ungoogled-chromium
        ]
      else
        [ ]
    )
    ++ [
      # CreativeSPACE 📽
      # blender-hip # Hardware accelerated rendering NOTE later after pos
      gimp
      ffmpeg
      krita
      inkscape
      darktable
      digikam
    ]
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
          hyprpwcenter
          hyprland-autoname-workspaces
        ]
      else
        [ ]
    );
}
