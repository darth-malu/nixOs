{
  wayland.windowManager.hyprland.settings.exec-once = [
     "systemctl --user enable --now waybar"
     # "systemctl --user enable --now hyprpaper.service"
     "systemctl --user enable --now hypridle"
     "systemctl --user enable --now hyprpolkitagent.service" #uwsm #"systemctl --user start hyprpolkitagent" # non-uwsm
      "uwsm app -s b sway-audio-idle-inhibit"
      "[workspace special:easy silent] uwsm app -s a easyeffects"
      "wl-paste --type image --watch cliphist store " # TODO: see if uwsm call needed really...
      "wl-paste --type text --watch cliphist store "
    ];
}
