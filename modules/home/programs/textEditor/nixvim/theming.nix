{
    #colorschemes.catppuccin.enable = true;
    programs.nixvim.colorschemes = {
      tokyonight = {#TODO: custom tokyonight
        enable = true;
        settings = {
          day_brightness = 0.3;
          dim_inactive = true;
          hide_inactive_statusline = true;
          light_style = "day";
          lualine_bold = true;
          on_colors = "function(colors) end";
          # on_highlights = "function(highlights, colors) end";
          on_highlights = ''
            function(hl, c)
              local prompt = "#2d3149"
              hl.TelescopeNormal = {
                bg = c.bg_dark,
                fg = c.fg_dark,
              }
              hl.TelescopeBorder = {
                bg = c.bg_dark,
                fg = c.bg_dark,
              }
              hl.TelescopePromptNormal = {
                bg = prompt,
              }
              hl.TelescopePromptBorder = {
                bg = prompt,
                fg = prompt,
              }
              hl.TelescopePromptTitle = {
                bg = prompt,
                fg = prompt,
              }
              hl.TelescopePreviewTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
              }
              hl.TelescopeResultsTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
              }
            end
          '';
          # on_highlights = "function(highlights, colors) end";
          sidebars = [
            "qf"
            "vista_kind"
            "terminal"
            "packer"
          ];
          style = "night"; #storm, night
          styles = {
            comments = {
              italic = true;
            };
            floats = "transparent"; # dark, transparent, normal or lua code
            functions = { };
            keywords = {
              italic = true;
            };
            sidebars = "dark"; # dark, transparent, normal or lua code
            variables = { };
          };
          terminal_colors = true;
          transparent = false;
        };
      };

      rose-pine = {
        enable = false;
        settings = {
          before_highlight = "function(group, highlight, palette) end";
          dark_variant = "moon";
          dim_inactive_windows = true;
          enable = {
            legacy_highlights = false;
            migrations = true;
            terminal = true;
          };
          extend_background_behind_borders = true;
          groups = {
            border = "muted";
            link = "iris";
            panel = "surface";
          };
          highlight_groups = { };
          styles = {
            bold = false;
            italic = false;
            transparency = false;
          };
          variant = "auto";
          on_highlights = ''
            function(hl, c)
              local prompt = "#2d3149"
              hl.TelescopeNormal = {
                bg = c.bg_dark,
                fg = c.fg_dark,
              }
              hl.TelescopeBorder = {
                bg = c.bg_dark,
                fg = c.bg_dark,
              }
              hl.TelescopePromptNormal = {
                bg = prompt,
              }
              hl.TelescopePromptBorder = {
                bg = prompt,
                fg = prompt,
              }
              hl.TelescopePromptTitle = {
                bg = prompt,
                fg = prompt,
              }
              hl.TelescopePreviewTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
              }
              hl.TelescopeResultsTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
              }
            end
          '';
        };

      };

        # Available colors = everforest,
        gruvbox = {
          enable = false;
          settings = {#options to require('gruvbox').setup
            on_highlights = ''
              function(hl, c)
                local prompt = "#2d3149"
                hl.TelescopeNormal = {
                  bg = c.bg_dark,
                  fg = c.fg_dark,
                }
                hl.TelescopeBorder = {
                  bg = c.bg_dark,
                  fg = c.bg_dark,
                }
                hl.TelescopePromptNormal = {
                  bg = prompt,
                }
                hl.TelescopePromptBorder = {
                  bg = prompt,
                  fg = prompt,
                }
                hl.TelescopePromptTitle = {
                  bg = prompt,
                  fg = prompt,
                }
                hl.TelescopePreviewTitle = {
                  bg = c.bg_dark,
                  fg = c.bg_dark,
                }
                hl.TelescopeResultsTitle = {
                  bg = c.bg_dark,
                  fg = c.bg_dark,
                }
              end
            '';
          # palette_overrides = {
          #   bright_blue = "#5476b2";
          #   bright_purple = "#fb4934";
          #   dark1 = "#323232";
          #   dark2 = "#383330";
          #   dark3 = "#323232";
          # };
          terminal_colors = true;
          };
        };

        poimandres = { #greyish
          enable = false;
          settings = {
            bold_vert_split = false;
            dim_nc_background = true;
            disable_background = false;
            disable_float_background = false;
            disable_italics = true;
          };
        };

        #TODO: make darthfox custom with duskfox template
        nightfox = {
          enable = false;
          flavor = "nightfox"; # “carbonfox”, “dawnfox”, “dayfox”, “duskfox”, “nightfox”, “nordfox”, “terafox” { dark ="nightfox, carbonfox", grey = {nordfox},light = "dayfox, dawnfox(brighter)"}
          settings = {
            groups = {
              all = {
                NormalNC = {
                  bg = "inactive";
                  fg = "fg1";
                };
              };
            };
            options = {
              colorblind = {
                enable = false;
                severity = {
                  deutan = 0.6;
                  protan = 0.3;
                };
              };
              inverse = {
                match_paren = false;
                search = true;
                visual = false;
              };
              modules = {
                coc = {
                  background = false;
                };
                diagnostic = {
                  background = false;
                  enable = true;
                };
              };
              styles = {
                comments = "italic";
                functions = "italic,bold";
              };
              terminal_colors = true;
              transparent = false;
            };
            palettes = {
              duskfox = {#custom
                bg0 = "#1d1d2b";
                bg1 = "#000000";
                bg3 = "#121820";
                sel0 = "#131b24";
              };
            };
            specs = {
              all = {
                inactive = "bg0";
              };
              duskfox = {
                inactive = "#090909";
              };
            };
          }; # end of nightfox settings

        }; # end of nightfox
    };
}
