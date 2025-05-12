{ pkgs }:
#TODO make a terminal pop up with interactive del

# let
#   pattern = "\${1:-\"*home_backup\"}";
# in
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
    if [[ -z "$response" || "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then # empty response or y
      if find "$HOME" -maxdepth 3 -iname "$pattern" -type f -delete; then
        echo "Backups removed."
      else
        echo "An error occured whilst deleting the backups"
      fi
    elif [[ "$response" =~ ^([nN])$ ]]; then
        printf 'no/Deletion Cancelled \n'
    else
      echo "Deletion failedd!!."
    fi
  }

  # Call the function, allowing the user to pass a pattern as an argument
  find_backup "$@"
''
