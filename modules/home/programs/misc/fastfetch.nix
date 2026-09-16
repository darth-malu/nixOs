{
  enable = true;
  settings = {
    # $XDG_CONFIG_HOME/fastfetch/config.jsonc
    logo = {
      # source = "nixos_small"; # nixos_small #nixos_old
      source = "/home/malu/Pictures/wallpaperS/anime/blue-hair-girl.jpg";
      # width = 60;
      # height = 15;
      position = "left";
      padding = {
        right = 1;
        top = 5;
        left = 1;
      };
      # color = {
      #   # Override logo colors
      #   "1" = "blue";
      #   "2" = "green";
      # };
    };
    display = {
      size = {
        binaryPrefix = "si";
      };
      # color = "blue";
      separator = " "; # 
      color = {
        keys = "blue"; # Key color
        title = "red"; # Title color
      };
      bar = {
        width = 10; # Width of percentage bars
        char.elapsed = "■"; # Character for elapsed portion
        char.total = "-"; # Character for total portion
      };
      percent = {
        type = 9; # 1=number, 2=bar, 3=both, 9=colored number
        color = {
          green = "green";
          yellow = "light_yellow";
          red = "light_red";
        };
      };
    };
    modules = [
      # "break"
      {
        type = "cpu";
        key = " ";
        keyColor = "red";
        format = " {name} ({cores-physical}C/{cores-logical}T) @ {freq-max}";
      }
      # "gpu"
      {
        type = "memory";
        key = "󰍛 ";
        keyColor = "red";
      }
      {
        type = "display";
        key = "󰍹 ({name})";
        # key = " ";
        keyColor = "blue";
        # "format" = "{width}x{height} @ {refresh-rate} Hz - {physical-width}x{physical-height} mm ({inch} inches, {ppi} ppi)";
        format = "{width}x{height} @ {refresh-rate} Hz";
      }

      {
        "type" = "os";
        "key" = " ";
        "keyColor" = "green";
      }
      {
        "type" = "kernel";
        "key" = " ";
        "keyColor" = "green";
      }
      {
        "type" = "shell";
        "key" = " ";
        "keyColor" = "green";
      }
      {
        "type" = "de";
        "key" = " DE ";
        "keyColor" = "blue";
      }
      {
        "type" = "wm";
        "key" = " ";
        "keyColor" = "blue";
      }
      {
        "type" = "terminal";
        "key" = " ";
        "keyColor" = "blue";
      }
      {
        "type" = "terminalfont";
        "key" = "  ";
        "keyColor" = "blue";
      }
    ];
  };
}
