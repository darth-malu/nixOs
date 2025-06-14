{pkgs, lib, ...}:
{

programs.adb = {
  enable = true;
};

environment.systemPackages = with pkgs; [
  android-studio
  # android-tools
  # androidenv.androidPkgs_9_0.platform-tools
  # androidenv.androidPkgs.all.packages.platforms.v36
];

  users.users.malu.extraGroups = ["kvm" "adbusers"];

}
