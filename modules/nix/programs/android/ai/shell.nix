{
  pkgs ? import <nixpkgs> {
    config = {
      android_sdk.accept_license = true;
      allowUnfree = true;
      allowUnfreePredicate =
        pkg:
        builtins.elem (pkgs.lib.getName pkg) [
          "android-sdk-cmdline-tools"
          "androidsdk"
        ];
    };
  },
}:

let
  androidSdk = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [
      "35"
      "34"
    ];
    buildToolsVersions = [ "35.0.0" ];
    abiVersions = [
      "arm64-v8a"
      "x86_64"
    ];
    includeNDK = true;
    ndkVersions = [ "27.1.12297006" ];
    includeCmake = true;
    cmakeVersions = [ "3.22.1" ];
  };
in
pkgs.mkShell {
  name = "vaite-android-eas";

  buildInputs = with pkgs; [
    androidSdk.androidsdk
    jdk17
    # nodejs_22
    nodejs
    bun
    git
    curl
    unzip
    glibc
  ];

  shellHook = ''
    export ANDROID_HOME="${androidSdk.androidsdk}/libexec/android-sdk"
    export ANDROID_SDK_ROOT="$ANDROID_HOME"
    export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/27.1.12297006"
    export JAVA_HOME="${pkgs.jdk17.home}"
    export PATH="$JAVA_HOME/bin:$PATH"
  '';
}
