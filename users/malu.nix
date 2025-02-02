{pkgs ,...}:

{
  users = { 
    mutableUsers = false; # false -> useradd group add does not work
    # defaultUserShell = pkgs.zsh;
    users.malu = {
      isNormalUser = true;
      hashedPassword = "$6$CBR4aPX655swD4cc$ajk7oboxdtZVH5bBF2eQYOCV6Zkg67LFeRKTuMkLjjTjic6xn1.fJGeq03wWkOdiQbZeuoYVjQoMbBmxOM1qt1";# mkpasswd <password> -m SHA-512
      uid = 1000;
      homeMode = "755";
      # description = "my user lol"; # appears as kde user
      description = "Darth Malu";
      #shell = [ pkgs.zsh pkgs.nushell ];
      shell = pkgs.bash;
      #useDefaultShell = true;
      # shell = "${pkgs.bash}/bin/bash"; # does not work
      extraGroups = [
        "input"
        "darth"
        "wheel"
        "networkmanager"
        #"video" #backlight control
        #"audio"
      ];
      packages = with pkgs; [
        firefox
        tree
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMSBfohKDgESEi8FWDnmW4/amgQZJo1t+nOOhqEzJReD malu@carthage"
      ];
      # openssh.authorizedKeys.keyFiles = [
      #   ./open_key
      # ];
    };

    groups = {
      darth.gid = 1000; # instantiate group darth #TODO: see groups id range implications
    };
  };
}
