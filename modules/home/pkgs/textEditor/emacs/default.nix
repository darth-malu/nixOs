{ pkgs, ... }:
{
  imports = [
    ./emacsPkgs.nix
  ];

  config = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk; # emacs, emacs-gtk, emacs-nox, emacs-pgtk
      # extraConfig = ''
      #   (setq standard-indent 2)
      # ''; # init.el
    };

    services.emacs = {
      enable = true; # emacs daemon
      startWithUserSession = true; # whether to launch Emacs servicee with the systemd session. boolean or "graphical" (default.target::) #TODO test without
      defaultEditor = true;
      socketActivation.enable = true; # Whether to enable systemd socket activation for the Emacs service. # TODO see if conflicting with startWithUSerSession
      client = {
        enable = false; # false::, generation of Emacs client desktop file.
        arguments = [
          "-c" # open in emacs frame / GUI frame
          # "-a 'emacs'"
        ];
      };
      # package =;
      # extraOptions = ''
      # '';
    };
  };
}
