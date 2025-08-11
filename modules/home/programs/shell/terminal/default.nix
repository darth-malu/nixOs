{ pkgs, ... }:
{
  imports = [
    ./kitty
    # ./wezterm
    # ./ghostty
  ];

  home.packages = [
    pkgs.kdePackages.konsole
  ];
}
