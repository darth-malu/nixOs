{
  # home.packages = [pkgs.nixd pkgs.nil];
  programs.zed-editor = {
    enable = true;

    extensions = [
      "qml"
      "nix"
      "python"
      "make"
    ];
    # package = pkgs.zed-editor;
    extraPackages = [
      pkgs.nixd
      pkgs.nil
    ];

    userSettings = {

      features = {
        copilot = false;
      };
      relative_line_numbers = true;
      auto_install_extensions = {
        nix = true;
        python = true;
      };
      hour_format = "hour24"; # The format to use for displaying hours in the journal. hour12::
      #show_whitespaces = "all" ;
      remove_trailing_whitespace_on_save = true;
      soft_wrap = "editor_width"; # def: none, # edditor_width, prefer_line_length

      preferred_line_length = 80; # 80:;
      auto_update = false;
      confirm_quit = true;

      vim_mode = true;
      tab_size = 2; # how many columns a tab should occupy
      hard_tabs = false; # tabs or spaces, false for tabs #TODO:test
      # autoscroll_on_clicks = true;
      hover_popover_enabled = true;
      show_whitespaces = "selection"; # selection, boundary, all , none
      current_line_highlight = "line"; # line, none, all, gutter

      ui_font_size = 16;
      ui_font_features = {
        calt = false; # disable ligatures
      };
      ui_font_fallbacks = "Symbol Nerd Font";
      ui_font_weight = 450; # 400::

      buffer_font_size = 15;
      buffer_font_family = "JetBrains Mono";
      buffer_font_weight = 400; # default 400, 100-900
      buffer_line_height = "comfortable";

      autosave = "on_focus_change";

      # assistant = {
      #     enabled = false;
      #     version = "2";
      #     default_open_ai_model = null;
      #     default_model = {
      #         provider = "zed.dev";
      #         model = "claude-3-5-sonnet-latest";
      #     };
      # };

      search = {
        whole_word = false;
        case_sensitive = false;
        include_ignored = false;
        regex = false;
      };

      "tab_bar" = {
        "show" = true;
        "show_nav_history_buttons" = true;
        "show_tab_bar_buttons" = true;
      };

      tabs = {
        close_position = "right";
        file_icons = true;
        git_status = false;
        activate_on_close = "history"; # history::, neighbour
        always_show_close_button = false;
      };

      toolbar = {
        breadcrumbs = true;
        quick_actions = true;
      };

      # preview_tabs = {
      #   enabled = true;
      #   enable_preview_from_file_finder = true;
      #   enable_preview_from_code_navigation = true;
      # };

      scrollbar = {
        show = "never"; # auto, never, always, system (match system config)
        cursors = true; # show cursor position on the scrollbar
        git_diff = true; # git diff indicators
        search_results = true; # search results
        selected_symbol = true;
        selected_text = true; # selected text occurrences
        diagnostics = "all"; # all::, error, warning, information, none,
      };

      cursor_shape = "block"; # block, bar::, underline, hollow

      hide_mouse = "on_typing_and_movement"; # on_typing, never, on_typing_and_movement::

      enable_language_server = true; # on default
      # format_on_save = "on";

      project_panel = {
        indent_guides = {
          show = "always"; # never, always
        };
      };

      languages = {
        "Python" = {
          tab_size = 4;
          #indent_guides.enabled = true;
          format_on_save = true;
          soft_wrap = "preferred_line_length";
          formatter = "language_server";
        };
        "nix" = {
          tab_size = 2;
          language_servers = [
            "nil"
            "nixd"
          ];
          prettier = {
            allowed = true;
          };
        };
      };

      # lsp_highlight_debounce = 75; # 75::

      lsp = {
        #     rust-analyzer = {

        #         binary = {
        #             #                        path = lib.getExe pkgs.rust-analyzer;
        #             path_lookup = true;
        #         };
        #     };
        # nil = {
        #    initialization_options = {# these initialization_options are merged into zed's defaults
        #      formatting = {
        #        command = ["nixfmt"];
        #      };
        #    settings = {
        #      diagnostic = {
        #        ignored = ["unused_binding"];
        #      };
        #    };
        #    };
        #  };

        qml = {
          binary = {
            arguments = [
              "-E"
              "additional-args"
            ];
          };
          tab_size = 2;
        };
        # nixd = {
        #   settings = {
        #     diagnostic = {
        #       suppress = ["sema-extra-with"];
        #     };
        #   };
        # };

        # nix = {
        #     binary = {
        #         path_lookup = true;
        #     };
        # };
      };

      # formatter = "prettier"; # language_server , auto, prettier, external
      formatter = {
        external = {
          command = "prettier";
          arguments = [
            "--stdin-filepath"
            "{buffer_path}"
          ];
        };

        diagnostics = {
          "include_warnings" = true;
          "inline" = {
            enabled = true;
            "update_debounce_ms" = 150;
            padding = 4; # padding between the end of the source line and the start of the diagnostic.
            "min_column" = 80;
          };
          "update_with_cursor" = false;
          "primary_only" = false;
          "use_rendered" = false;
        };

        git = {
          "git_gutter" = "tracked_files"; # tracked_files::, hide
          "gutter_debounce" = 100; # in ms
          "inline_blame" = {
            "enabled" = true;
            "show_commit_summary" = true;
          };
          "hunk_style" = "staged_hollow"; # staged_hollow::, unstaged_hollow
        };

        vim = {
          toggle_relative_line_numbers = true;
          use_system_clipboard = "always";
          highlight_on_yank_durations = 200;
          # custom_digraphs = {}; #TODO: findout what this does
        };

        base_keymap = "JetBrains"; # VSCode, Atom,

        theme = {
          mode = "system"; # system, dark, light
          light = "Rosé Pine Dawn";
          #dark = "One Dark";
          #dark = "Rosé Pine";
          dark = "Gruvbox Dark Soft";
        };

        indent_guides = {
          enabled = false;
          coloring = "indent_aware"; # disabled, indent_aware, "fixed"
          line_width = 1; # 1-10 in pixels
          active_line_width = 1; # 1-10
          background_coloring = "indent_aware"; # indent_aware, disabled
        };

        inlay_hints = {
          enabled = false;
          show_type_hints = true;
          show_parameter_hints = true;
          show_other_hints = true;
          show_background = false;
          edit_debounce_ms = 700;
          scroll_debounce_ms = 50;
          toggle_on_modifiers_press = null;
        };

        centered_layout = {
          left_padding = 0.2;
          right_padding = 0.2;
        };

        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        terminal = {
          alternate_scroll = "off";
          blinking = "off";
          copy_on_select = true;
          dock = "bottom";
          # detect_venv = {
          #     on = {
          #         directories = [".env" "env" ".venv" "venv"];
          #         activate_script = "default";
          #     };
          # };
          # env = {
          #     TERM = "kitty";
          # };
          #font_family = "FiraCode Nerd Font";
          font_family = "Zed Plex Mono";
          #font_features = null;
          font_size = 15;
          line_height = "comfortable";
          option_as_meta = false;
          button = false;
          shell = "system";
          #{
          #                    program = "zsh";
          #};
          toolbar = {
            title = true;
          };
          working_directory = "current_project_directory";
          cursor_blink = false;
          cursor_shape = "underline"; # block, bar, hollow,underline
        };

        ## tell zed to use direnv and direnv can use a flake.nix enviroment.
        # load_direnv = "shell_hook";

      }; # end of user settings
    }; # end of programs.zed
  }; # EOF
}
