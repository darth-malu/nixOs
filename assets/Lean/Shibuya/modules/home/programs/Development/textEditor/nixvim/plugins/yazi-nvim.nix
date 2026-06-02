#{pkgs, ...}:
{
  programs.nixvim.plugins.yazi = {
    enable = true;
    #package = pkgs.vimPlugins.yazi-nvim;
    #yaziPackage = pkgs.yazi;

    settings = {
        enable_mouse_support = true;
        floating_window_scaling_factor = 0.5;
        log_level = "debug";
        open_for_directories = true;
        yazi_floating_window_border = "single";
        yazi_floating_window_winblend = 50;
        clipboard_register = "*";
    };

  };
}
