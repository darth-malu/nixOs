{
    vim.keymaps = [
      {
        key = "<leader>wq";
        mode = ["n"];
        action = ":wq<CR>";
        silent = true;
        nowait = true;
        desc = "Save file and quit";
      }
      {
        key = "=";
        mode = ["n"];
        action = "<cmd>lua MiniFiles.open()<CR>";
        silent = true;
        nowait = true;
        desc = "Toggle MiniFiles";
      }
      {
        key = "<leader>e";
        mode = ["n"];
        action = "<cmd>lua MiniStarter.open()<CR>";
        silent = true;
        nowait = true;
        desc = "Toggle MiniStarter";
      }
      {
        key = "<leader>ha";
        mode = ["n"];
        # lua = true;
        action = "<cmd>lua require('harpoon.mark').add_file()<CR>";
        silent = true;
        nowait = true;
        desc = "add file to Harpoon list";
      }
      {
        key = "<leader>hm";
        mode = ["n"];
        action = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>";
        silent = true;
        nowait = true;
        desc = "Toggle harpoon menu";
      }
    #
      {
        key = "<leader>ht";
        mode = ["n"];
        action = "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>";
        silent = true;
        nowait = true;
        desc = "Toggle harpoon menu";
      }
      {
        key = "<leader>]";
        mode = ["n"];
        action = "<cmd>lua require('harpoon.ui').nav_next()<CR>";
        silent = true;
        nowait = true;
        desc = "Toggle harpoon menu";
      }
      {
        key = "<leader>[";
        mode = ["n"];
        action = "<cmd>lua require('harpoon.ui').nav_prev()<CR>";
        silent = true;
        nowait = true;
        desc = "Toggle harpoon menu";
      }
      {
        key = "-";
        mode = ["n"];
        action = "<cmd>Oil<CR>";
        silent = true;
        nowait = true;
        desc = "Toggle oil browser";
      }
      {
        key = "<leader>fo";
        mode = ["n"];
        action = "<cmd>Telescope oldfiles<CR>";
        silent = true;
        desc = "Show old files";
        nowait = true;
      }
      {
        key = "<leader>Z";
        mode = ["n"];
        action = "<cmd>Telescope grep_string<CR>";
        silent = true;
        nowait = true;
        #desc = "Show old files";
      }
      {
        key = "<leader>z";
        mode = ["n"];
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        nowait = true;
        silent = true;
      #desc = "Show old files";
      }
      {
        key = "<leader>k";
        mode = ["n"];
        action = "<cmd>file<CR>";
        silent = true;
        nowait = true;
        desc = "show current file";
      }
    {
      mode = [ "n" ];
      key = "<leader>rn";
      lua = true; # action considered lua no quotes**
      action = ''vim.lsp.buf.rename'';#FIXME: works unexpectedly...will do old_var = new_var instead rename to new_var
      silent = false;
      desc = "rename variable under cursor lol";
    }
    {
      mode = "n";
      key = "<leader>gf";
      #lua = true; # action considered lua no quotes**
      action = ''<cmd>lua
      function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
      <CR>'';
      silent = false;
      desc = "Toggle check-boxes";
    }
    {
      mode = "n";
      key = "U";
      action = "<C-r>";
      desc = "better undo (C-r)";
    }
    {
      mode = "n";
      # key = "<leader>un";
      key = "<leader>nn";
      #lua = true; # action considered lua no quotes**
      # key = "<C-l>";
      action = "<cmd>lua require(\"notify\").dismiss({ silent = true, pending = true })<CR>";
      desc = "Dismiss All notify Notifications";
      nowait = true;
    }
    {
      mode = ["n"];
      key = "<leader>/";
      action = "<cmd>nohl<CR>";
      desc = "Clear search";
    }
    {
      mode = ["n"];
      # key = "<leader>l";
      key = "<S-l>";
      #action = "<cmd>BufferLineCycleNext<cr>";
      action = "<cmd>bn<cr>";
      desc = "Cycle to next buffer";
    }

    {
      mode = ["n"];
      key = "<S-h>";
      #action = "<cmd>BufferLineCyclePrev<cr>";
      action = "<cmd>bp<cr>";
      desc = "Cycle to previous buffer";
    }

    {
      mode = ["n"];
      key = "<leader>x";
      action = "<cmd>bdelete<cr>";
      desc = "Delete buffer";
      nowait = true;
    }
    {
      mode = ["t"];
      key = "<leader>X";
      # lua = true;
      # action = "<cmd>lua vim.cmd('quit')";
      action = "<cmd>q<CR>";
      # vim.api.nvim_set_keymap("t", "<C-q>", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })
      # action = ''vim.cmd('quit')'';
      desc = "Quit term";
    }
    {
      mode = ["n"];
      key = "<M-s>";
      # key = "<M-;>";
      # key = "<M-a>";
      action = "<cmd>w<cr>";
      silent = true;
      #nowait = true;
      desc = "quick save";
    }
    ];
}
