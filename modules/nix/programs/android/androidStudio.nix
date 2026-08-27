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
        "34.0.0"
        "35.0.0"
      ];
      cmdLineToolsVersion = "22.0"; # sdkmanager / avdmanager
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

  environment.systemPackages =
    (with pkgs; [
      jdk21 # Gradle 8.14 supports up to Java 24; jdk25 is too new, jdk17 also works
      jdk17
      gradle
    ])
    ++ lib.optionals onCarthage [
      androidSdk # provides adb (platform-tools), aapt2, avdmanager...
    ];

  environment.sessionVariables = lib.mkIf onCarthage {
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk21}/lib/openjdk";
  };

  users.users.malu.extraGroups = lib.mkIf onCarthage [
    # needed for the Android emulator (KVM); harmless if unused
    "kvm"
  ];
  # USB device access (adb/fastboot) is handled automatically by systemd >= 258
  # uaccess rules (see 70-uaccess.rules); no adbusers group or custom udev rules.
}
