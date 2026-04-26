{
  imports = [
    ./inputrc.nix
    ./enVars.nix
    ../USIU
    ./programs
    ./services
    ./core
    # ./bootStuff.nix # BLEEDING_EDGE. FIXME: ZFS problems
    ./app-image.nix
    ./overlays
  ];

  xdg.menus.enable = true; # install files to support the XDG Desktop Menu specification
}
