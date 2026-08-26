{
  osConfig,
  config,
  lib,
  ...
}:
{
  /*
    If you need to reference another session variable (even if it is declared by using other options like ), then do so inside Nix instead. The above example then becomes
    A default value foo may be given as per ${parameter:-foo} and, similarly, an alternate value bar can be given as per ${parameter:+bar}.

    home.sessionVariables = {
      FOO = "Hello";
      BAR = "${config.home.sessionVariables.FOO} World!";
    };
  */

  programs.bash.profileExtra = ''
     if uwsm check may-start; then
       start-hyprland
    fi
  '';

  home.sessionVariables = {
    #MANWIDTH=999;
    # SUDO_PROMPT moved to bashrcExtra (needs bash ANSI-C quoting)
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
    "${config.home.homeDirectory}/.cache/.bun/bin"
    "${config.home.homeDirectory}/.bun/bin"
  ];

  xdg.configFile = {
    "uwsm/env" = {
      enable = lib.mkIf osConfig.programs.hyprland.withUWSM true;
      source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    };
    "mimeapps.list".force = true;
  };
}
