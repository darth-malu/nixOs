{ pkgs, ... }:

{
  systemd = {
    services = {
      "hello-world" = {
        script = ''
          set -eu
          ${pkgs.coreutils}/bin/echo "Hello Word darth"
          ${pkgs.dunst}/bin/dunstify -i /home/malu/Shibuya/assets/icons8-pause-48.png "Its working lol"
        '';
        # ${pkgs.libnotify}/bin/notify-send "Hello Word darth"
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          RemainAfterExit = true; # Prevents the service from automatically starting on rebuild. See https://discourse.nixos.org/t/how-to-prevent-custom-systemd-service-from-restarting-on-nixos-rebuild-switch/43431
        };
      };
    };
    timers = {
      "hello-world" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "3m";
          OnUnitActiveSec = "5m";
          Unit = "hello-world.service";
          # OnCalendar = "daily";
          # Persistent = true;
        };
      };
    };
  };
}
