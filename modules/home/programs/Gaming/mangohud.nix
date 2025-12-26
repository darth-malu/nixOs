{ lib, config }:
{
  options.mangohud = {
    enable = lib.mkEnableOption "Custom Mango";
  };

  config = lib.mkIf config.mangohud.enable {
    programs.mangohud = {
      enable = true;
      # enableSessionWide = true; # enable for all apps that support mangohud
      settingsPerApplication = {
        # $XDG_CONFIG_HOME/MangoHud/{application_name}.conf
        # https://github.com/flightlessmango/MangoHud/blob/master/data/MangoHud.conf
        mpv = {
          no_display = true;
        };
      };
      settings = {
        # $XDG_CONFIG_HOME/MangoHud/MangoHud.conf
        # https://github.com/flightlessmango/MangoHud/blob/master/data/MangoHud.conf
        output_folder = "~/Games/mangohud/";
        full = false;
        # fps_only = true;# Show FPS only. ***Not meant to be used with other display params***
        time = false;
        time_no_label = true; # Removes the time label
        # blacklist = [];
        cpu_mhz = true;
        cpu_power = false;
        gpu_power = false;
        gpu_temp = true;
        gpu_mem_temp = false;
        # gpu_core_clock = true;
        gpu_fan = true;
        gpu_voltage = true;
        gpu_power_limit = false;
        histogram = false;
        proc_vram = true;
        # vulkan_driver = true;
        # wine = true;
      };
    };
  };
}
