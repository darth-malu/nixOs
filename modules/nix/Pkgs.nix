{
  pkgs,
  # lib,
  config,
  ...
}:

{
  imports = [
    ./fonts.nix
    ./sync-thing
    ./ssh
    ./bash.nix
    ./qemu
  ];

  # qemuNix.enable = if config.networking.hostName == "carthage" then true else false;

  services = {
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
    # udev.enable = true; # true::
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
        # ntfs3g
        lsof # list open files/ports**
        usbutils # lsusb, usb-devices, usb-view(optional gui)
        jmtpfs # mtp drivers
        pciutils # lspci
        util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
        kitty
        bc
        # tldr # emacs better
        dotool # test if working
        micro
      ])
      ++ (
        if config.programs.hyprland.enable then
          with pkgs;
          [
            wl-clipboard
            # hyprcursor
            hyprpicker
            hyprpolkitagent
            # hyprsunset
            # libappindicator # TODO test if needed
            libappindicator-gtk3
            # polkit_gnome
            libcanberra-gtk3
            # libcanberra # TODO test if needed both
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
              # with pkgs.kdePackages;
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
