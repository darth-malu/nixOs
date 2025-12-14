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
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      # Instead of using pkgs.nextcloud28Packages.apps,
      # we'll reference the package version specified above
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          news
          contacts
          calendar
          tasks
          ;
      };
      extraAppsEnable = true;
      hostName = "localhost";
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "sqlite";
      };
    };
  };
}
