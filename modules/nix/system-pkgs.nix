{ pkgs, config, ... }:

{
  imports =
    [
      ./fonts.nix
      ./sync-thing
      ./ssh
      ./bash.nix
    ]
    ++ (
      if config.networking.hostName == "carthage" then
        [ ./qemu ] # TODO learn use
      else if config.networking.hostname == "tangier" then
        [ ]
      else
        [ ]
    );
  programs = {
    dconf.enable = false; # TODO see if needed
  };

  services = {
    gvfs.enable = true;
    blueman.enable = true;
    locate.enable = false; # i dont use this...fd/fzf
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = false; # check if needed
      };
      wireplumber.enable = true;
      #extraConfig.pipewire."92-low-latency" = {#FIXME: crackling
      #"context.properties" = {
      #"default.clock.rate" = 48000;
      #"default.clock.quantum" = 32;
      #"default.clock.min-quantum" = 32;
      #"default.clock.max-quantum" = 32;
      #};
      #};
    };
    # udev.enable = true; #default: true
    # dbus = {
    #   implementation = lib.mkDefault "broker"; #"broker" , "dbus"
    # };
  };

  environment = {
    # List of packages installed in system profile. To search, run: $ nix search wget
    systemPackages =
      (with pkgs; [
        libnotify # notify-send
        wget
        # neovimConf.neovim
        # nixd
        # appimage-run # for appiamges to run
        clinfo # verify OpenCl
        #cpufrequtils
        lshw
        efibootmgr
        curl
        dash
        procs
        #glib
        #gsettings-qt
        killall
        nix-prefetch-git # nix-prefetch-scripts #includes git prefetch
        pipewire
        pwvucontrol
        playerctl
        wireplumber
        ntfs3g
        lsof # list open files/ports**
        usbutils # lsusb, usb-devices, usb-view(optional gui)
        jmtpfs # mtp drivers
        pciutils # lspci
        util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
        kitty
        bc
        tldr
        xdg-user-dirs
        xdg-utils # xdg-open, xdg-mime, xdg-desktop-menu/icon #TODO: see if needed
        dotool # test if working
        micro
        spotube
      ])
      ++ (
        if config.programs.hyprland.enable then
          with pkgs;
          [
            wl-clipboard
            hyprcursor
            hyprpicker
            hyprpolkitagent
            hyprsunset
            libappindicator
            libappindicator-gtk3
            # polkit_gnome
            libcanberra-gtk3
            libcanberra
            # libsecret # secrets lul
            # lib.mkIf (config.networking.hostName == "tangier") with pkgs; [brightnessctl]
            #kdePackages.qt6ct kdePackages.qtwayland -- see if needed
          ]
          ++ (
            if config.networking.hostName == "tangier" then
              [
                brightnessctl
              ]
            else
              [ ]
          )
        else
          (
            if config.services.desktopManager.plasma6.enable then
              with pkgs.kdePackages;
              [
                # hello
                # filelight
                # ghostwriter
                # plan # watch
                # calindori
                # pkgs.labplot
              ]
            else
              [ ]
          )
      );
  };
}
