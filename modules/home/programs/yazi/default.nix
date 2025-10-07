{
  inputs,
  config,
  pkgs,
  ...
}:
{
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    keymap = import ./keymap.nix;
    theme = import ./theme.nix;
    # initLua = ./init.lua;
    shellWrapperName = "y"; # yy::
    plugins = import ./plugins;
    settings = {
      mgr = {
        layout = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = true; # case
        sort_reverse = true;
        sort_dir_first = true;
        sort_translit = true; # convert Æ to AE , Â to A
        linemode = "none"; # (birthtime) btime, mtime, none
        show_hidden = false;
        show_symlink = true;
        scrolloff = 10;
      };
      preview = {
        cache_dir = config.xdg.cacheHome;
        word_wrap = "yes"; # code preview word wrap
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 2; # in spaces
        max_width = 600; # after changing do yazi --clear-cache
        max_height = 900;
        # cache_dir = ""; # specifiy absolut path for persistence
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };
      opener = {
        play = [
          {
            run = "mpv $@";
            orphan = true;
            for = "unix";
          }
        ];
        edit = [
          {
            run = "$EDITOR $@";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "xdg-open $@";
            desc = "Open files with xdg-open";
          }
        ];
      };
      open = {
        # needs [openers]
        rules = [
          {
            mime = "text/*";
            use = [
              "edit"
              "open"
            ];
          }
          {
            mime = "application/pdf";
            use = [
              "open"
            ];
          }
          {
            mime = "video/*";
            use = "play";
          }
          # { mime = "application/json", use = "edit" },
          {
            name = "*.json";
            use = "edit";
          }
          # Multiple openers for a single rule
          {
            name = "*.html";
            use = [
              "open"
              "edit"
            ];
          }
        ];
        prepend_rules = [
          {
            name = "*.json";
            use = "edit";
          }
          # Multiple openers for a single rule
          {
            name = "*.html";
            use = [
              "open"
              "edit"
            ];
          }
        ];
        # append_rules = [
        #   {
        #     name = "*";
        #     use = "my-fallback";
        #   }
        # ];
      };
      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      }; # worker -> micro tasks,
    };
  };
}
