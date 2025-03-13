{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotask";

    openssh.authorizedKeys.keyFiles = [ ./remotebuild ]; # ssh key of the builder that will use the builder
  };

  users.groups."remotebuild" = {};
  users.groups."remotask" = {}; # TODO see if this "" is the ideal

  nix.settings.trusted-users = [ "remotebuild" ];

  programs.ssh.extraConfig = ''
  Host carthage
    HostName 192.168.100.5
    Port 22
    User remotebuild
    IdentitiesOnly yes
    IdentityFile /home/malu/.ssh/id_ed25519.pub
  '';
}
