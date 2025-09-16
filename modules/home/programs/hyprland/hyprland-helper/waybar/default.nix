{
  osConfig,
  lib,
  config,
  ...
}:

{
  options.waybar = {
    enable = lib.mkEnableOption "Enable waybar on hyprland";
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        # target = "graphical-session.target"; # config.wayland.systemd.target::
        # target = "graphical-session.target"; # config.wayland.systemd.target::
      };
      style =
        import ./css_waybar-common.nix
        + (
          if osConfig.networking.hostName == "carthage" then
            import ./css_waybar-carthage.nix
          else
            import ./css_waybar-tangier.nix
        );
      settings = {
        mainBar = {
          # height = 20; #so funny
          margin = "0 6 0 4";
          start_hidden = true;
          output =
            if osConfig.networking.hostName == "carthage" then
              [
                "HDMI-A-1"
                "DP-3"
              ]
            else
              [ "eDP-1" ];
          layer = "bottom";
          modules-center = [ ];
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window" # NOTE needed for transparency effects
          ];
          modules-right = [
            "group/resize_network"
          ]
          ++ (
            if osConfig.networking.hostName == "tangier" then
              [
                "group/disk_mpris"
                "group/ssd-temp_memory"
                "group/cpu_freq"
                "group/temp_wireplumber"
                "battery"
                "group/backlight_idle"
              ]
            else if osConfig.networking.hostName == "carthage" then
              [
                "group/gpu_mpris"
                "group/gpu_temp_network_block"
                "group/all_disks"
                "group/nvme-temp_memory"
                "group/cpu_block"
                "group/temp_wireplumber"
              ]
            else
              [ ]
          )
          ++ [
            "group/tray_clock"
          ]
          ++ (
            if osConfig.networking.hostName == "carthage" then
              [
                "group/power-profiles-idle-inhibitor"
              ]
            else
              [
                "power-profiles-daemon"
              ]
          );

          "hyprland/workspaces" = {
            format = "{name}";
            all-outputs = false; # If set to false workspaces group will be shown only in assigned output. Otherwise all workspace groups are shown.
            # active-only = true; # show active workspace ONLY on monitor instead of all currently open workspaces
            on-click = "activate";
            on-click-right = "close";
            on-scroll-up = "hyprctl dispatch workspace m-1"; # m- monitor, e -all open, r- m+empty
            on-scroll-down = "hyprctl dispatch workspace m+1";
            show-special = false;
            special-visible-only = true;
            format-icons = {
              active = "󱎴";
              default = "󰍹";
            };
            ignored-workspaces = [
            ];
          };

          "hyprland/submap" = {
            format = "💤 {}";
            max-length = 8;
            tooltip = false;
          };

          "hyprland/window" = {
            format = "{}";
            icon = true;
            icon-size = if osConfig.networking.hostName == "tangier" then 19 else 17;
            separate-outputs = true; # Show the active window of the monitor the bar belongs to, instead of the focused window.
            cursor = true;
            on-scroll-up = "hyprctl dispatch workspace m-1"; # m- monitor, e -all open, r- m+empty
            on-scroll-down = "hyprctl dispatch workspace m+1";
            max-length = 50;
            rewrite = {
              "(.*) — Mozilla Firefox" = "$1";
              "(.*) — Zen Browser" = "$1";
              "(.*) - Chromium" = "$1";
              "(.*)~" = "$1";
              # "v(.*)" = "  $1";
              # "v(.*)" = "  $1";
              # "v." = "  $1";
              # "v" = "$1";
            };
          };

          "temperature" = {
            #thermal-zone = 2;
            hwmon-path = # TODO have this be dynamic based on name?
              if osConfig.networking.hostName == "tangier" then
                "/sys/class/hwmon/hwmon4/temp1_input"
              else
                "/sys/class/hwmon/hwmon1/temp1_input"; # carthage? TODO: write script that checks name
            critical-threshold = if osConfig.networking.hostName == "tangier" then 90 else 80;
            # format-critical = "{temperatureC}° {icon}";
            # format-critical = "{temperatureC}° {icon}";
            # interval = 8;
            format = "{temperatureC} °";
            format-icons = [
              ""
              ""
              ""
            ];
            tooltip = false;
            min-length = 3;
            max-length = 5;
            cursor = true;
          };

          "power-profiles-daemon" = {
            format = "{icon}";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              default = "🧊";
              performance = "⚡";
              balanced = "☯";
              power-saver = ""; # ☘
            };
          };

          "battery" = {
            "states" = {
              "good" = 95;
              "half" = 50;
              "warning" = 20;
              "critical" = 10;
            };
            "interval" = 10;
            "format" = "{capacity}% {icon}";
            "format-charging" = "{capacity}% ";
            "format-plugged" = "{capacity}% ";
            "format-alt" = "{time} {icon}";
            # "format-good": "", // An empty format will hide the module
            # "format-full": "",
            "format-icons" = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "wireplumber" = {
            format = "{volume} {icon} "; # 🎙{node_name}
            format-icons = [
              ""
              ""
              ""
            ];
            format-muted = "🔇";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-backward = "pwvucontrol";
            max-volume = 100;
            scroll-step = 2;
            tooltip = false;
            # min-length = 5;
            # max-length = 5;
          };

          "wireplumber#sink" = {
            node-type = "Audio/Sink";
            format = "{volume} {icon} "; # 🎙{node_name}
            format-icons = [
              ""
              ""
              ""
            ];
            format-muted = "🔇";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-backward = "pwvucontrol";
            max-volume = 100;
            scroll-step = 2;
            tooltip = false;
            # min-length = 5;
            # max-length = 5;
          };

          "wireplumber#source" = {
            # TODO: make a script to do this
            node-type = "Audio/Source";
            format = "{volume} ";
            on-click-backward = "pwvucontrol";
            # tooltip = false;
            format-muted = "";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.05+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.05-";
            scroll-step = 5;
            # max-volume = 100; #FIXME
          };

          "tray" = {
            spacing = 8; # 10;;
            icon-size = 12;
            expand = true; # dynamically consume left over SPC
            # reverse-direction = true;
            # show-passive-items = true; # false::
            icons = {
              # "blueman" = "bluetooth";
            };
          };

          "group/power-profiles-idle-inhibitor" = {
            drawer = {
              transition-duration = "680";
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = false;
            };
            orientation = "horizontal";
            cursor = true;
            modules = [
              "power-profiles-daemon"
              "idle_inhibitor"
            ];
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
              # "mpd"
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
              if osConfig.networking.hostName == "carthage" then
                [
                  "disk"
                  "disk#mutsu"
                  "disk#hyogo"
                  "disk#linuxHdd"
                  "disk#extraHdd"
                ]
              else if osConfig.networking.hostName == "tangier" then
                [ "disk" ]
              else
                [ ];
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
              "wireplumber#source"
              "wireplumber#sink"
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
            modules = [
              "temperature"
              # "wireplumber#sink"
              # "wireplumber#source"
              "wireplumber"
            ];
          };

          "group/tray_clock" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 400;
              transition-left-to-right = true;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            modules = [
              "tray"
              # "custom/weather"
              "clock"
              # "custom/monitors"
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
            modules = [
              "cpu"
              "custom/cpu_freq"
            ];
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

          "group/ssd-temp_memory" = {
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 680;
              transition-left-to-right = false;
              children-class = "ssd";
              click-to-reveal = true;
            };
            modules = [
              "custom/ssd_temp"
              "memory"
            ];
          };

          "group/disk_mpris" = {
            orientation = "horizontal";
            cursor = true;
            drawer = {
              transition-duration = 680;
              transition-left-to-right = false;
              children-class = "gpuperf";
              click-to-reveal = true;
            };
            modules = [
              "disk"
              "mpris"
              "mpd"
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

          "custom/monitors" = {
            on-click = "hyprctl keyword monitor DP-1,disable; notify-send -i /home/malu/Shibuya/assets/icons/toggle-on-glassmorphism/icons8-toggle-on-48.png";
            on-click-right = "hyprctl keyword monitor DP-1,highres,0x0,1; notify-send -i /home/malu/Shibuya/assets/icons/toggle-off-glassmorphism/icons8-toggle-off-48.png";
            format = "󰍺 ";
            return-type = "";
            interval = 10;
            # min-length = 5;
            # max-length = 8;
            tooltip = false;
          };
          "custom/gpu" = {
            exec = "cat /sys/class/drm/card1/device/gpu_busy_percent";
            format = " \t{}%  ";
            return-type = "";
            interval = 5;
            min-length = 5;
            max-length = 8;
            tooltip = false;
          };

          "custom/gpu_temp" = {
            exec = "temp gpu_temp";
            interval = 5;
            format = "{} °";
            retur-type = "";
            min-length = 3; # absolut min lul
            max-length = 3;
            tooltip = false;
          };

          "custom/gpu_fans" = {
            exec = "temp gpu_fans";
            interval = 5;
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
            interval = 5;
            format = "   {usage}%";
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

          disk = {
            interval = 90;
            format = "   {specific_free:0.1f} GiB"; # 
            unit = "GB";
            path = "/";
          };

          "disk#linuxHdd" = {
            interval = 90;
            format = "   {specific_free:0.1f} Gib"; # 
            path = "/media/linuxHdd";
            unit = "GB";
          };

          "disk#hyogo" = {
            interval = 90;
            format = "󰡚   {specific_free:0.1f} Gib"; # 
            path = "/media/hyogo";
            "unit" = "GB";
          };

          "disk#mutsu" = {
            interval = 90;
            format = "󰡗   {specific_free:0.1f} Gib"; #  
            path = "/media/mutsu";
            unit = "GB";
          };

          "disk#extraHdd" = {
            interval = 90;
            format = "   {specific_free:0.1f} Gib"; # 󰨡
            path = "/media/extraHdd";
            unit = "GB";
          };

          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            timezone = "Africa/Nairobi";
            # min-length = 15;
            # max-length = 16;
            # format = "{:%a %d,  %I:%M %p }";
            # format-alt = "{:%d-%m-%Y}";
            format-alt = "{:%a %d,  %I:%M %p }";
            format = "{:%H:%M}";
            # format = "{%k:%M %p }";
            # format = "{%R}";
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
              "on-scroll-up" = "shift_up";
            };
          };

          "memory" = {
            interval = 30;
            # format-alt = "🧠 {}%";
            format-alt = "🧠   {used:0.1f}GB";
            # format = "🧠 {used:0.1f}GB";
            format = "🧠   {percentage}%";
            # max-length = 10;
          };

          "backlight" = {
            device = "intel_backlight";
            format = "{icon}";
            # format-alt = "<small>{percent}%</small>";
            format-icons = [
              "󱩎"
              "󱩏"
              "󱩐"
              "󱩑"
              "󱩒"
              "󱩓"
              "󱩔"
              "󱩕"
              "󱩖"
              "󰛨"
            ];
            on-scroll-up = "brightnessctl set 2%+";
            on-scroll-down = "brightnessctl set 2%-";
            smooth-scrolling-threshold = "2400";
            tooltip = true;
            tooltip-format = "Brightness {percent}%";
            reverse-scrolling = true;
          };

          "network" = {
            format-wifi = "  {essid} -{signalStrength}- {bandwidthDownBytes}"; # 
            # format-icons = [ ];
            format-wifi-alt = "  {bandwidthDownBytes}      {bandwidthUpBytes}";
            format-ethernet = "󰈀  {bandwidthDownBytes}       {bandwidthUpBytes}";
            format-linked = "󰈁 {ifname} {bandwidthDownBytes}       {bandwidthUpBytes}";
            format-disconnected = "No net ⚠️";
            interval = 2;
            # format-disconnected = "No net ⚠";
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
            tooltip = false;
            interval = 2;
            consume-icons = {
              "on" = " ";
            };
            random-icons = {
              #"off" = "<span color=\"#f53c3c\"></span> ";
              off = "";
              on = " ";
            };

            repeat-icons = {
              on = ""; # 🔁
              off = "";
            };

            single-icons = {
              off = "";
              on = "󰑘"; # 🔂
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
            on-scroll-down = "mpris_vol -";
            on-scroll-up = "mpris_vol +";
            tooltip = false;
            ellipsis = "...";
            player-icons = {
              default = "";
              Lollypop = " ";
              spotify = "󰓇 ";
              mpd = "♪";
            };
            status-icons = {
              paused = "⏸";
              playing = "";
              stopped = "";
            };
            dynamic-importance-order = [
              "title"
              "artist"
              "album"
              "position"
              "length"
            ];
            dynamic-len = 30;
            dynamic-order = [
              "title"
              "artist"
              "album"
            ];
            ignored-players = [
              "firefox"
              "chromium"
            ];
          };

          "custom/launcher" = {
            format = "󱄅";
            on-click = "rofi -show drun";
          };

          "idle_inhibitor" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              activated = "☕"; #  
              # activated = "💡"; # 🍺💡🚬
              deactivated = "󱄅"; # 🗿 🃏🧿
            };
            on-click-backward = "hyprctl keyword monitor DP-1,disable && notify-send -i '/home/malu/Shibuya/assets/icons/toggle-on-glassmorphism/icons8-toggle-off-48.png' false";
            on-click-forward = "hyprctl keyword monitor DP-1,highres,0x0,1 && notify-send -i '/home/malu/Shibuya/assets/icons/toggle-off-glassmorphism/icons8-toggle-on-48.png' true";
            on-scroll-down = "hyprctl hyprsunset gamma -10";
            on-scroll-up = "hyprctl hyprsunset gamma +10";
          };

          "group/backlight_idle" = {
            drawer = {
              transition-duration = 680;
              transition-left-to-right = false;
              children-class = "drawer-child";
              click-to-reveal = true;
            };
            orientation = "inherit";
            cursor = true;
            modules = [
              "backlight"
              "idle_inhibitor"
              # "battery"
            ];
          };
        };
      };
    };
  };
}
