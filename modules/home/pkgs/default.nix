{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:

{
  imports = [
    ./yt-dlp.nix
    ./qutebrowser
    ./soundStuff
    ./mpv
    ./git.nix
    ./yazi
    ./shell
    ./hyprland
    ./textEditor
    ./programs.nix
    ./services.nix
    inputs.nyaa.homeManagerModule
  ];

  homeHyprland.enable = lib.mkIf osConfig.programs.hyprland.enable true;

  home.packages =
    with pkgs;
    [
      sway-audio-idle-inhibit
      wev
      # tldr - using emacs one lol

      # disk management
      duf
      ncdu
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

      tokei

      # archive
      # zip xz unzip p7zip
      # testing for yazi #
      zip
      xz
      unzip
      p7zip

      #rofimoji bemoji
      modem-manager-gui
      modemmanager # saves the day with no internet
      # taskwarrior3
      # taskwarrior-tui

      # utilities
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

      # TODO EXP - see if icons will be fixed
      # libadwaita
      # THEMING
      pastel # color generator

      trash-cli # for move to trash mpv
      wf-recorder

      telegram-desktop
      discord
      whatsapp-for-linux # socials

      # lynx # terminal browser pretty fun -> on emacs now
      google-chrome
      # bluemail # TODO move to mu4e

      # Entertainment
      # lollypop # cantata better
      mpc-cli
      # ymuse # rudimentary
      cantata
      # youtube-tui # https://siriusmart.github.io/youtube-tui/
      spotify
      easyeffects

      # productivity
      # buku # TODO: test
      jetbrains.pycharm-community-bin
      jetbrains.rider # c#
    ]
    ++ (with pkgs; [
      # creative space
      #(ffmpeg.override { withXcb = true;  })
      # davinci-resolve
      #  ffmpeg
      spotube
      spotify-cli-linux
      spotube
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
    ++ (with pkgs; [
      # hyrpland
      hyprpicker
    ])
    ++
      # NOTE: selective
      (
        if osConfig.networking.hostName == "carthage" then
          with pkgs;
          [
            gimp
            obs-studio
            obs-cli
            ffmpeg-full # full vs vanilla?
          ]
        else if osConfig.networking.hostName == "tangier" then
          [
            ffmpeg
          ]
        else
          [ ]
      );

}
