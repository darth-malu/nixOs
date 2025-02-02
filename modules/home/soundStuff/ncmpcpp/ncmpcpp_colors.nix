{
  programs.ncmpcpp.settings = {
    color1 = 112;# song info, tiny tag editor and search engine 
    color2 = 136;

    song_columns_list_format = "(40)[38]{t} | (30)[38]{a} (25)[38]{b} (5)[38]{l}"; # clean
    song_list_format = "{$5%t}|{$6%f$9} $R %P %b      {$4%a$1$9}$9";

    current_item_prefix = "$(38)$r"; # highlight current
    current_item_inactive_column_prefix = "$(24)$r"; #nice purp

    alternative_header_first_line_format = "$0$aqqu$/a$9  {$6%a$9     }{$5%t$9}|{$3%f$9}  $0$atqq$/a$9";
    alternative_header_second_line_format = "{{$7%b$9}}|{$4%D$9}";
    alternative_ui_separator_color = 1;

    # icons  #TODO: use this for rewrite rules

    header_visibility = true;
    header_text_scrolling = true;
    header_window_color = 136; # page title #holy purplee

    window_border_color = 212; #pop up windows
    active_window_border = 21;

    state_line_color = 1;
    state_flags_color = 4; # mpc status flags eg rzxU

    main_window_color = 69;

    player_state_color = 31; # playing/paused status

    statusbar_time_color = 87;
    statusbar_color = 227; # song name on status bar

    statusbar_visibility = true;
    display_remaining_time = false; #instead of elapsed in status bar

    # volume
    volume_color = 124;
    display_volume_level = true;
    volume_change_step = 2;

    # progressbar
    progressbar_color = 24;
    progressbar_look = "─⊙┄";
    #progressbar_look = "─░─";
    progressbar_elapsed_color = 74;
    #progressbar_elapsed_color = 24; # muted 

    
    colors_enabled = true;
  };
}
