{
  filetype.rules = [
    # https://yazi-rs.github.io/docs/configuration/theme/#filetype
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

    # Orphan symbolic links
    {
      name = "*";
      is = "orphan";
      fg = "red";
    }

    # Fallback
    # { fg = "#CD9EFC"; name = "*/"; }
    {
      name = "*"; # all files
      fg = "white";
    }
    {
      name = "*/"; # all directories
      fg = "blue";
    }
  ];

  # status = {
  # };

  tabs = {
    inactive = {
      fg = "#e4e4e4";
      bg = "#21433E";
      # bold = true;
    };
    active = {
      fg = "#e4e4e4";
      bg = "#563d7c";
    };
    sep_inner = {
      open = "";
      close = "";
    };
    sep_outer = {
      open = "";
      close = "";
    };
  };

  mgr = {
    border = {
      border_style = {
        hidden = true; # hidden?
      };
      # border_symbol = " "; # "│"::
    };
    border_symbol = " "; # "│"::
    syntect_theme = "~/Downloads/gruvbox (Dark) (Soft).tmTheme"; # Syntax highlight in preview
    cwd = {
      fg = "#563d7c";
      # bg = "reset";
    };
  };

  mode = {
    normal_main = {
      fg = "#e4e4e4";
      bg = "#21433E";
      bold = true;
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
    prepend_conds = [
      {
        # Hidden directories
        "if" = "hidden & dir";
        text = "👻";
      }
      {
        # Directories
        "if" = "dir";
        text = "📁";
      }
      {
        # Normal files (not directories or symlinks)
        "if" = "!(dir | link)";
        text = "📄";
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
  };
}
