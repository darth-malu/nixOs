{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableBrowserSocket = true;
    pinentryPackage = pkgs.pinentry-curses; # TODO see implication of curses vs emacs
    enableSSHSupport = true; # .Also sets SSH_AUTH_SOCK environment variable correctly. Disables socket and activate once per user session
  };

  security.pam.services.login.gnupg = {
    # TODO optimise this
    enable = true;
    noAutostart = true;
    storeOnly = true;
  };
}
