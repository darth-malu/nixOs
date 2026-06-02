{ osConfig, ... }:
{
  services.kdeconnect = {
    enable = if osConfig.networking.hostName == "tangier" then false else true;
    indicator = true;
  };
}
