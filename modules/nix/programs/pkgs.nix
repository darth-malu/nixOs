{
  inputs,
  config,
  pkgs,
  ...
}:
{
  # services.udev.packages = [ pkgs.android-udev-rules ]; # NOTE: 'android-udev-rules' has been removed due to being superseded by built-in systemd uaccess rules.

  # List of packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages =
    with pkgs;
    [
      # DEVELOPER 🛠️
      # JavaScript
      # LUA
      # beekeeper-studio
      # cling
      # firebase-tools
      # libxml2
      # nasm
      # nodejs-slim_latest # consider npm for auto install of servers in lsp-mode
      # nodejs_25 # consider npm for auto install of servers in lsp-mode
      # patchelf
      # qtcreator
      # zlib
      android-tools
      dash
      deno
      ed
      lua54Packages.lua
      lua54Packages.luarepl
      manim # FIXME failed
      nodejs
      nushell
      rustywind
      socat
      tailwindcss-language-server # for use with lsp-tailwind (emacs)
      tailwindcss_4
      typescript
      typescript-language-server
      xonsh
      powershell
      eas-cli
      zenity
      newt
    ]
    ++ [
      # CORE
      libnotify # notify-send
      wget
      nvd
      app2unit # NOTE build error...wait for stable bin
      localsend
      #cpufrequtils
      lshw
      e2fsprogs # chattr etc
      efibootmgr
      curl
      procs
      libdisplay-info
      # stacer #NOTE: defunct
      psmisc # fuser,killall?
      nix-prefetch-git # nix-prefetch-scripts #includes git prefetch
      pipewire
      pwvucontrol
      playerctl
      lsof # list open files/ports**
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      # jmtpfs # mtp drivers - # TODO check if mtp-probe error is from this and how to mitigate - UNMAINTAINED
      pciutils # lspci
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock, more**
      kitty
      dotool # TODO test if working
      wl-clipboard
      # cliphist
      easyeffects
      mpc
      discord
      pv
      # ff2mpv-rust
      ff2mpv
      # gsmartcontrol
      # qdiskinfo
      # squirreldisk #kinda nice
      # superfile # kinda cool but dont need
      # testdisk-qt
      # utilities
      # win-disk-writer
      # testdisk # also installs photorec
      # duc
      # dust
      duf
      ncdu
      file # need for yazi mimedetection etc.
      iftop # TODO seems powerful investigate more
      inxi
      isd
      # gparted-full
      iotop-c
      lm_sensors
      lsof # list open files/ports**
      mission-center
      nethogs
      pciutils # lspci
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
      xdg-utils
      ripgrep-all
      dotool
      httrack
      modem-manager-gui
      modemmanager
      ventoy-full # usb imager #woeusb
      nautilus
      ffmpeg
      # firefox
      # ungoogled-chromium
      vulkan-tools
      libva-utils
      zenith
    ]
    ++ pkgs.lib.optionals (config.hypr.enable) [
      # hyprpicker
      # hyprpolkitagent
      libappindicator-gtk3 # needed for discord icon
      # libsecret # secrets lul
      # grimblast
      grim
      slurp
      mousam
      # file-roller
      # inputs.hyprswitch.packages.x86_64-linux.default
      # yelp
      sushi
      viewnior
      kdePackages.kalk
      # kdePackages.kclock # NOTE: broken jumpers/incrementers
      gnome-clocks
      imagemagick # screenshot
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
      kdePackages.dolphin
      # hyprsysteminfo
      # hyprshutdown
      # hyprpwcenter
      # hyprland-autoname-workspaces
    ]
    ++ pkgs.lib.optionals (config.networking.hostName == "tangier") [
      brightnessctl
      # inputs.envycontrol.packages.x86_64-linux.default
    ]
    ++ [
      # pastel # color generator
      # qalculate-qt # #FIXME:for rofi?
      # yaru-theme
      # aria2#NOTE: learn
      # libsecret # TODO use
      # ddrescue
      # testdisk
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
      # SOCIALS + Fediverse
      telegram-desktop
      # signal-desktop
      # mastodon # TODO: self host only? no desktop
      # cinny-desktop
      # rocketchat-desktop
      element-desktop
      google-chrome
      whatsapp-electron
    ]
    ++ [
      # SOUND
      # cantata # old af
      # clapper
      # kando
      # lollypop # cantata better
      # qqmusic
      # spotify-cli-linux
      # tenacity
      # ymuse # rudimentary
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      audacity
      blanket
      qbittorrent
      # gpu-screen-recorder-gtk
      wf-recorder
      # alarm-clock-applet
      spotify
      cliamp
      spotube
      # picard
      stremio-linux-shell
      sway-audio-idle-inhibit
    ]
    ++ [
      # ANIMU
      komikku # broken
      mangal
      ani-cli
      # miru #UNMAINTAINED
      #syncyomi - sync tachiyomi progress across devices
    ]
    ++ [
      bluemail
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      onlyoffice-desktopeditors
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
      # davinci-resolve
      # coppwr
      # helvum
      # kdePackages.mlt
      # ffmpeg-full
      handbrake # FIXME lag on open
      # obs-cli
      obs-studio
      exiftool
    ]
    ++ [
      # RARE usage | UNNEEDED
      # testdisk
      # testdisk-qt
      # extundelete
      # fio
      # killall # TODO: see if needed with psmisc
      # bc
    ];
}
