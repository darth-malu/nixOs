{ config, pkgs, ... }:
{
  options.tailscale = {
    enable = pkgs.lib.mkEnableOption "Enable my tailscale module :)";
  };

  config = pkgs.lib.mkIf config.tailscale.enable {
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

    # services.resolved.enable = true; # DNS fix addition

    services.networkd-dispatcher = {
      enable = false;
      rules."50-tailscale-optimizations" = {
        onState = [ "routable" ];
        script = ''
          ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };

    # 3. Optimization: Prevent systemd from waiting for network online
    # (Optional but recommended for faster boot with VPNs)
    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;
  };
}
