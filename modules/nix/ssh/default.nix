{
  services = {
    openssh = {
      # sshd.enable alias
      enable = true;
      openFirewall = true; # automatically open ports in firewall
      # ports = [ 22 ]; # 16bit unsigned int
      startWhenNeeded = true; # socket activated
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
        github.com-emacs = {
          hostNames = [
            "github.com"
          ];
          # publicKeyFile = ./public-keys/emacs.pub; # TODO test if this is working
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVixtVu6ZhXClAHrxX8pItL1aQ+A1YyxXTzeT+nAz58 malu@carthage";
        };
        github.com-org = {
          hostNames = [
            "github.com"
          ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmh48Y2HlE8/9yQpDul+064xIR3hQHjS9jTp6Ft7Mrh malu@carthage";
        };
      };

      # hostKeys = [
      # {
      #   bits = 4096;
      #   path = "/etc/ssh/ssh_host_rsa_key";
      #   type = "rsa";
      # openSSHFormat = true;
      # }
      # {
      #   path = "~/.ssh/trialNix";
      #   type = "ed25519";
      #   comment = "nix autoGen";
      #   # rounds = 100;
      # }
      # ];
      # authorizedKeysInHomedir = true;
      # authorizedKeysFiles = [ "/home/malu/Documents/authorized_keys" ];
      # extraConfig = import ./extraConf.nix; # FIXME check source of errors?
    };
  };
}
