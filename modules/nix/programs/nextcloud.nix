{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    nextcloud.enable = lib.mkEnableOption "Enable Next Cloud";
  };

  config = lib.mkIf config.nextcloud.enable {
    environment.etc."nextcloud-admin-pass".text = "abcd1234"; # writes out to /etc/nextcloud-admin-pass
    services.nextcloud = {
      enable = true;
      autoUpdateApps.enable = true;
      package = pkgs.nextcloud32; # Instead of using pkgs.nextcloud28Packages.apps,
      # we'll reference the package version specified above
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          news
          contacts
          calendar
          # tasks
          ;
      };
      extraAppsEnable = true;
      configureRedis = true;
      hostName = "localhost";
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "sqlite";
      };
      settings = {
        trusted_domains = [
          "192.168.100.56"
        ];
      };
    };
  };
}
