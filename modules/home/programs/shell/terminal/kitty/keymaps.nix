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
    "ctrl+alt+enter" = "new_window_with_cwd";
    # "ctrl+alt+n" = "launch --cwd=current --type=os-window";
    "kitty_mod+n" = "new_os_window_with_cwd";

    #close windows
    "kitty_mod+q" = "close_other_windows_in_tab";
    "ctrl+alt+space" = "close_window_with_confirmation ignore-shell";

    # detach Windows/Tabs
    "kitty_mod+f1" = "detach_window ask";
    "kitty_mod+f2" = "detach_tab ask";

    # move #arrow keys
    "ctrl+alt+up" = "move_window top";
    "ctrl+alt+down" = "move_window bottom";
    "ctrl+alt+left" = "move_window left";
    "ctrl+alt+right" = "move_window right";

    "ctrl+alt+b" = "move_window_backward";
    "ctrl+alt+f" = "move_window_forward";
    "ctrl+alt+t" = "move_window_to_top";
    # "kitty_mod+r" = "start_resizing_window"; #NOTE does not work

    "ctrl+left" = "resize_window narrower 5";
    "ctrl+right" = "resize_window wider 5";
    "ctrl+up" = "resize_window taller 5";
    "ctrl+down" = "resize_window shorter 5";
    "ctrl+Return" = "resize_window reset";

    "ctrl+alt+h" = "neighboring_window left";
    "ctrl+alt+l" = "neighboring_window right";
    "ctrl+alt+k" = "neighboring_window up";
    "ctrl+alt+j" = "neighboring_window down";
    "ctrl+alt+;" = "next_window";

    # Layout Bigger window increase number
    "kitty_mod+[" = "layout_action decrease_num_full_size_windows";
    "kitty_mod+]" = "layout_action increase_num_full_size_windows";
    "kitty_mod+y" = "layout_action mirror toggle";

    "ctrl+tab" = "next_layout";
    "kitty_mod+tab" = "layout_action bias 10 20 30 40 50 60";

    # tabs
    "kitty_mod+space" = "close_tab";
    "kitty_mod+enter" = "new_tab_with_cwd";

    "kitty_mod+`" = "set_tab_title";
    "kitty_mod+l" = "next_tab";
    "kitty_mod+h" = "previous_tab";

    "kitty_mod+right" = "move_tab_forward";
    "kitty_mod+left" = "move_tab_backward";

    "ctrl+page_up" = "scroll_page_up";
    "ctrl+page_down" = "scroll_page_down";

    # Scrollback
    "kitty_mod+period" = "show_scrollback";
    "kitty_mod+comma" = "show_last_command_output";
  };
}
