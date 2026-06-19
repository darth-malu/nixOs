{ pkgs, ... }:

let
  clr_backup = pkgs.writeShellScriptBin "clr_backup" ''
    find_backup() {
      local backup_pattern="''${1:-*.home_bak}";
      local files_to_delete="$(${pkgs.fd}/bin/fd -d 3 -t f --glob "$backup_pattern"  $HOME/.config)"

      if [ -n "$files_to_delete" ]; then
        printf '%s\n%s\n' "Files to be deleted are::" "$files_to_delete"
        read -r -p "Are you sure you want to remove these backups? (Y/n) " response

        case "$response" in
          [yY]* | "")
            printf '%s' "$files_to_delete" | xargs -n 1 rm -v

            if [ $? -eq 0 ]; then
              echo "Backup files removed."
            else
              echo "An error occurred while deleting the backups."
            fi
            ;;
          [nN]*)
            echo "Deletion cancelled."
            ;;
          *)
            echo "Invalid response. No files were deleted."
            ;;
        esac
      else
        printf "No files found to delete 🫠"
      fi
    }

    find_backup "$@"
  '';

in
{
  environment.systemPackages = [ clr_backup ];

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
