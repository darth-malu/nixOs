# {pkgs, ...}:
# {config}:

# let
#   helpers = config.lib.nixvim;
# in
{
  programs.nixvim.opts = {
    number = true; relativenumber = true;

    # Always show the signcolumn, otherwise text would be shifted when displaying error icons
    signcolumn = "yes";

    # Enable mouse
    mouse = "a";

    termguicolors = true;

    winbar = "%=%m\ %f";

    # Search
    ignorecase = true;
    smartcase = true;

    # Configure how new splits should be opened
    splitright = true;
    #splitbelow = true;

    list = true;
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
    # listchars.helpers.mkRaw = "{ tab = '» ', trail = '·', nbsp = '␣' }"; # check this

    # Tab defaults (might get overwritten by an LSP server)
    tabstop = 2; # define \t char
    shiftwidth = 2;
    softtabstop = 2;
    expandtab = true; # spaces for tabs lol
    smarttab = true;

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true; # package = pkgs.wl-clipboard;
    };

    undofile = true;

    cursorline = false; # Horizontal hightlight on cursor
    cursorcolumn = false; # vertical highlight on cursor

    autoread = true; # for parsing changes outside current instance of file
    swapfile = true;

    ruler = true; # cursor position eg TOP, relative: percentage

    gdefault = false; # Global %substitution by default

    scrolloff = 10;
  };
}
