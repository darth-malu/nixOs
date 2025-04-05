{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  options.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = {
    programs = {
      hyprland = {
        # required even with homeManager for system functions -> xdg, session files
        enable = true; # also enables XDPH
        withUWSM = lib.mkDefault true;
        # xwayland.enable = true; # true::
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; # set package + portal if using flake
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; # make sure to also set the portal package, so that they are in sync
      };
    };
    services = {
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
      power-profiles-daemon.enable = true;
      upower.enable = true; # TODO transfer to tangier only after testing
    };
    # (lib.mkIf config.networking.hostName == "tangier") services.upower.enable = true;
    security.polkit = {
      enable = true;
      extraConfig = ''
        # reboot/poweroff for non sudo users
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        });
      '';
    };
    # systemd = {
    #   user.services.hyprpolkitagent = {
    #     description = "hyprpolkitagent";
    #     wantedBy = [ "graphical-session.target" ];
    #     wants = [ "graphical-session.target" ];
    #     after = [ "graphical-session.target" ];
    #     serviceConfig = {
    #         Type = "simple";
    #         ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
    #         Restart = "on-failure";
    #         RestartSec = 1;
    #         TimeoutStopSec = 10;
    #       };
    #   };
    # }; # FIXME does not work
  };
}
