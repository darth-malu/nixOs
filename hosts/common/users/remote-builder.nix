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

  # programs.ssh.extraConfig = ''
  #   Host carthage
  #     HostName 192.168.100.5
  #     Port 22
  #     User remotebuild
  #     IdentitiesOnly yes
  #     IdentityFile /home/malu/.ssh/id_ed25519.pub
  # '';
}
