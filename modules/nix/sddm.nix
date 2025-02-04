{lib,...}:

{
  services.displayManager = {
    sddm = {
      enable = true;
      #package = lib.mkDefault pkgs-unstable.plasma5Packages.sddm;
      # package = pkgs-unstable.kdePackages.sddm;
      wayland.enable = lib.mkDefault true;
      autoNumlock = true;
      autoLogin.relogin = true;
      #autoLogin.minimumUid = 1000;
      # theme = "sddm-sugar-dark"; # no work like this
    };
  defaultSession = "hyprland-uwsm"; # preselect graphical session.
  # defaultSession = "hyprland"; # preselect graphical session.
  };
}
