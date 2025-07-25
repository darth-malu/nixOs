{
  programs.git = {
    enable = true;
    userName = "darth-malu";
    userEmail = "darth-malu@github.com";
    ignores = [
      "*.swp"
      ".stfolder.*"
      "*org-roam.db"
      "brain/"
    ];
    diff-highlight = {
      enable = true;
      pagerOpts = [
        "--tabs=4"
        "-RFX"
      ];
    };
    delta = {
      enable = false;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
    # aliases = {
    #   ci = "commit";
    #   co = "checkout";
    #   s = "status";
    #   p = "push";
    # };
    extraConfig = {
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
      }; # does --set-upstream origin to current branch
      #credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      #safe.directory = "/etc/nixos";
    };
  };
}
