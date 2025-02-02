{
  vim.notes.obsidian = {
    enable = true;
    setupOpts = {
      completion = {
        nvim_cmp = true;
        # Trigger completion at 2 chars.
        min_chars = 2;
      };
      # Where to put new notes. Valid options are
      #  * "current_dir" - put new notes in same directory as the current buffer.
      #  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir";
      # Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "notes";
      daily_notes = {
        date_format = "%d-%m-%Y-%";
        # folder = "~/obsidianVaults/dailyNotes";
        folder = "notes/dailies";
        default_tags =  "daily-notes" ;
      };
      workspaces = [
        { name = "personal"; path = "/home/malu/obsidianVaults/personal"; }
        { name = "work"; path = "/home/malu/obsidianVaults/work"; }
      ];
        # mappings = {
        #   # Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        #   ["gf"] = {
        #     action = function()
        #       return require("obsidian").util.gf_passthrough()
        #     end,
        #     opts = { noremap = false, expr = true, buffer = true },
        #   },
        #   # Toggle check-boxes.
        #   ["<leader>ch"] = {
        #     action = function()
        #       return require("obsidian").util.toggle_checkbox()
        #     end,
        #     opts = { buffer = true },
        #   },
        #   # Smart action depending on context, either follow link or toggle checkbox.
        #   ["<cr>"] = {
        #     action = function()
        #       return require("obsidian").util.smart_action()
        #     end,
        #     opts = { buffer = true, expr = true },
        #   }
        # },
   };
  };
}
