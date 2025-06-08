{ osConfig, ... }:
{
  # imports = [ ../modules/home ];

  imports =
    [
      ./pkgs
      ./xdg
      # ./editorConfig.nix # works nicely
    ]
    ++ (
      if osConfig.programs.hyprland.enable then
        [
          ./themes
        ]
      else
        [ ]
    );

  home = {
    username = "malu";
    #groupname = "darth";
    homeDirectory = "/home/malu";
    preferXdgDirectories = true;
    sessionPath = [
      "$HOME/.emacs.d/bin" # doom
    ];
    sessionVariables = {
      # EDITOR = "emacs";
      #MANPAGER="nvim +Man!";
      #MANWIDTH=999;
      LSP_USE_PLISTS = "true"; # for emacs? TODO see how to have this inside emacs itself
    };
    stateVersion = "24.11";
  };

  systemd.user = {
    startServices = "sd-switch"; # Nicely reload system units when changing configs # https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
    sessionVariables = {
    };
  };
}
