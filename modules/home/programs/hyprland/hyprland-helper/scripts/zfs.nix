{ pkgs }:

pkgs.writeShellScriptBin "darth_zfs_lister" ''
  # get list...if darth-pool = carthage else ... tangier (darthPool)
  function getList() {
    local isWhichPool

      if [ $? = 'darth-pool' ]; then
        zfs list darth-pool | awk 'NR==2{print $3}'
      else
        zfs list darthPool | awk 'NR==2{print $3}'
  }

  getList()
''
