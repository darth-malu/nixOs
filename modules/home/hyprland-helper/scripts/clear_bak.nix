{pkgs}:
pkgs.writeShellScriptBin "clr_back" /*bash*/''
  find_backup() {
    find $HOME -maxdepth 3 \( -iname "*home_backup" \) -type f -exec rm {} + 
  }
  find_backup
''