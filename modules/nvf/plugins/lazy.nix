#{pkgs, ...}:
{
    vim.lazy = { 
      # after - lua code to run after plugin is loaded, may be wrapped in function
      # setupModule - lua module to run setup function on
      # setupOpts - Options to pass to the setup function
      enable = true;
      loader = "lz.n";
      plugins  = {
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
