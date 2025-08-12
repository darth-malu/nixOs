{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/malu/Music";
    playlistDirectory = "/home/malu/Music/ncmpcppStuff/playlists";
    dataDir = "/home/malu/.local/share/mpd";
    dbFile = "/home/malu/.local/share/mpd/db";
    extraConfig # mpd.conf
      = ''
        audio_output {
          type "pipewire"
          name "Pipewire Sound Server"
        }

        playlist_plugin {
            name "m3u"
            enabled "true"
            # as_directory "yes"
        }

        audio_output {
          type      "fifo"
          name      "Visualizer feed"
          path      "/tmp/mpd.fifo"
          format    "44100:16:2"
          #buffer_timer "160"
        }

        input_cache {
            size "1 GB"
        }

        auto_update             "yes"
        # auto_update_depth       "2"
        follow_outside_symlinks "yes"
        follow_inside_symlinks  "yes"

        input {
            plugin "curl"
        }
      '';

    extraArgs = [
      # "--verbose"
    ];

    network = {
      port = 6600;
      listenAddress = "127.0.0.1"; # any:: also bind to /run/mpd/socket, 127.0.0.1
      startWhenNeeded = true;
    };

  };

  services.mpdris2 = {
    enable = true;
    multimediaKeys = true;
    notifications = false; # have dunst lol
    mpd = {
      #host = "config.services.mpd.network.listenAddress"; # default
      host = "localhost"; # default
      musicDirectory = "/home/malu/Music/";
      port = 6600;
      #host = "192.168.1.1";
    };
  };

  services.mpd-discord-rpc = {
    enable = true;
    settings = {
      hosts = [ "localhost:6600" ];
      format = {
        details = "$title";
        state = "On $album by $artist";
      };
    };
  };
}
