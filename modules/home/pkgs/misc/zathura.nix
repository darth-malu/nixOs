{
  enable = true;
  options = {
    # :set
    default-bg = "#000000";
    default-fg = "#FFFFFF";
    statusbar-h-padding = 0;
    statusbar-v-padding = 0;
    page-padding = 0;
    selection-clipboard = "clipboard"; # copy selection to system clipboard
    zoom-step = 20; # 10:: in % percentage
    zoom-min = 20; # 10::
    zoom-max = 1000; # 1000::
    scroll-step = 100; # 40::
    incremental-search = true;
    # highlight-color = ""; # #9FBC00::
    highlight-active-color = "#623CEA"; # #00BC00::, #75DBCD
    # highlight-transparency = ""; # 0.5::
    guioptions = "none"; # no statusbar
    adjust-open = "best-fit";
    smoth-scroll = true;
    font = "Iosevka Comfy semibold 10";
  };
  mappings = {
    # :map
    u = "scroll half-up";
    d = "scroll half-down";
    D = "toggle_page_mode"; # single | double page viewing mode
    N = "toggle_statusbar";
    M = "toggle_inputbar";
  };
  # extraConfig = ''
  # '';# zathurarc
  # keys ^ -> Meta, Ctrl
  # o -> open document
  # ^r -> recolor
  # ^n > toggle statusbar
  # ^m > toggle inputbar
  # zI, zO, z0 -> Zoom in, out or to the original size
  #
  # mouse
  # ^Scroll -> zoom in/out
  # Button1 -> follow link
  # Hold Button1 -> select text
  # Hold ^Button1 -> Highlight region
  #
  # vim keys work...including marks, search
  #f5 -> fullscreen mode

  # commands
  # :bmark -> for bookmark, blist -> list bookmarks ,bdelete
  # :exec -> execute an external command
  # write, write!
  # print
  # info
  # offset <number>
  # open, o -> open document
  # help

  # flags
  # -w [password]
  # --mode [presentation | fullscreen]
  # -P [number], --page [number] open at this page
}
