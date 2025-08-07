{
  pkgs,
  ...
}:
{

  programs.adb = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.android-studio ];
  # if config.networking.hostName == "carthage" then
  #   [
  #     pkgs.android-studio-full
  #   ]
  # else
  #   [ pkgs.android-studio ];
  # android-tools
  # androidenv.androidPkgs_9_0.platform-tools
  # androidenv.androidPkgs.all.packages.platforms.v36

  users.users.malu.extraGroups = [
    "kvm"
    "adbusers"
  ];

}
