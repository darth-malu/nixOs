{ config, ... }:
{
  xdg.configFile = {
    "hyprland-autoname-workspaces/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink ./hyprland-autoname-workspaces/config.toml;
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
