{pkgs, osConfig, ...}:
let
    mpvScripts = with pkgs.mpvScripts; [
      mpris
      mpv-discord
      sponsorblock
      quality-menu # allows you to change the streamed video and audio quality (ytdl-format) on the fly.
      youtube-upnext # C-u (configurablea) , space to append
      mpv-cheatsheet
      mpv-playlistmanager #S-Enter
      uosc
    ];
in
{
  programs.mpv = {
    enable = true;
    bindings = {
      "ctrl+a" = "script-message osc-visibility cycle";
      "ctrl+f" = "script-binding subtitle_lines/list_subtitles";
      "tab" = "script-binding uosc/toggle-ui";
      "menu" = "script-binding uosc/menu";
      "mbtn_right" = "script-binding uosc/menu";
      # "mbtn_left" = "space cycle pause; show-text \"\${filename}\n\${time-pos} / \${duration} (\${percent-pos}%)\"; osd-bar show-progress";
      "mbtn_left" = "space cycle pause; show-progress";
      "s" = "script-binding uosc/subtitles";          #! Subtitles
      "a" = "script-binding uosc/audio";             #! Audio tracks
      "q" = "script-binding uosc/stream-quality";     #! Stream quality
      "p" = "script-binding uosc/items";              #! Playlist
      "c" = "script-binding uosc/chapters";           #! Chapters
      "alt+>" = "script-binding uosc/delete-file-next";   #! Navigation > Delete file & Next
      "alt+<"  = "script-binding uosc/delete-file-prev";   #! Navigation > Delete file & Prev
      "alt+esc" = "script-binding uosc/delete-file-quit";   #! Navigation > Delete file & Quit
      "o" = "script-binding uosc/open-file";          #! Navigation > Open file
      #           set video-aspect-override "-1"         #! Utils > Aspect ratio > Default
      #           set video-aspect-override "16:9"       #! Utils > Aspect ratio > 16:9
      #           set video-aspect-override "4:3"        #! Utils > Aspect ratio > 4:3
      #           set video-aspect-override "2.35:1"     #! Utils > Aspect ratio > 2.35:1
      #           script-binding uosc/audio-device       #! Utils > Audio devices
      #           script-binding uosc/editions           #! Utils > Editions
      "ctrl+s"  = "async screenshot";                       #! Utils > Screenshot
      "alt+i" = "script-binding uosc/keybinds";           #! Utils > Key bindings
      "O" = "script-binding uosc/show-in-directory";  #! Utils > Show in directory
      #           script-binding uosc/open-config-directory #! Utils > Open config directory
      #           script-binding uosc/update             #! Utils > Update uosc
      "esc"  = "quit"; #! Quit
    };
    scripts = mpvScripts; #FIXME > error: collision between `/nix/store/aii6s2qsz4awn6vdh49pz1g2liwjh1sz-mpv-with-scripts-0.39.0/bin/umpv' and `/nix/store/wy5f4d2sjki9v930iasmzr5538jk0nhl-mpv-with-scripts-0.39.0/bin/umpv'

    scriptOpts = {
      mpv_discordRPC = {
        rpc_wrapper = "lua-discordRPC";
        periodic_timer=1;
        cover_art = true;
        active = true;
        key_toggle = "D";
      };
      uosc = import ./scripts/uosc.nix;
    };

    profiles = {#mpv/mpv.conf
      fast = {
        vo = if osConfig.networking.hostName == "carthage" then
            "vaapi"
             else if osConfig.networking.hostName == "tangier" then
            "vdpau"
             else "";
      }; # video output backend to use
    };
    config = {
      # sub-auto = "fuzzy";
      sub-font = "VictorMono Nerd Font";
      sub-font-size = 45; # 55::The unit is the size in scaled pixels at a window height of 720. The actual pixel size is scaled with the window height: if the window height is larger or smaller than 720, the actual size of the text increases or decreases as well.
      # sub-bold = true;
      sub-pos = 100; #0-150. 100 original - % vertical. >100 sub down
      embeddedfonts = true;
      osd-on-seek = false;
      osd-font = "VictorMono Nerd Font";
      osd-font-size = 45; # 55::
      osd-bar = false; # nice with uosc
      screenshot-format = "png"; # jpeg, png, webp, avif, jxl
      audio-device = "pipewire/alsa_output.pci-0000_09_00.3.analog-stereo"; # --audio-device=help
      #audio-pitch-correction=no # Do not filter audio to keep pitch when changing playback speed.
      fs = true;
      # fs-screen = # all, current, 0-32
      # keep-open = true; # after playback ends - TODO make script for youtube. close otherwise
      livemarkers = if osConfig.networking.hostName == "carthage" then
                      true
                    else if osConfig.networking.hostName == "tangier" then
                      false
                    else false;
      force-window = true;# immediate, true, | Do not wait with showing the video window until it has loaded. (This will resize the window once video is loaded. Also always shows a window with audio.)
      # osc = false;
      # sub-bold = true;
      profile = if osConfig.networking.hostName == "carthage"then
                "high-quality"
                else if osConfig.networking.hostName == "tangier" then
                "fast"
                else "";
      gpu-context = "wayland";
      video-sync = "display-resample";
      vo = "gpu-next"; # video output driveers experimental (gpu-next ) should be better, gpu,NOTE vaapi lowquality, vdpau -x11
      ytdl-format = "bestvideo+bestaudio";
      cache = true; # yes, no , auto
      cache-pause = true; #buffering insteaad of stutter :)
      cache-pause-initial = true;
      demuxer-max-bytes="512MiB";
      demuxer-max-back-bytes="100M";
      demuxer-readahead-secs=20;
      # Store cache payload on the hard disk instead of in RAM. (This may negatively
      # impact performance unless used for slow input such as network.)
      #cache-dir=~/.cache/
      #cache-on-disk=yes
      # cache-default = 4000000; # not found?
      hwdec = "auto"; # hardware decoding, auto,auto-safe, vaapi (unsafe), set vaapi only if necessary
      slang = "en";# Display English subtitles if available.
      alang = [ "jpn" "en" ];
      vlang = "en";
      subs-match-os-language = true;
      subs-fallback = true; # if noo match select a full track
      # dither = true; #   Can help reduce banding artifacts, especially in 8-bit content.
      no-border = true; # removes black borders around the video
      save-position-on-quit = true;
      watch-later-dir = "~/Videos/mpv-watch-later";
      resume-playback = true; # resume-playback-check-mtime - use incase of similar name to match mtime with statefile
      thumbnails = "best"; # all, best , none::
      volume = 70; # startup volume
      volume-max = 100;
      # gapless-audio = true; # no, yes, weak:: #Try to play consecutive audio files with no silence or disruption at the point of file change
      # ytdl-format = "best"; #ytdl, worst, mp4, webm (Default: bestvideo+bestaudio/best)
    };
    # bindings = {#input.conf
    # };
    # extraInput = #sub config append to mpv/input.conf
      # ''
      # ''; 
  };
}
