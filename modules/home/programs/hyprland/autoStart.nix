# { pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.exec-once = [
    # "app2unit -s b ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
    # "app2unit -s b quickshell"
    # "systemctl --user enable --now hyprsunset.service" #TODO write a script to auto do this
    # "app2unit -s b sway-audio-idle-inhibit"
    "sway-audio-idle-inhibit"
    "[workspace special:easy silent] easyeffects"
  ];
}
