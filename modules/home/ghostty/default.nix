{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    clearDefaultKeybinds = true;
    settings = {
      # theme = "dark:catppuccin-mocha,light:catppuccin-latte";
      foreground = "#35A29F"; background = "#022223";
      background-opacity = 0.8;
      # background-blur = 10; # true, false, nonegative integer
      cursor-color = "#FAA6FF";
      cursor-text = "#000000"; # can be hex
      cursor-style = "block";
      cursor-click-to-move =  true; # WARN: can be weird watch out ... only in primary screen mode...tmux nvim not work
      # split-divider-color = "";
      # mouse-hide-while-typing = true;
      # mouse-scroll-multiplier = 2;
      shell-integration = "bash"; # detect::
      shell-integration-features = "no-cursor";
      window-inherit-font-size = true; # spawned taabs/windows have parent foont size?
      window-theme = "ghostty";
      clipboard-write = "allow"; clipboard-read = "allow"; clipboard-trim-trailing-spaces = true; clipboard-paste-protection = true;
      clipboard-paste-bracketed-safe = true;
      copy-on-select = "clipboard"; # true:: - selection clipboard (middle click paste always uses this and enabled even if false), clipboard both system and selection, 
      quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "1m"; # can use m s y d # https://ghostty.org/docs/config/reference#quit-after-last-window-closed-delayv
      # font-family = "SpaceMono Nerd Font";
      # font-family = "CaskaydiaCove Nerd Font Mono";
      # font-family = "JetBrainsMono Nerd Font";
      font-family = "JetBrains Mono";
      # font-family-bold = "JetBrains Mono Bold";
      font-style = "Medium";
      font-style-bold = "SemiBold";
      font-style-italic = "Medium Italic";
      font-size = 11.5; # 
      freetype-load-flags = "no-hinting"; #foce-authint:: - #NOTE: very important for wezterm and ghostty
      # app-notifications = true; # clipboard-copy
      # linux-cgroup = "single-instance"; # always, never, single-instance
      # gtk-single-instance = true; #desktop:: - new instance  except only if ghostty launched from a terminal
      gtk-wide-tabs = false;
      desktop-notifications = true;
      bold-is-bright = true;
      keybind = import ./keybind.nix;
      # term = "xterm-256colors" ;
    };
  };
}
