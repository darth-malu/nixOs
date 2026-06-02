{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.podman = {
    enable = true;
  };
}
