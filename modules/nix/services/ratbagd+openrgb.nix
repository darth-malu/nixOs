{ pkgs, ... }:
{
  services.ratbagd.enable = true;
  services.hardware.openrgb.enable = false;

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "malu " ];

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    polychromatic
    piper
    razer-cli # FIXME: Daemon issue
    razergenie
    # openrazer-daemon
  ];
}
