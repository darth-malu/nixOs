{ pkgs }:
#pattern="\${1:-"*home_backup"}"
pkgs.writeShellScriptBin "clr_backup" ''
  find_backup() {
    # Allow the user to specify the search pattern (defaulting to "*home_backup")
    pattern=""*home_backup""

    # Find backups, but only print what *would* be deleted first
    find "$HOME" -maxdepth 3 -iname "$pattern" -type f -print0 | xargs -0 -n 100 echo "Would remove:"

    # Ask for confirmation before deleting
    read -r -p "Are you sure you want to remove these backups? (y/N) " response

    # Only delete if the user confirms
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      find "$HOME" -maxdepth 3 -iname "$pattern" -type f -delete
      echo "Backups removed."
    else
      echo "Deletion cancelled."
    fi
  }

  # Call the function, allowing the user to pass a pattern as an argument
  find_backup
''
