{pkgs, ...}:
{
  wayland.windowManager.hyprland.settings.exec-once = [
    # "emacs --daemon"
    # "systemctl --user start emacs" # daemon
    # "systemctl --user enable --now waybar"
    # "systemctl --user enable --now hyprpaper.service"
    "systemctl --user enable --now hypridle"
    # "systemctl --user enable --now hyprpolkitagent.service" #uwsm #"systemctl --user start hyprpolkitagent" # non-uwsm
    "uwsm app -s b sway-audio-idle-inhibit"
    "[workspace special:easy silent] uwsm app -s a easyeffects"
    "wl-paste --type image --watch cliphist store "
    "wl-paste --type text --watch cliphist store "
#nix/store/wz977h103pckjkyw7yj3h106p5ga1xzc-hyprpolkitagent-0.1.2/libexec/hyprpolkitagent
  ];
}
