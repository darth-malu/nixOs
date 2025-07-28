{
  imports = [
    ./services+timers
  ];

  # systemd.extraConfig = ''DefaultTimeOutStopSec=10s '';
  services.logind = {
    # https://wiki.nixos.org/wiki/Systemd/logind
    # https://wiki.archlinux.org/title/Power_management#ACPI_events
    # powerKey = "suspend"; # ignore, suspend,
    # extraConfig = '''';
  };
}
