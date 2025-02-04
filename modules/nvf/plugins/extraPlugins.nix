{pkgs,  ...}:
{
  vim = {
    extraPlugins = with pkgs.vimPlugins; {
      oil = {
        package = oil-nvim;
        setup = "require('oil').setup {}";
      };
      harpoon = {
        package = harpoon;
        setup = /*lua*/''require("harpoon").setup ({
          global_settings = {
            save_on_toggle = true; -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
            save_on_change = true, -- saves the harpoon file upon every change. disabling is unrecommended.
            tmux_autoclose_windows = false, -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
            excluded_filetypes = { "harpoon" }, -- filetypes that you want to prevent from adding to the harpoon list menu.
            mark_branch = false, -- set marks specific to each git branch inside git repository
          }
          -- require("telescope").load_extension('harpoon')
        })'';
        #after = ["oil"]; # place harpoon configuration after oil for test
      };
      mini-surround = {
        package = mini-surround;
        setup = "require('mini.surround').setup ({
          -- Add custom surroundings to be used on top of builtin ones. For more
          -- information with examples, see `:h MiniSurround.config`.
          custom_surroundings = nil,

          -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
          highlight_duration = 800,

          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            add = 'gsa', -- Add surrounding in Normal and Visual modes
            delete = 'gsd', -- Delete surrounding
            find = 'gsf', -- Find surrounding (to the right)
            find_left = 'gsF', -- Find surrounding (to the left)
            highlight = 'gsh', -- Highlight surrounding
            replace = 'gsr', -- Replace surrounding
            update_n_lines = 'gsn', -- Update `n_lines`
            suffix_last = 'l', -- Suffix to search with \"prev\" method
            suffix_next = 'n', -- Suffix to search with \"next\" method
          },

          -- Number of lines within which surrounding is searched
          n_lines = 20,

          -- Whether to respect selection type:
          -- - Place surroundings on separate lines in linewise mode.
          -- - Place surroundings on each line in blockwise mode.
          respect_selection_type = false,

          -- How to search for surrounding (first inside current line, then inside
          -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
          -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
          -- see `:h MiniSurround.config`.
          search_method = 'cover',

          -- Whether to disable showing non-error feedback
          -- This also affects (purely informational) helper messages shown after
          -- idle time if user input is required.
          silent = false,
        })";
      };
    };
    #startPlugins = [pkgs.vimPlugins.oil-nvim]; # legacy
  };
}
