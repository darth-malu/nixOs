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
      # lutris
      protonup
      # wine-wayland
      # wine64 # 64-bit only
      mangohud
    ]
    ++ (with pkgs-unstable; [
      lutris
      # heroic-unwrapped # FHS
      heroic # without fhs
      # protonplus
      bottles
      wineWowPackages.stable # support both 32-bit and 64-bit applications
      winetricks
      amdgpu_top
      # wine64
    ]);
}
