{ lib, osConfig, ... }:
{
  imports = [
    ./Development
    ./Gaming
    ./git.nix
    ./gpg.nix
    ./mpv
    ./nyaa.nix
    ./opencode.nix
    ./pkgs.nix
    ./qutebrowser
    ./shell
    ./soundStuff
    ./yazi
    ./yt-dlp
  ]
  ++ lib.optionals osConfig.programs.hyprland.enable [
    # ./hyprland  # - HOME hyprland
    ./hyprland/hyprland-helper
  ];
}
