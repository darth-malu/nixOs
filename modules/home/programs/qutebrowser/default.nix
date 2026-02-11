{ lib, osConfig, ... }:
{
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false; # false:: load config from GUI
    enableDefaultBindings = true; # true::

  keyBindings = {
    normal = {
      "<ctrl-m>" = "spawn mpv {url}";
      "<ctrl-l>" = "hint links spawn mpv {hint-url}";
      "x" = "tab-close";
      "X" = "undo";
      "<^>" = "tab-focus last";
      # ",p" = "spawn --userscript qute-pass";
      # ",l" = ''config-cycle spellcheck.languages ["en-GB"] ["en-US"]'';
      "<f1>" = lib.mkMerge [
        # TODO see more info on lib.mkMerge
        "config-cycle tabs.show never switching"
        "config-cycle statusbar.show in-mode always"
        "config-cycle scrolling.bar never always"
      ];
      "<f9>" = lib.mkMerge [
        "config-cycle colors.webpage.darkmode.enabled false true"
      ];
      "<f12>" = lib.mkMerge [
        "config-cycle tabs.show switching always"
      ];
      "<f10>" = "config-cycle statusbar.show never always";
    };
    prompt = {
        "<ctrl-y>" = "prompt-yes";
    };
  };

  searchEngines = {
    w   =  "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
    aw  =  "https://wiki.archlinux.org/?search={}";
    pdb  =  "https://www.protondb.com/search?q={}";
    nw  =  "https://wiki.nixos.org/index.php?search={}";
    mn  =  "https://mynixos.com/search?q={}";
    nps =  "https://search.nixos.org/packages?channel=24.11&from=0&size=50&sort=relevance&type=packages&query={}";
    npu =  "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
    g   =  "https://www.google.com/search?hl=en&q={}"; # hl=en&amp;
    pd   =  "https://www.protondb.com/search?q={}";
    b   =  "https://search.brave.com/search?q={}";
    yt  =  "https://www.youtube.com/results?search_query={}";
    gh  =  "https://github.com/search?o=desc&q={}&s=stars";
    t   =  "https://www.thesaurus.com/browse/{}";
    r   =  "https://www.reddit.com/search/?q={}";
  };

settings = {

colors = {
  hints = {
    bg = "#000000";
    fg = "#ffffff";
  };
  completion = {
    fg = "white";
    item.selected.bg = "#a100f2";    # #e8c000::
  };
  tabs = {
    bar.bg = "#00000000";       # color or entire bar
    odd.bg = "#00000000";       # odd rows
    even.bg = "#00000000";      # transparency tech

    selected.odd.bg = "#8f00ff"; # C3D898
    selected.even.bg = "#8f00ff";
  };
  webpage.darkmode= {
    enabled = false;
    # algorithm = "lightness-cielab";
    # policy.images = "never";
  };
};

completion = {
  # shrink = false;
};

statusbar = {
  show = "always";              # in-mode, always, never
  # widgets = ["keypress"  "search_match"  "url"  "scroll"  "history"  "tabs"  "progress"];
};

tabs = {
  close_mouse_button = "right"; # right, middle::
  select_on_remove = "last-used"; # Which tab to select when the focused tab is removed.
  show = "never"; # always::, never, switching, multiple
  width = "20%"; # in px or % - if vertical mode
  title.elide = "none";  # position of ellipsis (...)
  undo_stack_size = 50;  # 100::
  favicons = {
    show = "always";            # always::, never, pinned
    scale = 1.0;
  };
  indicator = {
    width = 2;
  };
  position = "left";
};

downloads.location.suggestion = "both"; # path::, filename, both

scrolling = {
  smooth = true;
  bar = "when-searching"; # overlay::, when-searching, never, always
};

 zoom = {
   default = "110%";
   # levels = [];

};
 auto_save = {
   session = true;
   interval = 10000; # milliseconds
 };

};

  }; # end of programs.
} # EOF
