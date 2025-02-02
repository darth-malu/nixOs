{inputs, ...}:

{
  imports = [
    inputs.wayland-pipewire-idle-inhibit.homeModules.default
  ];

  services.wayland-pipewire-idle-inhibit = {
    enable = true;
    #systemdTarget = "sway-session.target";
    #systemdTarget = "graphical-session.target";
    systemdTarget = "graphical-session.target";
    settings = {
      verbosity = "INFO";
      media_minimum_duration = 10;
      idle_inhibitor = "wayland";
      sink_whitelist = [
        #{ name = "Family 17h (Models 00h-0fh) HD Audio Controller Analog Stereo"; }
        "Family 17h (Models 00h-0fh) HD Audio Controller Analog Stereo"
      ];
      node_blacklist = [
        { name = "spotify"; }
        { app_name = "Music Player Daemon"; }
        { app_name = ".*mpd.*"; }
        { name = "mpd"; }
        { name = ".*mpd.*"; }
      ];
    };
  };
}
