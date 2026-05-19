{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    # androidenv.androidPkgs.androidsdk
    jdk25_headless
    steam-run
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  users.users.malu.extraGroups = [
    "kvm"
    "adbusers"
  ];
}
