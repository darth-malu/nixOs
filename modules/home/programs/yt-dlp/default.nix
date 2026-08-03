{osConfig, ...}:
{
  programs.yt-dlp = {
    enable = true;

settings = {
  # embed-thumbnail = true;
  no-overwrites = true; # Do not overwrite existing output files
  embed-metadata = true;
  embed-subs = true; # if without write-subs will delete file
  write-subs = true;
  # write-thumbnail = false;
  sub-langs = "en.*,-live_chat"; # all, en ja dwnload all safe for live chat
  downloader = "\${pkgs.aria2}/bin/aria2c";
  downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
  concurrent-fragments = 4;
  # Number of seconds to sleep before each download when used alone or a lower bound of a range for randomized sleep before each download (minimum possible number of seconds to sleep) when used
  min-sleep-interval = 1;
  max-sleep-interval = 2;
};

# $XDG_CONFIG_HOME/yt-dlp/config
extraConfig =
if osConfig.networking.hostName == "carthage" then ''
    -P "/media/Hyogo/Videos/YouTube/Unsorted"
'' else
    '' -P "~/Videos/Youtube/Unsorted"
'' +
''
    # -P "subtitle:subs"
    --no-playlist

    # Save all videos under YouTube directory in your home directory
    -o "%(channel)s-%(title)s.%(ext)s"

    # Download the best video available but no better than 1080p,
    # -f "bv[height<=1080]+ba/b[height<=1080]"
    # -f "bv[height<=1080][vcodec^=h264]+ba/b[height<=1080]"
    # -f "(bv*[height<=1080]*[vcodec~='^((he|a)vc|h26[45])']+ba) / (bv[height<=1080]+ba/b[height<=1080])"
    -f "(bv*[height<=1080]*[vcodec~='^(hevc|h26[45])']+ba) / (bv[height<=1080]+ba/b[height<=1080])"
'';

  };
}
