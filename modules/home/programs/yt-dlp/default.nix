{
  #NOTES:
  # --ignore-config - to disable config for a single run
  programs.yt-dlp = {
    enable = true;

# $XDG_CONFIG_HOME/yt-dlp/config
extraConfig =
''
    -P "~/Videos/YtDlp"
    -P "temp:tmp"
    -P "subtitle:subs"
    -P "thumbnail:thumbnail"
    # -P "thumbnail:%(title)s\%(title)s.%(ext)s" # will put thumbnail in folder with same name as video

    # Save all videos under YouTube directory in your home directory
    -o "%(channel)s-%(title)s.%(ext)s"

    # Download and merge the best video-only format and the best audio-only format,
    # or download the best combined format if video-only format is not available
    # -f "bv+ba/b"

    # Download the best video available but no better than 1080p,
    # -f "bv*[height<=1080]+ba/b[height<=1080]"
    -f "bv[height<=1080]+ba/b[height<=1080]"

    # -S "fps,codec:mp4:mp3"
'';

settings = {
  embed-thumbnail = true;
  no-overwrites = true; # Do not overwrite existing output files
  embed-metadata = true;
  embed-subs = true; # if without write-subs will delete file
  write-subs = true;
  write-thumbnail = false;
  sub-langs = "en.*,-live_chat"; # all, en ja dwnload all safe for live chat
  downloader = "\${pkgs.aria2.}/bin/aria2c";
  downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
  concurrent-fragments = 4;
  # Number of seconds to sleep before each download when used alone or a lower bound of a range for randomized sleep before each download (minimum possible number of seconds to sleep) when used
  min-sleep-interval = 1;
  max-sleep-interval = 2;
};

};
 }
