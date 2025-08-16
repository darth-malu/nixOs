{
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{

  programs.adb = {
    enable = true;
  };

  environment.systemPackages = [
    # (pkgs-unstable.ciscoPacketTracer8.override {
    #   # packetTracerSource = ../Downloads/Packet_Tracer822_amd64_signed.deb;
    #   packetTracerSource = ../../../Downloads/Packet_Tracer822_amd64_signed.deb;
    # })
    # pkgs-unstable.ciscoPacketTracer8
    # (pkgs.ciscoPacketTracer8.overrideAttrs {
    #   dontCheckForBrokenSymlinks = true;
    # })
    pkgs.android-studio
  ];
  # if config.networking.hostName == "carthage" then
  #   [
  #     pkgs.android-studio-full
  #   ]
  # else
  #   [ pkgs.android-studio ];
  # android-tools
  # androidenv.androidPkgs_9_0.platform-tools
  # androidenv.androidPkgs.all.packages.platforms.v36

  users.users.malu.extraGroups = [
    "kvm"
    "adbusers"
  ];

  # Packet tracer log in can be subverted if there is no internet connection
  # so use firejail to isolate packet tracer into its own network namespace
  # when running
  # programs.firejail = {
  #   enable = true;
  #   wrappedBinaries = {
  #     packettracer8 = {
  #       executable = lib.getExe pkgs.ciscoPacketTracer8;

  #       # Will still want a .desktop entry as the package is not directly added
  #       desktop = "${pkgs.ciscoPacketTracer8}/share/applications/cisco-pt8.desktop.desktop";

  #       extraArgs = [
  #         # This should make it run in isolated netns, preventing internet access
  #         "--net=none"

  #         # firejail is only needed for network isolation so no futher profile is needed
  #         "--noprofile"

  #         # Packet tracer doesn't play nice with dark QT themes so this
  #         # should unset the theme. Uncomment if you have this issue.
  #         # ''--env=QT_STYLE_OVERRIDE=""''
  #       ];
  #     };
  #   };
  # };
}
