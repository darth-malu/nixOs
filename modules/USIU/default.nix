{pkgs, lib, ...}:
{

programs.adb = {
  enable = true;
};

environment.systemPackages = with pkgs; [
  android-studio
  # androidenv.androidPkgs_9_0.platform-tools
];

}
