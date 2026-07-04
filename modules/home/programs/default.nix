{ lib, osConfig, ... }:
{
  imports = [
    ./Development
    ./Gaming
    ./git.nix
    ./gpg.nix
    ./mpv
    ./nyaa.nix
    ./pkgs.nix
    ./qutebrowser
    ./shell
    ./soundStuff
    ./yazi
    ./yt-dlp
  ]
  ++ (lib.optionals osConfig.hypr.enable [
    # TODO see if hypr better or full option
    # ./hyprland # - HOME hyprland setup files -> DEPRECATED
    ./hyprland/hyprland-helper
  ]);
}
