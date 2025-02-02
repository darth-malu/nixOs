{pkgs, ...}:

{
    users.users.git = {
      isSystemUser = true;
      group = "git";
      home = "/var/lib/git-server";
      createHome = true;
      shell = "${pkgs.git}/bin/git-shell";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMSBfohKDgESEi8FWDnmW4/amgQZJo1t+nOOhqEzJReD malu@carthage"];
      #openssh.authorizedKeys.keys = [
        #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF38sHxXn/r7KzWL1BVCqcKqmZA/V76N/y5p52UQghw7 example"
      #];
    };

    users.groups.git = {};
    #example use: sudo -u git bash -c "git init --bare ~/myproject.git" where ~ is defined home
}
