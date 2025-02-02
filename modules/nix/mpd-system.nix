{ config, ... }:#NOTE: is config <nixpkgs>.options?

{
    services.mpd = {
      #user = "mpd";
      enable = true;
      user = "malu";
    };

    systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.malu.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
    };

}
