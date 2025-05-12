{
  filetype.rules = [
    {
      fg = "#7AD9E5";
      mime = "image/*";
    }
    # { fg = "#F3D398"; mime = "video/*"; }
    {
      fg = "#DD6160";
      mime = "video/*";
    }
    {
      fg = "#F3D398";
      mime = "audio/*";
    }
    {
      fg = "#CD9EFC";
      mime = "application/x-bzip";
    }

    # Empty files
    {
      mime = "inode/x-empty";
      fg = "white";
    }

    # Fallback
    # { fg = "#CD9EFC"; name = "*/"; }
    # { name = "*"; fg = "white" }
    # { name = "*/"; fg = "blue"; }
  ];

  # flavor = "dracula"; #FIXME: see more on this

  # status = {
  # };

  manager = {
    tab_active = {
      fg = "#e4e4e4";
      bg = "#166F63";
    };
    tab_inactive = {
      fg = "#e4e4e4";
      bg = "red"; # FIXME not working
    };
  };

  mode = {
    normal_main = {
      fg = "#e4e4e4";
      bg = "#21433E";
      bold = true;
      #21433E
    };
    normal_alt = {
      fg = "#e4e4e4";
      bg = "#21433E";
    };
    select_main = {
      fg = "#e4e4e4";
      bg = "#563d7c";
    };
    select_alt = {
      fg = "#e4e4e4";
      bg = "#21433E";
    };
    unset_main = {
      fg = "#e4e4e4";
      bg = "#FF748B";
    };
    unset_alt = {
      fg = "#e4e4e4";
      bg = "#21433E";
    };
  };

  icon = {
    prepend_dirs = [
      {
        name = "desktop";
        text = "";
        fg_dark = "#563d7c";
        fg_light = "#563d7c";
      }
    ];
    append_exts = [
      {
        name = "mp3";
        text = "";
        fg_dark = "#00afff";
        fg_light = "#0075aa";
      }
    ];
    # prepend_conds = [
    #   { if = "hidden & dir";  text = "👻"; }  # Hidden directories
    #   { if = "dir";           text = "📁"; }  # Directories
    #   { if = "!(dir | link)"; text = "📄"; }  # Normal files (not directories or symlinks)
    # ];
  };
  # };
}
