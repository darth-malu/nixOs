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
