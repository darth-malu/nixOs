{ pkgs, osConfig, ... }:
{
  programs.zed-editor = {
    enable = if osConfig.networking.hostName == "carthage" then true else false;

    extraPackages = [
      pkgs.nixd
      # pkgs.nil
    ];

    userSettings = {
    };

  }; # end of programs.zed
}
