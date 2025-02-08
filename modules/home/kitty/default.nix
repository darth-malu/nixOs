{ osConfig, ...}:
{
  imports = [ ./keymaps.nix ./tui.nix ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
    shellIntegration.mode = "no-cursor"; # vi mode conflict fix
    font = {
      name = "JetBrainsMono Nerd Font";
      size =
        if osConfig.networking.hostName == "tangier"
          then 10
        else 11.2;
    };
    extraConfig = /*bash*/''
      action_alias launch_window launch --type=window --cwd=current
      action_alias launch_os_window launch --type=os-window --cwd=current
      action_alias launch_tab launch --type=tab --cwd=current
      enabled_layouts   tall:bias=60;full_size=1;mirrored=false,fat:bias 80
      #notify_on_cmd_finish always 5.0 notify # notify_on_cmd_finish always 5.0 bell #notify_on_cmd_finish always 5.0 command notify-send "imeisha lol"
      # notify_on_cmd_finish always 10.0 command 'notify-send -i "/home/malu/Downloads/ICONS/icons8-check-all-glassmorphism/icons8-check-all-48.png" "job finished with status: %s    " %c'

      notify_on_cmd_finish always 10.0 command notify-send -i '/home/malu/Shibuya/modules/home/scripts/assets/icons8-check-all-48.png' 'job finished with status: %s  ' %c
      # notify_on_cmd_finish always 5.0 command canberra-gtk-play -i bell; notify-send -i '/home/malu/Shibuya/modules/home/scripts/assets/icons8-check-all-48.png' 'job finished with status: %s  ' %c
    '';
    settings = {
      # term =  "xterm-256color";
      term =  "tmux-256color";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      # update_check_interval = 0;
      # undercurl_style = "thin-sparse"; # thin-sparse | thin | thick| sparse | dense
      cursor = "#FAA6FF"; # #573280 "#3FA8C6""#9381ff""#0CA4A5";
      # cursor_shape = "underline"; #block beam
      cursor_shape_unfocused =  "underline"; # hollow, beam , underline
      # cursor_beam_thickness = "1.5";
      # cursor_beam_thickness = "0.5";
      # cursor_underline_thickness = "2.0";
      # cursor_stop_blinking_after = "12.0"; #15.0::
      cursor_blink_interval = "-1"; # 0 -disable, -ve sys default, min interval(repaint_delay)

      #mouse_hide_wait = "-1.0";
      focus_follows_mouse = true;
      mouse_hide_wait = "0";
      default_pointer_shape = "beam";
      open_url_with = "default";
      clear_all_shortcuts = true;
      kitty_mod = "ctrl+shift";
      #enabled_layouts  = [ "fat:bias 70" "tall:bias=50;full_size=1;mirrored=false" "splits" ];
      draw_minimal_borders = true;
      paste_actions = "quote-urls-at-prompt,confirm,replace-dangerous-control-codes,confirm-if-large"; # no-op, filter(check doc)
      strip_trailing_spaces = "smart";

      foreground = "#35A29F"; background = "#022223";
      # foreground = "#9B7EBD";background = "#022223";background_opacity = "0.58";

      # cyan
      color6  = "#9d7cd8"; color14  = "#9400FF";
      # blue - directories,
      color4 =  "#7aa2f7"; color12 = "#3F8EFC";
      # magenta
      color5 =  "#EFABFF"; color13 =  "#ff6bdf";
      #Green
      color2  = "#00FF9C"; color10 =  "#89fc00";
      #red
      color1 = "#EF2917"; color9 = "#ef233c"; # color1 = "#DD0426";
      #yellow
      color3 = "#FFFB46"; color11 = "#fff000";

      sync_to_monitor = "no"; #not recommended for high mouse/keyboard RR (input latency - set to no), yes:: - prevents tearing when scrolling
      allow_remote_control = false; # used for arch update

      input_delay = 0; # 3:: # can cause flicker if terminal application does full screen redraw with every loop. **maybe my issue with ncmpcpp
      repaint_delay = 5; #10(100fps):: # delay between screen updates in milliseconds. decreasing increases FPS at the cost of CPU. ssync_to_monitor = no advised unless highrr
      bell_on_tab = "💎"; # bell_on_tab = " ";
      # tab_bar_background = none; # defaults to terminal background
      # tab_bar_margin_color = "";
      tab_bar_style = "fade"; tab_bar_edge = "bottom"; tab_bar_margin_height = "0.0 0.0"; tab_bar_margin_width = "0.0";
      tab_bar_min_tabs = "2"; tab_bar_align = "left"; tab_switch_strategy = "previous"; tab_fade = "0.25 0.5 0.75 0.98";
      tab_title_max_length = 40; # 0 - nolimit, number of cells that can be used to render the text in a tab
      # tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"; 
      # tab title option -> title , index, layout_name, num_windows 

      #clipboard_control write-clipboard write-primary read-clipboard-ask read-primary-ask
      #clipboard_max_size 512

      # active_tab_foreground = "#000";
      # active_tab_background = "#eee";
      active_border_color = "#8D99AE"; active_tab_font_style = "bold-italic";
      # inactive_tab_foreground = "#444";
      # inactive_tab_background = "#999";
      # inactive_tab_font_style = "normal";
      # inactive_border_color = "#42414D";
      copy_on_select = "a1";
      # window_border_width = 0.5;
    } //
    {
      background_opacity = if osConfig.services.desktopManager.plasma6.enable then 1 else 0.80; #0.66
    };
    # themeFile = "tokyo_night_storm"; # moon, day, storm, night
    # themeFile = "Catppuccin-Mocha"; # moon, day, storm, night
    #Also available: Catppuccin-Frappe Catppuccin-Latte Catppuccin-Macchiato Catppuccin-Mocha
    # See all available kitty themes at: https://github.com/kovidgoyal/kitty-themes/blob/46d9dfe230f315a6a0c62f4687f6b3da20fd05e4/themes.json
  };
}
