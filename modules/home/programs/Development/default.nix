{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./direnv.nix
    # ./editorconfig.nix
    ./bun.nix
  ];
}
