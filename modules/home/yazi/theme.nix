{
  filetype.rules = [
      { fg = "#7AD9E5"; mime = "image/*"; }
      # { fg = "#F3D398"; mime = "video/*"; }
      { fg = "#DD6160"; mime = "video/*"; }
      { fg = "#F3D398"; mime = "audio/*"; }
      { fg = "#CD9EFC"; mime = "application/x-bzip"; }

      	# Empty files
      { mime = "inode/x-empty"; fg = "white"; }

      # Fallback
      # { fg = "#CD9EFC"; name = "*/"; }
      # { name = "*"; fg = "white" }
      # { name = "*/"; fg = "blue"; }
  ];

  # flavor = "dracula";
  status = { 
    # mode_normal = { fg = "#e4e4e4"; bg = "red"; };
    mode_normal = { fg = "#21433E"; bg = "#0075aa"; };
    mode_select = { fg = "#21433E"; bg = "#FF8000"; };
    mode_unset = { fg = "#21433E"; bg = "#FF748B"; };
  };
  # status.
  icon = {
    prepend_dirs = [
      { name = "desktop"; text = ""; fg_dark = "#563d7c"; fg_light = "#563d7c"; }
    ];
    append_exts = [
      { name = "mp3"; text = ""; fg_dark = "#00afff"; fg_light = "#0075aa";}
    ];  
    # prepend_conds = [
    #   { if = "hidden & dir";  text = "👻"; }  # Hidden directories
    #   { if = "dir";           text = "📁"; }  # Directories
    #   { if = "!(dir | link)"; text = "📄"; }  # Normal files (not directories or symlinks)
    # ];
  };
      # };
}
