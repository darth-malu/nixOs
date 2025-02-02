{ inputs, pkgs, ...}:

{
  programs.yazi = {
    enable = true;
    # package = yazi.packages.${pkgs.system}.default;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableBashIntegration = true;
    keymap = import ./keymap.nix;
    theme = import ./theme.nix;
    plugins = import ./plugins.nix;
    settings = {
      manager = {
        layout = [ 1 4 3 ];
        sort_by = "natural";
        sort_sensitive = true; # case
        sort_reverse = true;
        sort_dir_first = true;
        sort_translit = true; # convert Æ to AE , Â to A
        # linemode = "none";
        linemode = "btime";
        show_hidden = true;
        show_symlink = true;
        scrolloff = 10;
      };
      preview = {
        word_wrap = "yes"; # code preview word wrap
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        # cache_dir = ""; # specifiy absolut path for persistence
        ueberzug_scale = 1;
        ueberzug_offset = [ 0 0 0 0 ];
      };
      # opener = {
      #   play = [ { run = 'mpv "$@"'; orphan = true; for = "unix"; } ];
      #   edit = [ { run = '$EDITOR "$@"'; block = true; for = "unix";} ];
      #   open = [ { run = 'xdg-open "$@"'; desc = "Open"; }; ];
      # };
      tasks = { micro_workers = 5; macro_workers = 10; bizarre_retry = 5; }; # worker -> micro tasks, 
    };
  };
}
