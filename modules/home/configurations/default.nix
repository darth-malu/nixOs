{ config, ... }:
{
  xdg.configFile = {
    "hyprland-autoname-workspaces/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/quickshell/bar/autoname-config.toml";
  };
  home.file = {
    # ".local/share/fonts/wps-fonts" = {
    ".local/share/fonts" = {
      # source = ./wps;
      source = ../../../assets/Fonts-Darth;
      # recursive = true;
    };
    ".icons/theme_GoogleDot-Violet" = {
      source = ../../../assets/hyprcursor/theme_GoogleDot-Violet;
      # recursive = true;
    };
  };
}
# https://nix-community.github.io/home-manager/options/home-manager/home.html?highlight=source#opt-home.file._name_.recursive
