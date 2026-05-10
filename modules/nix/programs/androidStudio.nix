{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    # androidenv.androidPkgs.androidsdk
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  users.users.malu.extraGroups = [
    "kvm"
    "adbusers"
  ];
}
