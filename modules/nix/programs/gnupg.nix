{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.gnupg.agent = {
    enable = true;
    # enableBrowserSocket = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true; # Enable SSH agent support in GnuPG agent. Also sets SSH_AUTH_SOCK environment variable correctly.
  };

  security.pam.services.login.gnupg = {
    enable = true;
    noAutostart = true;
    storeOnly = true;
  };
}
