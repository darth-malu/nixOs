{
  wayland.windowManager.hyprland.settings.exec-once = [
    # "systemctl --user enable --now hyprpolkitagent.service"
    # "/nix/store/*hyprpolkitagent*/libexec/hyprpolkitagent &"
    "uwsm app -s b /nix/store/*hyprpolkitagent*/libexec/hyprpolkitagent"
    # "uwsm app -s b ${pkgs}/libexec/hyprpolkitagent"
    # "systemctl --user enable --now hyprsunset.service" #TODO write a script to auto do this
    "uwsm app -s b sway-audio-idle-inhibit"
    "uwsm app -s b quickshell"
    # "uwsm app -s b waybar"
    "[workspace special:easy silent] uwsm app -s a easyeffects"
    "wl-paste --type image --watch cliphist store"
    "wl-paste --type text --watch cliphist store"
  ];
}
