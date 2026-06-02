{ osConfig, ... }:
{
  imports = [
    ./xdg
    ./homeSessionVariables+path.nix
    ./programs
    ./services
    ./configurations
  ];

  home = {
    username = "malu";
    # groupname = "darth";
    homeDirectory = "/home/malu";
    preferXdgDirectories = true;
    stateVersion = "26.05";
  };

  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs # https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
}
