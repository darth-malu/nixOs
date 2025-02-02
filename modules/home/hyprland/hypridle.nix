{
  services.hypridle = {
    enable = true; # install
    settings = {
      general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
      };
      listener = [
          {
          #timeout = 900; # 15 min
          timeout = 240; # 15 min
          on-timeout = "hyprlock";
          }
          {
          #timeout = 1200;
          timeout = 500;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
          }
      ];
    };
  };
}
