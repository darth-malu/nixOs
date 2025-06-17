{ pkgs }:

pkgs.writeShellScriptBin "clr_backup" ''

  fd_files_to_delete() {
    local backup_pattern="''${1:-*.home_backup}";
    ${pkgs.fd}/bin/fd  -0 -d 3 -t f --glob "$backup_pattern"  $HOME
  }

  find_backup() {
    local files_to_delete="$(fd_files_to_delete)"

    if [ -n "$files_to_delete" ]; then # -n: true if string > 0
      # CRITICAL FIX: Pipe the null-delimited list to xargs -0 for safe and correct printing.
      # xargs -0 -n 1 printf '%s\n' ensures each filename (even with spaces) is printed on a new line.
      printf '%s\n' 'Files to be deleted are::'
      printf '%s' "$files_to_delete" | xargs -0 -n 1 printf '%s\n'

      read -r -p "Are you sure you want to remove these backups? (Y/n) " response

      case "$response" in
        [yY]* | "") # match y/Yes/Yeah and blank RET"
          printf '%s' "$files_to_delete" | xargs -0 rm -v

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
