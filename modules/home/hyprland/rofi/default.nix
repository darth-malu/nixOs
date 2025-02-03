{ pkgs, ...}  : {
  imports = [./theme.nix];
  programs.rofi ={
    enable = pkgs.lib.mkDefault true;
    package = pkgs.rofi-wayland;
    cycle = true;
    location = "center";
    font = "SpaceMono Nerd Font 12";
    # plugins = with pkgs; [ rofi-emoji rofi-obsidian rofi-calc ];
    # terminal = "\${pkgs.kitty}/bin/kitty";
    terminal = "uwsm app -s a kitty";
    # package = pkgs-unstable.rofi-wayland.override { plugins = with pkgs-unstable; [ rofi-emoji rofi-obsidian rofi-calc ]; };
    #terminal = ;
    #yoffset = 3;
    extraConfig = {
      # modi = "drun,emoji,ssh";
      modes = [ "window"  "drun" "filebrowser" ];
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
      # kb-toggle-case-sensitivity #TODO: assign later
      # icon-theme = "candy icons";
      icon-size = 58;
      hover-select = true;
      window-format = "{w}{c} .\t{t}";
      display-drun = " "; display-run = " "; display-filebrowser = " "; display-window = " ";
      ml-row-down = "ScrollDown";
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
      me-accept-custom = "Control+MouseDPrimary";
      auto-select = true; # When one entry is left, automatically select it.
      monitor = 1; # - currently focused monitor, 2 - currently focused window, 3 - mouse (see more in docs), 4 - monitor with the focused window, 5-monitor with mouse pointer::
      dpi = 1; # 0 - aauto-detect based on x11 screen size(similar to i3 and gtk), 1 - auto based on monitor rofi is on
      matching = "normal"; #normal ::, regex, glob(slower for large list), fuzzy, prefix
      # no-lazy-grab = true; # Disables lazy grab, this forces the keyboard being grabbed before gui is shown.
      scroll-method = 1; #-0 page::, 1 - continua
      drun-use-desktop-cache =  true; # slow PC, Build and use a cache with the content of desktop files to reload when enabled -> -drun-reload-desktop-cache flag
      # pid = ./rofi.pid; #FIXME:
      replace = true;
    };
  };
}
