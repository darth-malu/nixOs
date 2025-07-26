{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./ssh
    ./Bash
    ./udev
    ./systemd
  ];
}
