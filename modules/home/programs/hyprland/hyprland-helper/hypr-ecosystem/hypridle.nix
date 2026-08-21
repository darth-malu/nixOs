{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        # ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };
      # listener = {
      #     timeout = 150                                # 2.5min.
      #     on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
      #     on-resume = brightnessctl -r                 # monitor backlight restore.
      # }
      listener = [
        {
          timeout = 240;
          on-timeout = "hyprlock";
        }
        {
          timeout = 500;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
