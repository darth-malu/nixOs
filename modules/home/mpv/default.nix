# {pkgs, ...}:
{
  programs.mpv = {
    enable = true;
    # scripts = with pkgs.mpvScripts; 
    #   [ 
    #     mpris
    #     # mpv-discord
    #     # sponsorblock
    #     # quality-menu
    #     # youtube-upnext
    #     mpv-cheatsheet
    #     mpv-playlistmanager
    #   ];
    profiles = {#mpv/mpv.conf
      # fast = {vo = "vdpau";};
    };
    config = {
      # sub-auto = "fuzzy";
      sub-font = "VictorMono Nerd Font";
      # sub-bold = true;
      profile = "fast";
      gpu-context = "wayland";
      vo = "gpu";
      ytdl-format = "bestvideo+bestaudio";
      cache = true; # yes, no , auto
      demuxer-max-bytes="512MiB";
      demuxer-readahead-secs=20;
      # cache-default = 4000000; # not found?
      hwdec = "auto-safe"; #auto,auto-safe, vaapi (unsafe)
    };
    # bindings = {#input.conf
    # };
    # extraInput = #sub config append to mpv/input.conf
      # ''
      # ''; 
  };
}
