{pkgs, inputs,...}:
{
  imports = [# flaked apps
    inputs.nyaa.homeManagerModule
  ];

  home.packages = with pkgs; [
    wev
    tldr
    # qalculate-qt # #FIXME:for rofi?

    dotool
    #calc

    #glow #md preview
    #aria2#NOTE: learn
    #pkgs-unstable.qbittorrent
    qbittorrent

    # archive
    # zip xz unzip p7zip

    #rofimoji bemoji
    hyprpicker
    sway-audio-idle-inhibit
    taskwarrior3
    taskwarrior-tui
    file
    lsof #list open files/ports**
    usbutils # lsusb, usb-devices, usb-view(optional gui)
    pciutils #lspci
    util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
    lm_sensors

    ventoy-full # usb imager #woeusb

    mission-center

    #gnome.nautilus gnome.sushi gnome.file-roller gnome.yelp

    telegram-desktop discord
    #whatsapp-for-linux

    # browser
    chromium
    lynx
    google-chrome
    bluemail
    # meld

    # alt can use flake or shell.nix
    #(python313.withPackages (ps: with ps; [
      #pip
      #seaborn
      #matplotlib
      #numpy
      #pandas
      #powerline
      #pygments
      #pynvim
    #]))

    # Entertainment
    lollypop mpc-cli spotify mpv easyeffects
    #spotify-cli-linux
    #spotify-tray
    # glyr
    #jamesdsp
     
    # disk management
    duf ncdu

    # productivity / school
    obsidian obs-studio obs-cli
    ffmpeg
    wpsoffice
    #productivity
    # davinci-resolve
    # digikam
    # nixd # zed
    #blender
    # blender-hip # accelarated render
    # freeglut
    # gcc
    # onlyoffice-bin
  ]
     ++
   (with pkgs; [
      #(ffmpeg.override { withXcb = true;  })
  #     ffmpeg
     spotube
     superfile
     # kdePackages.dolphin
  ]) ++ 
  (with pkgs;[ # INFO: MANGA stuff
      komikku
      manga-tui
      mangal
      manga-cli
      #syncyomi - sync tachiyomi progress across devices
    ])
  ;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    ripgrep = {
      enable = true;
      arguments = [#https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    comodoro = { #TODO: use
      enable = true;
    };

    lsd = {
      enable = true;
      enableAliases = true;
      colors = {#$XDG_CONFIG_HOME/lsd/colors.yaml
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

    fd = {
      enable = true;
      hidden = true;
      ignores = [".git" "*.bak" ];
      extraOptions = [# extra options to pass to fd
        "--no-ignore"
        "--absolute-path"
      ];
    };

    freetube = {
      enable = true;
      # package = pkgs-unstable.freetube;
      settings = {
        allowDashAv1Formats = true;
        checkForUpdates     = false;
        defaultQuality      = "1080";
        baseTheme           = "catppuccinMocha";
      };
    };

    fastfetch = {
      enable = true;
      # package = pkgs-unstable.fastfetch;
      settings = { # $XDG_CONFIG_HOME/fastfetch/config.jsonc
        logo = {
          source = "#nixos_small"; #nixos_small #nixos_old
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
          # {
          #   type = "datetime";
          #   key = "Date";
          #   format = "{1}-{3}-{11}";
          # }
          # {
          #   type = "datetime";
          #   key = "Time";
          #   format = "{14}:{17}:{20}";
          # }
          "break"
          "player"
          # "media"
          {
            "type" = "media";
            "key" = "NOW PLAYING";
            "format" = "{?artist}{artist} - {?}{title}";
            "keyColor" = "cyan";
          }
          "break"
          {
            "type" = "display";
            "key" = "MONITOR ({name})";
            "keyColor" = "blue";
            # "format" = "{width}x{height} @ {refresh-rate} Hz - {physical-width}x{physical-height} mm ({inch} inches, {ppi} ppi)";
            "format" = "{width}x{height} @ {refresh-rate} Hz";
          }
          "uptime"
          "packages"
        ];
      };
    };

    git-credential-oauth = {
      enable = true;
      extraFlags = [
        "-device"
      ];
      # package = pkgs-unstable.git-credential-oauth;
    };

    imv = {
      enable = true;
      settings = {
        options.background = "ffffff";
        aliases.x = "close";
      };
    };

    helix = {
      enable = true;
      extraPackages = [pkgs.marksman];
      # defaultEditor = true;
      settings = {
        theme = "autumn_night_transparent";
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
          line-number = "relative";
          lsp.display-messages = true;
        };
        keys.normal = {
          space = {
            space = "file_picker";
            w = ":w";
            q = ":q";
          };
          esc = [ "collapse_selection" "keep_primary_selection" ];
        };
      };
      languages.language = [{
        name = "nix";
        auto-format = true;
        # formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        formatter.command = pkgs.lib.getExe pkgs.nixfmt-rfc-style;
      }];
      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = { };
        };
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
      settings = { # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
        gui.theme = {
        lightTheme = true;
        activeBorderColor = [ "blue" "bold" ];
        inactiveBorderColor = [ "black" ];
        selectedLineBgColor = [ "default" ];
      };
      };
    };

    fzf = {
      enable = true;
      enableBashIntegration = true; #true::
      tmux = {
        enableShellIntegration = true; # sets FZF_TMUX=1 
        shellIntegrationOptions = [ "-p 50%,60%" ]; #-d 40% #TODO: see more # fzf-tmux --help
        # shellIntegrationOptions = [ "-d 40" ]; #-d 40% #TODO: see more # fzf-tmux --help
      };
      colors = {#https://github.com/junegunn/fzf/wiki/Color-schemes
        # bg = "#1e1e1e";
        bg = "#022223";
        # "bg+" = "#9381ff";# current line background plus associated border
        "bg+" =  "#022223";
        # fg = "#93E1D8"; # text
        # fg = "#4ED4BC"; # text
        fg = "#4ED4BC"; # text
        # fg = "#9400FF"; # text ; results but not current line
        # "fg+" = "#d4d4d4";# text current line
        # "fg+" = "#DA4167";# text current line; ~matched_text
        "fg+" = "#FCFCFC";# text current line; ~matched_text
        "gutter" =  "#022223";
        # "hl" = "#0FA3B1"; # highlighted substrings
        # "hl+" = "#F1DEDE"; # highlighted substrings(current line)
        "hl" = "#F7567C";
        "hl+" = "#9400FF";
        # "hl+" = "#4ED4BC";
        # "preview-fg" = "";
        # "preview-bg" = "";
        "pointer" = "#4F345A";
      };
      defaultCommand = "fd --type f";
      defaultOptions = [#FZF_DEFAULT_OPTS
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
      # changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"]; #M-c binding
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
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
      syntaxes= {
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
            block_title = { fg = "Magenta"; };
            border = {};
            playback_track = { fg = "Cyan"; modifiers = ["Bold"]; };
            playback_artists = { fg = "Cyan"; modifiers = ["Bold"]; };
            playback_album = { fg = "Yellow"; };
            playback_metadata = { fg = "BrightBlack"; };
            playback_progress_bar = { bg = "BrightBlack"; fg = "Green"; };
            current_playing = { fg = "Green"; modifiers = ["Bold"]; };
            page_desc = { fg = "Cyan"; modifiers = ["Bold"]; };
            table_header = { fg = "Blue"; };
            selection = { modifiers = ["Bold" "Reversed"]; };
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
          args = ["-n"];
        };
        device = {
          audio_cache = false;
          normalization = false;
        };
      };
    };

    zathura = {
      enable = true;
      options = {# this are the :set options
          default-bg = "#000000";
          default-fg = "#FFFFFF";
          statusbar-h-padding = 0;
          statusbar-v-padding = 0;
          page-padding = 0;
          selection-clipboard = "clipboard";# copy selection to system clipboard
          # zoom and scroll step size
          zoom-step = 20;
          scroll-step = 80;
          incremental-search = true;
      };
      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode";
      };
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
    nyaa.enable = true;
    # nix-index.enable = false;
    # nh.enable = true;
  };

  services = {
    # kdeconnect.enable = true;
    blueman-applet.enable = true;
    udiskie = {
      enable = true;
      tray = "auto";
      notify = true;
      automount = true;

      #settings = {
      #program_options = {
      #udisks_version = 2;
      #tray = true;
      #};
      #icon_names.media = [ "media-optical" ];
      #};
    };
  };
}
