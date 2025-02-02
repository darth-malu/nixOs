{#TODO: keymapOnEvents
  programs.nixvim.keymaps = [
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>e";
      options = {
        desc = "Toggle Neotree lul";
        silent = true;
        nowait = true; # dont wait out ambiguous mapping activate immediatedly, def - false
        unique = true;
      };
    }

    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        desc = "Undotree";
      };
    }

    {
      mode = "n";
      key = "<leader>rn";
      action.__raw = "vim.lsp.buf.rename";#FIXME: works unexpectedly...will do old_var = new_var instead rename to new_var
      options = {
        desc = "rename variable under cursor lol";
      };
    }

    #('n', '<space>q', vim.diagnostic.setloclist)

    #{
      #mode = "n";
      #key = "<space>d";
      #action = "<cmd>lua vim.diagnostic.open_float<CR>";
      #options = {
        #desc = "Open float diagnostics";
      #};
    #}

    {
      mode = "n";
      key = "[d";
      # action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      action.__raw = "vim.diagnostic.goto_prev";
      options = {
        desc = "Prev. diagnostic";
      };
    }

    {
      mode = "n";
      key = "]d";
      # action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      action.__raw = "vim.diagnostic.goto_next";
      options = {
        desc = "Next diagnostic";
      };
    }

    { mode = "n"; key = "M-e"; action = "^"; }
    { mode = "n"; key = "M-a"; action = "$"; }

    {
      mode = "n";
      key = "<leader>ca";
      action.__raw = "vim.lsp.buf.code_action";
      options = {
        desc = "Code Actions>>";
      };
    }

    # {
      # mode = "n";
      # #key = "<leader>o";
      # key = "K";
      # action = ''<cmd>Oil<CR>'';
      # options = {
        # desc = "Oil";
      # };
    # }

     # {
     #   mode = "n";
     #   key = "<A-o>"; #TODO: why this no work
     #   action.__raw = "<C-u>call append(line(\".\"), repeat([\"\"], v:count))()";
     #   options = {
     #     desc = "insert line before";
     #   };
     # }

     # {
     #   mode = "n";
     #   key = "<A-O>";
     #   action.__raw = "<C-u>call append(line(\".\")-1, repeat([''], v:count1)"; #TODO: convert this into  lua
     #   options = {
     #     desc = "insert line after";
     #   };
     # }

    {
      mode = "n";
      key = "U";
      action = "<C-r>";
      options = {
        desc = "better undo (C-r)";
      };
    }

    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>nohl<CR>";
      options = {
        desc = "Clear search";
      };
    }

    {
      mode = "n";
      #key = "<leader>o";
      key = "-";
      action = "<cmd>Oil<CR>";
      options = {
        desc = "Oil";
      };
    }

    # Lazygit
    #{
      #mode = "n";
      #key = "<leader>gg";
      #action = "<cmd>LazyGit<CR>";
      #options = {
        #desc = "LazyGit (root dir)";
      #};
    #}

    # Commentary bindings
    #{
      #action = "<cmd>Commentary<CR>";
      #key = "<leader>/";
    #}

    {
      mode = "n";
      # key = "<leader>un";
      key = "<leader>nn";
      # key = "<C-l>";
      action = ''
        <cmd>lua require("notify").dismiss({ silent = true, pending = true })<cr>
      '';
      options = {
        desc = "Dismiss All notify Notifications";
      };
    }

    {
      mode = "n";
      key = "<S-l>";
      #action = "<cmd>BufferLineCycleNext<cr>";
      action = "<cmd>bn<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<S-h>";
      #action = "<cmd>BufferLineCyclePrev<cr>";
      action = "<cmd>bp<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>x";
      # key = "M- "; #FIXME: does not work
      action = "<cmd>bdelete<cr>";
      options = {
        desc = "Delete buffer";
      };
    }
    {
      mode = "n";
      # key = "<M-s>";
      key = "<M-;>";
      # key = "<M-a>";
      action = "<cmd>w<cr>";
      options = {
        silent = true;
        nowait = true;
        desc = "quick save";
      };
    }

    {
      mode = "n";
      key = "<M-a>";
      action = "^";
      options = {
        desc = "BOL";
      };
    }

    {
      mode = "n";
      key = "<M-e>";
      action = "g_";
      options = {
        desc = "EOL";
      };
    } # GOing natural lol 0-$ g_

    #{
      #mode = "n";
      #key = "<leader>p";
      #action = "<cmd>BufferLinePick<cr>";
      #options = {
        #desc = "pick buffer visually";
      #};
    #}
  ];
}
