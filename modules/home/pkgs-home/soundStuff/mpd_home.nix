#{ config, pkgs, ... }:

{
    services.mpd = {
      enable = true;
      musicDirectory = "/home/malu/Music/";
      playlistDirectory =  "/home/malu/Music/playlistUnion";#"/home/malu/.local/share/mpd/playlistDirectory"
      dataDir = "/home/malu/.local/share/mpd"; #"/home/malu/.local/ncmpcppDataDir/"
      dbFile = "/home/malu/.local/share/mpd/db";

      extraConfig = ''
        audio_output {
          type "pipewire"
          name "Pipewire Sound Server"
        }
        audio_output {
          type      "fifo"
          name      "Visualizer feed"
          path      "/tmp/mpd.fifo"
          format    "44100:16:2"
          #buffer_timer "160"
        }

        auto_update             "yes"
        auto_update_depth       "2"
        follow_outside_symlinks "yes"
        follow_inside_symlinks  "yes"

        input {
            plugin "curl"
        }
      '';

      extraArgs = [
        "--verbose"
      ];

      network = {
        port = 6600;
        listenAddress = "127.0.0.1"; #any
        startWhenNeeded = true;
      };

      #dataDir = "\${dataDir}/playlists";
      #ncmpcpp_directory = ~/.config/ncmpcpp
      #lyrics_directory = ~/.local/share/darth_ncmpcpp
      #external_editor = "/usr/bin/nvim"
      #execute_on_song_change = ~/.darth/scripts/player/songinfo.sh
      #media_library_primary_tag = genre
      #mouse_support = no
      #startup_screen = playlist
      #startup_slave_screen = media_library
      #playlist_disable_highlight_delay = 5
      #allow_for_physical_item_deletion = "yes"
    # end of mpd
    };

    services.mpdris2 = {
      enable = true;
      multimediaKeys = true;
      notifications = false; #have dunst lol
      mpd = {
        #host = "config.services.mpd.network.listenAddress"; # default
        host = "localhost"; # default
        musicDirectory = "/home/malu/Music/";
        port = 6600;
        #host = "192.168.1.1";
      };
    };
}
