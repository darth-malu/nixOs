{
  # Display style of current position. available: line, bar
  timeline_style = "line";
  # Line display style config
  timeline_line_width = 1; # 2::
  # Render cache indicators for streaming content
  timeline_cache = true;
  # Timeline size when fully expanded, in pixels, 0 to disable
  timeline_size = 20; # 40::
  # Top border of background color to help visually separate timeline from video
  timeline_border = 1;

  controls = "menu,gap,subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality, gap, space, space, shuffle, loop-playlist, loop-file, gap, prev, items, next, gap, fullscreen";

  # Where to display volume controls: none, left, right
  volume = "none";
  volume_size = 20; # 40::
  volume_border = 1;
  volume_step = 1;
  #volume_persistency=
  ## Playback speed widget: mouse drag or wheel to change, click to reset
  speed_step = 0.4; # 0.1
  speed_step_is_factor = false;
  # speed_persistency=

  # If there's no playlist and file ends, load next file in directory
  # Uses `load_types` config below to determine what type of file to load next.
  # When enabled, usoc will set mpv config `keep-open` to `yes`, and `keep-open-pause` to `no`.
  autoload = true;
  # Hide UI when mpv autohides the cursor. Timing is controlled by `cursor-autohide` in `mpv.conf` (in milliseconds).
  autohide = true;
  # Enable uosc's playlist/directory shuffle mode
  # This simply makes the next selected playlist or directory item be random, just
  # like any other player in the world. It also has an easily togglable control button.
  shuffle = true;

  # Move files to trash (recycle bin) when deleting files. Dependencies:
  # - Linux: `sudo apt install trash-cli`
  use_trash = true;
  default_directory = "~/";
  #
  # Localization language priority from highest to lowest.
  # Also controls what languages are fetched by `download-subtitles` menu.
  # Built in languages can be found in `uosc/intl`.
  # `slang` is a keyword to inherit values from `--slang` mpv config.
  # Supports paths to custom json files: `languages=~~/custom.json,slang,en`
  languages = [
    "slang"
    "en"
  ];
  # By default, subtitles are downloaded into the directory of currently opened file.
  # If the file is being played from a URL, we use this directory instead (expands to `{mpv_config_dir}/subtitles`)
  # Prefix the path with `!` to force all subtitles to be saved there. Example: `!~~/subtitles`
  subtitles_directory = "~~/subtitles";

  # Scale the interface by this factor
  scale = 0.8; # 1::
  # Scale in fullscreen
  scale_fullscreen = 1; # 1.3::
  # Use only bold font weight throughout the whole UI
  font_bold = false;
  # Adjust the text scaling to fit your font
  font_scale = 1;

  # Border radius of buttons, menus, and all other rectangles
  border_radius = 4;

  # One of `total`, `playtime-remaining` (scaled by the current speed), `time-remaining` (remaining length of file)
  destination_time = "playtime-remaining";
  # Display sub second fraction in timestamps up to this precision
  time_precision = 0;
  # Display stream's buffered time in timeline if it's lower than this amount of seconds, 0 to disable
  buffered_time_threshold = 60;
  # Can be: flash, static, manual (controlled by flash-pause-indicator and decide-pause-indicator commands)
  pause_indicator = "flash";
  # Sizes to list in stream quality menu
  # stream_quality_options = "4320,2160,1440,1080,720,480,360,240,144";
  stream_quality_options = "1080,720";
  # Types to identify media files
  video_types = "3g2,3gp,asf,avi,f4v,flv,h264,h265,m2ts,m4v,mkv,mov,mp4,mp4v,mpeg,mpg,ogm,ogv,rm,rmvb,ts,vob,webm,wmv,y4m";
  audio_types = "aac,ac3,aiff,ape,au,cue,dsf,dts,flac,m4a,mid,midi,mka,mp3,mp4a,oga,ogg,opus,spx,tak,tta,wav,weba,wma,wv";
  image_types = "apng,avif,bmp,gif,j2k,jp2,jfif,jpeg,jpg,jxl,mj2,png,svg,tga,tif,tiff,webp";
  subtitle_types = "aqt,ass,gsub,idx,jss,lrc,mks,pgs,pjs,psb,rt,sbv,slt,smi,sub,sup,srt,ssa,ssf,ttxt,txt,usf,vt,vtt";
  playlist_types = "m3u,m3u8,pls,url,cue";
  # Type pools used by file navigation and `autoload` to determine what type of file to load next
  # Available: video,audio,image,playlist,same. `same` means the same type pool (not just extension) as currently open file.
  load_types = [
    "video"
    "audio"
    # "image"
  ];

  # A comma separated list of element IDs to disable. Available IDs:
  #   window_border, top_bar, timeline, controls, volume,
  #   idle_indicator, audio_indicator, buffering_indicator, pause_indicator
  disable_elements = [
    "pause_indicator"
    # "top_bar"
    "window_border"
  ];
  #
  ## List of mpv.conf properties respected by uosc:
  # osd-font, osd-playlist-entry, slang

  controls_size = 32; # 32::
  controls_margin = 8;
  controls_spacing = 2;
  # controls_persistency=
}
