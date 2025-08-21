# { config, ... }:
{
  services.n8n = {
    # enable = if config.networking.hostName == "tangier" then false else true;
    enable = true;
    openFirewall = true;
    # settings = ;
  };
}
