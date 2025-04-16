{ pkgs, ... }:

{
  imports = [
    ./dunst.nix
    # ./eww
    ./rofi
    ./waybar
    ./scripts
    ./hypr-ecos
  ];

  home.packages = with pkgs; [
    grimblast
    slurp
    viewnior
    vlc
    cliphist
    nautilus
    sushi
    yelp
    file-roller
  ];
}
