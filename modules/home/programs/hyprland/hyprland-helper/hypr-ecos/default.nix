{
  imports = [
    ./hypridle.nix
    ./hyprpaper2.nix
    ./hyprlock.nix
    ./hyprsunset.nix
  ];

  services.hyprpolkitagent = {
    enable = true;
  };
}
