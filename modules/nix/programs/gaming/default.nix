{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    ./steam.nix
  ];

  environment.systemPackages =
    with pkgs;
    [
      amdgpu_top
      mangohud
      protonplus
      lutris
      # protonup
      # wine64 # 64-bit only
      # support both 32-bit and 64-bit applications
      # wine-wayland
    ]
    ++ (with pkgs-unstable; [
      # lutris
      heroic
      bottles
      winetricks
      wineWowPackages.stable
    ]);
}
