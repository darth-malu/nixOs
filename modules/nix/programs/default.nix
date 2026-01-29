{
  imports = [
    ./pkgs.nix
    # ./sync-thing
    ./direnv.nix
    ./gnupg.nix
    ./less.nix
    ./nextcloud.nix
  ];

  nextcloud.enable = false;
}
