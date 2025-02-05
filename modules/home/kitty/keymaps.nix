{
  programs.kitty.keybindings = {
    ## Unbind
    "ctrl+shift+left" = "no_op";
    "ctrl+shift+right" = "no_op";
    "ctrl+tab" = "no_op";
    "ctrl+shift+tab" = "no_op";
    #"ctrl+c" = "copy_or_interrupt";
    "alt+c" = "copy_to_clipboard";
    "alt+v" = "paste_from_clipboard";
    "ctrl+alt+n" = "launch --cwd=current --type=os-window";
    "kitty_mod+s" = "paste_from_buffer a1";
    "kitty_mod+enter" = "new_window_with_cwd";
    "kitty_mod+h" = "neighboring_window left";
    "kitty_mod+l" = "neighboring_window right";
    "kitty_mod+k" = "neighboring_window up";
    "kitty_mod+j" = "neighboring_window down";

    #close windows
    "kitty_mod+q" = "close_other_windows_in_tab";
    "ctrl+," = "next_layout";
    "kitty_mod+space" = "close_window_with_confirmation ignore-shell";

    "kitty_mod+;" = "next_window";

    # detach windows
    "kitty_mod+f4" = "detach_window ask";
    "kitty_mod+f1" = "detach_window";

    # move #arrow keys
    "kitty_mod+up" = "move_window top";
    "kitty_mod+down" = "move_window bottom";
    "kitty_mod+left" = "move_window left";
    "kitty_mod+right" = "move_window right";

    "kitty_mod+b" = "move_window_backward";
    "kitty_mod+f" = "move_window_forward";
    "kitty_mod+`" = "move_window_to_top";
    "kitty_mod+r" = "start_resizing_window";

    #█▀█ █▀▀ █▀ █ ▀█ █▀▀   █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█
    #█▀▄ ██▄ ▄█ █ █▄ ██▄   ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀
    "ctrl+KP_4" = "resize_window narrower 5";
    "ctrl+KP_6" = "resize_window wider 5";
    "ctrl+KP_8" = "resize_window taller 5";
    "ctrl+KP_2" = "resize_window shorter 5";
    "ctrl+KP_Multiply" =  "resize_window reset";

    #█▀▀ █░█ █░░ █░░   █▀ █ ▀█ █▀▀   █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█ █▀
    #█▀░ █▄█ █▄▄ █▄▄   ▄█ █ █▄ ██▄   ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀ ▄█
    "kitty_mod+[" = "layout_action decrease_num_full_size_windows";
    "kitty_mod+]" = "layout_action increase_num_full_size_windows";
    "kitty_mod+y" = "layout_action mirror toggle";

    #"kitty_mod+/" = "layout_action bias 60 50 40 30 20 10";
    "kitty_mod+/" = "layout_action bias 10 20 30 40 50 60";
    # "ctrl+tab" = "send_text all \x1b[27;5;9~"; #FIXME: iron out this
    # "ctrl+hift+tab" = "send_text all \x1b[27;6;9~";

    #"kitty_mod+f12" = "swap_with_window";
#    "kitty_mod+f11" = "focus_visible_window";

    # tabs
    "ctrl+alt+space" = "close_tab";
    "ctrl+alt+enter" = "new_tab_with_cwd";

    "kitty_mod+t" = "set_tab_title";

    "alt+ctrl+l" = "next_tab";
    "alt+ctrl+h" = "previous_tab";

    "alt+ctrl+right" = "move_tab_forward";
    "alt+ctrl+left" =  "move_tab_backward";

    # detach tabs
    "kitty_mod+f8" = "detach_tab ask";

    "kitty_mod+f5" = "detach_tab";
    #New windows
    # "kitty_mod+n" = "new_os_window_with_cwd";

    "ctrl+page_up" = "scroll_page_up";
    "ctrl+page_down" = "scroll_page_down";
  };
}
