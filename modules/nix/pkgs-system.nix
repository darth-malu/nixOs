{pkgs,  config, pkgs-unstable,...}:

{
  programs = {
    dconf.enable = true;
  };

  services = {
    gvfs.enable = true;
    locate = { enable = true; };
    fstrim = { enable = true; interval = "weekly"; };
    # udev.enable = true; #default: true
    # dbus = {
    #   implementation = lib.mkDefault "broker"; #"broker" , "dbus"
    # };
  };

  environment = { # List of packages installed in system profile. To search, run: $ nix search wget
    systemPackages =(with pkgs; [
      libnotify # notify-send
      wget
      # neovimConf.neovim
      # nixd
      # appimage-run # for appiamges to run
      clinfo # verify OpenCl
      #cpufrequtils
      lshw efibootmgr file ripgrep fd fzf curl dash procs exfat
      #glib
      #gsettings-qt
      killall
      nix-prefetch-git #nix-prefetch-scripts #includes git prefetch
      pipewire pwvucontrol playerctl wireplumber 
      ntfs3g
      lsof #list open files/ports**
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      jmtpfs # mtp drivers
      pciutils #lspci
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
      kitty bc lsd tldr xdg-user-dirs xdg-utils # xdg-open, xdg-mime, xdg-desktop-menu/icon
      dotool  # test if working
    ])
    ++
    (with pkgs-unstable; [
      #waybar
      micro
      spotube
      # davinci-resolve
    ])
    ++
    (if config.programs.hyprland.enable
        then with pkgs; [
          wl-clipboard
          hyprcursor hyprpicker
          libappindicator libappindicator-gtk3
          # polkit_gnome
          hyprpolkitagent hyprsunset
          libcanberra-gtk3
          libcanberra
          # libsecret # secrets lul
          # lib.mkIf (config.networking.hostName == "tangier") with pkgs; [brightnessctl]
          kdePackages.qt6ct kdePackages.qtwayland
        ] ++
        (if config.networking.hostName == "tangier" then [
          brightnessctl

        ] else [])
        else
          (if config.services.desktopManager.plasma6.enable then with pkgs.kdePackages; [
            # hello
            # filelight
            ghostwriter
            # plan # watch
            calindori
            # pkgs.labplot
          ] else [])
    );
    };
}
