#{pkgs, ...}:
{
  vim.lazy = { 
    # after - lua code to run after plugin is loaded, may be wrapped in function
    # setupModule - lua module to run setup function on
    # setupOpts - Options to pass to the setup function
    enable = true; # Whether to enable plugin lazy-loading via lz.n and lzn-auto-require.
    # loader = "lz.n";
    plugins  = {
      "pomo.nvim" = {
        enabled = true;
        # package =   "github:epwalsh/pomo.nvim";
        setupModule = "";
        setupOpts = "";
        cmd = [
          "TimerStart" "TimerRepeat" "TimerSession"
        ];
      };
      vim-terminator = {
        enabled = true;
      };
      # toggleterm-nvim = {
      #   enabled = true;
      #   package = "toggleterm-nvim";
      #
      #   # setup function
      #   setupModule = "toggleterm";
      #   # setupOpts = cfg.setupOpts;
      #   inherit (cfg) setupOpts;
      #   after = "require('toggleterm').do_something()";
      #
      #   # events
      #   cmd = ["ToggleTerm"];
      # };
    };
  };
}
