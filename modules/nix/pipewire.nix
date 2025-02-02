{
  services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = false; # check if needed
      };
      wireplumber.enable = true;
      #extraConfig.pipewire."92-low-latency" = {
        #"context.properties" = {
        #"default.clock.rate" = 48000;
        #"default.clock.quantum" = 32;
        #"default.clock.min-quantum" = 32;
        #"default.clock.max-quantum" = 32;
        #};
      #};
    };
}
