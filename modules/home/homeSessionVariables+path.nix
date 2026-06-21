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
    SUDO_PROMPT = "$(tput sgr0)$(tput setaf 199)  $(tput sgr0) ";
    # EDITOR = "vim";
    # VISUAL = "emacsclient -r";
    # XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";

    APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";

    # Nuitka Stuff
    NUITKA_CACHE_DIR_CCACHE = "~/.cache/nuitka/cache";
    NUITKA_CACHE_DIR_DOWNLOADS = "~/.cache/nuitka/downloads";

    DARTH_ASCII = "~/Development/C/ascii";
    DARTH_YT = "~/Development/SkunkWorks/PySide6/youtubr/youtubr";

  };

  home.sessionPath = [
    # Prepend to $PATH in a double-quoted context
    "${config.xdg.configHome}/emacs/bin"
    "${config.home.homeDirectory}/Development/Core-Utils/bash/Scripts"
    "/home/malu/.cache/.bun/bin"
    "/home/malu/.bun/bin"
  ];

  xdg.configFile = {
    "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    "mimeapps.list".force = true;
  };
}
