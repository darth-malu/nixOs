{
  imports = [
    # ./nextcloud.nix
    # ./sync-thing
    ./android
    ./gaming
    ./gnupg.nix
    ./less.nix
    # ./localsend.nix
    ./virtualisation
    ./pkgs.nix
    ./manPages.nix
  ];

  # nextcloud.enable = true;

  steamy.enable = true;
}
