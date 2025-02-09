{
  imports = [
    ./keymaps.nix
    ./plugins
    ./lsp_completion.nix
    ./extraLua
  ];

  vim = {
    lineNumberMode = "relNumber";
    useSystemClipboard = true;
    searchCase = "smart"; # smart, ignore, insensitive
    # package = pkgs.neovim-unwrapped;
    # scrollOffset = 15; # WARN: does not work

    # dashboard.alpha.enable = false;
    # filetree.neo-tree.enable = true;
    options = {
      tabstop = 2; # number of spaces <TAB> in the file counts for.
      shiftwidth = 2; # use with > shifting
      # winbar = "%=%m\ %f";
      #autoindent = true;
      cursorline = true; # will make screen redrawing slower
      cursorlineopt = "number"; # line hl-CursorLine::, screenline hl-CursorLine, number hl-CursorLineNr, both - hl text line of the cursor
      signcolumn = "no"; #yes::, no
      #tm = 500; # timeout for mapped actions
      # wrap = true; # word wrapping
    };
    ui = {
      noice.enable = true;
      # modes-nvim.setupOpts.setCursorline = true; #colored cursor on current line
      colorizer = {
        enable = true;
        setupOpts.filetypes = {
          nix = {
            RGB = true;
            always_update = false; # see docs
            names = false; # like BLUE
            rgb_fn = true; #css rgba()
          };
          css = {
            RGB = true;
            always_update = false; # see docs
            names = false; # like BLUE
            rgb_fn = true; #css rgba()
          };
        };
      };
    };
    # binds = { cheatsheet.enable = true;};
    theme = {
      enable = true;
      transparent = true;
      # name = "gruvbox"; style = "dark";
       name = "tokyonight"; style = "moon"; #moon, night, storm, day
       # name = "catppuccin"; style = "mocha"; #moon, night, storm, day
      # name = "rose-pine"; style = "dawn"; #moon, dawn
    };
  };
}
