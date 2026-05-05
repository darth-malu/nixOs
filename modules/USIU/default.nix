{pkgs, lib, config, ...}:
{

# android_sdk.accept_license = true;
nixpkgs.config.android_sdk.accept_license = true;

  users.users.malu.extraGroups = ["kvm" "adbusers"];

}
