{ lib, config, ... }:
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
        plasmoid = {
          configuration = {
            # top level attributes
            system.nixos.tags = [ "PLASMA" ]; # disable if needed
            hyprland.enable = lib.mkForce false;
            kde.enable = lib.mkForce true;
            gnome.enable = lib.mkForce false;
          };
        };
        gnome = {
          configuration = {
            system.nixos.tags = [ "GNOME" ];
            hyprland.enable = lib.mkForce false;
            kde.enable = lib.mkForce false;
            gnome.enable = lib.mkForce true;
          };
        };
      }
    else
      {
        plasmoid = {
          configuration = {
            system.nixos.tags = [ "PLASMA" ];
            hyprland.enable = lib.mkForce false;
            kde.enable = lib.mkForce true;
            gnome.enable = lib.mkForce false;
          };
        };
      };
}
