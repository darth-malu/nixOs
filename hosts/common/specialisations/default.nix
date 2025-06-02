{ lib, config, ... }:
let
  plasmaSpecialisation = {
    configuration = {
      # top level attributes
      system.nixos.tags = [ "PLASMA" ]; # disable if needed
      hyprland.enable = lib.mkForce false;
      kde.enable = lib.mkForce true;
      gnome.enable = lib.mkForce false;
    };
  };
  gnomeSpecialisation = {
    configuration = {
      system.nixos.tags = [ "GNOME" ];
      hyprland.enable = lib.mkForce false;
      kde.enable = lib.mkForce false;
      gnome.enable = lib.mkForce true;
    };
  };
in
{
  imports = [
    ./hyprland.nix
    ./kde.nix
    ./gnome.nix
  ];

  hyprland.enable = lib.mkDefault true;
  kde.enable = lib.mkDefault false;
  gnome.enable = lib.mkDefault false;

  specialisation =
    if config.networking.hostName == "carthage" then
      {
        plasmoid = plasmaSpecialisation;
        gnome = gnomeSpecialisation;
      }
    else
      {
        plasmoid = plasmaSpecialisation;
      };
}
