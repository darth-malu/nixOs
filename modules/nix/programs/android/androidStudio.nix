{ pkgs, config, ... }:

{

  environment.systemPackages =
    with pkgs;
    [
    ]
    ++ lib.optionals (config.networking.hostName == "carthage") [
      android-studio
      android-tools
      # androidenv.androidPkgs.androidsdk
      # jdk25_headless
      jdk25
      steam-run
      gradle
      maven
    ];

  nixpkgs.config.android_sdk.accept_license = true;

  # environment.sessionVariables = {
  #   JAVA_HOME = "${pkgs.jdk25_headless}/lib/openjdk";
  # };

  users.users.malu.extraGroups = [
    "kvm"
    "adbusers"
  ];
}
