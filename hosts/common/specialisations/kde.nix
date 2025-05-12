{
  pkgs,
  lib,
  config,
  ...
}:
{
  # system.nixos.tags = ["kdeBoi"];
  # inheritParentConfig = true;
  # environment.etc."specialisation".text = "gnome";

  # users.users.maluware = {
  #   isNormalUser =  true;
  #   hashedPassword = "$6$HdXvkPgtduU6S.v8$twGdcmP6g4usswK71O3mRwWUYU.OOdN79ANLtEQvUpIYAyzNJ42ch0NnwEQOKBgMMOz8gXgF.tpqY7MXNjBFW0";
  #   uid = 1005;
  #   extraGroups = [ "networkmanager" "video" ];
  # };
  options.kde = {
    enable = lib.mkEnableOption "Plasma";
  };

  config = lib.mkIf config.kde.enable {
    programs.waybar.enable = false;
    services = {
      displayManager = {
        sddm.enable = lib.mkDefault true;
        sddm.wayland.enable = lib.mkDefault true;
        defaultSession = "plasma";
        # ly.enable = false;
      };
      desktopManager.plasma6.enable = true;
    };
    environment = {
      plasma6.excludePackages = with pkgs.kdePackages; [
        # plasma-browser-integration
        elisa
        # konsole
        oxygen
      ];
      # systemPackages = with pkgs; [
      # jetbrains.pycharm-community
      # ];
    };
  };
}
