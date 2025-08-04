{
  home.sessionVariables = {
    # EDITOR = "emacsclient -nw";
    EDITOR = "vim";
    # VISUAL = "emacs -r";
    #MANPAGER="nvim +Man!";
    #MANWIDTH=999;
    LSP_USE_PLISTS = "true"; # for emacs? TODO see how to have this inside emacs itself
    SUDO_PROMPT = "$(tput sgr0)$(tput setaf 199) $(tput sgr0) "; # 219
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
