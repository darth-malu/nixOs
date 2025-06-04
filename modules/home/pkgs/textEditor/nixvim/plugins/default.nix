{
  imports = [
    ./lualine.nix
    ./cmp.nix
    ./obsidian.nix
    ./lsp.nix
    ./alpha
    ./oil.nix
    ./harpoon.nix
    ./mini.nix
    ./treesitter.nix
    ./telescope.nix
    # ./voltUxApplets.nix
    # ./neotree.nix
    #./snippets.nix
    #./nvim-ufo.nix
    # ./bufferline.nix
    # ./yazi-nvim.nix
  ];

  programs.nixvim.plugins = {
    colorizer = {
      enable = false;
      # lazyLoad = {
      #   enable = true;
      #   settings = {
      #   };
      # };
    };

    otter = {
      enable = true;
      autoActivate = true;
    };

    web-devicons.enable = true;

    tmux-navigator = {
      enable = true;
      #keymaps = [
        #{
          #action = "left";
          #key = "<C-w>h";
        #}
        #{
          #action = "down";
          #key = "<C-w>j";
        #}
        #{
          #action = "up";
          #key = "<C-w>k";
        #}
        #{
          #action = "right";
          #key = "<C-w>l";
        #}
        #{
          #action = "previous";
          #key = "<C-w>\\";
        #}
      #];
    };

    lazygit = {
      enable = false;
    };

    nix = {
      enable = true;
    };

    # hmts.enable = true;

    neoscroll = {
      enable = true;
      settings = {
        cursor_scrolls_alone = true;
        easing_function = "quadratic";# :h neoscroll-easing-functions
        hide_cursor = false; # need termguicolors set
        mappings = [
          "<C-u>" #up
          "<C-d>" # down
          "<C-b>"
          "<C-f>"
          "<C-y>"
          "<C-e>"
          "zt"
          "zz"
          "zb"
        ];
        respect_scrolloff = false;
        stop_eof = true;
      };
    };

    #nvim-cmp = {
      #enable = true;
      #autoEnableSources = true;
    #};

   #wtf = {
    #enable = true;
    #context = true;
    #popupType = "popup";
    #openaiApiKey = "boop"; # TODO: add API key
    #openaiModelId = "gpt-3.5-turbo";
    #searchEngine = "duck_duck_go"; # | "google" | "stack_overflow" | "github" | "phind" | "perplexity";
    ## hooks.requestFinished = ""; # TODO: add notification here 
  #}; # need key lol


  undotree = {
    enable = false;
    settings = {
      autoOpenDiff = false;
      focusOnToggle = true;
    };
  };

  notify = {
    enable = true;
    backgroundColour = "#1e1e2e";
    fps = 60;
    # fps = 140;
    render = "default";
    timeout = 400;
    topDown = false;
  };

  persistence = {
    enable = false;
    # options = [ 
    #   "curdir"
    #   "tabpages"
    #   "winsize"
    #   "skiprtp"
    #   "buffers"
    # ];
  };

  # Autopairs
  nvim-autopairs = {
    enable = true;
    settings = {
      disable_filetype = [
        "TelescopePrompt"
      ];
      fast_wrap = {
        end_key = "$";
        map = "<M-e>";#TODO: investigate wrap around with this
      };
    };
  };

  # Trouble
  # trouble = {
  #   enable = true;
  # };

  # commentary.enable = false;

  # toggleterm = {
  #   enable = false;
  #   settings = {
  #     hide_numbers = false;
  #     autochdir = true;
  #     close_on_exit = true;
  #     #direction = "vertical";
  #     direction = "horizontal";
  #   };
  # };

  # gitsigns = {
  #   enable = false;
  #   settings.current_line_blame = true;
  # };

  # folke tech for improved UI 
  noice = {
    enable = true;
  };

  # todo-comments = {
  #   enable = false;
  #   settings = {
  #     colors = {
  #       error = ["DiagnosticError" "ErrorMsg" "#DC2626"];
  #       warning = ["DiagnosticWarn" "WarningMsg" "#FBBF24"];
  #       info = ["DiagnosticInfo" "#2563EB"];
  #       hint = ["DiagnosticHint" "#10B981"];
  #       default = ["Identifier" "#7C3AED"];
  #       test = ["Identifier" "#FF00FF"];
  #     };
  #   };
  # };
  };
}
