{ osConfig, lib, ... }:
{
  imports =
    [
      ./pkgs
      ./xdg
      ./variables.nix
    ]
    ++ (
      if osConfig.hyprland.enable then
        [
          # WIP
          ./themes.nix
          # ./dconf.nix
        ]
      else
        [ ]
    );
}
