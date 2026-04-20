{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.steamy = {
    enable = lib.mkEnableOption "steam";
    # Steam Launcher options
    # NOTE gamemoderun %command% -novid -sdlaudiodriver pipewire -vulkan -nomousegrab -high -map dota -vulkan_disable_steam_shader_cache
  };

  config = lib.mkIf config.steamy.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true; # Integrates with programs.steam
      protontricks.enable = true;
    };

    programs.gamemode = {
      # daemon and library combo that allows games to request a set of optimisations be temporarily applied to the host OS. This can improve game performance
      # Feral Game mode
      # https://www.mankier.com/8/gamemoded
      enable = true;
      # enableRenice  = true;     # true::
      settings = {
        # https://github.com/FeralInteractive/gamemode/blob/master/example/gamemode.ini
        general = {
          renice = 10; # 0(no change)::0-20 - user must be in gamemode group
        };
        # Warning: GPU optimisations have the potential to damage hardware
        # gpu = {
        # apply_gpu_optimisations = "accept-responsibility"; # 0::
        # gpu_device = 0; # /sys/class/drm/card0/
        # amd_performance_level = "high";
        # };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send -i /home/malu/Shibuya/assets/icons8-ps-controller-48.png 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send -i /home/malu/Shibuya/assets/icons8-ps-controller-48.png 'GameMode ended'";
          # script_timeout = 10;
        };
      };
    };

    programs.gamescope = {
      # is a microcompositor from Valve that is used on the Steam Deck. Its goal is to provide an isolated compositor that is tailored towards gaming and supports many gaming-centric features.
      enable = true;
      capSysNice = true; # Add cap_sys_nice capability to the GameScope binary so that it may renice itself.
    };

    environment.systemPackages =
      with pkgs;
      [
        # Trying gamescope recording
        antimicrox
        # bottles
        (heroic.override {
          extraPkgs =
            pkgs': with pkgs'; [
              gamemode
              gamescope
            ];
        }) # without fhs
        protonup-ng
        # protonup-rs
        # TODO see if wineWow64 needed or they are installed as deps where required
        # wineWowPackages.full # support both 32-bit and 64-bit applications - stable, full, waylandFull
        # pkgs.wineWow64Packages.wayland
        # winetricks
      ]
      ++ (
        if config.networking.hostName == "carthage" then
          [
            amdgpu_top
          ]
        else
          [ ]
      );

    hardware.xone.enable = false; # support for the xone driver for Xbox One and Xbox Series X|S accessories.
    # xpad kernel module
    # https://docs.kernel.org/input/joydev/joystick.html

    environment.sessionVariables = {
      # STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # change or add to the paths which steam searches for custom Proton versions.-> protonup
      # default location #~/.steam/root/compatibilitytools.d
    };

  };
}
