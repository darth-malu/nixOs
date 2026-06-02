{
  programs.kitty.keybindings = {
    f4 = "launch_tab btop";
    f3 = "launch_tab --title ncdu ncdu";
    f10 = "launch_tab nyaa";
    f12 = "launch_tab ncmpcpp";
    f9 = "launch_tab --title yazi-spawn yazi";
    f11 = "launch_window --location vsplit ncmpcpp";
    # f4 = "launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay less +G -R";
    # "f5" = "new_window_with_cwd";
    f5 = "launch_tab --title hyprctlClients sh -c 'hyprctl clients | less'";
  };
}
