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
          "remotebuild"
        ]; # [ "user1" "user2 "] or null(all users allowed)::
        # AllowUsers = null; # works
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
