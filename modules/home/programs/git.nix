{
  programs.delta = {
    enable = true;
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

  programs.diff-highlight = {
    enableGitIntegration = true; # Autoenabling is disabled
    pagerOpts = [
      "--tabs=4"
      "-RFX"
    ];
  };

  programs.git-credential-oauth = {
    enable = false;
    extraFlags = [ "-device" ];
  };

  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true; # does --set-upstream origin to current branch
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrwiQoWlBZ5OCuw8pF2CWM1iJjI4pW5FZvq5b5RktOH Tangier";
        signByDefault = true;
      };
      settings = {
        gpg = {
          format = "ssh";
        };
      };
      user = {
        name = "darth-malu";
        email = "justinmalu@gmail.com";
      };
      #credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      #safe.directory = "/etc/nixos";
    };
    ignores = [
      "*.swp"
      ".stfolder.*"
      ".stfolder*"
      "*org-roam.db"
      "brain/"
    ];
    # aliases = {
    #   ci = "commit";
    #   co = "checkout";
    #   s = "status";
    #   p = "push";
    # };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "carthage" = {
        identityFile = "~/.ssh/id_ed25519";
        user = "malu";
        # identitiesOnly = true;
      };
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}
