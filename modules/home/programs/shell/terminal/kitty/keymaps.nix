{
  programs.kitty.keybindings = {
    ## Unbind
    "ctrl+shift+left" = "no_op";
    "ctrl+shift+right" = "no_op";
    # "ctrl+tab" = "no_op";
    "ctrl+shift+tab" = "no_op";

    "alt+c" = "copy_or_interrupt";
    # "alt+c" = "copy_to_clipboard";
    "alt+v" = "paste_from_clipboard";
    "kitty_mod+a" = "paste_from_buffer a1";

    # Launch New Windows
    "ctrl+enter" = "new_window_with_cwd";
    # "ctrl+alt+n" = "launch --cwd=current --type=os-window";
    "ctrl+alt+n" = "new_os_window_with_cwd";

    #close windows
    "kitty_mod+q" = "close_other_windows_in_tab";
    # "kitty_mod+Escape" = "close_window_with_confirmation ignore-shell";
    "ctrl+Escape" = "close_window_with_confirmation ignore-shell";

    # detach Windows/Tabs
    "kitty_mod+f1" = "detach_window ask";
    "ctrl+alt+f1" = "detach_tab ask";

    # move #arrow keys
    "kitty_mod+up" = "move_window top";
    "kitty_mod+down" = "move_window bottom";
    "kitty_mod+left" = "move_window left";
    "kitty_mod+right" = "move_window right";

    "kitty_mod+b" = "move_window_backward";
    "kitty_mod+f" = "move_window_forward";
    "kitty_mod+t" = "move_window_to_top";
    # "kitty_mod+r" = "start_resizing_window"; #NOTE does not work

    "ctrl+alt+left" = "resize_window narrower 5";
    "ctrl+alt+right" = "resize_window wider 5";
    "ctrl+alt+up" = "resize_window taller 5";
    "ctrl+alt+down" = "resize_window shorter 5";
    "ctrl+alt+Return" = "resize_window reset";

    "ctrl+left" = "neighboring_window left";
    "ctrl+right" = "neighboring_window right";
    "ctrl+up" = "neighboring_window up";
    "ctrl+down" = "neighboring_window down";

    "ctrl+space" = "next_window";

    # Layout Bigger window increase number
    "ctrl+[" = "layout_action decrease_num_full_size_windows";
    "ctrl+]" = "layout_action increase_num_full_size_windows";
    "ctrl+y" = "layout_action mirror toggle";

    "ctrl+tab" = "next_layout";
    "kitty_mod+tab" = "layout_action bias 10 20 30 40 50 60";

    # tabs
    "alt+Escape" = "close_tab";
    "alt+enter" = "new_tab_with_cwd";

    "alt+t" = "set_tab_title";
    "alt+l" = "next_tab";
    "alt+h" = "previous_tab";

    "alt+right" = "move_tab_forward";
    "alt+left" = "move_tab_backward";

    # Scroll UP
    "ctrl+page_up" = "scroll_page_up";
    "ctrl+page_down" = "scroll_page_down";

    # Scrollback
    "ctrl+period" = "show_scrollback";
    "ctrl+comma" = "show_last_command_output";
  };
}
