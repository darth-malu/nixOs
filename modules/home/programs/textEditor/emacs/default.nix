{ pkgs, osConfig, ... }:
{
  imports = [
    ./emacsPkgs.nix
    # ./mbsync.nix
    ./mbsync_edmundmiller.nix
  ];

  config = {
    emacs-mail.enable = true;

    programs.emacs = {
      enable = true;
      # package = if osConfig.networking.hostName == "tangier" then pkgs.emacs else pkgs.emacs-pgtk; # emacs, emacs-gtk, emacs-nox, emacs-pgtk
      package = pkgs.emacs-pgtk;
      # extraConfig = ''
      #   (setq standard-indent 2)
      # ''; # init.el
    };

    services.emacs = {
      enable = true; # emacs daemon
      startWithUserSession = true; # launch with systemd user session. "graphical" -> graphical-session.target ( if true -> default.target::)
      # defaultEditor = false;
      socketActivation.enable = true;
      client = {
        # Whether to enable systemd socket activation for the Emacs service. # TODO see if conflicting with startWithUSerSession
        enable = true; # false::, generation of Emacs client desktop file.
        arguments = [
          "-c" # -r --reuse-frame (reuse frame if exists, otherwise create a new frame) - --create-frame/-c
          # "-nw"
          # "-a 'emacs'"
        ];
      };
      extraOptions = [
        "-r"
      ];
    };
  };
}
