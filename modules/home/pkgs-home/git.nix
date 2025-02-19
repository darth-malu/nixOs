{
  programs.git = {#NOTE: with openssh
    enable = true;
    userName = "darth malu"; #darth-malu
    userEmail = "darth-malu@github.com";
    ignores = ["*.swp"];
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
      p = "push";
    };
    extraConfig = {
      init.defaultBranch = "shibuya";
      #push = { autoSetupRemote = true; }; # does --set-upstream origin to current branch
      #credential.helper = "${pkgs-unstable.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      #safe.directory = "/etc/nixos";
    };
  };
}
