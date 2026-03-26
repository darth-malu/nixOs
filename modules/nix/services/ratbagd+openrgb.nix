{ pkgs }:
{
  services = {
    ratbagd.enable = true;
    openrgb = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [ openrgb-with-all-plugins ];
}
