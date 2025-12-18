{
  imports = [
    ./pkgs.nix
    ./sync-thing
    ./gnupg.nix
    ./less.nix
    ./nextcloud.nix
    # ./nvf.nix
  ];

  nextcloud.enable = true;
}
