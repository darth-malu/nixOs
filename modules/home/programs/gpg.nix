{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    settings = {
      no-comments = false;
      s2k-cipher-algo = "AES128";
    };
  };

  home.packages = with pkgs; [
    pinentry
    pinentry-all
  ];

  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    ''; # TODO Find out neeed
    verbose = true;
    pinentry.program = "pinentry-wayprompt";
  };
}
