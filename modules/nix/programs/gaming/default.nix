{ pkgs, ... }:

{
  imports = [
    ./steam.nix
    ./lutris.nix
  ];

  environment.systemPackages = with pkgs; [
    # heroic-unwrapped # FHS
    # lutris
    # protonplus
    # wine-wayland
    # wine64
    # wine64 # 64-bit only
    amdgpu_top
    antimicrox
    bottles
    heroic # without fhs
    lutris
    mangohud
    protonup
    wineWowPackages.stable # support both 32-bit and 64-bit applications
    winetricks
  ];
}
