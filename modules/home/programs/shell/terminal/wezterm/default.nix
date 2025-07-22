{
  programs.wezterm = {
    enable = true;
    # package = pkgs-unstable.wezterm;
    enableBashIntegration = true;
    extraConfig = import ./extra.nix;
    colorSchemes = { #$XDG_CONFIG_HOME/wezterm/colors
      # myCoolTheme = {
      #   ansi = [
      #     "#222222" "#D14949" "#48874F" "#AFA75A"
      #     "#599797" "#8F6089" "#5C9FA8" "#8C8C8C"
      #   ];
      #   brights = [
      #     "#444444" "#FF6D6D" "#89FF95" "#FFF484"
      #     "#97DDFF" "#FDAAF2" "#85F5DA" "#E9E9E9"
      #   ];
      #
      #   background = "#89FF95"; # "#1B1B1B"
      #   cursor_bg = "#FAA6FF"; # #573280 "#3FA8C6""#9381ff""#0CA4A5";
      #   # cursor_bg = "#BEAF8A";
      #   cursor_border = "#BEAF8A";
      #   cursor_fg = "#1B1B1B";
      #   foreground = "#35A29F"; #"#BEAF8A" "#35A29F"
      #   selection_bg = "#444444";
      #   selection_fg = "#E9E9E9";
      # };
    };
  };
}
