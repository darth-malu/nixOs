{
  enable = true;
  createDirectories = false; # false::, Whether to enable automatic creation of the XDG user directories.
  # documents = "${config.home.homeDirectory}/Documents";
  # download = "${config.home.homeDirectory}/Downloads";
  extraConfig = {
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/grimblast";
  };
}
