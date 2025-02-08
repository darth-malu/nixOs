{pkgs, ... }:

{
    home.packages = [pkgs.nixd pkgs.nil];
    programs.zed-editor = {
        enable = true;
        #extensions = ["nix" "toml" "elixir" "make"];
        # package = pkgs.zed-editor;
        extensions = ["nix" "python"];
        # extraPackages = with pkgs; [
        #   nixd
            #nil
        #   alejandra
        #];

        userSettings = {
            relative_line_numbers = true;
            #show_whitespaces = "all" ;
            ui_font_size = 16;
            buffer_font_size = 15;
            buffer_font_family = "JetBrains Mono";
            buffer_font_weight = 400; #default 400, 100-900
            buffer_line_height = "comfortable";
            current_line_highlight =  "line"; #line, none, all, gutter
            confirm_quit = true;
            hour_format = "hour24";
            auto_update = false;
            remove_trailing_whitespace_on_save = true;
            show_whitespaces = "selection"; # selection, boundary, all , none
            soft_wrap = "editor_width"; # def: none, # edditor_width, prefer_line_length
            hard_tabs = false; # tabs or spaces, false for tabs #TODO:test
            tab_size = 2;
            hover_popover_enabled = true;
            vim_mode = true;
            # autoscroll_on_clicks = true;

            autosave = {
              after_delay = {
                milliseconds = 1000;
              };
            };

            assistant = {
                enabled = false;
                version = "2";
                default_open_ai_model = null;
                default_model = {
                    provider = "zed.dev";
                    model = "claude-3-5-sonnet-latest";
                };
            };

            scrollbar = {
              show = "never"; #auto, never, always
              cursors = true;
              git_diff = false;
              search_results = true;
              selected_symbol = true;
              #diagnostics = true;
            };


            # "search": {
            #   "whole_word": false,
            #   "case_sensitive": false,
            #   "include_ignored": false,
            #   "regex": false
            # },

            tabs ={
              close_position = "right";
              file_icons = false;
              git_status = false;
              #activate_on_close = "history";
              activate_on_close = "neighbour"; #history, neighbour
              always_show_close_button = false;
            };

            # preview_tabs = {
            #   enabled = true;
            #   enable_preview_from_file_finder = true;
            #   enable_preview_from_code_navigation = true;
            # };

            enable_language_server = true; #on default
            format_on_save = "on";
            formatter = "launguage_server"; # language_server , auto
            # formatter = {
            #   external = {
            #     command = "prettier";
            #     arguments = ["--stdin-filepath" "{buffer_path}"];
            # };

            toolbar = {
              breadcrumbs = true;
              quick_actions = true;
            };

            terminal = {
                alternate_scroll = "off";
                blinking = "off";
                copy_on_select = true;
                dock = "bottom";
                detect_venv = {
                    on = {
                        directories = [".env" "env" ".venv" "venv"];
                        activate_script = "default";
                    };
                };
                env = {
                    TERM = "kitty";
                };
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
                cursor_shape = "underline"; #block, bar, hollow,underline
            };

            languages = {
                "Python" = {
                  tab_size = 4;
                };
                "nix" = {
                  tab_size =2;
                  language_servers = ["nixd"];
                };
            };

            lsp = {
            #     rust-analyzer = {

            #         binary = {
            #             #                        path = lib.getExe pkgs.rust-analyzer;
            #             path_lookup = true;
            #         };
            #     };
               nil = {
                  initialization_options = {
                    formatting = {
                      command = ["nixfmt"];
                    };
                  settings = {
                    diagnostic = {
                      ignored = ["unused_binding"];
                    };
                  };
                  };
                };

                nixd = {
                  settings = {
                    diagnostic = {
                      suppress = ["sema-extra-with"];
                    };
                  };
                };

                nix = {
                    binary = {
                        path_lookup = true;
                    };
                };
            };

            ## tell zed to use direnv and direnv can use a flake.nix enviroment.
            # load_direnv = "shell_hook";
            base_keymap = "JetBrains"; #VSCode, Atom,
            theme = {
                mode = "system"; # system, dark, light
                light = "Rosé Pine Dawn";
                #dark = "One Dark";
                #dark = "Rosé Pine";
                dark = "Gruvbox Dark Soft";
            };

            indent_guides = {
              enabled = false;
              coloring = "fixed"; # fixed, indent_aware
            };

            centered_layout = {
              left_padding = 0.2;
              right_padding = 0.2;
            };

            telemetry = {
              diagnostics = true;
              metrics = true;
            };

        };
    };
}
