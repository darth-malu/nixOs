{ pkgs, ... }:
{
  systemd.user.services = {
    hyprland-autoname-workspaces = {
      enable = false;
      description = "Hyprland-autoname-workspaces as systemd service";
      after = [ "graphical-session.target" ];
      requires = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      script = "${pkgs.hyprland-autoname-workspaces}/bin/hyprland-autoname-workspaces";
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 1;
    };
  };
}
