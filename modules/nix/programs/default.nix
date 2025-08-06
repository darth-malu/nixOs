{ config, ... }:
{
  imports = [
    ./pkgs.nix
    # ./sync-thing
  ];

  config = {
    steamy.enable = if config.networking.hostName == "carthage" then true else false;
    qemuNix.enable = if config.networking.hostName == "carthage" then true else false;
  };
}
