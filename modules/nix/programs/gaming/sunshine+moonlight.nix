{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = true; # true::
    settings = {
      sunshine_name = "darthSunshine";
      gamepad = "x360";
      # port = 47989;
    };
  };
}
