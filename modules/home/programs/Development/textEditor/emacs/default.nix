{ pkgs, ... }:
{
  imports = [
    ./emacsPkgs.nix
    # ./mbsync.nix
    ./mbsync_edmundmiller.nix
  ];

    emacs-mail.enable = false;

    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk; # emacs, emacs-gtk, emacs-nox, emacs-pgtk
      # NOTE: need update from 30.2 -> pgtk
    };

    services.emacs = {
      enable = true; # emacs daemon
      startWithUserSession = true; # launch with systemd user session. "graphical" -> graphical-session.target . true -> default.target::
      # defaultEditor = true;
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
        "-c"
      ];
    };

    home = {
      sessionPath = [
        "$HOME/.config/emacs/bin"
      ];
      sessionVariables = {
        LSP_USE_PLISTS = "true";
      };
    };
}
