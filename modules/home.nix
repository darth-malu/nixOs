{
  imports = [ ../modules/home ];

  home = {
    username = "malu";
    #groupname = "darth";
    homeDirectory = "/home/malu";
    stateVersion = "24.11";
    preferXdgDirectories = true;
    sessionPath = [
      "$HOME/.emacs.d/bin" # doom
    ];
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch"; # https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
}
