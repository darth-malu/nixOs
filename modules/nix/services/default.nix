{
  imports = [
    ./flatpak.nix
    ./ratbagd+openrgb.nix
    # ./jellyfin.nix
    ./postgresql.nix
    # ./jackett.nix
    ./snapper.nix
  ];

  services = {
    locate.enable = true;
    gvfs.enable = true; # sets GIO_EXTRA_MODULES, used for accessing trash/network filesystems
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
      #extraConfig.pipewire."92-low-latency" = {#FIXME: crackling
      #"context.properties" = {
      #"default.clock.rate" = 48000;
      #"default.clock.quantum" = 32;
      #"default.clock.min-quantum" = 32;
      #"default.clock.max-quantum" = 32;
      #};
      #};
    };
    # dbus = {
    #   implementation = lib.mkDefault "broker"; #"broker" , "dbus"
    # };
  };
}
