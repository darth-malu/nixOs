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
    protonup
    wineWowPackages.full # support both 32-bit and 64-bit applications - stable, full, waylandFull
    winetricks
  ];
}
