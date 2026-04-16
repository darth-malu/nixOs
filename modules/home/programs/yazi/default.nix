{
  inputs,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xdg-desktop-portal-termfilechooser
    glow
    ripdrag
    ueberzugpp
  ];

  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    keymap = import ./keymap.nix;
    theme = import ./theme.nix;
    initLua = ./init.lua;
    shellWrapperName = "y";
    plugins = {
      # Linked to: $XDG_CONFIG_HOME/yazi/plugins/<name>.yazi
      arrow = ./plugins/arrow.yazi;
      inherit (pkgs.yaziPlugins) smart-paste;
      inherit (pkgs.yaziPlugins) smart-enter;
      inherit (pkgs.yaziPlugins) piper;
      # inherit (pkgs.yaziPlugins) git;
      # inherit (pkgs.yaziPlugins) gvfs; # TODO:
      inherit (pkgs.yaziPlugins) jump-to-char;
      inherit (pkgs.yaziPlugins) bookmarks;
      # inherit (pkgs.yaziPlugins) toggle-pane;
      inherit (pkgs.yaziPlugins) wl-clipboard;
      inherit (pkgs.yaziPlugins) drag; # Drag files using ripdrag

      # smart-tab: ya pkg add wekauwau/smart-tab
    };
    settings = {
      mgr = {
        layout = [
          1
          4
          3
        ];
        sort_by = "btime"; # natural
        sort_sensitive = true; # case
        sort_reverse = true;
        sort_dir_first = true;
        sort_translit = true; # convert Æ to AE , Â to A
        linemode = "none"; # (birthtime) btime, mtime, none
        show_hidden = false;
        show_symlink = true;
        scrolloff = 10;
        title_format = ""; # {cwd}
      };
      plugin = {
        # prepend_fetchers = {
        #   id = "git";
        #   url = "*";
        #   run = "git";
        #   group = "git";
        # };
        prepend_previewers = [
          # {
          #   name = "*.md";
          #   run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"$1\"";
          #   # run = "piper -- echo \"$1\"";
          # }
          # {
          #   url = "*.csv";
          #   run = "piper -- bat -p --color=always \"$1\"";
          # }
          # {
          #   name = "*/";
          #   run = "piper -- lsd";
          # }
          # {
          #   name = "*";
          #   run = "piper -- echo \"$1\"";
          # }
          # {
          #   url = "*.tar*";
          #   run = "piper --format=url -- tar tf \"$1\"";
          # }
          # {
          #   mime = "application/sqlite3";
          #   run = "piper -- sqlite3 \"$1\" \".schema --indent\"";
          # }
        ]; # TODO: fix previewers to be more perfomant

      };
      preview = {
        cache_dir = config.xdg.cacheHome;
        word_wrap = "yes"; # code preview word wrap
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 2; # in spaces
        max_width = 600;
        max_height = 900;
        # cache_dir = ""; # specifiy absolut path for persistence # after changing do yazi --clear-cache
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
            run = "mpv %S";
            orphan = true;
            for = "unix";
          }
        ];
        emacs = [
          {
            run = "emacsclient -c %s";
            block = true;
            for = "unix";
          }
        ];
        vim = [
          {
            run = "vim %s";
            block = true;
            for = "unix";
          }
        ];
        libreoffice = [
          {
            run = "libreoffice %s";
            block = true;
            for = "unix";
          }
        ];
        wps = [
          {
            run = "wps %s";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "xdg-open %S";
            desc = "Open files with xdg-open";
            orphan = true;
          }
        ];
      };
      open = {
        # needs [openers]
        rules = [
          # {
          #   mime = "text/*";
          #   use = [
          #     "vim"
          #     "open"
          #   ];
          # }
          {
            mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            use = [
              "wps"
              "open"
            ];
          }
          {
            mime = "application/pdf";
            use = "open";
          }
          {
            mime = "video/*";
            use = "play";
          }
          {
            mime = "image/*";
            use = "open";
          }
          {
            name = "*.json";
            use = "vim";
          }
          {
            name = "*.html";
            use = [
              # Multiple openers for a single rule
              "open"
              "emacs"
            ];
          }
        ];
        prepend_rules = [
          {
            name = "*.org";
            use = [
              "emacs"
              "open"
            ];
          }
          {
            name = "*.json";
            use = "vim";
          }
          # Multiple openers for a single rule
          {
            name = "*.docx";
            use = [
              "wps"
              "open"
            ];
          }
        ];
        append_rules = [
          {
            mime = "text/*";
            use = [
              "emacs"
              # "vim"
              "open"
            ];
          }
          {
            name = "*"; # my fallback
            use = "open";
          }
        ];
      };
      tasks = {
        micro_workers = 10; # 10::
        macro_workers = 10; # 10::
        # bizarre_retry = 5;
      }; # worker -> micro tasks,
    };
  };
}
