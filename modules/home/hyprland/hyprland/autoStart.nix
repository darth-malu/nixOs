{
  wayland.windowManager.hyprland.settings.exec-once = [
     # "systemctl --user enable --now waybar"
     # "systemctl --user enable --now hyprpaper.service"
     # "hyprpaper &"
     # "swaybg -i ~/Pictures/wallpapers/singed.png"
     "systemctl --user enable --now hypridle"
     "systemctl --user enable --now hyprpolkitagent.service" #uwsm #"systemctl --user start hyprpolkitagent" # non-uwsm
      # "uwsm finalize 'HYPRLAND_INSTANCE_SIGNATURE HYPRLAND_CMD HYPRCURSOR_THEME HYPRCURSOR_SIZE XCURSOR_SIZE XCURSOR_THEME'"
    #"uwsm finalize WAYLAND_DISPLAY"
      "uwsm app -s b sway-audio-idle-inhibit"
      "[workspace special:easy silent] uwsm app -s a easyeffects"
      "wl-paste --type image --watch cliphist store " # TODO: see if uwsm call needed really...
      "wl-paste --type text --watch cliphist store "

      # "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland" #apps taking long to open
      # "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # waybar fix dynamic bg?
      # "dbus-update-activation-environment --systemd --all"
    ];
}
