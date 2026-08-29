{
  pkgs,
  osConfig,
  config,
  lib,
  ...
}:
{
  imports = [
    ./emacsPkgs.nix
    ./mbsync_edmundmiller.nix
  ];

  emacs-mail.enable = false;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk; # emacs-gtk, emacs-nox, emacs-pgtk
  };

  services.emacs = {
    enable = true; # emacs daemon
    startWithUserSession = true; # "graphical" - graphical-session.target . true - default.target::
    # defaultEditor = true;
    socketActivation.enable = lib.mkIf (osConfig.networking.hostName == "tangier") true;
    client = {
      # Whether to enable systemd socket activation for the Emacs service. # TODO see if conflicting with startWithUSerSession
      enable = true; # false::, generation of Emacs client desktop file.
      arguments = [
        "--reuse-frame" # -r --reuse-frame (reuse frame if exists, otherwise create a new frame) - --create-frame/-c
        # "-nw"
        # "-a 'emacs'"
      ];
    };
    extraOptions = [
      # extra command-line arguments to pass to emacs.
      #"--fullscreen"
      #"--no-splash"
    ];
  };

  home = {
    sessionPath = [
      "${config.xdg.configHome}/emacs/bin"
      "${config.home.homeDirectory}/.config/emacs/bin"
      "/home/malu/.config/emacs/bin"
    ];
    sessionVariables.LSP_USE_PLISTS = "true";
  };
}
