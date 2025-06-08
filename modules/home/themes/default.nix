{pkgs, osConfig, lib, config, ...}:

# let
#   gruvboxplus = import ../home/gruvbox-plus.nix { inherit pkgs;};
# in
# lib.mkIf osConfig.services.desktopManager.plasma6.enable {
lib.mkIf osConfig.programs.hyprland.enable {

home.pointerCursor = {
  enable = true; # false::
  gtk.enable = true; # waybar, gtk apps
  dotIcons.enable = true; # Whether to enable .icons config generation for home.pointerCursor
  hyprcursor = {
    size = 24; # 32::
    enable = true;
  };
  x11 = {
    enable = true; # false:: xwayland?
    # defaultCursor = pkgs.
  };
  name = "google-cursor";  package = pkgs.google-cursor;
  size = if osConfig.networking.hostName == "carthage" then 24 else if osConfig.networking.hostName == "tangier" then 20 else 18;
};

gtk = {
  enable = true;
  #font = {
  #name = "DaddyTimeMono Nerd Font";
  #size = 12;
  #};

cursorTheme = {
  # package = pkgs.bibata-cursors; name = "Bibata-Modern-Ice";
  name = "google-cursor"; package = pkgs.google-cursor;
  size = if osConfig.networking.hostName == "carthage" then 24 else if osConfig.networking.hostName == "tangier" then 20 else 18;
};

theme = {
  name = "nightfox-gtk-theme";  package = pkgs.nightfox-gtk-theme;
  # name = "breeze-gtk";  package = pkgs.kdePackages.breeze-gtk;
  # name = "yaru";  package = pkgs.yaru-theme;
  # name = "tokyonight-gtk-theme"; package = pkgs.Tokyonight-Moon;
};

iconTheme = {
  # name = "kora-icon-theme"; package = pkgs.kora-icon-theme;
  name = "candy-icons"; package = pkgs.candy-icons;
  # name = "windows10-icons"; package = pkgs.windows10-icons;
  # name = "papirus-icon-theme"; package = pkgs.papirus-icon-theme;
  # name = "gruvbox-plus-icons";  package = pkgs.gruvbox-plus-icons;
};

gtk2 = {
  extraConfig = ''
        "gtk-can-change-accels" = "1"
      '';
  configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc"; #FIXME not working?
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
