{ lib, config, ... }: {
  services.snapper = lib.mkIf (config.networking.hostName == "carthage") {
    # systemd.time(7)
    snapshotInterval = "daily";
    snapshotRootOnBoot = true;
    cleanupInterval = "1d";
    persistentTimer = true;
    configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "malu" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "0";
        TIMELINE_LIMIT_DAILY = "1";
        TIMELINE_LIMIT_WEEKLY = "2";
        TIMELINE_LIMIT_MONTHLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";
      };
    };
  };
}
