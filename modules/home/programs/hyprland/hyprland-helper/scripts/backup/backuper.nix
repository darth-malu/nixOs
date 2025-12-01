{ pkgs }:
pkgs.writeShellScriptBin "backupToSumbiHDD" ''

# --- Configuration ---
# SOURCE_DIR="$HOME/sharepoint"
SOURCES=("$HOME/sharepoint" "$HOME/Shibuya" "$XDG_CONFIG_HOME/quickshell" )

# EXTERNAL_DRIVE_FLASH="/dev/sdb1"
SUMBI_HDD="/media/SumbiHDD"
SAN_DISK_FLASH="/media/Ventoy"

MOUNT_POINT_FLASH="$SAN_DISK_FLASH/BackupS"
MOUNT_POINT_HDD="$SUMBI_HDD/maluFolder/BackupS"
LOG_FILE="$HOME/sharepoint/backup_videos.log"

# --- Functions ---
log_message() {
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

backup_folders() {
    local DESTINATION="$1"
    local OVERALL_STATUS=0
    local git_ignore=(".git")

    log_message "Starting backup_folders: to $DESTINATION..."
    sleep 1
    for dir in "''${SOURCES[@]}"; do
        for i in ''${git_ignore[@]};do
          rsync -aPvz "$dir" "$DESTINATION" --exclude="$i" --delete --log-file="$LOG_FILE" # --delete extraneous (files not in source)
          if [ $? -ne 0 ]; then
              log_message "ERROR: rsync failed for source $dir. Status: $?."
              OVERALL_STATUS=1
          fi
        done
        sleep 1
    done

    if [ $OVERALL_STATUS -eq 0 ];then
        log_message "Backup to $DESTINATION completed successfully."
    else
        log_message "Backup to $DESTINATION failed. Check $LOG_FILE for details."
    fi
}

log_message "--- Starting Backup to HDD/FLASH ---"

# Perform the backups
if [ -d "$MOUNT_POINT_FLASH" ]; then
    backup_folders "$MOUNT_POINT_FLASH"
fi

if [ -d "$MOUNT_POINT_HDD" ]; then
    backup_folders "$MOUNT_POINT_HDD"
fi
# Unmount the external drives
# unmount_drive "$MOUNT_POINT_FLASH"
# unmount_drive "$MOUNT_POINT_HDD"

log_message "--- Backing up from Sharepoint 100% complete ---"

exit 0

''
