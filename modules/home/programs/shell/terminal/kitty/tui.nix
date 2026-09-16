{
  programs.kitty.keybindings = {
    f4 = "launch_tab btop";
    f5 = "launch_tab --title hyprctlClients sh -c 'hyprctl clients | less'";
    f6 = "launch_tab --title ncdu ncdu";
    f9 = "launch_tab --title yazi-spawn yazi";
    f10 = "launch_tab nyaa";
    f11 = "launch_window --location vsplit ncmpcpp";
    f12 = "launch_tab ncmpcpp";
    # f4 = "launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay less +G -R";
    # "f5" = "new_window_with_cwd";
  };
}
