{
  # programs.ssh = {
  #   package = pkgs-unstable.openssh;
  #   startAgent = true; 
  # };

  # programs.gnupg.agent = {
  #   enable = false;
  #   enableSSHSupport = true;
  # };

  # systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  # programs.ssh.package = pkgs-unstable.openssh;
  services = {
    openssh = { # sshd.enable alias
      enable = true;
      openFirewall = true; # automatically open ports in firewall 
      # package = pkgs-unstable.openssh;
      startWhenNeeded = true;
      # ports = [ 22 443 ]; # 16bit unsigned int
      #ports = [ 22 ]; # 16bit unsigned int
      settings = {
        #LogLevel = "DEBUG";
        PasswordAuthentication = false; # def: false=require public key auth?
        # PubkeyAuthentication = true;
        KbdInteractiveAuthentication = false;
        #AllowUsers = null; # all users::
        PermitRootLogin = "yes"; # Allow password login to the installation, if the user sets a password via "passwd" It is safe as root doesn't have a password by default and SSH is disabled by default
        X11Forwarding = false;
        #UseDns = true; #default false
        # PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
        #AllowUsers = ["malu" "git" ]; # [ "user1" "user2 "] or null(all users allowed)
      };
      authorizedKeysInHomedir = true;
      #authorizedKeysFiles = [ "$HOME/.ssh/id_ed25519.pub" ];
      authorizedKeysFiles = [ "/home/malu/Documents/authorized_keys" ];
      #authorizedKeysFiles = [ /home/malu/.ssh/id_ed25519.pub ];
      #extraConfig = ''
        #Match user git
          #AllowTcpForwarding no
          #AllowAgentForwarding no
          #PermitTTY no
      #'';
    };
  };
}
