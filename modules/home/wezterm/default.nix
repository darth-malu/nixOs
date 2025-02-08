{
  programs.wezterm = {
    enable = true;
    # package = pkgs-unstable.wezterm;
    enableBashIntegration = true;
    colorSchemes = { #$XDG_CONFIG_HOME/wezterm/colors
      myCoolTheme = {
        ansi = [
          "#222222" "#D14949" "#48874F" "#AFA75A"
          "#599797" "#8F6089" "#5C9FA8" "#8C8C8C"
        ];
        brights = [
          "#444444" "#FF6D6D" "#89FF95" "#FFF484"
          "#97DDFF" "#FDAAF2" "#85F5DA" "#E9E9E9"
        ];
        # background = "#1B1B1B";
        background = "#1B1B1B";
        cursor_bg = "#BEAF8A";
        cursor_border = "#BEAF8A";
        cursor_fg = "#1B1B1B";
        foreground = "#BEAF8A";
        selection_bg = "#444444";
        selection_fg = "#E9E9E9";
      };
    };
      extraConfig = /*lua*/''
        -- Your lua code / config here
        local wezterm = require 'wezterm'
        local config =  wezterm.config_builder()
        -- config.font = wezterm.font ('Fira Code', { weight = 'Bold', italic = true })
        config.font = wezterm.font_with_fallback({
          {
            family = "JetBrainsMono Nerd Font",
            -- scale = 1.1, -- messes with lualine?
            weight = 'Medium',
            -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
            -- calt aka:Contextual Alternates
            -- clig aka: Contextual Ligatures Replaces a sequence of glyphs with a single glyph which is preferred for typographic purposes. Unlike other ligature features
            --TODO: investigate further
          },
          {
            family = "SpaceMono Nerd Font", 
            scale = 1.0,
            weight = 'Medium',
          }
          })
        config.font_size = 11.5 --10windows::, 12:: linux,
        config.color_scheme = 'Tokyo Night'
        config.animation_fps = 60
        -- config.colors = {
        --
        -- }
        config.default_cwd = "$HOME/Shibuya"
        config.hide_tab_bar_if_only_one_tab = true
        config.window_background_opacity = 0.8
        config.scrollback_lines = 3500

        -- keys
        config.leader = { key ="a", mods = "CTRL", timeout_milliseconds = 1000 }
        config.keys = {

        }
        return config      
        '';
  };
}
