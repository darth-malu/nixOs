{pkgs, lib, config, ...}:
{

programs.adb = {
  enable = true;
};

environment.systemPackages = [pkgs.android-studio-full ];
# if config.networking.hostName == "carthage" then
#   [
#     pkgs.android-studio-full
#   ]
# else
#   [ pkgs.android-studio ];
# android-tools
# androidenv.androidPkgs_9_0.platform-tools
# androidenv.androidPkgs.all.packages.platforms.v36

android_sdk.accept_license = true;

  users.users.malu.extraGroups = ["kvm" "adbusers"];

}
