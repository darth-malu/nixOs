{ pkgs ? import <nixpkgs> {config.android_sdk.accept_license = true; config.allowUnfree = true;} }:

let
  androidSdk = androidenv.androidPkgs.androidsdk;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    androidSdk
    glibc
  ];
  # override the aapt2 that gradle uses with the nix-shipped version
  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/28.0.3/aapt2";
}