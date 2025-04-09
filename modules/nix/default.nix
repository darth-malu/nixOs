{
  imports = [
    ./sync-thing
    ./system-pkgs.nix
    ./fonts.nix
    ./inputrc.nix
    ./ssh
    ./services_timers-systemd.nix
    # ./sync_thing.nix
    ./enVars.nix
    ./qemu
    # ../specialisations
  ];
}
