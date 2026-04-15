{
  enable = true;
  options = {
    # https://www.mankier.com/5/zathurarc#Options-zathura
    # :set command options - Make them permanent
    adjust-open = "best-fit";
    continuous-hist-save = true; # save document history at each page change or only when closing a document
    default-bg = "#000000";
    default-fg = "#FFFFFF";
    font = "Iosevka Comfy semibold 10";
    guioptions = "none"; # no statusbar
    highlight-active-color = "#623CEA"; # #00BC00::, #75DBCD - color of currently selected highlighted element (eg. current search result)
    highlight-fg = "rgba(255, 255, 255, 0.8)"; # Text when highlighting...eg number for links
    # highlight-color = ""; # #9FBC00:: # parts of document (eg show search results)
    # highlight-transparency = ""; # 0.5::
    incremental-search = true;
    page-padding = 0;
    scroll-step = 100; # 40::
    selection-clipboard = "clipboard"; # copy selection to system clipboard
    statusbar-h-padding = 0;
    statusbar-v-padding = 0;
    zoom-max = 1000; # 1000::
    zoom-min = 20; # 10::
    zoom-step = 20; # 10:: in % percentage
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
