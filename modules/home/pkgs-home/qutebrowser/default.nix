{ lib, ... }:
{
  programs.qutebrowser = {
  enable = true;
  loadAutoconfig = true; # false:: load config from GUI
  enableDefaultBindings = true; # true::

# aliases = {};

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

quickmarks = {
  nixpkgs = "https://github.com/NixOS/nixpkgs";
  home-manager = "https://github.com/nix-community/home-manager";
  twitter = "https://x.com";
};

searchEngines = {
  w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
  aw = "https://wiki.archlinux.org/?search={}";
  nw = "https://wiki.nixos.org/index.php?search={}";
  g = "https://www.google.com/search?hl=en&amp;q={}";
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
  # tabs.tabs_are_windows = true; #wack lol
};

extraConfig = ''''; # extra lines added to qutebrowser config.py
};

}
