{
  vim.notify.nvim-notify = {
    enable = true;
    setupOpts = {
      background_colour = "NotifyBackground"; # NotifyBackground::
      icons = { DEBUG = ""; ERROR = ""; INFO = ""; TRACE = ""; WARN = ""; };
      position = "bottom_right";
      render = "compact"; #one of “default”, “minimal”, “simple”, “compact”, “wrapped-compact” or (luaInline)
      stages = "fade_in_slide_out"; # “fade_in_slide_out”, “fade”, “slide”, “static”
      timeout = 1000; # 1000::
    };
  };
}
