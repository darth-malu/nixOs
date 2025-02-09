{pkgs, osConfig, lib, ...}:

# let
#   gruvboxplus = import ../home/gruvbox-plus.nix { inherit pkgs;};
# in
# lib.mkIf osConfig.services.desktopManager.plasma6.enable {
lib.mkIf osConfig.programs.hyprland.enable {
  home.pointerCursor = {
    hyprcursor = {
      size = 24;
      enable = true;
    };
    gtk.enable = true; # waybar, gtk apps
    # x11.enable = true; #xwayland?
    package = pkgs.bibata-cursors; name = "Bibata-Modern-Ice";
    # package = pkgs.posy-cursors; name = "posy-cursors";
    size = if osConfig.networking.hostName == "carthage" then 24 else if osConfig.networking.hostName == "tangier" then 20 else 18;
  };

  gtk = {
    enable = true;
    #font = {
      #name = "DaddyTimeMono Nerd Font";
      #size = 12;
    #}; 
    # cursorTheme = { 
    #   package = pkgs.bibata-cursors; name = "Bibata-Modern-Ice";
    #   size = if osConfig.networking.hostName == "carthage" then 24 else if osConfig.networking.hostName == "tangier" then 20 else 18;
    # };#NOTE: not needed
    theme = {
      name = "Nightfox-Dark"; package = pkgs.nightfox-gtk-theme;
      # name = "tokyonight-gtk-theme"; package = pkgs.Tokyonight-Moon;
    };
    iconTheme = {
      # package = pkgs.kora-icon-theme; name = "kora";

      package = pkgs.candy-icons; name = "candy-icons";
    };

    # gtk3 = {
    #   extraConfig = {
    #     gtk-application-prefer-dark-theme = "1";
    #   };
    # };
    #
    # gtk4 = {
    #   extraConfig = {
    #     #gtk-theme-name = ''Nightfox:Dark''; #eg nautilus
    #     gtk-theme-name = "Nightfox-Dark"; #eg nautilus
    #     gtk-cursor-blink = false;
    #     gtk-recent-files-limit = 20;
    #   };
    #   # extraCss = #gtk-4.0/gtk.css
    #   #   ''
    #   # '';
    # };
  };

  qt = {
    enable = true;
    # platformTheme.name = "adwaita"; #kvantum , gtk, gnome, kde, gtk3, **deprecated
    platformTheme.name = "qtct"; #"gtk", "gtk3", "gnome", "adwaita", "lxqt", "qtct", "kde" or (submodule) #qt6ct
    style = {
      #name = "adwaita-dark"; #kvantum
      #name = "breeze"; package = pkgs.libsForQt5.breeze-qt5;
      # name = "breeze"; package = pkgs.kdePackages.breeze;
      name = "adwaita-dark"; #adwaita-dark
      # package = pkgs.adwaita-qt6;
    };
  };
}
