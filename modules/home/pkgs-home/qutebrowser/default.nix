{ lib, ... }:
{
  programs.qutebrowser = {
  enable = true;
  loadAutoconfig = true; # false:: load config from GUI
  enableDefaultBindings = true; # true::

keyBindings = {
  normal = {
    "<ctrl-v>" = "spawn mpv {url}";
    ",p" = "spawn --userscript qute-pass";
    ",l" = ''config-cycle spellcheck.languages ["en-GB"] ["en-US"]'';
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
  w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
  aw = "https://wiki.archlinux.org/?search={}";
  nw = "https://wiki.nixos.org/index.php?search={}";
  g = "https://www.google.com/search?hl=en&amp;q={}";
  # "DEFAULT" = "https://www.google.com/search?hl=en&amp;q={}";
  #ge = "https://www.gemini.google.com/app";
  #yt = "https://www.youtube.com";
};

settings = {
  # config.py
  colors.hints = {
    bg = "#000000";
    fg = "#ffffff";
  };
  colors.tabs.bar.bg = "#000000";
  colors.webpage.darkmode.enabled = true;
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
  # url.searchengines = {
    # DEFAULT = "https://duckduckgo.com/?q={}";
    # "DEFAULT" = "https://www.google.com/search?hl=en&amp;q={}";
    # aw = "https://wiki.archlinux.org/?search={}";
    # g = "https://www.google.com/search?hl=en&amp;q={}";
    # nw = "https://wiki.nixos.org/index.php?search={}";
    # w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
  # };
  # url.start_pages = "https://www.google.com"; #FIXME not work
  # tabs.tabs_are_windows = true; #wack lol
};

extraConfig = ''''; # extra lines added to qutebrowser config.py
};

}
