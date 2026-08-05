{
  config,
  lib,
  pkgs,
  ...
}:

{
  # FIXME: translate
  /*
    systemctl --user edit --full --force hyprland-session.target

        [Unit]
        Description=Hyprland session
        BindsTo=graphical-session.target
        Wants=graphical-session-pre.target
        After=graphical-session-pre.target
        PropagatesStopTo=graphical-session.target
  */
  systemd.user.targets."hyprland-session" = {
    Description = "Hyprland session";
    BindsTo = [ "graphical-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
    PropagatesStopTo = [ "graphical-session.target" ];
  };
}
