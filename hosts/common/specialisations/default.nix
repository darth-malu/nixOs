{ lib, config, ... }:

let
  plasmaSpecialisation.configuration = {
    # top level attributes
    system.nixos.tags = [ "::PLASMA::" ]; # disable if needed
    kde.enable = lib.mkForce true;
    hypr.enable = lib.mkForce false;
    # gnome.enable = lib.mkForce false;
  };

  gnome.configuration = {
    # top level attributes
    system.nixos.tags = [ "::GNOME::" ]; # disable if needed
    gnome.enable = lib.mkForce true;
    hypr.enable = lib.mkForce false;
    kde.enable = lib.mkForce false;
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
    ./gnome.nix
  ];

  hypr.enable = lib.mkDefault true;
  kde.enable = lib.mkDefault false;
  niri.enable = lib.mkDefault false;
  gnome.enable = lib.mkDefault false;

  specialisation = {
    plasmoid = plasmaSpecialisation;
    gnome = lib.mkIf (config.networking.hostName == "carthage") gnome;
    niroid = lib.mkIf (config.networking.hostName == "carthage") niri;
  };
}
