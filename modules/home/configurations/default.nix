{ config, ... }:
{
  xdg.configFile = {
    "hyprland-autoname-workspaces/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/quickshell/bar/autoname-config.toml";
  };
  home.file = {
    ".local/share/fonts/wps-fonts" = {
      source = ./wps;
      # recursive = true;
    };
    # ".icons/theme_GoogleDot-Violet" = {
    #   source = ../../../assets/hyprcursor/theme_GoogleDot-Violet;
    #   recursive = true;
    # };
  };
}
