{ config, ... }:
{
  /*
    If you need to reference another session variable (even if it is declared by using other options like ), then do so inside Nix instead. The above example then becomes
    A default value foo may be given as per ${parameter:-foo} and, similarly, an alternate value bar can be given as per ${parameter:+bar}.

    home.sessionVariables = {
      FOO = "Hello";
      BAR = "${config.home.sessionVariables.FOO} World!";
    };
  */

  home.sessionVariables = {
    #MANWIDTH=999;
    SUDO_PROMPT = "$(tput sgr0)$(tput setaf 199) $(tput sgr0) ";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    LSP_USE_PLISTS = "true";
    EDITOR = "vim";
  };
  home.sessionPath = [
    "$HOME/.emacs.d/bin"
    "$HOME/.code/PySide6/youtubr/dist"
  ];

  # UWSM environment
  xdg.configFile."uwsm/env".text =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  # EDITOR = "emacsclient -nw";
  # VISUAL = "emacs -r";

  systemd.user = {
    startServices = "sd-switch"; # Nicely reload system units when changing configs # https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch #TODO: see if need
    # sessionVariables = {
    # };
  };
}
