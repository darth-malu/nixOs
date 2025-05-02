{
  home.sessionVariables = {
    # EDITOR="nvim";
    # GTK_THEME = "Nightfox-Dark";
    #MANPAGER="nvim +Man!"; #TODO: make emacsclient my MANPAGER
    #MANWIDTH=999;
    LSP_USE_PLISTS = "true"; # for emacs? TODO test
    XDG_SCREENSHOTS_DIR = "~/Pictures/grimblast"; # TODO test...not working maybe need xdg_utils
  };
  systemd.user.sessionVariables = {
    # EDITOR="nvim";
    # UWSM_WAIT_VARNAMES="$UWSM_WAIT_VARNAMES";
  };
}
