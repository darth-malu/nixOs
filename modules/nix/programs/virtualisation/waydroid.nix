{
  lib,
  pkgs,
  ...
}:

{
  options.waydroid.enable = lib.mkEnableOption "Enable Waydroid";
  config.virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
    /*
      Fetch Waydroid images.
      You can add the parameters "-s GAPPS -f" to have GApps support.
      $ sudo waydroid init
    */
  };
  environment.systemPackages = [ pkgs.waydroid-helper ];

  systemd = {
    packages = [ pkgs.waydroid-helper ];
    services.waydroid-mount.wantedBy = [ "multi-user.target" ];
  };
}
