{pkgs, ... }:

{
  systemd = {
    timers = {
      "hello-world" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "3m";
          OnUnitActiveSec = "2m";
          Unit = "hello-world.service";
          OnCalendar = "daily";
          Persistent = true;
        };
      };
    };

    services = {
          # ${pkgs.coreutils}/bin/echo "Hello Word darth"
      "hello-world" = {
        script = ''
          set -en
          notify-send "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
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

