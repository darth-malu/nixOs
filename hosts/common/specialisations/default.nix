{ lib, config, ... }:
{
  imports = [
    ./hyprland.nix
    ./kde.nix
  ];

  hyprland.enable = lib.mkDefault true;

  kde.enable = lib.mkDefault false;

  specialisation = {
    plasmoid = {
      configuration = {
        # top level attributes
        programs.waybar.enable = false; # FIXME: does not work offcourse lol
        system.nixos.tags = [ "PLASMA" ]; # disable if needed
        hyprland.enable = lib.mkForce false;
        kde.enable = lib.mkForce true;
      };
    };
  };
}
