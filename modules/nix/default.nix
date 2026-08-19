{
  imports = [
    ./inputrc.nix
    ./systemVariables.nix
    ../USIU
    ./programs
    ./services
    ./core
    ./app-image.nix
    ./overlays
  ];

  xdg.menus.enable = true; # install files to support the XDG Desktop Menu specification
  # NOTE: cannot have this in home options
}
