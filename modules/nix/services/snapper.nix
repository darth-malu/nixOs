{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # snapper-gui
    # snapper
  ];
  services.snapper = {
    # systemd.time(7)
    snapshotInterval = "hourly";
    snapshotRootOnBoot = true;
    cleanupInterval = "1d";
    persistentTimer = true;
    configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "malu" ];
        TIMELINE_CREATE = true; # NOTE This is what enables automatic snapshots
        TIMELINE_CLEANUP = true;
        # Define exact limits so your drive doesn't bloat
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "0";
        TIMELINE_LIMIT_MONTHLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";
      };
      # NOTE: Just use generations for this since its mostly the store
      nix = {
        SUBVOLUME = "/nix";
        ALLOW_USERS = [ "malu" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        # Define exact limits so your drive doesn't bloat
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "0";
        TIMELINE_LIMIT_MONTHLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";
      };
    };
  };
}

# NOTE
# You need to create a snapshots subvolume inside the subvolume you would like to back up
