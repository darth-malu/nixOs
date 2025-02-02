#{pkgs,...}:

{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {#enabledExtensions for ext not supported by nixvim
      fzf-native = {
        enable = true;
        #package = pkgs.vimPlugins.telescope-fzy-native-nvim;
        settings = {
          case_mode = "ignore_case"; #def: smart_case #TODO: see diff
        };
      };
      undo = {
        enable = true;
        settings = {
          #entry_format = "state #$ID";
          layout_config = {
            prompt_position = "top";
          };
          mappings = {
            #i = {
              #"<c-cr>" = "require('telescope-undo.actions').restore";
              #"<cr>" = "require('telescope-undo.actions').yank_additions";
              #"<s-cr>" = "require('telescope-undo.actions').yank_deletions";
            #};
            i = {
              "<A-j>" = {#TODO: test this
                __raw = "require('telescope.actions').move_selection_next";
              };
              "<A-k>" = {
                __raw = "require('telescope.actions').move_selection_previous";
              };
            };
            n = {
              Y = "require('telescope-undo.actions').yank_deletions";
              u = "require('telescope-undo.actions').restore";
              y = "require('telescope-undo.actions').yank_additions";
            };
          };
          selection_caret = "> ";#TODO: test this
          side_by_side = true;
          time_format = "!%Y-%m-%dT%TZ";
          #use_custom_command = [
            #"bash"
            #"-c"
            #"echo '$DIFF' | delta"
          #];
          #use_delta = true;
          #vim_diff_opts = {
            #ctxlen = 8;
          #};
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env = {
            COLORTERM = "truecolor";
          };
          sorting_strategy = "descending";
        };

      };
    };

    keymaps = {#:h map-modes
      # "<leader>lg" = {
        # action = "live_grep";
        # mode = [ "n" "v" ];
        # options = {
          # #noremap default
          # # nowait - wait for extra input in ambiguous mappings
          # # silent?
          # # unique - fail if map is already defined
          # nowait = true;
          # desc = "live grep lol";
        # };
      # };
      "<leader>cs" = "colorscheme";
      "<leader>cm" = "todo-comments";

      "<leader>ff" = "find_files";
      "<leader>fo" = "oldfiles";

      "<leader>sh" = "help_tags";

      "<leader>sk" = "keymaps";
      "<leader>tu" = "undo";

      "<leader><leader>" = "buffers";

      "<leader>gd" = "lsp_definitions"; # [G]oto [D]efinition;
      "<leader>gr" = "lsp_references"; # [G]oto [R]eferences;
      "<leader>gi" = "lsp_implementations"; #[G]oto [I]mplementations

      "<leader>ds" = "lsp_document_symbols"; #[D]ocument [S]ymbols
      "<leader>ws" = "lsp_dynamic_workspace_symbols"; # [W]orkspace [S]ymbols

      "<leader>Z" = "grep_string";
      "<leader>z" = "current_buffer_fuzzy_find";
      #"<leader>fg" = "git_commits";
    };
};
}
