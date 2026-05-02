{ lib, config, ... }:

let
  plasmaSpecialisation.configuration = {
    # top level attributes
    system.nixos.tags = [ "::PLASMA::" ]; # disable if needed
    hyprland.enable = lib.mkForce false;
    kde.enable = lib.mkForce true;
    # gnome.enable = lib.mkForce false;
  };
in
{
  imports = [
    ./hyprland.nix
    ./kde.nix
  ];

  hyprland.enable = lib.mkDefault true;
  kde.enable = lib.mkDefault false;

  specialisation = lib.mkIf (config.networking.hostName == "carthage") {
    plasmoid = plasmaSpecialisation;
  };
}
