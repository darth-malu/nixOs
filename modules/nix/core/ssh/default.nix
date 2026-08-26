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
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no"; # By default, root logins using a password are disallowed. They can be disabled entirely by setting services.openssh.settings.PermitRootLogin to "no".
        UseDns = true; # false::
        AllowUsers = [
          "malu"
          "git"
          "remotebuild"
        ]; # [ "user1" "user2 "] or null(all users allowed)::
      };
      # Added after carthage reinstall — pinned so reinstalls only need rebuild
      knownHosts = {
        "carthage" = {
          hostNames = [ "carthage" "192.168.1.2" ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAG5e76Bmm84K1Xqd38o1TUBFbgvsj6/5wILkI3GQUV root@carthage";
        };
        "tangier" = {
          hostNames = [ "tangier" "192.168.1.5" ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9a9x3FJGsEmfZ6cC9dHrPZhL+qrnJarZ4BrPYrHtSX root@tangier";
        };
      };
    };
  };
}

# To improve the security of your SSH server, it is recommended to apply the following measures:

# Disable password-based login
# Disable root login
# Restrict allowed users
# Change the default port
