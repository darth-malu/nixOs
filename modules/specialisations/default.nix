{
  imports = [./hyprland.nix];
  specialisation = {
    plasmoid = { 
      configuration = import ./kde.nix;
      inheritParentConfig = false;
    };
    # gnomify.configuration = import ./gnome.nix;
    # hyprland.configuration = import ./hyprland.nix;
  };
}
