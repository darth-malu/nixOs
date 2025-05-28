{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        scheme-medium
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );

  emax = with pkgs; import ./emacs-pkgs.nix;

in
{
  imports = [
    ./yt-dlp.nix
    ./qutebrowser
    ./soundStuff
    ./mpv
    ./git.nix
    # ./tmux
    ./emacs
    ./yazi
    ../terminal
    ../bash
    ../hyprland
    ../textEditor
    inputs.nyaa.homeManagerModule
  ];

  # modules
  homeHyprland.enable = lib.mkIf osConfig.hyprland.enable true;

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
      # qalculate-qt # #FIXME:for rofi?
      dotool
      # calc
      #aria2#NOTE: learn
      qbittorrent

      # ntfs3g # NOTE: trying whichever which way
      tokei

      # archive
      # zip xz unzip p7zip

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
      nethogs

      #gnome.nautilus gnome.sushi gnome.file-roller gnome.yelp

      trash-cli # for move to trash mpv
      # xorg.libxcb # for ffmpeg x11grab?
      wf-recorder

      telegram-desktop
      discord
      whatsapp-for-linux # socials

      # browserr
      # chromium
      # lynx # terminal browser pretty fun -> on emacs now
      google-chrome
      # bluemail # TODO move to mu4e

      # Entertainment
      # lollypop # cantata better
      mpc-cli
      # ymuse # rudimentary
      cantata
      youtube-tui # https://siriusmart.github.io/youtube-tui/
      spotify
      easyeffects

      # productivity
      buku # TODO: test
      # groff
      # ghostscript
      # obsidian
      # glow # TODO: test this extensively # see quart for blog with markdown
      #blender
      # blender-hip # accelarated render
      # freeglut
      # gcc
    ]
    ++ emax
    ++ (with pkgs; [
      # creative space
      #(ffmpeg.override { withXcb = true;  })
      # davinci-resolve
      #  ffmpeg
      spotube
      spotify-cli-linux
      spotube
      kdePackages.kdenlive
      # digikam
    ])
    ++ (with pkgs; [
      # NOTE: MANGA stuff
      # komikku # broken
      mangal
      ani-cli
      miru
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

  programs = import ./programs.nix;

  services = {
    # kdeconnect.enable = true;
    blueman-applet.enable = lib.mkIf osConfig.hyprland.enable true;
    udiskie = {
      enable = lib.mkIf osConfig.hyprland.enable true;
      tray = "auto"; # works
      notify = true;
      automount = false; # better?
      # appindicator = true; # use if no icon shows...uses appindicator3
      settings = {
        # config written to .config/udiskie/config.yml
        # https://github.com/coldfix/udiskie/blob/master/doc/udiskie.8.txt#configuration
        # program_options = {
        #   udisks_version = 2;
        #   tray = true;
        # };
        # icon_names.media = [ "media-optical" ];
        # file-manager = "kitty -e 'yazi'";
        file-manager = "kitty -e 'yazi'";
        terminal = "${pkgs.kitty}/bin/kitty -e yazi";
        # file-manager = "/home/malu/.nix-profile/bin/yazi";
        # file-manager = "xdg-open";
      };
    };
  };
}
