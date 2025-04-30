{ pkgs }:
#pattern="\${1:-"*home_backup"}"
#TODO make a terminal pop up with interactive del

let
  pattern = "\${1:-\"*home_backup\"}";
in
pkgs.writeShellScriptBin "clr_backup" ''

  find_backup() {

    # Find backups, but only print what *would* be deleted first
    find "$HOME" -maxdepth 3 -iname "${pattern}" -type f -print0 | xargs -0 -n 50 printf '%s\n' 'Files to be removed::'

    # Ask for confirmation before deleting
    read -r -p "Are you sure you want to remove these backups? (y/N) " response

    # Only delete if the user confirms
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      # delete matched files
      # fd "$HOME" -d 3 "${pattern}" -0 -t f
      find "$HOME" -maxdepth 3 -iname "${pattern}" -type f -delete
      if [$? -eq 0]; then
        echo "Backups removed."
      else
        echo "An error occured whilst deleting the backups"
      fi
    else
      echo "Deletion cancelled." # default option
    fi
  }

  # Call the function, allowing the user to pass a pattern as an argument
  find_backup "$@"
''
