{pkgs, ...}: {
  vim = {
    lsp = {
      # formatOnSave = true; # false:: #TODO: see formatters available
      mappings = {
        # format = "<leader>lf";
        # goToDeclaration = "<leader>lgD";
        # documentHighlight = "<leadere>lH";
        # goToType = "<leader>lgt";
        # hover = "<leader>lh";
        # toggleFormatOnSave = "<leader>ltf";
        # renameSymbol = "<leader>ln";
        # openDiagnosticFloat = "<leader>le";
        # listWorkspaceFolders = "<leader>lwl";
        # listReferences = "<leader>lgr";
      };
      null-ls = {
        enable = true;
        debounce = 250; # 250::,
        default_timeout = 5000; #milliseconds, 5000::
        diagnostics_format = "[#{m}] #{s} (#{c})"; # #[#{m}] #{s} (#{c})::
        # sources = {};
      };
      trouble = {
        enable = true;
        mappings = {
          documentDiagnostics = "<leader>ld";
          locList = "<leader>xl";
          lspReferences = "<leader>lr";
          quickfix = "<leader>xq";
          symbols = "<leader>xs";
        };
      };
      otter-nvim = {
        enable = true;
        # mappings = {
        #   toggle = "<leader>lo";
        # };
        setupOpts = {
          lsp.diagnostic_update_event = ["BufWritePost"]; #BufWritePost , InsertLeave, TextChange
          buffers.set_filetype = true;
          handle_leading_whitespace = true;
        };
      };
    };
    treesitter = {
      indent = {
        enable = true; #true::
        disable = [];
      };
      grammars = [
        #  list of package
        pkgs.vimPlugins.nvim-treesitter-parsers.markdown_inline
      ];
      #highlight.enable = true; # true::
      #indent.disable = ["c" "rust"];
    };
    languages = {
      #adds to treesitter grammars
      enableLSP = true;
      enableTreesitter = true; # all enabled...can be explicit
      lua.enable = true;
      css.enable = true;
      python = {
        enable = true;
        # treesitter.enable = true;
        lsp = {
          enable = true;
          server = "python-lsp-server"; package = pkgs.python312Packages.python-lsp-server;
          # server = "basedpyright"; package = pkgs.basedpyright; #NOTE: broken right now
          #basedpyright::, "pyright" "python-lsp-server"
        };
        format = {
          enable = true;
          type = "black"; #black::, "black-and-isort", isort, ruff
        };
      };
      bash = {
        enable = true;
        lsp = {
          enable = true;
        };
        treesitter.enable = true;
        extraDiagnostics = {
          enable = true;
          types = ["shellcheck"];
        };
      };
      markdown = {
        enable = true;
        format = {
          enable = true;
          # package
        };
        extensions = {
          render-markdown-nvim = {
            enable = true;
          };
        };
      };
      nix = {
        enable = true;
        #lsp.server = "nil";
        extraDiagnostics = {
          enable = true;
          types = [
            "statix"
            "deadnix"
          ];
        };
        format = {
          enable = true;
          # package = ; # alejandra::
          type = "alejandra"; # nix formatter to use , # alejandra::, nixfmt, nixpkgs-fmt
        };
        treesitter = {
          enable = true;
        };
      };
      # python.enable = true;
    };
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        #next = "<Tab>";
        scrollDocsDown = "<c-f>";
        scrollDocsUp = "<c-d>";
        #confirm = "<CR>";
        #complete = "<C-Space>";
        # = "<C-Space>";
      };
      setupOpts = {
        completion.completeopt = "menu, menuone, noinsert";
      };
      #sourcePlugins = [];
    };
  };
}
