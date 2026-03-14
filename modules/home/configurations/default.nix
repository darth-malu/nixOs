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
  };
}
# xdg.dataFile = {
#   "fonts" = {
#     source = ./hyprland-autoname-workspaces_config.toml;
#     recursive = true;
#   };
# };
