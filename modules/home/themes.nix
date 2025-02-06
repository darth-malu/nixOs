{pkgs, osConfig, lib, ...}:

# let
#   gruvboxplus = import ../home/gruvbox-plus.nix { inherit pkgs;};
# in
# lib.mkIf osConfig.services.desktopManager.plasma6.enable {
lib.mkIf osConfig.programs.hyprland.enable {
  home.pointerCursor = {
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
    # };
    theme = {
      name = "Nightfox-Dark"; package = pkgs.nightfox-gtk-theme;
      # name = "tokyonight-gtk-theme"; package = pkgs.Tokyonight-Moon;
    };
    iconTheme = {
      package = pkgs.kora-icon-theme; name = "kora";

      # currently not workign
      # package = pkgs.candy-icons; name = "candy-icons";
      #package = pkgs.nordzy-icon-theme; name = "nordzy-icon-theme";
      #package = gruvboxplus; name = "GruvboxPlus";
      # package = pkgs.colloid-icon-theme; name = "colloid-icon-theme";
      # package = pkgs.dracula-icon-theme; name = "dracula-icon-theme";
      # package = pkgs.papirus-icon-theme; name = "papirus-icon-theme";
      # package = pkgs.whitesur-icon-theme; name = "whitesur-icon-theme";
      #package = pkgs.pantheon.elementary-icon-theme; name = "elementary-icon-theme";
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
    platformTheme.name = "gtk3"; #"gtk", "gtk3", "gnome", "adwaita", "lxqt", "qtct", "kde" or (submodule) #qt6ct
    style = {
      #name = "adwaita-dark"; #kvantum
      #name = "breeze"; package = pkgs.libsForQt5.breeze-qt5;
      # name = "breeze"; package = pkgs.kdePackages.breeze;
      name = "adwaita-dark";
      # package = pkgs.adwaita-qt6;
    };
  };
}
