{ config, ... }:
{
  services.n8n = {
    enable = if config.networking.hostName == "tangier" then false else true;
    openFirewall = true;
    # settings = ;
  };
}
