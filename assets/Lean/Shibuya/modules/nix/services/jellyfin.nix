# { config, lib, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    # cacheDir = "~/.cache/jellyfin-server-cache";
    user = "malu";
    # hardwareAcceleration = {
    #   enable = true;
    # };
  };
}
