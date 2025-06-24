{pkgs, osConfig, lib, config, ...}:

# let
#   gruvboxplus = import ../home/gruvbox-plus.nix { inherit pkgs;};
# in
# lib.mkIf osConfig.services.desktopManager.plasma6.enable {
lib.mkIf osConfig.programs.hyprland.enable {

home.pointerCursor = {
  enable = true; # false::
  gtk.enable = true; # waybar, gtk apps
  dotIcons.enable = true;
  hyprcursor = {
    size = 24; # 32::
    enable = true;
  };
  x11 = {
    enable = true;
    # defaultCursor = "X_cursor"; # letf_ptr::
  };
  # name = "Bibata-Modern-Ice"; package = pkgs.bibata-cursors;
  # name = "bibata-cursors"; package = pkgs.bibata-cursors;
  name = "GoogleDot-White";  package = pkgs.google-cursor; # on xwayland stuff like waybar, intelliJ
  size = if osConfig.networking.hostName == "carthage" then 24 else if osConfig.networking.hostName == "tangier" then 20 else 18;
};

gtk = {
  enable = true;
  #font = {
  #name = "DaddyTimeMono Nerd Font";
  #size = 12;
  #};

cursorTheme = {
  name = "Bibata-Modern-Ice"; package = pkgs.bibata-cursors;
  # name = "google-cursor"; package = pkgs.google-cursor;
  size = if osConfig.networking.hostName == "carthage" then 24 else if osConfig.networking.hostName == "tangier" then 20 else 18;
};

theme = {
  name = "Nightfox-Dark";  package = pkgs.nightfox-gtk-theme;
  # name = "breeze-gtk";  package = pkgs.kdePackages.breeze-gtk;
  # name = "Yaru-Dark";  package = pkgs.yaru-theme;
  # name = "tokyonight-gtk-theme"; package = pkgs.Tokyonight-Moon;
};

iconTheme = {
  name = "Colloid-Catppuccin-Dark"; package = pkgs.colloid-icon-theme.override {schemeVariants = ["catppuccin"];};
  # name = "kora"; package = pkgs.kora-icon-theme;
  # name = "WhiteSur"; package = pkgs.whitesur-icon-theme;
  # name = "candy-icons"; package = pkgs.candy-icons;
  # name = "Papirus-Dark"; package = pkgs.papirus-icon-theme;

  # name = "gruvbox-plus-icons";  package = pkgs.gruvbox-plus-icons;
  # name = "Windows10-icons"; package = pkgs.windows10-icons;
};

gtk2 = {
  # extraConfig = ''
  #       "gtk-can-change-accels" = "1"
  #     ''; #TODO see importance
  configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
};

gtk3 = {
  extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };
  # bookmarks = [ #FIXME error
  #   "file://home/malu/org"
  # ];
};

gtk4 = {
  # extraCss = '''';
  extraConfig = {
    #     #gtk-theme-name = ''Nightfox:Dark''; #eg nautilus
    #     gtk-theme-name = "Nightfox-Dark"; #eg nautilus
    #     gtk-cursor-blink = false;
    # gtk-recent-files-limit = 20;
    gtk-application-prefer-dark-theme = 1;
  };
  #   # extraCss = #gtk-4.0/gtk.css
  #   #   ''
  #   # '';
};

};

qt = {
  enable = true;
  platformTheme.name = "adwaita-dark"; #kvantum , gtk, gnome, kde, gtk3, **deprecated
  # platformTheme.name = "qtct"; # "gtk", "gtk3", "gnome", "adwaita", "lxqt", "qtct", "kde" or (submodule) #qt6ct
  # platformTheme = "gnome";
  style.name = "adwaita-dark";
};

}
