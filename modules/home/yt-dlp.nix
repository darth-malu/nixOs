{
  #NOTES:
  # --ignore-config - to disable config for a single run
  programs.yt-dlp = {
    enable = true;
    extraConfig = #$XDG_CONFIG_HOME/yt-dlp/config
    ''
        -P "~/Videos/YtDlp" -P "temp:tmp"
        # Save all videos under YouTube directory in your home directory
        -o "%(channel)s-%(title)s.%(ext)s"


        # Download and merge the best video-only format and the best audio-only format,
        # or download the best combined format if video-only format is not available
        # -f "bv+ba/b"

        # Download the best video available but no better than 1080p,
        -f "bv*[height<=1080]+ba/b[height<=1080]"

    '';
    # package = pkgs-unstable.yt-dlp;
    settings = {# $XDG_CONFIG_HOME/yt-dlp/config.
      embed-thumbnail = true;
      no-overwrites = true;# Do not overwrite existing output files
      embed-metadata = false;
      embed-subs = true; # if without write-subs will delete file
      write-subs = true;
      write-thumbnail = false;
      sub-langs = "all,-live_chat"; # dwnload all safe for live chat
      downloader = "aria2c";
      downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      concurreent-fragments = 4;
      # Number of seconds to sleep before each download when used alone or a lower bound of a range for randomized sleep before each download (minimum possible number of seconds to sleep) when used
      min-sleep-interval = 1;
      max-sleep-interval = 2;
    };
  };
}
