{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = {
      name = "qtct"; # qtct Use Qt settings from plasma (kde),
      # package = with pkgs; [
      #   kdePackages.qt6ct
      # ];
    };
    style.name = "kvantum"; # breeze "adwaita-dark" "kvantum";
    kvantum = {
      enable = false;
      themes = with pkgs; [
        # Theme packages to install to $XDG_CONFIG_HOME/Kvantum/.
        gruvbox-kvantum
        # catppuccin-kvantum
        rose-pine-kvantum
      ];
      # settings = {
      # Global configuration settings written to $XDG_CONFIG_HOME/Kvantum/kvantum.kvconfig.
      #   Applications = {
      #     KvArc = [
      #       "app1"
      #       "app2"
      #     ];
      #     KvFlat = [
      #       "app3"
      #     ];
      #   };
      #   General = {
      #     theme = "KvAdapta";
      #   };
      #   SomethingElse = {
      #     foo = "bar";
      #   };
      # };
    };
  };

}
