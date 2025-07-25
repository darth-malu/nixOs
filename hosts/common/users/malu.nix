{ pkgs, ... }:

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
      "input"
      "darth"
      "wheel"
      "networkmanager" # allow access to the NetworkManager daemon and be able to configure and add new networks
      #"video" #backlight control
      #"audio"

      # android
      "adbusers" # grand user access to Android Debug Bridge
      "kvm"
    ];
    packages = with pkgs; [
      firefox
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJXqFrWf3rqkudQ6+aBFXkWpZcAm9HW9oHZclRwtGI8G justinmalu@gmail.com" # c
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKubRXSOrk4IrM4Ai3FcvWFVV1wxRUNPF+0VZo9xSph1 darth-malu@github.com" # t
    ];
    # openssh.authorizedKeys.keyFiles = [
    #   ./open_key
    # ];
  };

  users.groups = {
    darth.gid = 1000; # instantiate group darth #TODO: see groups id range implications
  };
  programs.command-not-found.enable = false;
}
