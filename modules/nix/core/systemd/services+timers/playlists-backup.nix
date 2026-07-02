{ pkgs, ... }:

{
  systemd = {
    services = {
      "playlists-backup" = {
        description = "Backup ncmpcpp playlists to /media/Hyogo";
        script = ''
          if [ -d "/home/malu/Music/ncmpcpp/playlists" ] && [ "$(ls -A /home/malu/Music/ncmpcpp/playlists)" ]; then
            ${pkgs.rsync}/bin/rsync -a --delete \
              /home/malu/Music/ncmpcpp/playlists/ \
              /media/Hyogo/Backups/ncmpcpp/playlists/
          else
            echo "Backup skipped: Source directory is missing or empty."
          fi
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
