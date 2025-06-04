{ lib, ... }:
let
  plasmaSpecialisation.configuration = {
    # top level attributes
    system.nixos.tags = [ "PLASMA" ]; # disable if needed
    hyprland.enable = lib.mkForce false;
    kde.enable = lib.mkForce true;
    gnome.enable = lib.mkForce false;
  };

  gnomeSpecialisation.configuration = {
    system.nixos.tags = [ "GNOME" ];
    hyprland.enable = lib.mkForce false;
    kde.enable = lib.mkForce false;
    gnome.enable = lib.mkForce true;
  };

  hyprlandSpecialisation.configuration = {
    system.nixos.tags = [ "HYPRLAND" ];
    environment.etc."specialisation".text = "vaxrys";
    # inheritParentConfig = true;
    hyprland.enable = lib.mkForce true;
    kde.enable = lib.mkForce false;
    gnome.enable = lib.mkForce false;
    programs.dconf.enable = true;
  };
in
{
  imports = [
    ./hyprland.nix
    ./kde.nix
    ./gnome.nix
  ];

  hyprland.enable = lib.mkDefault false;
  kde.enable = lib.mkDefault true;
  gnome.enable = lib.mkDefault false;

  specialisation = {
    # plasmoid = plasmaSpecialisation;
    hyprland.configuration = hyprlandSpecialisation;
    # gnome = gnomeSpecialisation;
  };
}
