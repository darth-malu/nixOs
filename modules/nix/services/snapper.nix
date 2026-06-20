{
  services.snapper = {
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
      };
    };
  };
}
