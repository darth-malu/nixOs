{ pkgs, osConfig, ... }:

{
  imports = [
   ./non-nixpkgs-scripts
  ];
  programs.mpv = {
    enable = true;

scripts = with pkgs.mpvScripts; [
  mpris
  # sponsorblock # TODO not need?
  # quality-menu
  youtube-upnext # C-u (configurable) , space to append. 'up next'/recommended youtube videos
  mpv-cheatsheet # use ?
  mpv-playlistmanager # S-Enter to add to playlist
  uosc
  memo # recent files menu
  # modernx-zydezu
  thumbfast
  # evafast # provides evafast/toggle script-binding for speeding up independently of the hybrid key. TODO need?
  # eisa01.smartskip
  # visualizer
  webtorrent-mpv-hook
];

scriptOpts = {

# uosc = import ./scripts/uosc.nix;
uosc = import ./scriptOpts/uosc.nix;

modernx-zydezu = import ./scriptOpts/modernx-zydezu.nix;

};

bindings = {

Y = "script-binding quality_menu/video_formats_toggle";
# Alt+f script-binding quality_menu/audio_formats_toggle
# "ctrl+a" = "script-message osc-visibility cycle";
# "ctrl+f" = "script-binding subtitle_lines/list_subtitles";
# "menu" = "script-binding uosc/menu";
"mbtn_right" = "script-binding uosc/menu";
# "mbtn_right" = "cycle pause; show-text \"\${filename}\n\${time-pos} / \${duration} (\${percent-pos}%)\"; osd-bar show-progress";
"mbtn_left" = "cycle pause; show-progress";
# "ctrl+s" = "async screenshot"; # ! Utils > Screenshot
"esc" = "quit"; # ! Quit
# p = "script-binding webtorrent/toggle-info";

s = "script-binding uosc/subtitles"; # ! Subtitles

a = "script-binding uosc/audio"; # ! Audio tracks

q = "script-binding uosc/stream-quality"; # ! Stream quality

p = "script-binding uosc/items"; # ! Playlist

c = "script-binding uosc/chapters"; # ! Chapters

# d = "script-message-to youtube_download menu"; # ! Download

o = "script-binding uosc/open-file"; # ! Navigation > Open file

O = "script-binding uosc/show-in-directory"; # ! Utils > Show in directory

"alt+i" = "script-binding uosc/keybinds"; # ! Utils > Key bindings

tab =  "script-binding uosc/toggle-ui"; # ! darth toggle
# "alt+>" = "script-binding uosc/delete-file-next"; # ! Navigation > Delete file & Next
# "alt+<" = "script-binding uosc/delete-file-prev"; # ! Navigation > Delete file & Prev
# "alt+esc" = "script-binding uosc/delete-file-quit"; # ! Navigation > Delete file & Quit
          # set video-aspect-override "-1"         #! Utils > Aspect ratio > Default
          # set video-aspect-override "16:9"       #! Utils > Aspect ratio > 16:9
          # set video-aspect-override "4:3"        #! Utils > Aspect ratio > 4:3
          # set video-aspect-override "2.35:1"     #! Utils > Aspect ratio > 2.35:1
          # script-binding uosc/audio-device       #! Utils > Audio devices
          # script-binding uosc/editions           #! Utils > Editions
          # script-binding uosc/open-config-directory #! Utils > Open config directory
          # script-binding uosc/update             #! Utils > Update uosc

};

profiles = {
  # mpv/mpv.conf
  fast = {
    vo =
      if osConfig.networking.hostName == "carthage" then
        "gpu"
        # "vaapi"
      else
        # "vdpau"
        "nvdec" ;
  }; # video output backend to use
  high-quality = {
    vo =
      if osConfig.networking.hostName == "carthage" then
        "gpu-next" # change to gpu if issues
      else
        # "vdpau"
        "nvdec" ;
  };
};

config = {

osd-on-seek = false;
osd-font = "quicksand"; #VictorMono Nerd Font
osd-font-size = 38; # 55::
osd-bar = false; # nice with uosc
osc = false; # for modernx

audio-device =
  if osConfig.networking.hostName == "carthage" then
    "pipewire/alsa_output.pci-0000_09_00.3.analog-stereo"
  else if osConfig.networking.hostName == "tangier" then
    "pipewire/alsa_output.pci-0000_00_1b.0.analog-stereo"
  else
    "pipewire"; # FIXME no default option test further
# --audio-device=help
#audio-pitch-correction=no # Do not filter audio to keep pitch when changing playback speed.

fs = false; # fullscreen
# fs-screen = # all, current, 0-32

profile =
  if osConfig.networking.hostName == "carthage" then
    "high-quality"
  else
    "fast";

gpu-context = "wayland";

video-sync =
  if osConfig.networking.hostName == "carthage" then
    "display-resample"
  else if osConfig.networking.hostName == "tangier" then
    "audio"
  else
    "audio";

hwdec = "auto"; # hardware decoding, auto,auto-safe, vaapi (unsafe)
vo =
  if osConfig.networking.hostName == "carthage" then
    "gpu-next"
  else if osConfig.networking.hostName == "tangier" then
    "gpu"
  else
    "gpu";

# ytdl-format = "bestvideo+bestaudio"; # ytdl,"best"  worst, mp4, webm (Default: bestvideo+bestaudio/best)
ytdl-format = "bv[height<=1080]+ba/b[height<=1080]"; # ytdl,"best"  worst, mp4, webm (Default: bestvideo+bestaudio/best)

cache = true; # yes, no , auto
cache-pause = true; # buffering insteaad of stutter :)
cache-pause-initial = true;
demuxer-max-bytes = "512MiB";
demuxer-max-back-bytes = "100M";
demuxer-readahead-secs = 20;
# Store cache payload on the hard disk instead of in RAM. (This may negatively
# impact performance unless used for slow input such as network.)
#cache-dir=~/.cache/
#cache-on-disk=yes
# cache-default = 4000000; # not found?

slang = "en"; # Display English subtitles if available.
alang = [
  "jpn"
  "en"
];
vlang = [ "jpn" "en" ];
# sub-auto = "fuzzy";
sub-font = "VictorMono Nerd Font";
sub-font-size = 40; # 55::The unit is the size in scaled pixels at a window height of 720. The actual pixel size is scaled with the window height: if the window height is larger or smaller than 720, the actual size of the text increases or decreases as well.
# sub-bold = true;
sub-pos = 100; # 0-150. 100 original - % vertical. >100 sub down
subs-match-os-language = true; #TODO test this further
subs-fallback = true; # if noo match select a full track



save-position-on-quit = true;
watch-later-dir = "~/Videos/mpv-watch-later";
resume-playback = true; # resume-playback-check-mtime - use incase of similar name to match mtime with statefile
# thumbnails = "best"; # all, best , none:: #FIXME failed

volume = 70; # startup volume
volume-max = 100;
gapless-audio = true; # no, yes, weak:: #Try to play consecutive audio files with no silence or disruption at the point of file change

border = false; # for mordernx etc
embeddedfonts = true;
screenshot-format = "png"; # jpeg, png, webp, avif, jxl

# idle = true;
# force-window = true;

# dither = true; #   Can help reduce banding artifacts, especially in 8-bit content.

}; # end of config
 # extraInput = #sub config append to mpv/input.conf
 # ''
 # '';

}; # end of mpv
} # EOF
