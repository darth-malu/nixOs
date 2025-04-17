{
  services = {
    openssh = {
      # sshd.enable alias
      enable = true;
      openFirewall = true; # automatically open ports in firewall
      # ports = [ 22 ]; # 16bit unsigned int
      startWhenNeeded = true;
      settings = {
        #LogLevel = "DEBUG";
        PasswordAuthentication = true; # def: false=require public key auth?
        UseDns = true; # false::
        AllowUsers = [
          "malu"
          "git"
        ]; # [ "user1" "user2 "] or null(all users allowed)::
        # AllowUsers = null; # works
      };
      knownHosts = {
        emacsRepo = {
          hostNames = [
            "github.com"
          ];
          publicKeyFile = ./public-keys/emacs.pub; # TODO test if this is working
        };
      };
      # authorizedKeysInHomedir = true;
      # authorizedKeysFiles = [ "/home/malu/Documents/authorized_keys" ];
      extraConfig = import ./extraConf.nix;
    };
  };
}
