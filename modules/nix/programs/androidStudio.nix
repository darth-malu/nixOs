{ pkgs, ... }:

{

  environment.systemPackages = [
    pkgs.android-studio
    pkgs.android-tools
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  users.users.malu.extraGroups = [
    "kvm"
    "adbusers"
  ];
}
