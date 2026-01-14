{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}) mesa;
  # myMesa = (inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}) mesa.drivers;
in
{
  options.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    # hardware.graphics.package = mesa;
    # system.nixos.tags = [ "Hyprland" ];
    programs = {
      hyprland = {
        # required even with homeManager for system functions -> xdg, session files
        enable = true; # also enables XDPH
        withUWSM = true;
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
      power-profiles-daemon.enable = lib.mkIf (config.networking.hostName == "tangier") true;
      upower.enable = lib.mkIf (config.networking.hostName == "tangier") true;
      blueman.enable = lib.mkIf (!config.kde.enable) true;
    };

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
  };
}
