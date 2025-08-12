{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./steam.nix
  ];

  home.packages = with pkgs; [
    amdgpu_top
    bottles
    # winetricks
    heroic
    lutris
    mangohud
    protonplus
    # protonup
    wine64
    # wine-wayland
  ];
}
