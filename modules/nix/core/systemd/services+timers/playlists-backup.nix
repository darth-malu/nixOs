{ pkgs, ... }:

{
  systemd = {
    services = {
      "playlists-backup" = {
        description = "Backup ncmpcpp playlists to /media/Hyogo";
        script = ''
          ${pkgs.rsync}/bin/rsync -a --delete \
            /home/malu/Music/ncmpcpp/playlists/ \
            /media/Hyogo/Backups/ncmpcpp/playlists/
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "malu";
        };
      };
    };
    timers = {
      "playlists-backup" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "hourly";
          Persistent = true;
        };
      };
    };
  };
}
