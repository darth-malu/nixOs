{
  config,
  lib,
  pkgs,
  ...
}:

{

  environment.variables = {
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

    LSP_USE_PLISTS = "true";

    PATH = [
      "/home/malu/.config/emacs/bin"
    ];
  };
}
