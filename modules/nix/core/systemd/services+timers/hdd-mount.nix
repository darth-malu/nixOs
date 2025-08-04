{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd = {
    services = {
      "hdd-mount" = {
        script = ''
          mount_units=(
            media-kibweziExtraHdd.mount
            media-extraHdd.mount
          )

          for unit in "''${mount_units[@]}"; do
            mount_point=$(systemctl show -p Where "$unit" | cut -d'=' -f2)

            if [[ -z "$mount_point" ]]; then
              printf '%s\n' 'Skipping...no mount point in filesystem'
              dunstrify 'Skipping...no mount point in filesystem'
              continue
            fi

            if mountpoint -q "$mount_point"; then
              printf '%s\n' "$mount_point is already mounted"
              dunstify "$mount_point: mount successful"
            else
              printf '%s\n' "Trying to mount: [$mount_point]"
              dunstify "Trying to mount: [$mount_point]"
              systemctl start "$unit"

              if mountpoint -q "$mount_point"; then
                printf '%s\n' "$mount_point: mount successful"
                dunstify "$mount_point: mount successful"
              else
                printf "$mount_point: mount failed"
              fi
            fi
          done
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          RemainAfterExit = true; # Prevents the service from automatically starting on rebuild. See https://discourse.nixos.org/t/how-to-prevent-custom-systemd-service-from-restarting-on-nixos-rebuild-switch/43431
        };
      };
    };
    timers = {
      "hdd-mount" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "3m";
          OnUnitActiveSec = "5m";
          Unit = "hdd-mount.service";
          # OnCalendar = "daily";
          # Persistent = true;
        };
      };
    };
  };
}
