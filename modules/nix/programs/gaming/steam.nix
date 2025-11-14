{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.steamy = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf config.steamy.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true; # Integrates with programs.steam
      protontricks = {
        enable = true;
        # package =
      };
    };

    programs.gamemode = {
      # daemon and library combo that allows games to request a set of optimisations be temporarily applied to the host OS. This can improve game performance
      # Feral Game mode
      # https://www.mankier.com/8/gamemoded
      enable = true;
      # enableRenice  = true;     # true::
      settings = {
        # general = {
        #   renice = 10; # 0::-20 - user must be in gamemode group
        # };
        # Warning: GPU optimisations have the potential to damage hardware
        # gpu = {
        #   apply_gpu_optimisations = "accept-responsibility"; # 0::
        #   gpu_device = 0; # /sys/class/drm/card0/
        #   amd_performance_level = "high";
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

    environment.systemPackages = with pkgs; [
      # Trying gamescope recording
      # gst_all_1.gstreamer
    ];

    hardware.xone.enable = true; # support for the xbox controller USB dongle

    environment.sessionVariables = {
      # STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # change or add to the paths which steam searches for custom Proton versions.-> protonup
      # default location #~/.steam/root/compatibilitytools.d
    };

  };
}
