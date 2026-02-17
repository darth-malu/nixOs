{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keyFiles = [ ./remotebuild.pub ]; # remote machine ssh key
  };

  users.groups.remotebuild = { };

  nix.settings.trusted-users = [
    "remotebuild"
    "malu"
  ];

  # nixos-rebuild boot --target-host malu@192.168.100.3 --use-remote-sudo --flake ~/Shibuya#tangier --ask-sudo-password
}
