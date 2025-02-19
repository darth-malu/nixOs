{
  programs.ncmpcpp = {
    enable = true;
    #package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    mpdMusicDir = "~/Music";

    bindings = [
      # scroll
      { key = "j";command = "scroll_down";}

      { key = "k"; command = "scroll_up"; }

      {key = "l";command = "next_column";}

      {key = "L";command = "next_screen";}

      { key = "H"; command = "previous_screen"; }

      { key = "h"; command = "previous_column"; }

      { key = "shift-tab"; command = "previous"; }

      { key = "tab"; command = "next"; }

      ##lyrics
      { key = "'";  command = "show_lyrics"; }

      { key = "^"; command = "toggle_lyrics_fetcher"; }

      # playlists manipulation
      { key = "J"; command = [ "select_item" "scroll_down" ]; }

      #{ key = "ctrl-v"; command = "select_range"; }

      # WARN: DANGEROUS
      { key = "d"; command = "delete_browser_items"; }

      {
        key = "K";
        command = [
          "select_item"
          "scroll_up"
        ];
      }
    ];

  };
}
