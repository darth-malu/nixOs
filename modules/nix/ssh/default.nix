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
    openssh = {
      # sshd.enable alias
      enable = true;
      openFirewall = true; # automatically open ports in firewall
      # ports = [ 22 ]; # 16bit unsigned int
      # package = pkgs-unstable.openssh;
      startWhenNeeded = true;
      settings = {
        #LogLevel = "DEBUG";
        PasswordAuthentication = true; # def: false=require public key auth?
        # PubkeyAuthentication = true; FIXME: causing issues??
        # KbdInteractiveAuthentication = false; # true::
        #AllowUsers = null; # all users::
        # PermitRootLogin = "yes"; # Allow password login to the installation, if the user sets a password via "passwd" It is safe as root doesn't have a password by default and SSH is disabled by default
        # X11Forwarding = false; # false::
        UseDns = true; # false::
        # PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password"::, "forced-commands-only", "no"
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
          publicKeyFile = ./public-keys/emacs.pub;
        };
      };
      # authorizedKeysInHomedir = true;
      #authorizedKeysFiles = [ "$HOME/.ssh/id_ed25519.pub" ];
      # authorizedKeysFiles = [ "/home/malu/Documents/authorized_keys" ];
      #extraConfig = ''
      #Match user git
      #AllowTcpForwarding no
      #AllowAgentForwarding no
      #PermitTTY no
      #'';
      # extraConfig = ''
      #   Host emacsGit
      #   HostName github.com
      #   User git
      #   IdentityFile ~/.ssh/emacs

      #   Host orgGit
      #   HostName github.com
      #   User git
      #   IdentityFile ~/.ssh/org-roam
      # '';
    };
  };
}
