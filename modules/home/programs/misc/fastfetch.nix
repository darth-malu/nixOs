{
  enable = true;
  settings = {
    # $XDG_CONFIG_HOME/fastfetch/config.jsonc
    logo = {
      source = "nixos_small"; # nixos_small #nixos_old
      padding = {
        right = 1;
      };
    };
    display = {
      size = {
        binaryPrefix = "si";
      };
      # color = "blue";
      # separator = "  ";
      separator = " ";
      color = {
        keys = "blue"; # Key color
        title = "red"; # Title color
      };
      bar = {
        width = 10; # Width of percentage bars
        charElapsed = "■"; # Character for elapsed portion
        charTotal = "-"; # Character for total portion
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
      {
        type = "os";
        key = "OS";
        keyColor = "cyan";
        format = "{name} {version}";
      }
      {
        "type" = "cpu";
        "format" = "{name} ({cores-physical}C/{cores-logical}T) @ {freq-max}";
      }
      "gpu"
      "disk"
      "de"
      "wm"
      # "break"
      "player"
      # "media"
      {
        "type" = "media";
        "key" = "NOW PLAYING";
        "format" = "{?artist}{artist} - {?}{title}";
        "keyColor" = "cyan";
      }
      # "break"
      {
        "type" = "display";
        "key" = "MONITOR ({name})";
        "keyColor" = "blue";
        # "format" = "{width}x{height} @ {refresh-rate} Hz - {physical-width}x{physical-height} mm ({inch} inches, {ppi} ppi)";
        "format" = "{width}x{height} @ {refresh-rate} Hz";
      }
      "uptime"
      # "packages"
    ];
  };
}
