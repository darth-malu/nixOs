{ pkgs, inputs, ... }:
{
  imports = [
    ./inputrc.nix
    ./enVars.nix
    ../USIU
    ./programs
    ./services
    ./core
    ./app-image.nix
    ./overlays.nix
  ];

  xdg.menus.enable = true;
  environment.etc."/xdg/menus/applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nixd flake suggestion
}
