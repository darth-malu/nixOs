{ pkgs, ... }:

{
  systemd = {
    services = {
      # FIXME: does not seemm to be working?
      # ${pkgs.coreutils}/bin/echo "Hello Word darth"
      "hello-world" = {
        script = ''
          set -eu
          # notify-send "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
          ${pkgs.coreutils}/bin/echo "Hello Word darth"
          ${pkgs.libnotify}/bin/notify-send "Hello Word darth"
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
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
          OnCalendar = "daily";
          Persistent = true;
        };
      };
    };

    # user = { #FIXME: err
    #   timers = {
    #     "dunstHello" = {
    #       wantedBy = [ "timers.target" ];
    #       timerConfig =  {
    #         OnBootSec = "60";
    #         Unit = "dunstHello.service";
    #         Persistent = true;
    #       };
    #     };
    #   };
    #   services = {
    #     "dunstHello" = {
    #       script = ''
    #         set -e
    #         ${pkgs.dunst}/bin/dunst "Hello Word darth"
    #       '';
    #       serviceConfig = {
    #         Type = "oneshot";
    #         User = "malu";
    #       };
    #     };
    #   };
    # };
  };
}
