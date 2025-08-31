{ pkgs, ... }:
{
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ ];
  services = {
    openssh = {
      enable = true;
      openFirewall = true; # automatically open ports in firewall
      # ports = [ 22 ]; # 16bit unsigned int
      startWhenNeeded = true; # socket activated
      settings = {
        #LogLevel = "DEBUG";
        PasswordAuthentication = true; # def: false=require public key auth?
        PermitRootLogin = false; # By default, root logins using a password are disallowed. They can be disabled entirely by setting services.openssh.settings.PermitRootLogin to "no".
        UseDns = true; # false::
        AllowUsers = [
          "malu"
          "git"
          "remotebuild"
        ]; # [ "user1" "user2 "] or null(all users allowed)::
        # AllowUsers = null; # works
      };
      # authorizedKeysInHomedir = true;
      # authorizedKeysFiles = [ "/home/malu/Documents/authorized_keys" ];
    };
  };
}
