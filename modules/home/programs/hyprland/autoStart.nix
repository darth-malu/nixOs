{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app -s b ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent" # TODO see if this works
    # "uwsm app -s b /nix/store/*hyprpolkitagent*/libexec/hyprpolkitagent"
    "uwsm app -s b quickshell"
    # "systemctl --user enable --now hyprsunset.service" #TODO write a script to auto do this
    "uwsm app -s b sway-audio-idle-inhibit"
    "[workspace special:easy silent] uwsm app -s a easyeffects"
    "wl-paste --type image --watch cliphist store"
    "wl-paste --type text --watch cliphist store"
  ];
}
