{
  vim.mini = {
    # ai = {
    #   enable = true;
    #   setupOpts = {
    #     mappings = {
    #       # Main textobject prefixes
    #       around = "a";
    #       inside = "i";
    #       #Next/last variants
    #       around_next = "an";
    #       inside_next = "in";
    #       around_last = "al";
    #       inside_last = "il";
    #       #Move cursor to corresponding edge of `a` textobject
    #       # goto_left = "g["; #no work?
    #       # goto_right = "g]";
    #     };#TODO: check on modifiers and alignment
    #   };
    # };
    sessions = {
      enable = true;
      setupOpts = {
        # Whether to read default session if Neovim opened without file arguments
        autoread = false;
        # Whether to write currently read session before quitting Neovim
        autowrite = true;
        # Directory where global sessions are stored (use `''` to disable)
        # directory = #<"session" subdir of user data directory from |stdpath()|>,
        # File for local session (use `''` to disable)
        # file = "Session.vim";
        file = "/home/malu/Documents/Session.vim";
        # Whether to force possibly harmful actions (meaning depends on function)
        force = {
          read = false;
          write = true;
          delete = false;
        };
        # Hook functions for actions. Default `nil` means 'do nothing'.
        # hooks = {
        # Before successful action
        # pre = { read = "nil"; write = "nil"; delete = "nil" ;};
        # After successful action
        # post = { read = "nil"; write = "nil"; delete = "nil" ;};
        # };
        # Whether to print session path after action
        verbose = {
          read = false;
          write = true;
          delete = true;
        };
      };
    };
    comment = {
      enable = true;
      setupOpts = {
        mappings = {
          comment = "<leader>c";
          comment_line = "<leader>c";
          comment_visual = "<leader>c";
          textobject = "<leader>c";
        };
      };
    };
    # hipatterns = {
    #   enable = true;
    #   setupOpts = {
    #   };
    # };
    git = {
      enable = true;
      setupOpts = {
        # General CLI execution
        job = {
          # Path to Git executable
          git_executable = "git";

          # Timeout (in ms) for each job before force quit
          timeout = 30000;
        };

        # Options for `:Git` command
        command = {
          # Default split direction
          split = "auto";
        };
      };
    };
    map = { 
      enable = true;
        setupOpts = {
          # Encode symbols. See `:h MiniMap.config` for specification and
          # `:h MiniMap.gen_encode_symbols` for pre-built ones.
          # Default: solid blocks with 3x2 resolution.
          encode = "nil";

          # Scrollbar parts for view and line. Use empty string to disable any.
          scroll_line = "█";
          scroll_view = "┃";

          # Window options
          window = {
            # Whether window is focusable in normal way (with `wincmd` or mouse)
            focusable = true;

            # Side to stick ('left' or 'right')
            side = "right";

            # Whether to show count of multiple integration highlights
            show_integration_count = true;

            # Total width
            width = 10;

            # Value of 'winblend' option
            winblend = 25;

            # Z-index
            zindex = 10;
          };
        };
    };
    starter = {
      enable = true;
      setupOpts = {};
    };
    files.enable = true;
    move = { 
      enable = true;
      setupOpts = {
        # Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          # Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          # left = "<M-h>";
          # right = "<M-l>";
          # down = "<M-j>";
          # up = "<M-k>";
          left  = "<M-Left>";
          right = "<M-Right>";
          down  = "<M-Down>";
          up    = "<M-Up>";

          # Move current line in Normal mode
          line_left  =  "<M-Left>";
          line_right =  "<M-Right>";
          line_down  =  "<M-Down>";
          line_up    =  "<M-Up>";
        };

        # Options which control moving behavior
        # options = {
          # Automatically reindent selection during linewise vertical move
          # reindent_linewise = true;
        # };
      };
    };
    # tabline = { enable = true; };
  };
}
