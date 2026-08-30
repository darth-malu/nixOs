{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableBrowserSocket = true;
    pinentryPackage = pkgs.pinentry-curses; # TODO see implication of curses vs emacs
    enableSSHSupport = false; # .Also sets SSH_AUTH_SOCK environment variable correctly. Disables socket and activate once per user session
    # NOTE: prompt on every git opp sometimes weird
  };

  security.pam.services.login.gnupg = {
    # TODO optimise this
    enable = true;
    noAutostart = true;
    storeOnly = true;
  };
}
