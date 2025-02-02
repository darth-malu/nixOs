{osConfig, ...}:
{
  wayland.windowManager.hyprland.settings = {
    env = [# xdg set by uwsm
      # "HYPRCURSOR_THEME,material-cursors"
      "HYPRCURSOR_THEME,theme_GoogleDot-Violet"
      "HYPRCURSOR_SIZE,24"
      "SLURP_ARGS, -d -b -B F050F022 -b 10101022 -c ff00ff"

      "QT_AUTO_SCREEN_SCALE_FACTOR,1" # enable auto scaling based on the monitors pixel density
      "QT_QPA_PLATFORM,wayland;xcb"
      "GDK_BACKEND,x11,wayland,*" # * - other GDK backend
      "QT_QPA_PLATFORMTHEME,qt6ct"
      "CLUTTER_BACKEND,wayland"
      "GTK_THEME,Nightfox-Dark"
      # "SDL_VIDEODRIVER,wayland" # set to x11 incase of game issues
      # "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" #attempted fix
    ]
    ++ (if osConfig.networking.hostName == "tangier" then
      [
        "LIBVA_DRIVER_NAME,nvidia" # nvidia hw acceleration
        "__GLX_VENDOR_LIBRARY_NAME,nvidia" # force GBM as backend
      ] 
    else []);
  };
}
