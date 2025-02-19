{
  programs.ncmpcpp = {
    enable = true;
    # package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    # package = pkgs-unstable.ncmpcpp;
    mpdMusicDir = "~/Music";


    settings = {
      startup_screen = "playlist";
      user_interface = "classic"; # classic , alternative #TODO: add snippet for nice comments
      default_place_to_search_in = "database"; #playlist

      message_delay_time = 2;

      locked_screen_width_part = 20-80;
      ask_for_locked_screen_width_part = true; # disable to use default

      jump_to_now_playing_song_at_start = true;
      #now_playing_prefix = " "; # 󱉺  
      now_playing_prefix = "   ";#TODO:check how to filter out songs from playlist

      # external_editor = "/home/malu/.nix-profile/bin/nvim";
      external_editor = "/run/current-system/sw/bin/nvim";
      use_console_editor = true;#TODO: what is sit doing?

      show_hidden_files_in_local_browser = false;

      # functionality
      centered_cursor = true; #playing focus
      autocenter_mode = true; # Centers highlight on current song during switch

      cyclic_scrolling = true;
      connected_message_on_startup = false;

      ignore_diacritics = true; # local language ^ pronounciation marker eg. shadda, umlauts
      #ignore_leading_the = true;

      block_search_constraints_change_if_items_found = true; # fields in Search engine above "Reset" will be blocked after successful searching
      display_bitrate = false;

      enable_window_title = true;

      empty_tag_marker = "@darth";
      #empty_tag_color = "";

      # media_library_primary_tag = "genre"; #album_artist, artist, date, genre, composer, performer
      media_library_albums_split_by_date = true;
      media_library_hide_album_dates = true;

      default_find_mode = "wrapped"; #wrapped - go to match as you type, normal <key>w 

      # lyrics
      follow_now_playing_lyrics = true;
      lyrics_directory = "~/.local/share/darth_ncmpcpp";
      store_lyrics_in_song_dir = false;
      # lyrics_fetchers = "genius , azlyrics";
      # lyrics_fetchers = "genius";

      incremental_seeking = "yes";
      seek_time = "1";

      titles_visibility = false;

      header_text_scrolling = true;
      header_visibility = true;

      ######### -> Columns
      playlist_editor_display_mode = "columns";
      playlist_disable_highlight_delay = 5; #0 to disable fade
      playlist_show_remaining_time = true; #header time remaining
      playlist_shorten_total_times = true;
      playlist_separate_albums = false; # add separator lines between albums in playlist view
      playlist_display_mode = "columns";

      search_engine_display_mode = "columns";
      ask_before_clearing_playlists = true;
      browser_display_mode = "columns";

      #clock_display_seconds = yes
      mouse_support = true;

      visualizer_output_name = "Visualizer feed";
      visualizer_type = "wave_filled"; # wave, wave_filled, spectrum, ellipse
      visualizer_in_stereo = "yes"; # yes if fifo set to 44100:16:2
      visualizer_autoscale = true;
      visualizer_spectrum_smooth_look = true;
      # visualizer_color = "25, 38, 10";
      visualizer_color = "25, 38, 104";
      visualizer_look = "+|";
      # visualizer_look = "●▮";

      ncmpcpp_directory = "~/.local/share/ncmpcpp";
      mpd_crossfade_time = 4;
      mpd_connection_timeout = 5;
      mpd_host = "localhost";
      mpd_port = 6600;

      # execute_on_song_change = "~/.darth/scripts/player/songinfo.sh";
      execute_on_song_change = "songart";
      #execute_on_player_state_change = "";

      ## Selected tracks ##
      # selected_item_prefix = "->>";
      # selected_item_prefix = "|>";
      selected_item_prefix = "+  ";
      discard_colors_if_item_is_selected = true;

      system_encoding = "utf8";
      #regular_expressions = none/basic/extended/perl;
      generate_win32_compatible_filenames = true; # generated file names eg. with tag editor wont have  \?*:|
      allow_for_physical_item_deletion = true;
      #startup_slave_screen = "browser";
    };
  };
}
