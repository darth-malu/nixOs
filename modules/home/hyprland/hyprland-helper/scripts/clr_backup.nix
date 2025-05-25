{ pkgs }:

pkgs.writeShellScriptBin "clr_backup" ''

  find_backup() {
    local pattern = "''${1:-*home_backup}";
    # Find backups, but only print what *would* be deleted first
    # find "$HOME" -maxdepth 3 -iname "$pattern" -type f -print0 | xargs -0 -n 50 printf '%s\n' 'Files to be removed::'
    printf '%s\n' 'Files to be removed::'
    find "$HOME" -maxdepth 3 -iname "$pattern" -type f -print

    # Ask for confirmation before deleting
    read -r -p "Are you sure you want to remove these backups? (y/N) " response

    # Only delete if the user confirms
    case "$response" in
      [yY] | [yY][eE][sS])
        if find "$HOME" -maxdepth 3 -iname "$pattern" -type f -delete; then
          echo "Backups removed."
        else
          echo "An error occurred while deleting the backups."
        fi
        ;;
      [nN] | [nN][oO])
        echo "Deletion cancelled."
        ;;
      *)
        echo "Invalid response. No files were deleted."
        ;;
    esac
  }

  # Call the function, allowing the user to pass a pattern as an argument
  find_backup "$@"
''
