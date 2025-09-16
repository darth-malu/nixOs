{ osConfig, ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      # xdg set by uwsm
      "HYPRCURSOR_THEME,theme_GoogleDot-Violet"
      "HYPRCURSOR_SIZE,24"
      "SLURP_ARGS, -d -b -B F050F022 -b 10101022 -c ff00ff"

      "GDK_SCALE,1" # TODO TRY 2 won’t conflict with Wayland-native GTK programs.
      "GDK_DPI_SCALE=1"
      "GDK_BACKEND,wayland,x11,*" # * - other GDK backend

      "QT_AUTO_SCREEN_SCALE_FACTOR,1" # enable auto scaling based on the monitors pixel density # TODO test changes if needed
      # "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORM,wayland"
      "QT_QPA_PLATFORMTHEME,qt6ct"

      # "CLUTTER_BACKEND,wayland"
      # "GTK_THEME,Nightfox-Dark"
      # "SDL_VIDEODRIVER,wayland" # set to x11 incase of game issues
      # "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0" #attempted fix
    ]
    ++ (
      if osConfig.networking.hostName == "tangier" then
        [
          "LIBVA_DRIVER_NAME,nvidia" # hw acceleration on nvidia GPUs
          "__GLX_VENDOR_LIBRARY_NAME,nvidia" # force GBM as backend
        ]
      else
        [ ]
    );
  };
}
