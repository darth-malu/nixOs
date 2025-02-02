# {pkgs}:
{
  programs.wezterm = {
    enable = true;
    extraConfig = /*lua*/ ''
      -- Your lua code / config here
      local mylib = require 'mylib';
      return {
        usemylib = mylib.do_fun();
        font = wezterm.font("JetBrains Mono"),
        font_size = 16.0,
        color_scheme = "Tomorrow Night",
        hide_tab_bar_if_only_one_tab = true,
        default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" },
        keys = {
          {key="n", mods="SHIFT|CTRL", action="ToggleFullScreen"},
        }
      }
    '';
    colorSchemes = {
      myCoolTheme = {
        ansi = [
          "#222222" "#D14949" "#48874F" "#AFA75A"
          "#599797" "#8F6089" "#5C9FA8" "#8C8C8C"
        ];
        brights = [
          "#444444" "#FF6D6D" "#89FF95" "#FFF484"
          "#97DDFF" "#FDAAF2" "#85F5DA" "#E9E9E9"
        ];
        background = "#1B1B1B";
        cursor_bg = "#BEAF8A";
        cursor_border = "#BEAF8A";
        cursor_fg = "#1B1B1B";
        foreground = "#BEAF8A";
        selection_bg = "#444444";
        selection_fg = "#E9E9E9";
      };
    };
    enableBashIntegration = true;
  };
}
