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

  environment.systemPackages = with pkgs; [
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
