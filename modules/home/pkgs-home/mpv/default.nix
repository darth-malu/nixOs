{ pkgs, osConfig, ... }:
let

mpvScripts = with pkgs.mpvScripts; [
  mpris
  # mpv-discord #TODO too much work lol
  # sponsorblock # TODO not need?
  quality-menu # allows you to change the streamed video and audio quality (ytdl-format) on the fly.
  youtube-upnext # C-u (configurablea) , space to append
  mpv-cheatsheet # use ?
  mpv-playlistmanager # S-Enter to add to playlist
  # uosc
  modernx-zydezu
  thumbfast # thumbnails
];

in
{
  programs.mpv = {
    enable = true;

scripts = mpvScripts;
scriptOpts = {

modernx-zydezu = import ./scriptOpts/modernx-zydezu.nix;

playlistmanager = import ./scriptOpts/playlistManager.nix;

};

bindings = import ./keybindings.nix // {
  Y = "script-binding quality_menu/video_formats_toggle";
  # Alt+f script-binding quality_menu/audio_formats_toggle
};

extraInput = ''
 b  quit #! Quit
'';

profiles = {
  # mpv/mpv.conf
  fast = {
    vo =
      if osConfig.networking.hostName == "carthage" then
        "vaapi"
      else if osConfig.networking.hostName == "tangier" then
        # "vdpau"
        "nvdec"
      else
        "";
  }; # video output backend to use
};

config = {

osd-on-seek = false;
osd-font = "VictorMono Nerd Font";
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
# keep-open = true; # after playback ends - TODO make script for youtube. close otherwise
# livemarkers = #FIXME test if failed
#   if osConfig.networking.hostName == "carthage" then
#     true
#   else if osConfig.networking.hostName == "tangier" then
#     false
#   else
#     false;
# force-window = false; # FIXME not working for audio # immediate, true, | Do not wait with showing the video window until it has loaded. (This will resize the window once video is loaded. Also always shows a window with audio.)
# sub-bold = true;

profile =
  if osConfig.networking.hostName == "carthage" then
    "high-quality"
  else if osConfig.networking.hostName == "tangier" then
    "fast"
  else
    "";
gpu-context = "wayland";

video-sync =
  if osConfig.networking.hostName == "carthage" then
    "display-resample"
  else if osConfig.networking.hostName == "tangier" then
    "audio"
  else
    "audio";

hwdec = "auto"; # hardware decoding, auto,auto-safe, vaapi (unsafe), set vaapi only if necessary
vo =
  # video output drivers experimental (gpu-next ) should be better, gpu,NOTE vaapi lowquality, vdpau -x11
  if osConfig.networking.hostName == "carthage" then
    "gpu-next"
  else if osConfig.networking.hostName == "tangier" then
    "gpu"
  else
    "gpu";

# ytdl-format = "bestvideo+bestaudio"; # ytdl,"best"  worst, mp4, webm (Default: bestvideo+bestaudio/best)
ytdl-format = "bv*[height<=1080]+ba/b[height<=1080]"; # ytdl,"best"  worst, mp4, webm (Default: bestvideo+bestaudio/best)

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
# dither = true; #   Can help reduce banding artifacts, especially in 8-bit content.

}; # end of config
 # extraInput = #sub config append to mpv/input.conf
 # ''
 # '';

}; # end of mpv
} # EOF
