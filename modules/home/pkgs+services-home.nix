{pkgs, inputs, pkgs-unstable, ...}:

{
  imports = [# flaked apps
    inputs.nyaa.homeManagerModule
  ];

  home.packages = with pkgs; [
    # neovimConf.neovim
    #inputs.nixvim-config.packages.${system}.default #no options lol
    file ripgrep fd fzf
    # jq #cli json processor
    wev
    tldr
    glib # for treesitter?

    #dotool kdotool wtype
    dotool
    #calc

    #glow #md preview

    #aria2#NOTE: learn
    #pkgs-unstable.qbittorrent
    qbittorrent

    # archive
    zip xz unzip p7zip

    #rofimoji bemoji
    hyprpicker hyprcursor

    #yazi
    # eza
    lsd
    sway-audio-idle-inhibit
    taskwarrior3 taskwarrior-tui
    lsof #list open files/ports**
    usbutils # lsusb, usb-devices, usb-view(optional gui)
    pciutils #lspci
    util-linux # fdisk, findmnt, kill, chsh, dmesg, eject, fstrim, hwclock
    lm_sensors

    ventoy-full # usb imager #woeusb

    mission-center

    #gnome.nautilus gnome.sushi gnome.file-roller gnome.yelp

    # Socials
    telegram-desktop
    #whatsapp-for-linux
    discord-ptb

    # browser
    chromium qutebrowser microsoft-edge lynx google-chrome
    bluemail
    # blueman

    # dev
    meld
    #zed-editor
    # jetbrains.pycharm-community-bin
    #unstable.python39Packages.poetry

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
   (with pkgs-unstable; [
      #(ffmpeg.override { withXcb = true;  })
  #     ffmpeg
     spotube
     superfile
   ]);

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
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
    fastfetch.enable = true;
    bashmount.enable = true;
    nyaa.enable = true;
    # nix-index.enable = false;
    # nh.enable = true;
  };

  services = {
    # kdeconnect.enable = true;
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
