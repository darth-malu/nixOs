{pkgs,  config, pkgs-unstable,...}:

{
  programs = {
    # dconf.enable = false;
      bash = {
        completion.enable = true;
        promptInit = import ./PS1.nix;
        enableLsColors = true;
        #blesh.enable = true;
        undistractMe = { #ISSUES
         enable = false;
          timeout = 30; #seconds
          playSound = false;#TODO: can this be improved??
        };
        # shell init
        # loginShellInit = /*bash*/ ''
        #   if uwsm check may-start; then
        #     # exec uwsm start -s hyprland-uwsm.desktop
        #     exec uwsm start hyprland-uwsm.desktop
        #     # exec uwsm start -S hyprland.desktop
        #     # exec uwsm start hyprland-systemd.desktop
        #   fi
        # '';
        # shellInit = /*bash*/ ''
        #   if uwsm check may-start && uwsm select; then
        #     exec systemd-cat -t uwsm_start uwsm start default
        #   fi
        # '';
        # interactiveShellInit = /*bash*/ ''
        # '';
      };

  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.malu.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };

  services = {
    mpd = {
      #user = "mpd";
      enable = true;
      user = "malu";
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = false; # check if needed
      };
      wireplumber.enable = true;
      #extraConfig.pipewire."92-low-latency" = {
        #"context.properties" = {
        #"default.clock.rate" = 48000;
        #"default.clock.quantum" = 32;
        #"default.clock.min-quantum" = 32;
        #"default.clock.max-quantum" = 32;
        #};
      #};
    };

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
      lshw efibootmgr file ripgrep fd curl dash procs exfat
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
