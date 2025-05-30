{

# Display style of current position. available: line, bar
timeline_style = "bar";

# Line display style config
timeline_line_width = 1; #2::

# Render cache indicators for streaming content
timeline_cache = true;

# Timeline size when fully expanded, in pixels, 0 to disable
timeline_size=25; #40::

# Comma separated states when element should always be fully visible.
# Available: paused, audio, image, video, idle, windowed, fullscreen
# timeline_persistency= "idle,paused";

# Top border of background color to help visually separate timeline from video
timeline_border=1;

# When scrolling above timeline, wheel will seek by this amount of seconds.
# Default uses fast seeking. Add `!` suffix to enable exact seeks. Example: `5!`
timeline_step=5;

controls = "menu,gap,subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality, gap, space, space, shuffle, loop-playlist, loop-file, gap, prev, items, next, gap, fullscreen";

# Where to display volume controls: none, left, right
volume = "none";
volume_size = 10; #20
volume_border = 1;
volume_step = 1;
#volume_persistency=

## Playback speed widget: mouse drag or wheel to change, click to reset
speed_step = 0.4;
speed_step_is_factor = false;
# speed_persistency=

# Move files to trash (recycle bin) when deleting files. Dependencies:
# - Linux: `sudo apt install trash-cli`
# - MacOS: `brew install trash`
use_trash = true;

# Hide UI when mpv autohides the cursor. Timing is controlled by `cursor-autohide` in `mpv.conf` (in milliseconds).
autohide = true;

default_directory = "~/";

autoload = true;

shuffle = true;

# Enable uosc's playlist/directory shuffle mode
# This simply makes the next selected playlist or directory item be random, just
# like any other player in the world. It also has an easily togglable control button.

languages = [
  "slang"
  "en"
];
# Localization language priority from highest to lowest.
# Also controls what languages are fetched by `download-subtitles` menu.
# Built in languages can be found in `uosc/intl`.
# `slang` is a keyword to inherit values from `--slang` mpv config.
# Supports paths to custom json files: `languages=~~/custom.json,slang,en`

subtitles_directory = "~~/subtitles";

pause_indicator = "flash"; # flash, static, manual(controlled by flash-pause-indicator and decide-pause-indicator commands)

stream_quality_options = "1080,720,480";

# Scale the interface by this factor
scale = 1; # 1::
# Scale in fullscreen
scale_fullscreen = 1.3; # 1.3::
# Adjust the text scaling to fit your font
font_scale = 1; #0.8

# Use only bold font weight throughout the whole UI
font_bold = false;

# One of `total`, `playtime-remaining` (scaled by the current speed), `time-remaining` (remaining length of file)
destination_time = "playtime-remaining";
# Display sub second fraction in timestamps up to this precision
time_precision = 0;
# Display stream's buffered time in timeline if it's lower than this amount of seconds, 0 to disable
buffered_time_threshold = 60;

video_types = "3g2,3gp,asf,avi,f4v,flv,h264,h265,m2ts,m4v,mkv,mov,mp4,mp4v,mpeg,mpg,ogm,ogv,rm,rmvb,ts,vob,webm,wmv,y4m";
audio_types = "aac,ac3,aiff,ape,au,cue,dsf,dts,flac,m4a,mid,midi,mka,mp3,mp4a,oga,ogg,opus,spx,tak,tta,wav,weba,wma,wv";
image_types = "apng,avif,bmp,gif,j2k,jp2,jfif,jpeg,jpg,jxl,mj2,png,svg,tga,tif,tiff,webp";
subtitle_types = "aqt,ass,gsub,idx,jss,lrc,mks,pgs,pjs,psb,rt,sbv,slt,smi,sub,sup,srt,ssa,ssf,ttxt,txt,usf,vt,vtt";
playlist_types = "m3u,m3u8,pls,url,cue";

load_types = [
  "video"
  "audio"
  # "image"
];

# A comma separated list of element IDs to disable. Available IDs:
#   window_border, top_bar, timeline, controls, volume,
#   idle_indicator, audio_indicator, buffering_indicator, pause_indicator
# disable_elements="window_border";
#
## List of mpv.conf properties respected by uosc:
# osd-font, osd-playlist-entry, slang

controls_size = 32;
controls_margin = 8;
controls_spacing = 2;
# controls_persistency=

}
