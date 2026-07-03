{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # ./nextcloud.nix
    # ./sync-thing
    ./android
    ./gaming
    ./gnupg.nix
    ./less.nix
    ./localsend.nix
    ./virtualisation
    ./pkgs.nix
  ];

  # nextcloud.enable = true;

  steamy.enable = true;
}
