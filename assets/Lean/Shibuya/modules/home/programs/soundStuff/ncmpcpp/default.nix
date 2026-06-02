{pkgs, ...}:
{
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };

    mpdMusicDir = "~/Music";

  bindings = [
  # scroll
  { key = "j";command = "scroll_down";}
  { key = "k"; command = "scroll_up"; }
  # {key = "G"; command = ["move_end"];}
  # {key = "K"; command = ["move_home"];}
  # {key = "ctrl-g"; command = ["jump_to_browser"];}
  # playlists manipulation
  { key = "J"; command = [ "select_item" "scroll_down" ]; }
  {key = "K"; command = ["select_item" "scroll_up"];}

  {key = "l"; command = "next_column" ;}
  { key = "h"; command = "previous_column"; }

  { key = "escape"; command = "remove_selection"; }

  # { key = "shift-tab"; command = "previous"; }
  # { key = "tab"; command = "next"; }

  ##lyrics
  { key = "'";  command ="show_lyrics" ; } # Had to rebind "l"

  # { key = "^"; command = "toggle_lyrics_fetcher"; }

  # { key = "ctrl-v"; command = "select_range"; }

  # WARN: DANGEROUS
  { key = "d";
    command = [
      "delete_browser_items"
      "delete_playlist_items"
      "delete_stored_playlist"
    ];
  }
  # {key = "0"; command = "run_external_command  \"qs ipc call mpris songArt\"";}
  ];

settings = {

startup_screen = "playlist";
user_interface = "classic"; # classic , alternative #TODO: add snippet for nice comments
default_place_to_search_in = "database"; #playlist

message_delay_time = 2;
connected_message_on_startup = false;

locked_screen_width_part = "50"; # 20-80::
ask_for_locked_screen_width_part = true; # disable to use default

jump_to_now_playing_song_at_start = true;
#now_playing_prefix = " "; # 󱉺  
now_playing_prefix = " ";#TODO:check how to filter out songs from playlist
now_playing_suffix = "  ";

external_editor = "/home/malu/.nix-profile/bin/emacsclient -nc";
use_console_editor = true;#TODO: what is sit doing?

# functionality
centered_cursor = true; #playing focus
autocenter_mode = true; # Centers highlight on current song during switch

block_search_constraints_change_if_items_found = true; # fields in Search engine above "Reset" will be blocked after successful searching

cyclic_scrolling = true;

display_bitrate = false;

enable_window_title = true;

ignore_diacritics = true; # local language ^ pronounciation marker eg. shadda, umlauts TODO : investigate if this is what is causing issues with -

ignore_leading_the = true;

tag_editor_extended_numeration = true;
empty_tag_marker = "❌";
#empty_tag_color = "";

media_library_primary_tag = "genre"; #album_artist, artist, date, genre, composer, performer
media_library_albums_split_by_date = true;
media_library_hide_album_dates = true;
# media_library_disable_two_column_mode = false; # false::

default_find_mode = "wrapped"; #wrapped - go to match as you type, normal <key>w

lyrics_directory = "~/Music/ncmpcpp/lyrics";
store_lyrics_in_song_dir = false;
fetch_lyrics_for_current_song_in_background = false;

lyrics_fetchers = "genius , azlyrics";
# lyrics_fetchers = "genius";
follow_now_playing_lyrics = true;

incremental_seeking = "yes";
seek_time = "1";

titles_visibility = false;

header_text_scrolling = true;
header_visibility = true; # If enabled, header window will be displayed, otherwise hidden.

colors_enabled = true;

color1 = 112;                   
color2 = 136;                   # Current Screen , playlist length

# song_columns_list_format = "(40)[39]{t} | (30)[39]{a} | (30)[39]{f} (25)[39]{b} (5)[39]{l}"; # clean

song_columns_list_format = "(40)[39]{t} | (30)[39]{a} | (25)[39]{b} (5)[39]{l}"; # clean

# song_columns_list_format = "(40)[7]{t} (30)[7]{a} (25)[7]{b} (5)[7]{l}"; # 39,38

# song_columns_list_format = "(40)[46]{t} (30)[46]{a} (25)[46]{b} (5)[46]{l}"; # 39,38

song_list_format = "{$5%t} | {$6%f$9} $r %p %b      {$4%a$1$9}$9";

current_item_prefix = "$(142)$r"; # highlight current

current_item_inactive_column_prefix = "$(24)$r"; #nice purp

window_border_color = 212; #pop up windows
active_window_border = 21;

main_window_color = 69;          # add-menu , 69, 44

visualizer_output_name = "Visualizer feed";
visualizer_type = "wave_filled"; # wave, wave_filled, spectrum, ellipse
visualizer_in_stereo = "yes"; # yes if fifo set to 44100:16:2
visualizer_autoscale = true;
visualizer_spectrum_smooth_look = true;
# visualizer_color = "25, 38, 10";
visualizer_color = "25, 38, 104";
visualizer_look = "+|";
# visualizer_look = "●▮";

volume_color = 214;             # 124 (green)
display_volume_level = true;
volume_change_step = 2;

header_window_color = 136; # page title #holy purplee

alternative_header_first_line_format = "$0$aqqu$/a$9  {$6%a$9     }{$5%t$9}|{$3%f$9}  $0$atqq$/a$9";
alternative_header_second_line_format = "{{$7%b$9}}|{$4%d$9}";
alternative_ui_separator_color = 1;

state_line_color = 1;
state_flags_color = 4; # mpc status flags eg rzxu

player_state_color = 136; # playing/paused status

statusbar_time_color = 87;
statusbar_color = 221; # 227 song name on status bar
statusbar_visibility = true;

display_remaining_time = false; #instead of elapsed in status bar

progressbar_color = 24;
# progressbar_look = "─⊙┄";
progressbar_look = "─⊙ ";
#progressbar_look = "─░─";
progressbar_elapsed_color = 74;
#progressbar_elapsed_color = 24; # muted

playlist_disable_highlight_delay = 5; #0 to disable fade
playlist_show_remaining_time = true; #header time remaining
playlist_shorten_total_times = true;
playlist_separate_albums = false; # add separator lines between albums in playlist view
ask_before_clearing_playlists = true;

search_engine_display_mode = "columns";
browser_display_mode = "columns";
playlist_display_mode = "columns";
playlist_editor_display_mode = "columns";
# browser_playlist_prefix = " - ";
# browser_playlist_prefix = " -> ";
#clock_display_seconds = yes

lines_scrolled = 8;
mouse_list_scroll_whole_page = true;
mouse_support = true;

ncmpcpp_directory = "~/.local/share/ncmpcpp";

mpd_crossfade_time = 4;
mpd_connection_timeout = 5;
# mpd_host = "localhost";
mpd_host = "localhost";
mpd_port = 6600;

execute_on_song_change = "qs ipc call mpris songArt 2> /dev/null"; # "songart"

selected_item_prefix = "+  ";
discard_colors_if_item_is_selected = true;

system_encoding = "utf8";
regular_expressions =  "extended"; # none/basic/extended/perl;
generate_win32_compatible_filenames = true; # generated file names eg. with tag editor wont have  \?*:|

allow_for_physical_item_deletion = true;
show_hidden_files_in_local_browser = true;

#startup_slave_screen = "browser";

};
 };
  }
