{ pkgs, config, ... }:

{
  users.mutableUsers = false; # false -> disable useradd group add
  # defaultUserShell = pkgs.zsh;
  users.users.malu = {
    isNormalUser = true;
    hashedPassword = "$6$CBR4aPX655swD4cc$ajk7oboxdtZVH5bBF2eQYOCV6Zkg67LFeRKTuMkLjjTjic6xn1.fJGeq03wWkOdiQbZeuoYVjQoMbBmxOM1qt1"; # mkpasswd <password> -m SHA-512
    uid = 1000;
    homeMode = "755";
    description = "Darth Malu"; # appears as kde user
    shell = pkgs.bash;
    #useDefaultShell = true;
    extraGroups = [
      # user implicity in users group
      "input"
      "darth"
      "wheel"
      "networkmanager" # allow access to the NetworkManager daemon and be able to configure and add new networks # change networkmanager settings in general
      "video" # backlight control, NOTE trouble accessing /dev/dri
      "render" # mesa stuff
      #"audio"
      "gamemode"
      # "docker"
      # "kvm" # ?android nonly?
    ]
    ++ (pkgs.lib.optionals config.hardware.openrazer.enable [
      "openrazer"
    ]);
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQMlSKPdJ2PxIxxCI5CMCNHmrZ7GvuwGfdow9CoZoqx Carthage"

      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrwiQoWlBZ5OCuw8pF2CWM1iJjI4pW5FZvq5b5RktOH Tangier"
    ];
  };

  users.groups.darth.gid = 1000;
  programs.command-not-found.enable = false;
}
