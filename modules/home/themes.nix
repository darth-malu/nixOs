{pkgs, osConfig, lib, config, ...}:

# let
#   gruvboxplus = import ../home/gruvbox-plus.nix { inherit pkgs;};
# in
# lib.mkIf osConfig.services.desktopManager.plasma6.enable {
lib.mkIf osConfig.programs.hyprland.enable {

gtk = {
  enable = true;
  #font = {
  #name = "DaddyTimeMono Nerd Font";
  #size = 12;
  #};

cursorTheme = {
  package = pkgs.bibata-cursors; name = "Bibata-Modern-Ice";
  size = if osConfig.networking.hostName == "carthage" then 24 else if osConfig.networking.hostName == "tangier" then 20 else 18;
};#NOTE: not needed

theme = {
  name = "Nightfox-Dark";
  package = pkgs.nightfox-gtk-theme;
  # name = "tokyonight-gtk-theme"; package = pkgs.Tokyonight-Moon;
};

iconTheme = {
  # package = pkgs.kora-icon-theme; name = "kora";
  package = pkgs.candy-icons; name = "candy-icons";
  # package = pkgs.windows10-icons; name = "windows10-icons";
  # package = pkgs.kora-icon-theme; name = "kora-icon-theme";
  # package = pkgs.gruvbox-plus-icons;
  # name = "gruvbox-plus-icons";
};

};

qt = {
  enable = true;
  platformTheme.name = "adwaita-dark"; #kvantum , gtk, gnome, kde, gtk3, **deprecated
  # platformTheme.name = "qtct"; # "gtk", "gtk3", "gnome", "adwaita", "lxqt", "qtct", "kde" or (submodule) #qt6ct
  # platformTheme = "gnome";
  style = {
    name = "adwaita-dark";
  };
};

}
