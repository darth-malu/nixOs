# { pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user enable --now hyprpolkitagent.service"
    # "uwsm app -s b ${pkgs}/libexec/hyprpolkitagent"
    # "systemctl --user enable --now hyprsunset.service" #TODO write a script to auto do this
    "uwsm app -s b sway-audio-idle-inhibit"
    "[workspace special:easy silent] uwsm app -s a easyeffects"
    "/nix/store/nkrj43fbdwv3j82zim1654ykbfqb81ga-hyprpolkitagent-0.1.2/libexec/hyprpolkitagent &" # TODO hypolkit manual start...change on update
    # "uwsm app -s a qbittorent" # FIXME not work
    "wl-paste --type image --watch cliphist store"
    "wl-paste --type text --watch cliphist store"
    # nix/store/wz977h103pckjkyw7yj3h106p5ga1xzc-hyprpolkitagent-0.1.2/libexec/hyprpolkitagent
  ];
}
