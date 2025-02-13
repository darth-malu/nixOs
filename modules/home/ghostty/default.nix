{osConfig, ...}:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    clearDefaultKeybinds = true;
    settings = {
      # theme = "dark:catppuccin-mocha,light:catppuccin-latte";
      foreground = "#4BC6B2";# #35A29F
      background = "#222436";#"#022223";
      # background-opacity = 0.76;
      # background-blur = 10; # true, false, nonegative integer
      # adjust-cell-height = "-5%";
      adjust-cell-height = "5%";
      #window
      # window-vsync = false; #NOTE: feels ghostty works better with this on (default)
      window-padding-balance = true; window-padding-x = 0; window-padding-y = 0;
      window-inherit-working-directory = true;
      window-inherit-font-size = true;
      window-decoration = false;
      focus-follows-mouse = true;
      #cursor
      cursor-color = "#FAA6FF";
      cursor-text = "#000000"; # can be hex
      cursor-style = "block";
      cursor-click-to-move =  true; #WARN:can be weird watch out ... only in primary screen mode...tmux nvim not work
      # split-divider-color = "";
      mouse-hide-while-typing = true;
      # mouse-scroll-multiplier = 2;
      shell-integration = "bash"; # detect::
      shell-integration-features = "no-cursor";
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
      # adjust-font-baseline = "20%";# % or pixels
      # font-family-bold = "JetBrains Mono Bold";
      font-style = "SemiBold";
      font-style-bold = "Bold";
      font-style-italic = "Medium Italic";
      font-size = if osConfig.networking.hostName == "carthage" then 11.5 else 10.9; # 
      freetype-load-flags = "no-hinting"; #foce-authint:: - #NOTE: very important for wezterm and ghostty
      app-notifications = false; # clipboard-copy
      # linux-cgroup = "single-instance"; # always, never, single-instance
      # gtk-single-instance = true; #desktop:: - new instance  except only if ghostty launched from a terminal
      # gtk-adwaita = false;
      gtk-wide-tabs = false;
      desktop-notifications = true;
      bold-is-bright = true;
      keybind = import ./keybind.nix;
      # term = "xterm-256colors" ; #FIXME:tput: unknown terminal "xterm-256colors"
    };
  };
}
