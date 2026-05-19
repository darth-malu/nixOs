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
      # "smart-tab" = ./plugins/smart-tab.yazi; #FIXME: does not load
      inherit (pkgs.yaziPlugins)
        smart-paste
        smart-enter
        piper
        git
        jump-to-char
        # bookmarks               # FIXME mgr_emit
        toggle-pane
        wl-clipboard
        drag
        # relative-motions # - mgr_emit - FIXME: also bookmarks
        ;

      # smart-tab: ya pkg add wekauwau/smart-tab

      # TODO: make smart-tab runCommand
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
        prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];

        prepend_previewers = [
          {
            url = "*.md";
            run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"$1\"";
            # run = "piper -- echo \"$1\"";
          }
          {
            url = "*.csv";
            run = "piper -- bat -p --color=always \"$1\"";
          }
          # {
          #   url = "*/";
          #   run = "piper -- lsd";
          # }
          # {
          #   url = "*";
          #   run = "piper -- echo \"$1\"";
          # }
          {
            url = "*.tar*";
            run = "piper --format=url -- tar tf \"$1\"";
          }
          {
            mime = "application/sqlite3";
            run = "piper -- sqlite3 \"$1\" \".schema --indent\"";
          }
        ]; # TODO: fix previewers to be more perfomant

      };
      preview = {
        cache_dir = config.xdg.cacheHome; # specifiy absolut path for persistence # after changing do yazi --clear-cache
        word_wrap = "yes"; # code preview word wrap
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 2; # in spaces
        max_width = 600;
        max_height = 900;
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
          }
        ];
        emacs = [
          {
            run = "emacsclient -c -n %s"; # -c;;
            orphan = true;
          }
        ];
        emacsnw = [
          {
            run = "emacsclient -nw %s"; # -c;;
            block = true;
          }
        ];
        vim = [
          {
            run = "vim %s";
            block = true;
            for = "unix";
          }
        ];
        wps = [
          {
            run = "wps %s";
            orphan = true;
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
          {
            url = "*.org";
            use = [
              "emacsnw"
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
            mime = "text/*";
            use = [
              "emacsnw"
              "vim"
              "open"
            ];
          }
        ];
        prepend_rules = [
          {
            url = "*.json";
            use = "vim";
          }
          {
            url = "*.jsx";
            use = [
              "emacsnw"
              "emacs"
            ];
          }
          {
            url = "*.js";
            use = [
              "emacsnw"
              "emacs"
            ];
          }
          {
            url = "*.ts";
            use = [
              "emacsnw"
              "emacs"
            ];
          }
          {
            url = "*.tsx";
            use = [
              "emacsnw"
              "emacs"
            ];
          }
          {
            mime = "text/html";
            use = [
              "open"
              "emacsnw"
            ];
          }
        ];
        append_rules = [
          {
            url = "*"; # my fallback
            use = [
              "open"
              "vim"
              "emacsnw"
              "emacs"
            ];
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
