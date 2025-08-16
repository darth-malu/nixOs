{
  enable = true;
  settings = {
    # https://github.com/aristocratos/btop?tab=readme-ov-file#configurability
    color_theme = "Nord"; # Default::
    theme_background = false;
    #* Define presets for the layout of the boxes. Preset 0 is always all boxes shown with default settings. Max 9 presets.
    #* Format: "box_name:P:G,box_name:P:G" P=(0 or 1) for alternate positions, G=graph symbol to use for box.
    #* Use whitespace " " as separator between different presets.
    #* Example: "cpu:0:default,mem:0:tty,proc:1:default cpu:0:braille,proc:0:tty"
    presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
    vim_keys = false; # Conflicting keys for h:"help" and k:"kill" is accessible while holding shift.
    shown_boxes = "proc"; # proc cpu mem net";
    proc_sorting = "cpu lazy";
    proc_tree = false;
    proc_gradient = true;
  };
  themes = {
    my-theme = ''
      theme[main_bg]="#282a36"
      theme[main_fg]="#f8f8f2"
      theme[title]="#f8f8f2"
      theme[hi_fg]="#6272a4"
      theme[selected_bg]="#ff79c6"
      theme[selected_fg]="#f8f8f2"
      theme[inactive_fg]="#44475a"
      theme[graph_text]="#f8f8f2"
      theme[meter_bg]="#44475a"
      theme[proc_misc]="#bd93f9"
      theme[cpu_box]="#bd93f9"
      theme[mem_box]="#50fa7b"
      theme[net_box]="#ff5555"
      theme[proc_box]="#8be9fd"
      theme[div_line]="#44475a"
      theme[temp_start]="#bd93f9"
      theme[temp_mid]="#ff79c6"
      theme[temp_end]="#ff33a8"
      theme[cpu_start]="#bd93f9"
      theme[cpu_mid]="#8be9fd"
      theme[cpu_end]="#50fa7b"
      theme[free_start]="#ffa6d9"
      theme[free_mid]="#ff79c6"
      theme[free_end]="#ff33a8"
      theme[cached_start]="#b1f0fd"
      theme[cached_mid]="#8be9fd"
      theme[cached_end]="#26d7fd"
      theme[available_start]="#ffd4a6"
      theme[available_mid]="#ffb86c"
      theme[available_end]="#ff9c33"
      theme[used_start]="#96faaf"
      theme[used_mid]="#50fa7b"
      theme[used_end]="#0dfa49"
      theme[download_start]="#bd93f9"
      theme[download_mid]="#50fa7b"
      theme[download_end]="#8be9fd"
      theme[upload_start]="#8c42ab"
      theme[upload_mid]="#ff79c6"
      theme[upload_end]="#ff33a8"
      theme[process_start]="#50fa7b"
      theme[process_mid]="#59b690"
      theme[process_end]="#6272a4"
    '';
  };
}
