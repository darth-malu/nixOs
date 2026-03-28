{ osConfig, ... }:
{
  imports = [
    ./xdg
    ./session_Variables+Path.nix
    ./programs
    ./services
    ./configurations
  ];

  home = {
    username = "malu";
    # groupname = "darth";
    homeDirectory = "/home/malu";
    preferXdgDirectories = true;
    stateVersion = if osConfig.networking.hostName == "carthage" then "25.11" else "24.11";
  };

  systemd.user = {
    startServices = "sd-switch"; # Nicely reload system units when changing configs # https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
    # sessionVariables = {};
  };
}
