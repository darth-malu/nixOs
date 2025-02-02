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
      modes = [ "window"  "drun" "filebrowser" ]; #for extraConfig
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
      # icon-theme = "candy icons";
      icon-size = 38;
      hover-select = true;
      window-format = "{w} {c}   .  {t}";
      display-drun = " "; display-run = " "; display-filebrowser = " "; display-window = " ";
      ml-row-down = "ScrollDown";
      me-select-entry = "MousePrimary";
      me-accept-entry = "MouseDPrimary";
      me-accept-custom = "Control+MouseDPrimary";
    };
  };
}
