{inputs, lib, pkgs, ...}:

{
  programs =  {
    hyprland = { # required even with homeManager for system functions -> xdg, session files
      enable = true; # also enables XDPH
      withUWSM = lib.mkDefault true;
      # xwayland.enable = true; # true::
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; # set package + portal if using flake
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;# make sure to also set the portal package, so that they are in sync
    };
  };
  services = {
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
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
}
