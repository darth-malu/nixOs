{pkgs, lib, ...}:
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

  imports = [
    # ../../../hosts/carthage/drives.nix
    # ../../../hosts/carthage/amd.nix
    # ../../hosts/carthage/default.nix
    # ../../../users/malu.nix
    ../carthage/common
  ];
  services = {
    displayManager = {
      sddm.enable = lib.mkDefault true;
      defaultSession = "plasma"; # plasmax11, plasma(wayland)
      sddm.wayland.enable = lib.mkDefault true;
      ly.enable = lib.mkForce false;
    };
    desktopManager.plasma6.enable = true;
  };
  # programs = { # custom option cleaner enable disbale
    # hyprland = {
      # enable = lib.mkForce false; # for exception for waybar, rofi
      # withUWSM = false;
    # };
  # };
  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      # plasma-browser-integration
      elisa
      # konsole
      oxygen
    ];
    systemPackages = with pkgs; [
      jetbrains.pycharm-community
    ];
  };
}
