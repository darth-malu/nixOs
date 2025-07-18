{
  imports = [
    ./xdg
    ./sessionVariables.nix
    ./pkgs
    ./programs
    ./services
  ];

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  home = {
    username = "malu";
    #groupname = "darth";
    homeDirectory = "/home/malu";
    preferXdgDirectories = true;
    stateVersion = "24.11";
  };

  systemd.user = {
    startServices = "sd-switch"; # Nicely reload system units when changing configs # https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
    sessionVariables = {
    };
  };
}
