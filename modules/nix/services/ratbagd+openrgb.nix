{ pkgs, config, ... }:
{
  services = {
    ratbagd.enable = false;
    hardware.openrgb.enable = false;
  };

  hardware = {
    openrazer = {
      enable = true;
      users = [ "malu" ];
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      polychromatic
      # piper
      razer-cli # FIXME: Daemon issue
      # razergenie
      # openrazer-daemon
    ]
    ++ pkgs.lib.optionals config.services.hardware.openrgb.enable [
      openrgb-with-all-plugins
    ];
}
