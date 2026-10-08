{
  osConfig,
  pkgs,
  ...
}:

{

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
    size = if osConfig.networking.hostName == "carthage" then 24 else 20;
  };
}
