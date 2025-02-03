{inputs, lib, pkgs-unstable,pkgs, ...}:

{
  programs =  {
    hyprland = { # required even with homeManager for system functions -> xdg, session files
      enable = true; # also enables XDPH
      withUWSM = lib.mkDefault true;
      xwayland.enable = true; # true::
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
    # extraConfig = ''
    #   # reboot/poweroff for non sudo users
    #   polkit.addRule(function(action, subject) {
    #     if (
    #       subject.isInGroup("users")
    #         && (
    #           action.id == "org.freedesktop.login1.reboot" ||
    #           action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
    #           action.id == "org.freedesktop.login1.power-off" ||
    #           action.id == "org.freedesktop.login1.power-off-multiple-sessions"
    #         )
    #       )
    #     {
    #       return polkit.Result.YES;
    #     }
    #   });
    # '';
  };
  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true; # false:: - use portal for xdg-open. sets NIXOS_XDG_OPEN_USE_PORTAL = 1
    wlr.enable = true; # to share screen
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };
}
