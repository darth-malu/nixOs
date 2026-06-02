{
  enable = true;
  enableBashIntegration = true; # eg l in bash for lsd -l
  colors = {
    # $XDG_CONFIG_HOME/lsd/colors.yaml
    # https://github.com/lsd-rs/lsd/tree/v1.0.0#color-theme-file-content -> For supported colors
    icons = {
      extension = {
        go = "";
        hs = "";
      };
      filetype = {
        dir = "📂";
        file = "📄";
      };
      name = {
        ".cargo" = "";
        ".trash" = "";
        "Music-Videos" = "📺";
        "Computers" = "🧑🏽‍💻";
        "Programming" = "⌨️";
        "scratch" = "🐾";
        ".Trash-1000" = "🗑";
      };
    };
    size = {
      large = "dark_yellow";
      none = "grey";
      small = "yellow";
    };
    settings = {
      date = "relative";
      ignore-globs = [
        ".git"
        ".stdfolder"
        ".stdignore"
        ".hg"
      ];
    };
  };
}
