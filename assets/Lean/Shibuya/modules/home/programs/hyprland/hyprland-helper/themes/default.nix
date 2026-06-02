{
  pkgs,
  osConfig,
  lib,
  config,
  ...
}:

# let
#   gruvboxplus = import ../home/gruvbox-plus.nix { inherit pkgs;};
# in
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
    name = "GoogleDot-Black";
    package = pkgs.google-cursor;
    size =
      if osConfig.networking.hostName == "carthage" then
        24
      else if osConfig.networking.hostName == "tangier" then
        20
      else
        18;
  };

  gtk = {
    enable = true;
    # font = {
    #   name = "DaddyTimeMono Nerd Font";
    #   size = 12;
    # };

    cursorTheme = {
      # name = "Bibata-Modern-Ice"; package = pkgs.bibata-cursors;
      name = "GoogleDot-Black";
      package = pkgs.google-cursor;
      # name = "google-cursor"; package = pkgs.google-cursor;
      size =
        if osConfig.networking.hostName == "carthage" then
          24
        else if osConfig.networking.hostName == "tangier" then
          20
        else
          18;
    };

    theme = {
      name = "Nightfox-Dark";
      package = pkgs.nightfox-gtk-theme;
      # name = "breeze-gtk";  package = pkgs.kdePackages.breeze-gtk;
      # name = "Yaru-Dark";  package = pkgs.yaru-theme;
      # name = "tokyonight-gtk-theme"; package = pkgs.Tokyonight-Moon;
    };

    iconTheme = {
      name = "Colloid-Dracula";
      package = pkgs.colloid-icon-theme.override { schemeVariants = [ "dracula" ]; };
      # name = "kora"; package = pkgs.kora-icon-theme;
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
      theme = config.gtk.theme; # null::
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
    platformTheme.name = "kde";
    style.name = "breeze"; # "adwaita-dark";
  };

}
