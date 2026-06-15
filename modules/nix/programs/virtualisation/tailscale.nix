{ config, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    #authKeyFile = "/run/secrets/tailscale_key"; # preauthorized key
  };
  networking = {
    nftables.enable = true;
    firewall = {
      enable = true;
      # Always allow traffic from your Tailscale network
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      # Allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  environment.systemPackages = with pkgs; [
    ethtool
  ];

  services.networkd-dispatcher = {
    enable = true;
    rules."50-tailscale-optimizations" = {
      onState = [ "routable" ];
      script = ''
        ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
      '';
    };
  };
}
