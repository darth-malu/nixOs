{osConfig, lib, config, ...}:

{
  options.dunst = {
    enable =  lib.mkEnableOption "dunst";
  };
  # config = lib.mkIf (osConfig.specialisation != {}) {
  config = {
    services.dunst = lib.mkIf config.dunst.enable {
      # enable = lib.mkIf (osConfig.services.desktopManager.plasma6.enable != true ) true;
      # enable = if (osConfig.kde.enable != true) then true else false;
      enable = true;
      # waylandDisplay = ""; #"":: #Set the service's WAYLAND_DISPLAY environment variable.
        # configFile = path; # conf written to $XDG_CONFIG_HOME/dunst/dunstrc regardless. This allows using a mutable configuration file generated from the immutable one, useful in scenarios where live reloading is desired.
      
          settings.global.title = "dunst";
          settings.global.class = "dunst";
          settings.global.ignore_dbusclose = false;
          settings.global.width = "(100,1000)";
          # width = "(70,1000)";
          # height = "(20,50)"; #height = 300;
          # height = 300;#TODO: see if height needed
          #offset = "30x50";
          settings.global.background = "#0C1017";
          # background = "#1f2335";
          # background = "#1A1B26";
          # highlight = "#E56264";
          # highlight = "#9d7cd8"; #GOOD PURPLE
          settings.global.highlight = "#8852A8";
          settings.global.foreground = "#3798B9";
          # foreground = "#9d7cd8";
          # foreground = "#349C99";
          settings.global.frame_width = 0;
          # frame_color = "#E56264";
          settings.global.frame_color = "#9d7cd8";
          #frame_color = "#98C8D3";
          #offset = "50x25";
          settings.global.offset = "0x12";
          #offset = "150x12";
          settings.global.origin = "top-center";
          #origin = "top-left";
          #transparency = 10; #x11 only
          #frame_color = "#eceff1";
          settings.global.font = "quicksand 11";

          # <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>.
          settings.global.markup = "yes";
          settings.global.plain_text = "yes";

          # format = "%a %i <b>%s</b>%b";#
          settings.global.format = ''
            %a %i
            <b>%s</b>
            %b''; # both body and summary bold HACK: added %i can remove FIXME: the bold in body does not work :)
          # %a appname | %s summary | %b body | %i iconname (including its path) | %I iconname (without its path) | %p progress value ([ 0%] to [100%]) | %n progress value without any extra characters | %% Literal %

          settings.global.notification_limit = 10;
          settings.global.indicate_hidden = true;
          settings.global.ignore_newline = false;
          settings.global.stack_duplicates = false; #dup count
          settings.global.show_indicators = false;
          settings.global.sticky_history = true; # or timeout
          #browser = "/usr/bin/xdg-open";
          settings.global.browser = "/usr/bin/firefox -new-tab";

          settings.global.word_wrap = "yes";

          # Shrink window if it's smaller than the width.  Will be ignored if
          # width is 0.
          settings.global.shrink = "no";

          # Don't remove messages, if the user is idle (no mouse or keyboard input)
          # for longer than idle_threshold seconds.
          # Set to 0 to disable.
          settings.global.idle_threshold = 0;

          # Which monitor should the notifications be displayed on.
          settings.global.monitor = "keyboard"; # mouse, keyboard, none
          # "keyboard" needs a windowmanager that exports the
          # _NET_ACTIVE_WINDOW property.
          # This should be the case for almost all modern windowmanagers.
          #
          # If this option is set to mouse or keyboard, the monitor option
          # will be ignored.
          settings.global.follow = "none";

          # Progress bar
          settings.global.progress_bar = true;
          settings.global.progress_bar_height = 4; # twice frame_width # default:10
          settings.global.progress_bar_frame_width = 1;
          settings.global.progress_bar_min_width = 100; # notif rescaled to fit the progress bar
          settings.global.progress_bar_max_width = 1000;
          settings.global.progress_bar_corner_radius = 8;
          settings.global.progress_bar_corners = "all"; #default: all
          settings.global.progress_bar_horizontal_alignment = "center"; #right/left/center

          # mouse
          settings.global.mouse_left_click = "do_action, close_current";
          settings.global.mouse_right_click = "close_all";
          settings.global.mouse_middle_click = "close_current";

          settings.global.corner_radius= 6;
          settings.global.corners = "all"; #bottom-right, bottom-left, top-right, top-left, top, bottom, left, right or all.
          settings.global.icon_position = "left"; #off/l/r
          settings.global.icon_corner_radius = 6;
          settings.global.icon_corners = "all";
          settings.global.min_icon_size = 10;
          settings.global.max_icon_size = 100;
          settings.global.layer = "overlay"; #overylay/top/bottom # wayland only
          settings.global.vertical_alignment = "center"; # center-default, top/center/bottom Defines how the text and icon should be aligned vertically within the notification.
          settings.global.separator_height = 2;
          settings.global.padding = 0; # between text and separator/window in vertical axis
          settings.global.horizontal_padding = 0; #padding but horizontal
          settings.global.text_icon_padding = 8; #text to icon - horizontal
          settings.global.gap_size = 1;
          settings.global.separator_color = "frame";
          settings.global.sort = "yes";
          settings.global.line_height = 3;# The spacing between lines.  If the height is smaller than thefont height, it will get raised to the font height.
        

        settings.urgency_normal = {
          timeout = 4;
        };

        settings.urgency_low = {
          timeout = 2;
         };

        settings.urgency_critical = {
          background = "#900000FF";
          foreground = "#ffffff";
          #highlight = "#F8D210";
          frame_color = "#D20062";
          timeout = 6;
        };

        settings.history-ignore = {
          # This notification will not be saved in history
          summary = "foobar";
          appname= "changeVolume";
          history_ignore = "yes";
        };
      
    };
  };
  # };
  # };
}
