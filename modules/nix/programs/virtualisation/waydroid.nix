{
  lib,
  pkgs,
  ...
}:

{
  options.waydroid.enable = lib.mkEnableOption "Enable Waydroid";
  config = {
    virtualisation.waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
    environment.systemPackages = [ pkgs.waydroid-helper ];

    systemd = {
      packages = [ pkgs.waydroid-helper ];
      services.waydroid-mount.wantedBy = [ "multi-user.target" ];
    };
  };
}
