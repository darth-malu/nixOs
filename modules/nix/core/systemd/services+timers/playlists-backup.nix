{ pkgs, ... }:

{
  systemd = {
    services = {
      "playlists-backup" = {
        description = "Backup ncmpcpp playlists to /media/Hyogo";
        script = ''
          # Define paths for cleaner readability
          SRC_DIR="/home/malu/Music/ncmpcpp/playlists"
          DEST_DIR="/media/Hyogo/Backups/ncmpcpp/playlists"
          # Creates a unique folder name every day (e.g., .trash/2026-07-03)
          TRASH_DIR="/media/Hyogo/Backups/ncmpcpp/.trash/$(date +%F)"

          if [ -d "$SRC_DIR" ] && [ -n "$(find "$SRC_DIR" -maxdepth 1 -mindepth 1 -print -quit)" ]; then
            
            # Ensure target destinations exist
            mkdir -p "$DEST_DIR"
            mkdir -p "$TRASH_DIR"

            # Run rsync safely with an incremental trash backup
            "${pkgs.rsync}/bin/rsync" -a --delete \
              --backup \
              --backup-dir="$TRASH_DIR" \
              --max-delete=15 \
              "$SRC_DIR/" \
              "$DEST_DIR/"
              
            echo "Sync complete. Discarded files (if any) moved to: $TRASH_DIR"
          else
            echo "Backup skipped: Source directory is missing or empty." >&2
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
