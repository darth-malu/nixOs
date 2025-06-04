{ pkgs }:

pkgs.writeShellScriptBin "clr_backup" ''

  find_backup() {
    local backup_pattern="''${1:-*.home_backup}";
    # Find backups, but only print what *would* be deleted first
    # find "$HOME" -maxdepth 3 -iname "$pattern" -type f -print0 | xargs -0 -n 50 printf '%s\n' 'Files to be removed::'

    local files_to_delete_null=$(${pkgs.fd}/bin/fd "$backup_pattern"  -d 3 -t f $HOME)

    if [ -n "$files_to_delete_null" ]; then
      # CRITICAL FIX: Pipe the null-delimited list to xargs -0 for safe and correct printing.
      # xargs -0 -n 1 printf '%s\n' ensures each filename (even with spaces) is printed on a new line.
      printf 'Files to be deleted are::\n'
      printf "%s" "$files_to_delete_null" | xargs -n 1 printf '%s\n'

      read -r -p "Are you sure you want to remove these backups? (Y/n) " response

      case "$response" in
        [yY]* | "") # match y/Yes/Yeah and blank RET""
          printf '%s\n' "$files_to_delete_null" | xargs -0 rm -v

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
