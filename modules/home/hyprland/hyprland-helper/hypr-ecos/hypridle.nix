{ lib, config }:
{
  options.hypridle = {
    enable = lib.mkEnableOption "hypridle";
  };
  config = lib.mkIf config.hypridle.enable {
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
  };
}
