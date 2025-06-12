{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotasks";

    openssh.authorizedKeys.keyFiles = [ ./remotebuild ]; # ssh key of the machine that will use the builder
  };

  # users.groups."remotebuild" = { };
  users.groups."remotasks" = { }; # TODO see if this "" is the ideal

  nix.settings.trusted-users = [
    "remotebuild"
    "malu"
  ];
}
