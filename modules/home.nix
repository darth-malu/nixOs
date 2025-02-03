{
  imports = [ ../modules/home ];

  home = {
    username = "malu";
    #groupname = "darth";
    homeDirectory = "/home/malu";
    stateVersion =  "24.05"; #TODO: make this different for the machines
    preferXdgDirectories = true;
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch"; #https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
}
