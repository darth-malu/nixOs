{
  specialisation.plasmaHome.configuration = {
    wayland.windowManager.hyprland = {
      enable = false;
    };
    services = {
      dunst.enable = false;
      hypridle.enable = false;
      hyprpaper.enable = false;
    };
    programs = {
      hyprlock.enable = false;
      starship.enable = true;
      waybar.enable = false;
      rofi = {
        enable = false;
      };
    };
  };
}
