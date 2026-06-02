{

title_font_size = 15;
window_top_bar = false;                # show OSC window top bar: "auto", "yes", or "no" (borderless/fullscreen)
loop_in_pause = false; # dontt think i need

compact_mode = false; # replace the jump buttons with the seek/chapter buttons
jump_buttons = false;                    # show the jump backward and forward buttons
info_button = false;
ontop_button = false;                    # show window on top button
screenshot_button = false;
playpause_size = 30;                    # icon size for the play/pause button
midbuttons_size = 20;                   # icon size for the middle buttons
sidebuttons_size = 20;                  # icon size for the side buttons
track_nextprev_buttons = true;          # show next/previous playlist track buttons

volume_control = false;                  # show mute button and volume slider
volume_control_type = "logarithmic";         # volume scale type: "linear::" or "logarithmic"

persistent_progress = true;            # always show a small progress line at the bottom of the screen
persistent_progressheight = 37;         # the height of the persistent_progress bar
persistent_buffer = true;              # on web videos, show the buffer on the persistent progress line
persistent_progresstoggle = false;       # enable toggling the persistent_progress bar

vid_scale = false;                      # scale osc with the video
scale_windowed = 0.8;                   # osc scale factor when windowed
scale_fullscreen = 1.0;                 # osc scale factor when fullscreen
scale_forced_window = 0.8;              # osc scale factor when forced (no video, like music files)

download_button = true;                 # show download button on web videos (requires yt-dlp and ffmpeg)
# download_path = "~~desktop/mpv/downloads"; # default download directory for videos (https://mpv.io/manual/master/#paths)
download_path = "~~desktop/Videos/mpvDownloads"; # default download directory for videos (https://mpv.io/manual/master/#paths)

osc_color = "#000000";                  # accent color of the OSC and title bar
window_title_color = "#FFFFFF";         # color of the title in borderless/fullscreen mode
window_controls_color = "#FFFFFF";      # color of the window controls (close, minimize, maximize) in borderless/fullscreen mode
window_controls_close_hover = "#E81123"; # color of close window control on hover
window_controls_minmax_hover = "#53A4FC";# color of min/max window controls on hover
title_color = "#FFFFFF";                # color of the title (above seekbar)
seekbarfg_color = "#1D96F5";            # color of the seekbar progress and handle, in Hex color format
seekbarbg_color = "#FFFFFF";            # color of the remaining seekbar, in Hex color format
seekbar_cache_color = "#8a2be2";        # color of the cache ranges on the seekbar
volumebar_match_seek_color = false;     # match volume bar color with seekbar color (ignores side_buttons_color)
time_color = "#FFFFFF";                 # color of the timestamps (below seekbar)
chapter_title_color = "#FFFFFF";        # color of the chapter title next to timestamp (below seekbar)
side_buttons_color = "#FFFFFF";         # color of the side buttons (audio, subtitles, playlist, etc.)
middle_buttons_color = "#FFFFFF";       # color of the middle buttons (skip, jump, chapter, etc.)
playpause_color = "#FFFFFF";            # color of the play/pause button
held_element_color = "#999999";         # color of the element when held down (pressed)
hover_effect_color = "#FFFFFF";         # color of a hovered button when hover_effect includes "color"
thumbnail_border_color = "#FFFFFF";     # color of the border for thumbnails (with thumbfast)

fade_alpha = 150;                       # alpha of the OSC background box
fade_blur_strength = 100;               # blur strength for the OSC alpha fade. caution: high values can take a lot of CPU time to render
window_fade_alpha = 75;                 # alpha of the window title bar
thumbnail_border = 0;                   # the width of the thumbnail border

# Button hover effects
hover_effect = "size,glow,color";       # active button hover effects: "glow", "size", "color"; can use multiple separated by commas
hover_button_size = 115;                # relative size of a hovered button if "size" effect is active
button_glow_amount = 5;                 # glow intensity when "glow" hover effect is active

# Progress bar settings
    seekbar_handle_size = 0.8;              # size ratio of the seekbar handle (range: 0 ~ 1)
    seek_range = true;                      # show seek range overlay
    seek_rangealpha = 175;                  # transparency of the seek range
    seekbar_keyframes = true;              # use keyframes when dragging the seekbar

    automatic_keyframe_mode = true;         # automatically set keyframes for the seekbar based on video length
    automatic_keyframe_limit = 600;         # videos longer than this (in seconds) will have keyframes on the seekbar

}
