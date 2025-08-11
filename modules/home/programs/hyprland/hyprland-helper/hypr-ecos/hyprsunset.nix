# { inputs, pkgs, ... }:
{
  services.hyprsunset = {
    enable = true;
    # package = inputs.hyprsunset.packages.${pkgs.system}.hyprsunset;
    extraArgs = [ "--identity" ];
    # transitions = {
    #   sunrise = {
    #     calendar = "*-*-* 06:00:00"; # TODO systemd time?
    #     requests = [
    #       [
    #         "temperature"
    #         "6500"
    #       ]
    #       # [ "gamma 100" ]       # like full brightness
    #     ];
    #   };
    #   sunset = {
    #     calendar = "*-*-* 19:00:00";
    #     requests = [
    #       [
    #         "temperature"
    #         "3500"
    #       ]
    #     ];
    #   };
    # };
  };
}
