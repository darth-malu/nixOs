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
    shellWrapperName = "y"; # yy::
    plugins = {
      # Linked to: $XDG_CONFIG_HOME/yazi/plugins/<name>.yazi
      arrow = ./plugins/arrow.yazi;
      inherit (pkgs.yaziPlugins) smart-paste;
      inherit (pkgs.yaziPlugins) smart-enter;
      inherit (pkgs.yaziPlugins) piper;

      # smart-tab: ya pkg add wekauwau/smart-tab
      # wl-clipboard: ya pkg add grappas/wl-clipboard
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
        prepend_previewers = [
          {
            name = "*.md";
            run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"$1\"";
          }
          # {
          #   name = "*/";
          #   run = "piper -- lsd";
          # }
        ];

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
            run = "mpv \"$@\"";
            orphan = true;
            for = "unix";
          }
        ];
        emacsEdit = [
          {
            run = "emacsclient -c \"$@\"";
            block = true;
            for = "unix";
          }
        ];
        vimEdit = [
          {
            run = "$EDITOR \"$@\"";
            block = true;
            for = "unix";
          }
        ];
        libreoffice = [
          {
            run = "libreoffice \"$@\"";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "xdg-open \"$@\"";
            desc = "Open files with xdg-open"; # FIXME: does not work
          }
        ];
      };
      open = {
        # needs [openers]
        rules = [
          # {
          #   mime = "text/*";
          #   use = [
          #     "vimEdit"
          #     "open"
          #   ];
          # }
          {
            mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            use = [
              "libreoffice"
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
            use = "vimEdit";
          }
          {
            name = "*.html";
            use = [
              # Multiple openers for a single rule
              "open"
              "emacsEdit"
            ];
          }
        ];
        prepend_rules = [
          {
            name = "*.org";
            use = [
              "emacsEdit"
              "open"
            ];
          }
          {
            name = "*.json";
            use = "vimEdit";
          }
          # Multiple openers for a single rule
          {
            name = "*.html";
            use = [
              "open"
              "vimEdit"
            ];
          }
        ];
        append_rules = [
          {
            mime = "text/*";
            use = [
              "vimEdit"
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
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      }; # worker -> micro tasks,
    };
  };
}
