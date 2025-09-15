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
}
