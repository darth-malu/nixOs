{
  services.hyprsunset = {
    enable = true;
    extraArgs = [ "--verbose" ]; # ---identity
    # systemdTarget = "hyprland-session.target";
    settings = {
      max-gamma = 150; # 100::
      profile = [
        {
          time = "7:00";
          identity = true;
        }
        {
          time = "22:00";
          temperature = 5800; # 6000::
          # gamma = 0.8; # 1.0::
        }
      ];
    };
  };
}

/*
  // Blue light filter
  hyprctl hyprsunset temperature 2500
  Disable blue-light filter
  hyprctl hyprsunset identity

  //

  # Set gamma to 50%
  hyprctl hyprsunset gamma 50
  # Increase gamma by 10%
  hyprctl hyprsunset gamma +10
*/
