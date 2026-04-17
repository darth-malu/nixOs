{
  imports = [
    ./inputrc.nix
    ./enVars.nix
    ../USIU
    ./programs
    ./services
    ./core
    ./bootStuff.nix
    ./app-image.nix
    ./overlays.nix
  ];

  xdg.menus.enable = true; # install files to support the XDG Desktop Menu specification
}
