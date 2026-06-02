{ pkgs }:

pkgs.writeShellScriptBin "backupRsync" ''
    # rsync -avz --delete /path/to/source/ /media/$USER/your_flash_drive_name/backup/

  SOURCE="/path/to/source/"
  DEST="/media/$USER/your_flash_drive_name/backup/"

  echo "Starting backup to flash drive..."
  rsync -avz --delete "$SOURCE" "$DEST"
  echo "Backup complete."
''
# - attach this to a systemd timer
# z -> compress
# --delete -> delete files in destination if they are no longer in the source
# -v - verbose; shows what files are being transferred
# -a - archive mode; preserve permissions, ownership, timestamps, etc
