{
  home.sessionVariables = {
    EDITOR="nvim";
    #MANPAGER="nvim +Man!";
    #MANWIDTH=999;
    #BEMOJI_CLIP_CMD="wl-copy"; # which clipboard tool to use
    #BEMOJI_TYPE_CMD="wtype"; # which typing tool to use (ydotool will NOT work)
    #BEMOJI_TYPE_CMD="dotool"; # which typing tool to use (ydotool will NOT work)
    #BEMOJI_ECHO_NEWLINE="true"; # whether to end the output with a newline character
    # UWSM_WAIT_VARNAMES="$UWSM_WAIT_VARNAMES";
  };
  systemd.user.sessionVariables = {
    # EDITOR="nvim";
    # UWSM_WAIT_VARNAMES="$UWSM_WAIT_VARNAMES";
  };
}
