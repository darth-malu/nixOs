{
  imports = [
    ./inputrc.nix
    ./enVars.nix
    # ../USIU
    ./programs
    ./services
    ./core
    # ./app-image.nix
    ./overlays.nix
    # ./themes-nix.nix
  ];
}
