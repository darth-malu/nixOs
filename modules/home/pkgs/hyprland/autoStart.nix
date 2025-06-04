{
  wayland.windowManager.hyprland.settings.exec-once = [
    # "systemctl --user enable --now hyprpolkitagent.service"
    # "systemctl --user enable --now hyprsunset.service"
    "uwsm app -s b sway-audio-idle-inhibit" # TODO test this
    "[workspace special:easy silent] uwsm app -s a easyeffects"
    # "uwsm app -s a qbittorent" # FIXME not work
    "wl-paste --type image --watch cliphist store"
    "wl-paste --type text --watch cliphist store"
    # nix/store/wz977h103pckjkyw7yj3h106p5ga1xzc-hyprpolkitagent-0.1.2/libexec/hyprpolkitagent
  ];
}
