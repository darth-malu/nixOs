{
  pkgs,
  config,
  lib,
  ...
}:

let
  # Declarative Android SDK. Versions pinned to match the Vaite project
  # (Expo SDK 54 / React Native 0.81). Only evaluated on the host that needs
  # it (carthage) to avoid pulling the ~4 GB SDK onto tangier.
  androidSdk =
    (pkgs.androidenv.composeAndroidPackages {
      platformVersions = [ "35" ]; # compileSdkVersion set in app.json expo-build-properties
      buildToolsVersions = [
        "35.0.0"
        "36.0.0" # react-native/gradle/libs.versions.toml: buildTools = "36.0.0"
      ];
      cmdLineToolsVersion = "22.0"; # sdkmanager / avdmanager
      cmakeVersions = [ "3.22.1" ]; # AGP resolves cmake;3.22.1 for RN native modules
      includeNDK = true;
      ndkVersions = [ "27.1.12297006" ]; # react-native/gradle/libs.versions.toml
      includeEmulator = false;
      includeSystemImages = false;
      includeSources = false;
    }).androidsdk;

  onCarthage = config.networking.hostName == "carthage";
in
{
  # Accept the android-sdk-license (read by androidenv/license.nix)
  nixpkgs.config.android_sdk.accept_license = true;

  # Gradle/AGP download third-party binaries (aapt2, ...) that are dynamically
  # linked against generic-linux glibc; let them run on NixOS.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    zlib
    stdenv.cc.cc.lib
  ];

  environment.systemPackages =
    (with pkgs; [
      jdk17 # RN 0.81 / Kotlin 2.1 / Gradle 8.14 all target JDK 17
      gradle
    ])
    ++ lib.optionals onCarthage [
      androidSdk # provides adb (platform-tools), aapt2, avdmanager...
      android-studio-full
    ];

  environment.sessionVariables = lib.mkIf onCarthage {
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
  };

  users.users.malu.extraGroups = lib.mkIf onCarthage [
    # needed for the Android emulator (KVM); harmless if unused
    "kvm"
  ];
  # USB device access (adb/fastboot) is handled automatically by systemd >= 258
  # uaccess rules (see 70-uaccess.rules); no adbusers group or custom udev rules.
}
