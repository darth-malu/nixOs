{
  imports = [
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./hyprsunset.nix
  ];

  services.hyprpolkitagent = {
    enable = true;
  };
}
