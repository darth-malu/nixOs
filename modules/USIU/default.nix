{pkgs, pkgs-unstable, lib, config, ...}:
{

  environment.systemPackages = with pkgs-unstable; [
    # ciscoPacketTracer8
    ciscoPacketTracer7
  ];

  users.users.malu.extraGroups = ["kvm" "adbusers"];

}
