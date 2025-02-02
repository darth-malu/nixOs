{pkgs-unstable, ... }:
{
  #services.ssh-agent.enable = true;
  programs.git = {#NOTE: with openssh
    enable = true;
    package = pkgs-unstable.git;
    userName = "darth malu"; #darth-malu
    userEmail = "darth-malu@github.com";
    ignores = ["*.swp"];
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    extraConfig = {
      init.defaultBranch = "main";
      #push = { autoSetupRemote = true; }; # does --set-upstream origin to current branch
      #credential.helper = "${pkgs-unstable.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      #safe.directory = "/etc/nixos";
    };
  };
}
