{ pkgs }:

pkgs.writeShellScriptBin "clr_back" ''

  find_backup() {
    find $HOME -maxdepth 3 \( -iname "*home_backup" \) -type f -exec rm {} + 
  }

  find_backup
''
