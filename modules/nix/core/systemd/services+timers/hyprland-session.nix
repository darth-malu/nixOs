{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd.user.targets."hyprland-session" = {
    Unit = {
      Description = "Hyprland session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
      PropagatesStopTo = [ "graphical-session.target" ];
    };
  };
}
