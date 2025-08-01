{
  config,
  inputs,
  osConfig,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    [
      ed
      nasm
      sway-audio-idle-inhibit
      wev
      # tldr - using emacs one lol
      # kdePackages.dolphin # FIXME launching shit not working on hyprland
      # kdePackages.konsole
      duf
      ncdu
      libsecret
      # superfile # kinda cool but dont need
      #testdisk # also installs photorec
      # testdisk-qt
      # gsmartcontrol
      # squirreldisk #kinda nice
      # qdiskinfo
      # win-disk-writer
      #
      # qalculate-qt # #FIXME:for rofi?
      dotool
      # calc
      #aria2#NOTE: learn
      qbittorrent

      # tokei

      # zip xz unzip p7zip
      # testing for yazi #
      # zip
      # xz
      # unzip
      # p7zip

      #rofimoji bemoji
      modem-manager-gui
      modemmanager # saves the day with no internet
      # taskwarrior3
      # taskwarrior-tui

      # utilities
      # warp-terminal # insane bloat
      file
      lsof # list open files/ports**
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      pciutils # lspci
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
      lm_sensors

      ventoy-full # usb imager #woeusb

      # perfomance monitoring
      mission-center
      iftop
      iotop-c
      nethogs
      inxi
      amdgpu_top

      # libadwaita
      pastel # color generator

      trash-cli # for move to trash mpv
      wf-recorder

      inputs.quickshell.packages.${system}.default
      telegram-desktop
      discord
      whatsapp-for-linux

      google-chrome
      # bluemail # TODO move to mu4e

      # Entertainment
      # lollypop # cantata better
      mpc-cli
      # ymuse # rudimentary
      # smplayer
      # cantata # old af
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      spotify
      easyeffects

      # productivity
      # buku # TODO: test
      jetbrains.pycharm-community-bin
      wpsoffice
      # vscodium-fhs
      # vscodium
      dotnet-sdk

      # C
      libgcc
      nasm

      # icons
      yaru-theme
    ]
    ++ (with pkgs; [
      # creative space
      #(ffmpeg.override { withXcb = true;  })
      # davinci-resolve
      spotify-cli-linux
      # spotube
      # kdePackages.kdenlive
      # digikam
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
          gimp
          darktable
          obs-studio
          obs-cli
          ffmpeg-full # full vs vanilla?
          #STEAM
          mangohud
          lutris
          bottles
          heroic
          protonup-qt # GUI for installing custom Proton versions like GE_Proton
          # wine
          wine64
          winetricks
        ]
      else
        [ ffmpeg ]
    )
    ++ (
      if config.homeHyprland.enable then
        with pkgs;
        [
          grimblast
          slurp
          viewnior
          vlc
          cliphist
          nautilus
          sushi
          yelp
          # inputs.hyprswitch.packages.x86_64-linux.default
          file-roller
        ]
      else
        [ ]
    );
}
