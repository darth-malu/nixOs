{
  compact_mode = true;
  info_button = false;
  title_font_size = 15;
  seekbar_handle_size = 0;
  jump_buttons = false;                    # show the jump backward and forward buttons
  window_top_bar = false;                # show OSC window top bar: "auto", "yes", or "no" (borderless/fullscreen)
  ontop_button = false;                    # show window on top button
  screenshot_button = false;
  loop_in_pause = false; # dontt think i need
  playpause_size = 30;                    # icon size for the play/pause button
  midbuttons_size = 24;                   # icon size for the middle buttons
  sidebuttons_size = 24;                  # icon size for the side buttons

persistent_progress = true;            # always show a small progress line at the bottom of the screen
persistent_progressheight = 37;         # the height of the persistent_progress bar
persistent_buffer = true;              # on web videos, show the buffer on the persistent progress line
persistent_progresstoggle = true;       # enable toggling the persistent_progress bar

download_button = true;                 # show download button on web videos (requires yt-dlp and ffmpeg)
# download_path = "~~desktop/mpv/downloads"; # default download directory for videos (https://mpv.io/manual/master/#paths)
download_path = "~/Videos/mpvDownloads"; # default download directory for videos (https://mpv.io/manual/master/#paths)
}
