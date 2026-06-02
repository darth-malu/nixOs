{
programs.wezterm.extraConfig =
  /*lua*/''
  -- keys
  config.leader = { key ="a", mods = "CTRL", timeout_milliseconds = 1000 }
  -- config.keys = {
  --
  -- }
  -- Dim inactive panes
  config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5
  }
  '';
}
