{ pkgs }:
pkgs.writeShellScriptBin "backupToSumbiHDD" ''

# --- Configuration ---
# SOURCE_DIR="$HOME/sharepoint"
SOURCES=("$HOME/sharepoint" "$HOME/Shibuya" "$XDG_CONFIG_HOME/quickshell" )

# EXTERNAL_DRIVE_FLASH="/dev/sdb1"
SUMBI_HDD="/media/SumbiHDD/malu"
SAN_DISK_FLASH="/media/Ventoy"

MOUNT_POINT_FLASH="$SAN_DISK_FLASH/BackupS"
MOUNT_POINT_HDD="$SUMBI_HDD/maluFolder/BackupS"
LOG_FILE="$HOME/sharepoint/backup_videos.log"

# --- Functions ---
log_message() {
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# mount_drive() {
#     local DEVICE="$1"
#     local MOUNT_POINT="$2"

#         if ! mountpoint -q "$MOUNT_POINT"; then
#         log_message "Mounting $DEVICE to $MOUNT_POINT..."
#             sudo mount "$DEVICE" "$MOUNT_POINT"
#             if [ $? -ne 0 ]; then
#             log_message "Error mounting $DEVICE to $MOUNT_POINT. Exiting."
#                 exit 1
#                 fi
#             else
#             log_message "$DEVICE is already mounted at $MOUNT_POINT."
#                 fi
# }

# unmount_drive() {
#     local MOUNT_POINT="$1"

#     if mountpoint -q "$MOUNT_POINT"; then
#         log_message "Unmounting $MOUNT_POINT..."
#         sudo umount "$MOUNT_POINT"
#         if [ $? -ne 0 ]; then
#             log_message "Error unmounting $MOUNT_POINT."
#             fi
#         else
#             log_message "$MOUNT_POINT is not mounted."
#             fi
# }

backup_folders() {
    local DESTINATION="$1"
    local OVERALL_STATUS=0

    log_message "Starting backup_folders: to $DESTINATION..."
    sleep 1
    for dir in ''${SOURCES[@]}; do
        rsync --exclude='.git' -ahPvz "$dir" "$DESTINATION" --delete --log-file="$LOG_FILE" # --delete extraneous (files not in source)
        if [ $? -ne 0 ]; then
            log_message "ERROR: rsync failed for source $dir. Status: $?."
            OVERALL_STATUS=1
        fi
        sleep 1
    done

    if [ $OVERALL_STATUS -eq 0 ];then
        log_message "Backup to $DESTINATION completed successfully."
    else
        log_message "Backup to $DESTINATION failed. Check $LOG_FILE for details."
    fi
}

log_message "--- Starting Backup to HDD/FLASH ---"

# Mount the external drives
# mount_drive "$EXTERNAL_DRIVE_FLASH" "$MOUNT_POINT_FLASH"
# mount_drive "$EXTERNAL_DRIVE_HDD" "$MOUNT_POINT_HDD"

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
