{
  pkgs,
  osConfig,
  lib,
  config,
  ...
}:

{
  imports = [
    ./qt.nix
    ./gtk.nix
    ./homePointer.nix
  ];
}
