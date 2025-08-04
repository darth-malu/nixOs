{
  programs.plasma = {
    enable = true;
    #
    # Some high-level settings:
    #

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };

    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 12;
      };
    };

    # desktop.widgets = [
    # ];

  };
}
