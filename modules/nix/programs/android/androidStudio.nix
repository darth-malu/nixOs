{
  config,
  lib,
  pkgs,
  ...
}:

{
  /*
    https://wiki.nixos.org/wiki/Android
    NixOS uses the androidenv package for building android SDKs and manually creating emulators without the use of Android Studio.
    Example android sdk is androidenv.androidPkgs.androidsdk
    They also include all of the SDK tools such as sdkmanager and avdmanager needed to create emulators.

    # RUnning apps -> steam-run ~/Android/Sdk/emulator/emulator -feature -Vulkan @Pixel_5_API_33

    # ADB
    Previously you would need use programs.adb.enable = true; and users.users.<your-user>.extraGroups = [ "adbusers" ]; to add ADB to your PATH and configure access rules. This option is no longer needed as systemd 258 handles uaccess rules for ADB and fastboot automatically.

    # https://nixos.org/manual/nixpkgs/unstable/#android
  */

  users.users.malu.extraGroups = [
    "kvm"
    "adbusers"
  ];

  # programs.adb.enable = true; #no longer works?

  environment.systemPackages = with pkgs; [ android-studio-full ];

  nixpkgs.config.android_sdk.accept_license = true;
}
