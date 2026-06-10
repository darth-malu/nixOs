{
  osConfig,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./programs+options.nix
    ./developerPkgs.nix
  ];

  home.packages =
    with pkgs;
    [
      libvdpau
      # inputs.vermilion.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ [
      grim
      imagemagick # screenshot
      # sound-theme-freedesktop # free sounds
      libcanberra-gtk3
      kdePackages.kasts
      kdePackages.ksudoku
      kdePackages.kservice
      nautilus
      kdePackages.konsole
      # KIO is a library that provides file manipulation and copying, remote file access, thumbnail previews, the Trash, the Places panel, and various other common file-related user interface components.
      kdePackages.kio-fuse # FUSE Interface for KIO
      kdePackages.kio-extras # Additional components to increase the functionality of KIO
      kdePackages.kio-admin # Manage files as administrator using the admin:// KIO protocol
      # kdePackages.kio-gdrive
      kdePackages.qtwayland # allows Qt-based applications to run on the Wayland display protocol
    ]
    ++ [
      # pastel # color generator
      # qalculate-qt # #FIXME:for rofi?
      # yaru-theme
      # aria2#NOTE: learn
      # libsecret # TODO use
      ventoy-full # usb imager #woeusb
      xdg-utils
      ddrescue
      testdisk
      trash-cli
      wev # NOTE use ./ascii
      jdupes
      cryptsetup
      pass-wayland
    ]
    ++ [
      # testing for yazi #
      zip # Compressor/archiver for creating and modifying zipfiles.
      unzip # Extraction utility for archives compressed in .zip format
      xz # General-purpose data compression software, successor of LZMA
      p7zip # New p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projec…
      rar # also has unrar
    ]
    ++ [
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
      modemmanager # saves the day with no internet
    ]
    ++ [
      whatsapp-electron
      telegram-desktop
      discord
      signal-desktop
    ]
    ++ [
      # Fediverse
      # mastodon # TODO: self host only? no desktop
      cinny-desktop
      # rocketchat-desktop
      # element-desktop
    ]
    ++ [
      # SOUND
      cantata # old af
      # clapper
      # kando
      lollypop # cantata better
      # qqmusic
      # spotify-cli-linux
      # tenacity
      # wf-recorder
      # ymuse # rudimentary
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      audacity
      blanket
      easyeffects
      mpc
      qbittorrent
      gpu-screen-recorder-gtk
      alarm-clock-applet
      spotify
      spotube
      stremio-linux-shell
      sway-audio-idle-inhibit
    ]
    ++ [
      # komikku # broken
      mangal
      ani-cli
      # kazumi # watch anime online with danmaku support
      # miru # issue launching -kde
      #syncyomi - sync tachiyomi progress across devices
    ]
    ++ lib.optionals (osConfig.networking.hostName == "carthage") [
      # coppwr
      # helvum
      # kdePackages.mlt
      # ffmpeg-full
      handbrake # FIXME lag on open
      # obs-cli
      obs-studio
      # ungoogled-chromium
      google-chrome
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      bluemail
    ]
    ++ [
      # Productivity Tools
      wpsoffice
      # libreoffice-qt-still
      # libreoffice-still
      onlyoffice-desktopeditors
    ]
    ++ [
      # CreativeSPACE 📽
      blender
      darktable # Artist
      digikam # Librarian
      ffmpeg
      gimp
      inkscape-with-extensions
      krita
      kdePackages.kdenlive
      # figma-linux
      # figma-agent  #NOTE listens on 127.0.0.1:44950
      # davinci-resolve
      exiftool
    ]
    ++ (lib.optionals (osConfig.hypr.enable) [
      # file-roller
      # inputs.hyprswitch.packages.x86_64-linux.default
      # yelp
      grimblast
      slurp
      sushi
      viewnior
      # hyprpwcenter
      hyprland-autoname-workspaces
      kdePackages.qt6ct
      kdePackages.kalk
      kdePackages.dolphin
    ]);
}
