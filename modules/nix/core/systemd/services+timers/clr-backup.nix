{ pkgs }:

{
  systemd = {
    services = {
      "clr-backup" = {
        description = "Clean up home-manager backup files in .config";
        script = ''
          find /home/malu/.config -maxdepth 3 -type f -name '*.home_bak' -exec rm -v {} \;
        '';
        path = [ pkgs.findutils ];
        serviceConfig = {
          Type = "oneshot";
          User = "malu";
          RemainAfterExit = true; # Prevents service from start on rebuild
        };
      };
    };
    timers = {
      "clr-backup" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "weekly";
          Persistent = true;
        };
      };
    };
  };
}
