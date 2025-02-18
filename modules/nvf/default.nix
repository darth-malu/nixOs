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
      conceallevel = 1; # for obsidian 1 or 2
      expandtab = 2; # In Insert mode: Use the appropriate number of spaces to insert a <Tab>
      tabstop = 2; # number of spaces <TAB> in the file counts for.
      softtab = 2; # 	Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.  It 'feels' like <Tab>s are being inserted, while in fact a mix of spaces and <Tab>s is used.  This is useful to keep the 'ts' setting at its standard value

      shiftwidth = 2; # use with > shifting. used if ssofttab is -ve
      spell = true;

      # winbar = "%=%m\ %f";
      #autoindent = true;
      cursorline = true; # will make screen redrawing slower
      cursorlineopt = "number"; # line hl-CursorLine::, screenline hl-CursorLine, number hl-CursorLineNr, both - hl text line of the cursor
      signcolumn = "no"; #yes::, no
      #tm = 500; # timeout for mapped actions
      # wrap = true; # word wrapping
    };
    ui = {
      noice = {
        enable = true;
        setupOpts = {
          format = {
            cmdline = {
              icon = "";
              lang = "vim";
              pattern = "^:";
            };
            filter = {
              icon = "";
              lang = "bash";
              pattern = "^:%s*!";
            };
            help = {
              icon = "󰋖";
              pattern = "^:%s*he?l?p?%s+";
            };
            lua = {
              icon = "";
              lang = "lua";
              pattern = "^:%s*lua%s+";
            };
            search_down = {
              icon = " ";
              kind = "search";
              lang = "regex";
              pattern = "^/";
            };
            search_up = {
              icon = " ";
              kind = "search";
              lang = "regex";
              pattern = "^%?";
            };
          };
          presets = { # classic bottom cmdline for search
            bottom_search = false; #true::
            command_palette = false;# cmdline and popupmenu together
          };
        };
      };
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
      # transparent = true;
      # name = "gruvbox"; style = "dark";
       name = "tokyonight"; style = "moon"; #moon, night, storm, day
       # name = "catppuccin"; style = "mocha"; #moon, night, storm, day
      # name = "rose-pine"; style = "dawn"; #moon, dawn
    };
  };
}
