{ pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    antimicrox
    bottles
    heroic # without fhs
    protonup-ng
    wineWowPackages.full # support both 32-bit and 64-bit applications - stable, full, waylandFull
    # winetricks
  ];
}
