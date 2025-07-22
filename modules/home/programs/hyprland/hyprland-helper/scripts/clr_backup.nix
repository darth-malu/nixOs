{ pkgs }:

pkgs.writeShellScriptBin "clr_backup" ''

  find_backup() {
    local backup_pattern="''${1:-*.home_backup}";
    local files_to_delete="$(${pkgs.fd}/bin/fd -d 3 -t f --glob "$backup_pattern"  $HOME)"

    if [ -n "$files_to_delete" ]; then # -n: true if string > 0
      printf '%s\n%s\n' 'Files to be deleted are::' "$files_to_delete"
      read -r -p "Are you sure you want to remove these backups? (Y/n) " response

      case "$response" in
        [yY]* | "") # match y/Yes/Yeah and blank RET"
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

  # Call the function, allowing the user to pass a pattern as an argument
  find_backup "$@"
''
