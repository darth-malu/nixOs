{ inputs, system, ... }:
{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${system}.default;
    # activeConfig = "/home/malu/Shibuya/modules/home/programs/hyprland/hyprland-helper/quickshell"; # if null:: use $XDG_CONFIG_HOME/quickshell
    systemd = {
      enable = true;
      target = "hyprland-session.target"; # config.wayland.systemd.target::
    };
  };
}
