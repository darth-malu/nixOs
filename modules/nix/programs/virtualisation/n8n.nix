{ config, lib, ... }:

{
  options.n8n = {
    enable = lib.mkEnableOption "Enable custom n8n";
  };

  config = lib.mkIf config.n8n.enable {
    services.n8n = {
      enable = if config.networking.hostName == "tangier" then false else true;
      openFirewall = true;
      # settings = ;
    };
  };
}
