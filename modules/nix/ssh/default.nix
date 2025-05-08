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
          # publicKeyFile = ./public-keys/emacs.pub; # TODO test if this is working
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRszOn4mMS5HCMwLch6Wqbb1qCsapem5woNxx/U4LRA emacs stuff";
        };
        orgRoam = {
          hostNames = [
            "github.com"
          ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE58JjkxBtMXnMAkyYLEnp5lto+XlL6spllX6LaDaauA will this work";
        };
        org = {
          hostNames = [
            "github.com"
          ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1gX5yQAnTy9O1d1KXjcWSgVC6QtBXta8lJ+Q9b663u org";
        };
      };
      # authorizedKeysInHomedir = true;
      # authorizedKeysFiles = [ "/home/malu/Documents/authorized_keys" ];
      # extraConfig = import ./extraConf.nix; # FIXME check source of errors?
    };
  };
}
