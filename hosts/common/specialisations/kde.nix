{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.kde = {
    enable = lib.mkEnableOption "Plasma module";
  };

  config = lib.mkIf config.kde.enable {
    services = {
      displayManager = {
        sddm.enable = lib.mkDefault true;
        sddm.wayland.enable = lib.mkDefault true;
        defaultSession = "plasma";
        # ly.enable = false;
      };
      desktopManager.plasma6.enable = true;
      blueman.enable = false; # TODO test if works
    };

    programs.dconf.enable = true;

    environment = {
      plasma6.excludePackages = with pkgs.kdePackages; [
        # plasma-browser-integration
        # elisa
        # konsole
        oxygen
      ];
      # systemPackages = with pkgs; [
      # jetbrains.pycharm-community
      # ];
    };
  };
}
