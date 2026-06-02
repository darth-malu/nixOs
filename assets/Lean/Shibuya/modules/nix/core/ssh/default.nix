{ pkgs, config, ... }:
{
  # systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ ];
  services = {
    openssh = {
      enable = true;
      openFirewall = true; # automatically open ports in firewall
      # ports = [ 22 ]; # 16bit unsigned int
      startWhenNeeded = true; # socket activated
      settings = {
        #LogLevel = "DEBUG";
        PasswordAuthentication = false; # true:: def: if false require public key authentication
        PermitRootLogin = "no"; # By default, root logins using a password are disallowed. They can be disabled entirely by setting services.openssh.settings.PermitRootLogin to "no".
        UseDns = true; # false::
        AllowUsers = [
          "malu"
          "git"
          "remotebuild"
        ]; # [ "user1" "user2 "] or null(all users allowed)::
      };
      # extraConfig = ''
      #   Host carthage
      #   HostName 192.168.100.122
      #   User malu
      #   IdentityFile ~/.ssh/id_ed25519
      # '';
    };
  };
}

# To improve the security of your SSH server, it is recommended to apply the following measures:

# Disable password-based login
# Disable root login
# Restrict allowed users
# Change the default port
