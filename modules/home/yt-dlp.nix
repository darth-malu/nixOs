{
  programs.yt-dlp = {
    enable = true;
    extraConfig = #$XDG_CONFIG_HOME/yt-dlp/config
    ''
        # Lines starting with # are comments

        # Always extract audio
        # -x

        # Do not copy the mtime
        # --no-mtime

        # Use this proxy
        #--proxy 127.0.0.1:3128

        # Save all videos under YouTube directory in your home directory
        -o ~/Videos/YtDlp/%(title)s.%(ext)s

        # --windows-filenames

        # Do not overwrite existing output files
        --no-overwrites

        #Write thumbnail image to disk
        # --write-thumbnail

        # Output progress bar as new lines
        #--newline

        #Video format code
        --format bestvideo*+bestaudio/best

        #Write subtitle file
        --write-subs

        # Download all the available subtitles
        # --all-subs

        # merge subtitles into video file
        --embed-subs

        # Embed metadata to the video file. Also adds chapters to file
        --embed-metadata

        #Specify ffmpeg audio quality to use
        #--audio-quality QUALITY

        # Download only the video, if the URL refers to a video AND a playlist
        #--yes-playlist

        # Number of seconds to sleep before each download when used alone or a lower bound of a range for randomized sleep before each download (minimum possible number of seconds to sleep) when used
        --min-sleep-interval 1
        --max-sleep-interval 2

        # Number of fragments of a dash/hlsnative video that should be download concurrently (default is 1)
        --concurrent-fragments 4
    '';
    # package = pkgs-unstable.yt-dlp;
    settings = {

    };
  };
}
