{ lib, ... }:
{
  programs.qutebrowser = {
  enable = true;
  loadAutoconfig = true; # false:: load config from GUI
  enableDefaultBindings = true; # true::

  keyBindings = {
    normal = {
      "<ctrl-v>" = "spawn mpv {url}";
      # ",p" = "spawn --userscript qute-pass";
      # ",l" = ''config-cycle spellcheck.languages ["en-GB"] ["en-US"]'';
      "<f1>" = lib.mkMerge [
        # TODO see more info on lib.mkMerge
        "config-cycle tabs.show never always"
        "config-cycle statusbar.show in-mode always"
        "config-cycle scrolling.bar never always"
      ];
    };
    prompt = {
        "<ctrl-y>" = "prompt-yes";
    };
  };

  searchEngines = {
    w   =  "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
    aw  =  "https://wiki.archlinux.org/?search={}";
    nw  =  "https://wiki.nixos.org/index.php?search={}";
    mn  =  "https://mynixos.com/search?q={}";
    nps =  "https://search.nixos.org/packages?channel=24.11&from=0&size=50&sort=relevance&type=packages&query={}";
    npu =  "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
    # g =  "https://www.google.com/search?hl=en&amp;q={}";
    g   =  "https://www.google.com/search?hl=en&q={}";
    b   =  "https://search.brave.com/search?q={}";
    yt  =  "https://www.youtube.com/results?search_query={}";
    gh  =  "https://github.com/search?o=desc&q={}&s=stars";
    t   =  "https://www.thesaurus.com/browse/{}";
  };

settings = {
  colors = {
    hints = {
        bg = "#000000";
        fg = "#ffffff";
    };
    tabs.bar.bg = "#000000";
    webpage.darkmode.enabled = true;
  };
  tabs = {
    close_mouse_button = "right"; # right, middle::
    # position = "top";
    select_on_remove = "last-used"; # Which tab to select when the focused tab is removed.
    show = "multiple"; # multiple, always::, never, switching
    width = "10%"; # in px or % - vertical mode
  };
  downloads.location.suggestion = "both"; # path::, filename, both
  scrolling = {
    smooth = true;
    bar = "when-searching"; # overlay::, when-searching, never, always
  };
  auto_save = {
    session = true;
    interval = 10000; # milliseconds
  };
};

  }; # end of programs.
} # EOF
