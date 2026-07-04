{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    snapper-gui
    # snapper
  ];
  services.snapper = {
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
      };
      nix = {
        SUBVOLUME = "/nix";
        ALLOW_USERS = [ "malu" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
    };
  };
}

# NOTE
# You need to create a snapshots subvolume inside the subvolume you would like to back up
