{
  home.sessionVariables = {
    # EDITOR = "emacsclient -nw";
    EDITOR = "vim";
    # VISUAL = "emacs -r";
    #MANPAGER="nvim +Man!";
    #MANWIDTH=999;
    LSP_USE_PLISTS = "true"; # for emacs? TODO see how to have this inside emacs itself
  };
  home.sessionPath = [
    "$HOME/.emacs.d/bin"
  ];

  systemd.user = {
    startServices = "sd-switch"; # Nicely reload system units when changing configs # https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
    # sessionVariables = {
    # };
  };
}
