{
  # client will use this account on the remote
  # ENable distributed builds on client
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNI0lfUg8UYuCG6v48Li4iGL2uAsM5V8GpkRViT4V+B malu@tangier"
    ]; # tangier/remote machine ssh key
  };

  users.groups.remotebuild = { };

  nix.settings.trusted-users = [
    "remotebuild"
    "malu"
  ];

  # nixos-rebuild boot --target-host malu@192.168.100.3 --use-remote-sudo --flake ~/Shibuya#tangier --ask-sudo-password # from tangier
}
