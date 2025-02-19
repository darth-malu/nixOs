{lib, ...}:
{
  imports = [
    ./hyprland.nix
    ./kde.nix
  ];

  hyprland.enable = true;
  kde.enable = false;

  specialisation = {
    plasmoid = { 
      configuration = { # top level attributes
        programs.waybar.enable = false;
        system.nixos.tags = ["plasma-tilde"];
        hyprland.enable = lib.mkForce false;
        kde.enable = lib.mkForce true;
      };
    };
  };
}
