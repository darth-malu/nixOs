{osConfig, lib,...}:
{
  imports = [
    ./pkgs-home
    ./xdg
    ./variables.nix
  ] ++
  (if osConfig.hyprland.enable then [ # WIP
    ./themes.nix
  ] else []);
}
