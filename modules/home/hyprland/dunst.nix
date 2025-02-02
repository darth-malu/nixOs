{osConfig, lib,...}:
{
  config = lib.mkIf (osConfig.specialisation != {}) {
  services.dunst = {
    # enable = lib.mkIf (osConfig.services.desktopManager.plasma6.enable != true ) true;
    enable = lib.mkIf osConfig.programs.hyprland.enable true;
    settings = {
      global = {
        title = "dunst";
        class = "dunst";
        ignore_dbusclose = false;
        # width = "(100,1000)";
        width = "(70,1000)";
        height = "(20,50)"; #height = 300;
        #offset = "30x50";
        background = "#0C1017";
        # background = "#1f2335";
        # background = "#1A1B26";
        # highlight = "#E56264";
        # highlight = "#9d7cd8"; #GOOD PURPLE
        highlight = "#8852A8";
        foreground = "#3798B9";
        # foreground = "#9d7cd8";
        # foreground = "#349C99";
        frame_width = 0;
        # frame_color = "#E56264";
        frame_color = "#9d7cd8";
        #frame_color = "#98C8D3";
        #offset = "50x25";
        offset = "0x12";
        #offset = "150x12";
        origin = "top-center";
        #origin = "top-left";
        #transparency = 10; #x11 only
        #frame_color = "#eceff1";
        font = "quicksand 11";

        # <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>.
        markup = "yes";
        plain_text = "yes";

        format = ''
          %a
          <b>%s</b>
          %b'';

        notification_limit = 10;
        indicate_hidden = true;
        ignore_newline = false;
        stack_duplicates = false; #dup count
        show_indicators = false;
        sticky_history = true; # or timeout
        #browser = "/usr/bin/xdg-open";
        browser = "/usr/bin/firefox -new-tab";

        word_wrap = "yes";

        # Shrink window if it's smaller than the width.  Will be ignored if
        # width is 0.
        shrink = "no";

        # Don't remove messages, if the user is idle (no mouse or keyboard input)
        # for longer than idle_threshold seconds.
        # Set to 0 to disable.
        idle_threshold = 0;

        # Which monitor should the notifications be displayed on.
        monitor = "keyboard"; # mouse, keyboard, none
        # "keyboard" needs a windowmanager that exports the
        # _NET_ACTIVE_WINDOW property.
        # This should be the case for almost all modern windowmanagers.
        #
        # If this option is set to mouse or keyboard, the monitor option
        # will be ignored.
        follow = "none";

        # Progress bar
        progress_bar = true;
        progress_bar_height = 4; # twice frame_width # default:10
        progress_bar_frame_width = 1;
        progress_bar_min_width = 100; # notif rescaled to fit the progress bar
        progress_bar_max_width = 1000;
        progress_bar_corner_radius = 8;
        progress_bar_corners = "all"; #default: all
        progress_bar_horizontal_alignment = "center"; #right/left/center

        corner_radius= 6;
        corners = "all"; #bottom-right, bottom-left, top-right, top-left, top, bottom, left, right or all.
        icon_position = "left"; #off/l/r
        icon_corner_radius = 6;
        icon_corners = "all";
        min_icon_size = 10;
        max_icon_size = 100;
        layer = "overlay"; #overylay/top/bottom # wayland only
        vertical_alignment = "center"; # center-default, top/center/bottom
        separator_height = 2;
        padding = 0; # between text and separator/window in vertical axis
        horizontal_padding = 0; #padding but horizontal
        text_icon_padding = 8; #text to icon - horizontal
        gap_size = 1;
        separator_color = "frame";
        sort = "yes";
        line_height = 3;# The spacing between lines.  If the height is smaller than thefont height, it will get raised to the font height.
      };

      urgency_normal = {
        timeout = 4;
      };

      urgency_low = {
        timeout = 2;
       };

      urgency_critical = {
        background = "#900000FF";
        foreground = "#ffffff";
        #highlight = "#F8D210";
        frame_color = "#D20062";
        timeout = 6;
      };

      history-ignore = {
        # This notification will not be saved in history
        summary = "foobar";
        appname= "changeVolume";
        history_ignore = "yes";
      };
    };
  };
  };
  # };
  # };
}
