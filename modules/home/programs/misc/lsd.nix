{
  enable = true;
  enableBashIntegration = true;
  colors = {
    # $XDG_CONFIG_HOME/lsd/colors.yaml
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
        ".hg"
      ];
    };
  };
}
