{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        scheme-medium
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );

  # R-with-my-packages = pkgs.rWrapper.override {
  #   packages = with pkgs.rPackages; [
  #     ggplot2
  #     dplyr
  #     xts
  #   ];
  # };
  # RStudio-with-my-packages = pkgs.rstudioWrapper.override {
  #   packages = with pkgs.rPackages; [
  #     ggplot2
  #     dplyr
  #     xts
  #   ];
  # };
in
{
  imports = [
    ./yt-dlp.nix
    ./qutebrowser
    ./soundStuff
    ./mpv
    ./git.nix
    # ./tmux
    ./emacs
    ./yazi
    ../terminal
    ../bash
    ../hyprland
    ../textEditor
    inputs.nyaa.homeManagerModule
  ];

  # modules
  homeHyprland.enable = lib.mkIf osConfig.hyprland.enable true;

  home.packages =
    with pkgs;
    [
      sway-audio-idle-inhibit
      wev
      # tldr - using emacs one lol

      # disk management
      duf
      ncdu
      # superfile # kinda cool but dont need
      #testdisk # also installs photorec
      # testdisk-qt
      # gsmartcontrol
      # squirreldisk #kinda nice
      # qdiskinfo
      # win-disk-writer
      # qalculate-qt # #FIXME:for rofi?
      dotool
      # calc
      #aria2#NOTE: learn
      qbittorrent

      # ntfs3g # NOTE: trying whichever which way
      tokei

      # archive
      # zip xz unzip p7zip

      #rofimoji bemoji
      modem-manager-gui
      modemmanager # saves the day with no internet
      # taskwarrior3
      # taskwarrior-tui

      # utilities
      file
      lsof # list open files/ports**
      usbutils # lsusb, usb-devices, usb-view(optional gui)
      pciutils # lspci
      util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
      lm_sensors

      ventoy-full # usb imager #woeusb

      # perfomance monitoring
      mission-center
      iftop
      nethogs

      #gnome.nautilus gnome.sushi gnome.file-roller gnome.yelp

      trash-cli # for move to trash mpv
      # xorg.libxcb # for ffmpeg x11grab?
      wf-recorder

      telegram-desktop
      discord
      whatsapp-for-linux # socials

      # browserr
      # chromium
      # lynx # terminal browser pretty fun -> on emacs now
      google-chrome
      # bluemail # TODO move to mu4e

      # Entertainment
      # lollypop # cantata better
      mpc-cli
      # ymuse # rudimentary
      cantata
      youtube-tui # https://siriusmart.github.io/youtube-tui/
      spotify
      easyeffects

      # productivity
      buku # TODO: test
      # groff
      # ghostscript
      # obsidian
      # glow # TODO: test this extensively # see quart for blog with markdown
      #blender
      # blender-hip # accelarated render
      # freeglut
      # gcc
      hyprpicker
    ]
    ++ import ./pkg-groups/emacs.nix
    ++ (with pkgs; [
      # creative space
      #(ffmpeg.override { withXcb = true;  })
      # davinci-resolve
      #  ffmpeg
      spotube
      spotify-cli-linux
      spotube
      kdePackages.kdenlive
      # digikam
    ])
    ++ (with pkgs; [
      # NOTE: MANGA stuff
      # komikku # broken
      mangal
      ani-cli
      miru
      #syncyomi - sync tachiyomi progress across devices
    ])
    ++
      # NOTE: selective
      (
        if osConfig.networking.hostName == "carthage" then
          with pkgs;
          [
            gimp
            obs-studio
            obs-cli
            ffmpeg-full # full vs vanilla?
          ]
        else if osConfig.networking.hostName == "tangier" then
          [
            ffmpeg
          ]
        else
          [ ]
      );

  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.

    java = {
      enable = true;
      # package = pkgs.jdk23;
    };

    ripgrep = {
      enable = true;
      arguments = [
        # https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };

    comodoro = {
      # TODO: use
      enable = false;
    };

    lsd = {
      enable = true;
      # enableAliases = true; #NOTE has been deprecated and replaced with integration options per shell, for example, 'programs.lsd.enableBashIntegration'.
      enableBashIntegration = true;
      colors = {
        # $XDG_CONFIG_HOME/lsd/colors.yaml
        icons = {
          extension = {
            go = "";
            hs = "";
          };
          filetype = {
            dir = "📂";
            file = "📄";
          };
          name = {
            ".cargo" = "";
            ".trash" = "";
          };
        };
        size = {
          large = "dark_yellow";
          none = "grey";
          small = "yellow";
        };
        settings = {
          date = "relative";
          ignore-globs = [
            ".git"
            ".hg"
          ];
        };
      };
    };

    # eza = {
    #   enable = true;
    # };
    pandoc = {
      enable = true;
    };

    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git"
        "*.bak"
      ];
      extraOptions = [
        # extra options to pass to fd
        "--no-ignore"
        "--absolute-path"
      ];
    };

    freetube = {
      enable = true;
      # package = pkgs-unstable.freetube;
      settings = {
        allowDashAv1Formats = true;
        checkForUpdates = false;
        defaultQuality = "1080";
        baseTheme = "catppuccinMocha";
      };
    };

    fastfetch = {
      enable = true;
      # package = pkgs-unstable.fastfetch;
      settings = {
        # $XDG_CONFIG_HOME/fastfetch/config.jsonc
        logo = {
          source = "nixos_small"; # nixos_small #nixos_old
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          # separator = "  ";
          separator = " ";
        };
        modules = [
          # "os"
          {
            "type" = "os";
            "key" = "DISTRO";
            "keyColor" = "red";
          }
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }
          "break"
          "player"
          # "media"
          # {
          #   "type" = "media";
          #   "key" = "NOW PLAYING";
          #   "format" = "{?artist}{artist} - {?}{title}";
          #   "keyColor" = "cyan";
          # }
          # "break"
          {
            "type" = "display";
            "key" = "MONITOR ({name})";
            "keyColor" = "blue";
            # "format" = "{width}x{height} @ {refresh-rate} Hz - {physical-width}x{physical-height} mm ({inch} inches, {ppi} ppi)";
            "format" = "{width}x{height} @ {refresh-rate} Hz";
          }
          # "uptime"
          "packages"
        ];
      };
    };

    git-credential-oauth = {
      enable = true;
      extraFlags = [ "-device" ];
      # package = pkgs-unstable.git-credential-oauth;
    };

    imv = {
      enable = false;
      settings = {
        options.background = "ffffff";
        aliases.x = "close";
      };
    };

    # ssh = { #FIXME: makes thinigs worse? lol
    # enable = true;
    # controlPersist = "10m"; # whether control socket should remain open in background
    # extraConfig = "";
    # extraOptionOverrides = { # extra SSH config that take precedence over any host specific config
    # forwardAgent = true; #false:: ; Whether the connection to the authentication agent (if any) will be forwarded to the remote machine.
    # };
    # };

    lazygit = {
      enable = true;
      settings = {
        # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
        gui.theme = {
          lightTheme = true;
          activeBorderColor = [
            "blue"
            "bold"
          ];
          inactiveBorderColor = [ "black" ];
          selectedLineBgColor = [ "default" ];
        };
      };
    };

    fzf = {
      enable = true;
      enableBashIntegration = true; # true::
      tmux = {
        enableShellIntegration = true; # sets FZF_TMUX=1
        shellIntegrationOptions = [ "-p 50%,60%" ]; # -d 40% #TODO: see more # fzf-tmux --help
      };
      colors = {
        # https://github.com/junegunn/fzf/wiki/Color-schemes
        # bg -> background
        # bg+ -> current line background plus associated border
        # fg -> # text above current line - default text
        # fg + -> # text current line; ~ matched pattern
        # hl -> # highlighted substrings, ~ current line
        # hl+ -> # highlighted substrings(current line)
        # bg = "#1e1e1e";
        bg = "#022223";
        # "bg+" = "#9381ff";
        "bg+" = "#222436"; # #022223 - green, #222436 - tokyo
        # fg = "#93E1D8";
        # fg = "#4ED4BC";
        fg = "#4ED4BC";
        "fg+" = "#0FA3B1";
        # fg = "#9400FF";
        # "fg+" = "#d4d4d4";
        # "fg+" = "#DA4167";
        "gutter" = "#022223";
        # "hl" = "#0FA3B1";
        # "hl+" = "#F1DEDE";
        # "hl" = "#F7567C";
        "hl" = "#9400FF";
        "hl+" = "#FCFCFC";
        # "hl+" = "#9400FF";
        # "hl+" = "#4ED4BC";
        # "preview-fg" = "";
        # "preview-bg" = "";
        "pointer" = "#4F345A";
      };
      defaultCommand = "fd --type f";
      defaultOptions = [
        # FZF_DEFAULT_OPTS
        "--height 40%"
        "--border"
        # "--border none"
        # "--layout reverse"
        # "--tmux center;60%;50%  --layout reverse" #--tmux is silently ignored when you're not on tmux.# reverse; reverse-list
        # "--style minimal"
        # "--cycle"
        # "--gap 1"
        # "--scroll-off=4"
      ];
      changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ]; # M-c binding
      # changeDirWidgetCommand = "fd --type d";
      # fileWidgetCommand = "fd --type f"; #C-t #FIXME: broken $FZF_DEFAULT_OPTS: invalid command line string
      # fileWidgetOptions = ["preview 'head {}"];
      historyWidgetOptions = [
        "--sort"
        "--exact"
      ];
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
      syntaxes = {
        gleam = {
          src = pkgs.fetchFromGitHub {
            owner = "molnarmark";
            repo = "sublime-gleam";
            rev = "2e761cdb1a87539d827987f997a20a35efd68aa9";
            hash = "sha256-Zj2DKTcO1t9g18qsNKtpHKElbRSc9nBRE2QBzRn9+qs=";
          };
          file = "syntax/gleam.sublime-syntax";
        };
      };

      themes = {
        dracula = {
          src = pkgs.fetchFromGitHub {
            owner = "dracula";
            repo = "sublime"; # Bat uses sublime syntax for its themes
            rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
            sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
          };
          file = "Dracula.tmTheme";
        };
      };
    };

    spotify-player = {
      enable = false;
      # package = pkgs.spotify-player;
      themes = [
        {
          name = "default2";
          palette = {
            black = "black";
            red = "red";
            green = "green";
            yellow = "yellow";
            blue = "blue";
            magenta = "magenta";
            cyan = "cyan";
            white = "white";
            bright_black = "bright_black";
            bright_red = "bright_red";
            bright_green = "bright_green";
            bright_yellow = "bright_yellow";
            bright_blue = "bright_blue";
            bright_magenta = "bright_magenta";
            bright_cyan = "bright_cyan";
            bright_white = "bright_white";
          };
          component_style = {
            block_title = {
              fg = "Magenta";
            };
            border = { };
            playback_track = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            playback_artists = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            playback_album = {
              fg = "Yellow";
            };
            playback_metadata = {
              fg = "BrightBlack";
            };
            playback_progress_bar = {
              bg = "BrightBlack";
              fg = "Green";
            };
            current_playing = {
              fg = "Green";
              modifiers = [ "Bold" ];
            };
            page_desc = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            table_header = {
              fg = "Blue";
            };
            selection = {
              modifiers = [
                "Bold"
                "Reversed"
              ];
            };
          };
        }
      ];
      keymaps = [
        {
          command = "NextTrack";
          key_sequence = "g n";
        }
        {
          command = "PreviousTrack";
          key_sequence = "g p";
        }
        {
          command = "Search";
          key_sequence = "C-c C-x /";
        }
        {
          command = "ResumePause";
          key_sequence = "M-enter";
        }
        {
          command = "None";
          key_sequence = "q";
        }
      ];
      settings = {
        theme = "default";
        playback_window_position = "Top";
        copy_command = {
          command = "wl-copy";
          args = [ "-n" ];
        };
        device = {
          audio_cache = false;
          normalization = false;
        };
      };
    };

    zathura = {
      enable = true;
      options = {
        # this are the :set options
        default-bg = "#000000";
        default-fg = "#FFFFFF";
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 0;
        selection-clipboard = "clipboard"; # copy selection to system clipboard
        zoom-step = 20; # 10:: in % percentage
        zoom-min = 20; # 10::
        zoom-max = 1000; # 1000::
        scroll-step = 100; # 40::
        incremental-search = true;
        # highlight-color = ""; # #9FBC00::
        highlight-active-color = "#623CEA"; # #00BC00::, #75DBCD
        # highlight-transparency = ""; # 0.5::
        guioptions = "none"; # no statusbar
        adjust-open = "best-fit"; # opening zathura defaults
        smoth-scroll = true;
        font = "Iosevka Comfy semibold 10";
      };
      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode"; # single | double page viewing mode
      };
      # extraConfig = ''
      # '';# zathurarc
      # keys ^ -> Meta, Ctrl
      # o -> open document
      # ^r -> recolor
      # ^n > toggle statusbar
      # ^m > toggle inputbar
      # zI, zO, z0 -> Zoom in, out or to the original size
      #
      # mouse
      # ^Scroll -> zoom in/out
      # Button1 -> follow link
      # Hold Button1 -> select text
      # Hold ^Button1 -> Highlight region
      #
      # vim keys work...including marks, search
      #f5 -> fullscreen mode

      # commands
      # :bmark -> for bookmark, blist -> list bookmarks ,bdelete
      # :exec -> execute an external command
      # write, write!
      # print
      # info
      # offset <number>
      # open, o -> open document
      # help

      # flags
      # -w [password]
      # --mode [presentation | fullscreen]
      # -P [number], --page [number] open at this page
    };

    # starship = {
    #   enable = lib.mkDefault false;
    #   settings = {
    #     add_newline = true;
    #     character = {
    #       success_symbol = "[➜](bold green)";
    #       error_symbol = "[➜](bold red)";
    #   };
    #   };
    # };

    btop.enable = true;
    bashmount.enable = true;
    nyaa = {
      #https://github.com/Beastwick18/nyaa/wiki/General-Configuration
      enable = true;
      # theme = "Dracula"; # Dracula, Gruvbox, Catppuccin Macchiato, Default - also user themes
      # default_source = "Nyaa"; # Nyaa:: , TorrentGalaxy, Sukebei
      # download_client = "qBittorrent";
      # timeout = 30; # request timeout for sources and clients (measured in seconds)
      # cursor_padding = 4; # cursor padding for input fields
      # scroll_padding = 6; # scroll padding for results table
      # save_config_on_change = false; # save config when changing sources/themes -NOTE does not work on nix since store location is immutable
      # hot_reload_config = false; # hot-reload config on change
      # notifications = {
      #   position = "TopRight";
      #   duration = 3.0;
      #   max_width = 75;
      #   animation_speed = 4.0;
      # };
    };
    # nix-index.enable = false;
    # nh.enable = true;
  };

  services = {
    # kdeconnect.enable = true;
    blueman-applet.enable = lib.mkIf osConfig.hyprland.enable true;
    udiskie = {
      enable = lib.mkIf osConfig.hyprland.enable true;
      tray = "auto"; # works
      notify = true;
      automount = false; # better?
      # appindicator = true; # use if no icon shows...uses appindicator3
      settings = {
        # config written to .config/udiskie/config.yml
        # https://github.com/coldfix/udiskie/blob/master/doc/udiskie.8.txt#configuration
        # program_options = {
        #   udisks_version = 2;
        #   tray = true;
        # };
        # icon_names.media = [ "media-optical" ];
        # file-manager = "kitty -e 'yazi'";
        file-manager = "kitty -e 'yazi'";
        terminal = "${pkgs.kitty}/bin/kitty -e yazi";
        # file-manager = "/home/malu/.nix-profile/bin/yazi";
        # file-manager = "xdg-open";
      };
    };
  };
}
