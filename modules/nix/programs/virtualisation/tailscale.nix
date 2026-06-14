{
  services.tailscale = {
    enable = true;
    # Enable tailscale at startup

    # If you would like to use a preauthorized key
    #authKeyFile = "/run/secrets/tailscale_key";

  };
}
