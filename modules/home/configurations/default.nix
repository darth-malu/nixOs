{ config, ... }:
{
  xdg.configFile = {
    "hyprland-autoname-workspaces/config.toml" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/quickshell/bar/autoname-config.toml";
    };
  };
  home.file = {
    ".icons/theme_GoogleDot-Violet" = {
      source = ../../../assets/hyprcursor/theme_GoogleDot-Violet;
      recursive = false;
    };

    ".local/share/icons" = {
      source = ../../../assets/quickshell-icons;
      recursive = true;
    };
  };
}
# https://nix-community.github.io/home-manager/options/home-manager/home.html?highlight=source#opt-home.file._name_.recursive
