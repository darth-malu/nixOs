{
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      ai = {
        n_lines = 30;
        search_method = "cover_or_next";
        # Whether to disable showing non-error feedback
        # silent = false;
        mappings = {
          # Main textobject prefixes
          around = "a";
          inside = "i";
          #Next/last variants
          around_next = "an";
          inside_next = "in";
          around_last = "al";
          inside_last = "il";
          #Move cursor to corresponding edge of `a` textobject
          # goto_left = "g["; #no work?
          # goto_right = "g]";
        };#TODO: check on modifiers and alignment

      };

      comment = {#todo: impliment this with a mapping>
        mappings = {
          comment = "<leader>c";
          comment_line = "<leader>c";
          comment_visual = "<leader>c";
          textobject = "<leader>c";
        };
      };

      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          # update_n_lines = "gsn";
          suffix_last = "l"; # Suffix to search with "prev" method
          suffix_next = "n"; # Suffix to search with "next" method
        };
        # Whether to respect selection type:
        # - Place surroundings on separate lines in linewise mode.
        # - Place surroundings on each line in blockwise mode.
        respect_selection_type = false;#TODO: see implications fully 
        # How to search for surrounding (first inside current line; then inside
        # neighborhood). One of 'cover'; 'cover_or_next'; 'cover_or_prev';
        # 'cover_or_nearest'; 'next'; 'prev'; 'nearest'. For more details;
        # see `:h MiniSurround.config`.
        search_method = "cover";   
        silent = true;
        # Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500;
       # Number of lines within which surrounding is searched
        n_lines = 50;
      };

      move = {
        options = { # control moving behavior
          # Automatically reindent selection during linewise vertical move
          reindent_linewise = true;
        };
        mapppings = {
        #Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>";
        right = "<M-l>";
        down = "<M-j>";
        up = "<M-k>";

        # Move current line in Normal mode
        line_left = "<M-h>";
        line_right = "<M-l>";
        line_down = "<M-j>";
        line_up = "<M-k>";
        };
      };
      # bracketed = {
      #   # buffer     = { suffix = "b"; options = {};};
      #   comment    = { suffix = "c"; options = {};};
      #   conflict   = { suffix = "x"; options = {};};
      #   # diagnostic = { suffix = "d"; options = {};};
      #   # file       = { suffix = "f"; options = {};};
      #   indent     = { suffix = "i"; options = {};};
      #   jump       = { suffix = "j"; options = {};};
      #   # location   = { suffix = "l"; options = {};};
      #   # oldfile    = { suffix = "o"; options = {};};
      #   quickfix   = { suffix = "q"; options = {};};
      #   treesitter = { suffix = "t"; options = {};};
      #   # undo       = { suffix = "u"; options = {};};
      #   # window     = { suffix = "w"; options = {};};
      #   # yank       = { suffix = "y"; options = {};};
      # };
    };
  };
}
