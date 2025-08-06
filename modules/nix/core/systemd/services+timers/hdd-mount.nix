{ config, ... }:
{
  systemd = {
    services = {
      "hdd-mount" = {
        enable = if config.networking.hostName == "tangier" then true else false;
        description = "This unit is made to solve my HDD mounting issues 😃";
        script = ''
          mount_units=(
            media-kibweziExtraHdd.mount
            media-kibweziC.mount
            media-extraHdd.mount
            media-linuxHdd.mount
          )
          for unit in "''${mount_units[@]}"; do
            systemctl start $unit
          done
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root"; # root , malu
          RemainAfterExit = true; # Prevents the service from automatically starting on rebuild. See https://discourse.nixos.org/t/how-to-prevent-custom-systemd-service-from-restarting-on-nixos-rebuild-switch/43431
        };
        wantedBy = [ "multi-user.target" ]; # 🟢 This makes it run at boo
      };
    };
    # timers = {
    #   "hdd-mount" = {
    #     wantedBy = [ "timers.target" ];
    #     timerConfig = {
    # OnBootSec = "3m";
    # OnUnitActiveSec = "5m";
    # Unit = "hdd-mount.service";
    # OnCalendar = "daily";
    # Persistent = true;
    # };
    # };
    # };
  };
}
