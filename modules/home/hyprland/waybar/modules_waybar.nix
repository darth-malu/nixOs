{osConfig, lib,...}:

{
  config = lib.mkIf (osConfig.specialisation != {}) {
    programs.waybar = {
      # enable = lib.mkIf config.wayland.windowManager.hyprland.enable true;
      # enable = lib.mkIf osConfig.programs.hyprland.enable true;
      systemd = {
          enable = false;
          # target = "graphical-session.target";
      };
      style = 
        if osConfig.networking.hostName == "carthage"
          then import ./css_waybar-carthage.nix
        else 
          if osConfig.networking.hostName == "tangier" then import ./css_waybar-tangier.nix else import ./css_waybar-carthage.nix;
      settings = {
        mainBar = {
          # height = 20; #so funny
          margin = "0 6 0 4";
          layer = "bottom";
          modules-center = [];
          modules-left = [
            "hyprland/workspaces"
            # "hyprland/window"
          ];
          modules-right = if osConfig.networking.hostName == "tangier" then [
            "group/resize_network"
            "group/disk_memory"
            "group/ssd-mpris"
            "group/cpu_freq"
            "group/temp_wireplumber"
            "group/tray_clock"
            "battery"
            "backlight"
            "idle_inhibitor"
          ] 
          else [
              "group/resize_network"
              "group/gpu_mpris"
              "group/gpu_temp_network_block"
              "group/all_disks"
              #"custom/nvme_temp"
              "group/nvme-temp_memory"
              "group/cpu_block"
              "group/temp_wireplumber"
              "group/tray_clock"
              "idle_inhibitor"
          ];

          "hyprland/workspaces" = {
            format = "{name}";
            all-outputs = true;
            on-click = "activate";
            on-click-right = "close";
            # on-click-forward = "dash -c 'hyprctl dispatch workspace special:nc'";
            on-scroll-up = "hyprctl dispatch workspace m-1"; # m- monitor, e -all open, r- m+empty
            on-scroll-down = "hyprctl dispatch workspace m+1";
            show-special = false;
            format-icons = {
              active = "󱎴";
              default = "󰍹";
            };
          };

          "hyprland/submap" = {
            format = "✌️ {}";
            max-length = 8;
            tooltip = false;
          };

          "hyprland/window" = {
            format = "{}";
            # icon = true;
            icon-size = 17;
            separate-outputs = true;
            cursor = true;
            #max-length = 50;
            rewrite = {
              "(.*) — Mozilla Firefox" = "$1";
              "(.*) — Zen Browser" = "$1";
              "(.*) - Chromium" = "$1";
              "(.*)~" = "$1";
              # "v(.*)" = "  $1";
              "v(.*)" = "  $1";
              "v" = "$1";
            };
          };

          "temperature" = {
            #thermal-zone = 2;
            # hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
            hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input"; # k10temp?
            critical-threshold = 80;
            format-critical = "{temperatureC}° {icon}";
            interval = 8;
            format = "{temperatureC} °";
            format-icons = [ " " " " "" ];
            tooltip = false;
            min-length = 3;
            max-length = 4;
            cursor = true;
          };

          "battery" = {
            "states" = { "good" = 95; "warning" = 20; "critical" = 10; };
            "interval"  = 10;
            "format" = "{capacity}%  {icon}";
            "format-charging" = "{capacity}% ";
            "format-plugged" = "{capacity}% ";
            "format-alt" = "{time} {icon}";
            # "format-good": "", // An empty format will hide the module
            # "format-full": "",
            "format-icons" = ["" "" "" "" ""];
          };

          "wireplumber" = {
            format = "{volume}  ";# 🎙️
            format-muted = "";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-backward = "pwvucontrol";
            max-volume = 100;
            scroll-step = 2;
            tooltip = false;
            # min-length = 5;
            # max-length = 5;
          };

          "tray" = {
            spacing = 10;
            icon-size = 12;
          };

          "group/gpu_mpris" = {
            drawer = {
              transition-duration = "680";
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            orientation = "horizontal";
            cursor = true;
            modules = [
              "custom/gpu"
              "mpris"
              "mpd"
            ];
          };

          "group/gpu_temp_network_block" = {
            drawer = {
              transition-duration = 680;
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            orientation = "inherit";
            cursor = true;
            modules = [
              "custom/gpu_temp"
              "custom/gpu_freq"
              "custom/gpu_fans"
            ];
          };

          "group/tangier_disk_mpris" = {
            drawer = {
              transition-duration = 680;
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            orientation = "inherit";
            cursor = true;
            modules = [
              "disk"
              "mpris"
              "mpd"
            ];
          };

          "group/all_disks" = {
            drawer = {
              transition-duration = 680;
              transition-left-to-right = true;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            orientation = "inherit";
            cursor = true;
            modules =
              if osConfig.networking.hostName == "carthage"  then
              [
                "disk"
                "disk#home"
                "disk#linuxHdd"
                "disk#extraHdd"
              ]
              else if osConfig.networking.hostName == "tangier" then ["disk"] else [];
          };

          "group/resize_network" = {
            modules = [
              "hyprland/submap"
              "network"
            ];
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 400;
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
          };


          "group/media" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 400;
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            modules = [
              "wireplumber"
              "mpris"
              "mpd"
            ];
          };

          "group/window_mpris" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 400;
              transition-left-to-right = true;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            modules = [
              "hyprland/window"
              "mpd"
              "mpris"
              #"wireplumber"
            ];
          };

          "group/temp_wireplumber" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 400;
              transition-left-to-right = true;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            modules = [ "temperature" "wireplumber" ];
          };

          "group/tray_clock" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 400;
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            modules = [
              "tray"
              # "custom/weather"
              "clock"
            ];
          };

          "group/cpu_freq" = {
            drawer = {
              transition-duration = 680;
              transition-left-to-right = true;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            orientation = "horizontal";
            cursor = true;
            modules = [ "cpu" "custom/cpu_freq"  ];
          };

          "group/cpu_block" = {
            drawer = {
              transition-duration = 680;
              transition-left-to-right = true;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            orientation = "horizontal";
            cursor = true;
            modules = [
              "cpu"
              "custom/cpu_freq"
            ];
          };

          "group/mpd_block" = {
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 680;
              transition-left-to-right = true;
              children-class = "mpd";
              click-to-reveal = false;
            };
            modules = [
              "mpris"
              "mpd"
            ];
          };

          "group/ssd-temp_network" = {
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 680;
              transition-left-to-right = true;
              children-class = "ssd";
              click-to-reveal = true;
            };
            modules = [
              "custom/ssd_temp"
              "network"
            ];
          };

          "group/ssd-mpris" = {
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 680;
              transition-left-to-right = true;
              children-class = "ssd";
              click-to-reveal = true;
            };
            modules = [
              "custom/ssd_temp"
              "mpris"
              "mpd"
            ];
          };

          "group/disk_memory" = {
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 680;
              transition-left-to-right = true;
              children-class = "gpuperf";
              click-to-reveal = true;
            };
            modules = [
              "disk"
              "memory"
            ];
          };
          "group/nvme-temp_memory" = {
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 680;
              transition-left-to-right = false;
              children-class = "nvme_memory";
              click-to-reveal = true;
            };
            modules = [
              "custom/nvme_temp"
              "memory"
            ];
          };

          "custom/gpu" = {
            exec = "cat /sys/class/drm/card1/device/gpu_busy_percent";
            format = " \t{}%  ";
            return-type = "";
            interval = 10;
            min-length = 5;
            max-length = 8;
            tooltip = false;
          };

          "custom/gpu_temp" = {
            exec = "temp gpu_temp";
            interval = 10;
            format = "{} °";
            retur-type = "";
            min-length = 3;#absolut min lul
            max-length = 3;
            tooltip = false;
          };

          "custom/gpu_fans" = {
            exec = "temp gpu_fans";
            interval = 10;
            format = "{} rpm";
            return-type = "";
            min-length = 8;
            max-length = 8;
            tooltip = false;
          };

          "custom/gpu_freq" = {
            exec = "temp gpu_freq";
            interval = 20;
            format = "{} ";
            return-type = "";
            tooltip = false;
          };

          "cpu" = {
            interval = 10;
            format = " \t{usage}%";
            tooltip = false;
            max-length = 7;
            min-length = 7;
          };

          "custom/cpu_freq" = {
            exec = "temp cpu_freq";
            format = "{} Ghz";
            return-type = "";
            interval = 5;
            min-length = 8;
            max-length = 8;
            tooltip = false;
          };

          "custom/ssd_temp" = {
            exec = "temp ssd_temp";
            format = "{} °";
            return-type = "";
            interval = 10;
            min-length = 3;
            max-length = 3;
            tooltip = false;
          };

          "custom/nvme_temp" = {
            exec = "temp nvme_temp";
            format = "{} °";
            return-type = "";
            interval = 10;
            min-length = 3;
            max-length = 3;
            tooltip = false;
          };

          "disk" = {
            interval = 90;
            format = " \t{specific_free:0.1f} GiB";
            "unit" = "GB";
            path = "/";
          };

          "disk#home" = {
            interval = 90;
            format = "   {specific_free:0.1f} Gib";
            path = "/home";
            "unit" = "GB";
          };

          "disk#linuxHdd" = {
            interval = 90;
            format = "   {specific_free:0.1f} Gib";#
            path = "/media/linuxHdd";
            "unit" = "GB";
          };

          "disk#extraHdd" = {
            interval = 90;
            format = "   {specific_free:0.1f} Gib"; #󰨡
            path = "/media/extraHdd";
            "unit" = "GB";
          };

          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            timezone = "Africa/Nairobi";
            format-alt = "{:%Y-%m-%d}";
            min-length = 15;
            max-length = 16;
            format = "{:%a %d,  %I:%M %p }";
            tooltip = true;
            calendar = {
              "mode" = "month";
              "mode-mon-col" = 3;
              "weeks-pos" = "right"; # possible values = right:left
              "on-scroll" = 1;
              "on-click-right" = "mode";
              "format" = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              "on-click-right" = "mode";
              "on-scroll-down" = "shift_down";
            };
          };

          "memory" = {
            interval = 30;
            # format-alt = "🧠 {}%";
            format-alt = "🧠 {used:0.1f}GB";
            # format = "🧠 {used:0.1f}GB";
            format = "🧠 {percentage}%";
            # max-length = 10;
          };

          "backlight" = {
            device = "intel_backlight";
            format = "{icon}";
            tooltip = true;
            format-alt = "<small>{percent}%</small>";
            format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
            on-scroll-up = "brightnessctl set 1%+";
            on-scroll-down = "brightnessctl set 1%-";
            smooth-scrolling-threshold = "2400";
            tooltip-format = "Brightness {percent}%";
            reverse-scrolling = true;
          };

          "network" = {
            format-wifi = "  {essid} {bandwidthDownBytes}";
            format-icons = [];
            format-wifi-alt =  "  {bandwidthDownBytes}      {bandwidthUpBytes}";
            format-ethernet = "   {bandwidthDownBytes}       {bandwidthUpBytes}";
            interval = 2;
            format-linked = "{ifname} (No IP) ";
            #format-disconnected = "⚠  No net";
            format-disconnected = "⚠️  No net ❗";
            tooltip = false;
          };

          # "custom/weather" = {
          #   #format = "{}°C";
          #   format = "{}";
          #   tooltip = true;
          #   interval = 3600;
          #   #exec = "wttrbar --location Nairobi";
          #   exec = "/home/malu/.darth/scripts/get_weather.sh Nairobi";
          #   #return-type = "json";
          #   return-type = "json";
          # };

          "mpd" = {
            format = "{songPosition}{queueLength}  {singleIcon} {consumeIcon}{randomIcon}{repeatIcon}  ";
            format-disconnected = "Disconnected ";
            format-paused = "";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}-Stopped  \t";
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
            #tooltip = false;
            interval = 2;
            consume-icons = {
              "on" = " ";
            };
            random-icons = {
              #"off" = "<span color=\"#f53c3c\"></span> ";
              "off" = "";
              "on" = " ";
            };

            repeat-icons = {
              "on" = "";
              "off" = "";
            };

            single-icons = {
              "on" = "";
              "off" = "";

              #"on" = "🔂";
            };

            state-icons = {
              paused = "⏸";
              stopped = "";
              playing = "♪";
            };
          };

          "mpris" = {
            #format = "-<{player_icon} {dynamic}>-";
            format = "{player_icon} {dynamic}";
            format-paused = "{status_icon}  {dynamic}";
            format-playing = "{player_icon}  {dynamic}";
            #on-click-middle = "~/.darth/scripts/player_focus.sh";#FIXME: focus not working
            # on-scroll-down = "~/.darth/scripts/player/mpris_volume.sh -";
            # on-scroll-up = "~/.darth/scripts/player/mpris_volume.sh +";
            on-scroll-down = "mpris_vol -2";
            on-scroll-up = "mpris_vol +2";
            tooltip = false;
            ellipsis = "...";
            player-icons = {
              default = "";
              Lollypop = " ";
              spotify = "󰓇 ";
              mpd = "♪";
            };
            status-icons = {paused = "⏸";playing = "";stopped = "";};
            dynamic-importance-order = [ "title" "artist" "album" "position" "length" ];
            dynamic-len = 30;
            dynamic-order = ["title" "artist" "album" ];
            ignored-players = [ "firefox" "chromium"];
          };

          "custom/launcher" = {
            format = "󱄅";
            on-click = "rofi -show drun";
          };

          "idle_inhibitor" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              #activated = "  ";
              activated = "🍺";
              deactivated = " ";
            };
          };
        };
      };
    };
  };
}
