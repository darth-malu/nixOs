{modulesPath,...}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../specialisations #includes hyprland config and specialisations
    ./common
  ];
}
