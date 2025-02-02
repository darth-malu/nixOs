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
    # map = { #FIXME: does not work
    #   enable = true;
    # };
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
