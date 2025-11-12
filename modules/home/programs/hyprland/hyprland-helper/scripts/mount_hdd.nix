{ pkgs }:

pkgs.writeShellScriptBin "mount_hdd" ''
      # Get a list of mount units defined in systemd
      # mapfile -t mount_units < <(systemctl list-units --type=mount --all --no-legend | awk '{print $1}')

    # Chech where drives are mounted
    # for unit in "''${mount_units[@]}"; do

  mount_units=(
    media-kibweziExtraHdd.mount
    media-kibweziC.mount
    media-Mutsu.mount
    media-Hyogo.mount
  )

  for unit in "''${mount_units[@]}"; do
    mount_point=$(systemctl show -p Where "$unit" | cut -d'=' -f2)

    if [[ -z "$mount_point" ]]; then
      printf '%s\n' 'Skipping...no mount point in filesystem'
      continue
    fi

    if mountpoint -q "$mount_point"; then
      printf '%s\n' "$mount_point is already mounted"
    else
      printf '%s\n' "Trying to mount: [$mount_point]"
      systemctl start "$unit"

      if mountpoint -q "$mount_point"; then
        printf '%s\n' "$mount_point: mount successful"
      else
        printf "$mount_point: mount failed\n"
      fi
    fi
  done
''
