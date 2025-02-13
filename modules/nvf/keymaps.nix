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

    {
      key = "<Tab>";
      mode = ["i"];
      lua = true;
      action = ''function () require('luasnip').expand() end'';
      silent = true;
      nowait = true;
      desc = "lua snip jump";
    }
    {
      key = "<leader>ht";
      mode = ["n"];
      action = "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>";
      silent = true;
      nowait = true;
      desc = "Toggle harpoon menu";
    }
    {
      key = "<S-l>";
      mode = ["n"];
      action = "<cmd>lua require('harpoon.ui').nav_next()<CR>";
      silent = true;
      nowait = true;
      desc = "Toggle harpoon menu";
    }
    {
      key = "<S-h>";
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
    {#scrolling
      key = "<C-E>";
      mode = ["i"];
      action = "<C-X><C-E>";
      silent = true;
      desc = "scroll down just abit in insert mode lol";
      nowait = true;
    }
    {#scrolling
      key = "<C-Y>";
      mode = ["i"];
      action = "<C-X><C-Y>";
      silent = true;
      desc = "scroll up just abit in insert mode lol";
      nowait = true;
    }
    {# smooth scrolling
      key = "<C-U>";
      mode = ["n"];
      # action = "<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>";
      action = "<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>";
      silent = true;
      desc = "scrolling that much smoother";
      nowait = true;
    }
    {#scrolling
      key = "<C-D>";
      mode = ["n"];
      action = "<C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>";
      silent = true;
      desc = "scrolling that much smoother";
      nowait = true;
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
    }
    {
      key = "<leader>z";
      mode = ["n"];
      action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
      nowait = true;
      silent = true;
    }
    # {
    #   key = "<leader>k";
    #   mode = ["n"];
    #   action = "<cmd>file<CR>";
    #   silent = true;
    #   nowait = true;
    #   desc = "show current file";
    # }
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
      key = "<leader>.";
      #lua = true; # action considered lua no quotes**
      # action = "<cmd>lua function() return require(\"obsidian\").util.toggle_checkbox() end, opts = { buffer = true }, <CR>";
      action = "<cmd>ObsidianToggleCheckbox<CR>";
      silent = false;
      nowait = true;
      desc = "Toggle check-boxes in obsidian"; #TODO: not sure if it works yet
    }
    {
      mode = "n";
      key = "<leader>oq";
      action = "<cmd>ObsidianQuickSwitch<CR>";
      desc = "Obsidian quickswitch any other note in vault with ripgrep";
    }
    {
      mode = "n";
      key = "<leader>on";
      action = "<cmd>ObsidianNew<CR>"; #NOTE: has optional arg `title`
      desc = "Obsidian new note";
    }
    {
      mode = "n";
      key = "<leader>od";
      action = "<cmd>ObsidianDailies<CR>"; #NOTE: has optional arg `offset`a eg. :ObsidianDailies -2 1 -> notes from 2 days ago to tomorrow
      desc = "Obsidian new note";
    }
    {
      mode = "n";
      key = "<leader>ot";
      action = "<cmd>ObsidianTOC<CR>";
      desc = "Obsidian TOC of current note";
    }
    {
      mode = "n";
      key = "<leader>ol";
      action = "<cmd>ObsidianFollowLink vsplit<CR>";
      desc = "Obsidian vsplit link under cursor in vsplit";
    }
    {
      mode = "n";
      key = "<leader>op";
      action = "<cmd>ObsidianOpen<CR>";
      desc = "open note in obsidian app";
    }
    {
      mode = "n";
      key = "U";
      action = "<C-r>";
      desc = "better undo (C-r)";
    }
    {
      mode = "n";
      key = "<leader>nn";
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
      key = "<leader><S-l>";
      action = "<cmd>bn<cr>";
      desc = "Cycle to next buffer";
    }

    {
      mode = ["n"];
      key = "<leader><S-h>";
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
      action = "<cmd>q<CR>";
      desc = "Quit term";
    }
    {
      mode = ["n"];
      key = "<M-s>";
      action = "<cmd>w<cr>";
      silent = true;
      desc = "quick save";
    }
  ];
}
