{
  inputs,
  pkgs,
  system,
  config,
  ...
}:
{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${system}.default;
    activeConfig = "./qs_config"; # null:: if null $XDG_CONFIG_HOME/quickshell
    systemd = {
      enable = true;
      target = "hyprland-session.target"; # config.wayland.systemd.target::
    };
  };
}
