{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keyFiles = [ ./remotebuild.pub ];
  };

  users.groups.remotebuild = {};

  nix.settings.trusted-users = [ "remotebuild" ];

  programs.ssh.extraConfig = ''
  Host builder
    HostName <url of the host>
    Port 2222
    User remotebuild
    IdentitiesOnly yes
    IdentityFile /root/.ssh/id_builder
  '';
}
