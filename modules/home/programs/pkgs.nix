{
  osConfig,
  pkgs,
  pkgs-stable,
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
      # inputs.vermilion.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ [
      grim
      imagemagick # screenshot
      zenity
      # sound-theme-freedesktop # free sounds
      libcanberra-gtk3
      kdePackages.kasts
      kdePackages.ksudoku
      kdePackages.kservice
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
      # Fediverse
      telegram-desktop
      # signal-desktop
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
    ++ [
      # coppwr
      # helvum
      # kdePackages.mlt
      # ffmpeg-full
      handbrake # FIXME lag on open
      # obs-cli
      obs-studio
    ]
    ++ [
      bluemail
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ [
      # Productivity Tools
      # libreoffice-qt-still
      # libreoffice-still
      onlyoffice-desktopeditors
      # wordbook
      # wpsoffice
    ]
    ++ [
      # CreativeSPACE 📽
      blender
      darktable # Artist
      digikam # Librarian
      gimp
      inkscape-with-extensions
      krita
      kdePackages.kdenlive
      # figma-linux
      # figma-agent  #NOTE listens on 127.0.0.1:44950
      pkgs-stable.davinci-resolve
      exiftool
    ];
}
