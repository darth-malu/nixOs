{ lib, config, ... }:

let
  plasmaSpecialisation.configuration = {
    # top level attributes
    system.nixos.tags = [ "::PLASMA::" ]; # disable if needed
    hypr.enable = lib.mkForce false;
    kde.enable = lib.mkForce true;
    # gnome.enable = lib.mkForce false;
  };

  niri.configuration = {
    # top level attributes
    system.nixos.tags = [ "--NIRI--" ]; # disable if needed
    niri.enable = lib.mkForce true;
    hypr.enable = lib.mkForce false;
    kde.enable = lib.mkForce false;
    # gnome.enable = lib.mkForce false;
  };
in
{
  imports = [
    ./hyprland.nix
    ./kde.nix
    ./niri.nix
  ];

  hypr.enable = lib.mkDefault true;
  kde.enable = lib.mkDefault false;
  niri.enable = lib.mkDefault false;

  specialisation = lib.mkIf (config.networking.hostName == "carthage") {
    plasmoid = plasmaSpecialisation;
    # niroid = niri;# TODO incomplete
  };
}
