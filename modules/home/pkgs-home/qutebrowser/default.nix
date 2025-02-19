{lib,...}:
{
  programs.qutebrowser = {
    enable = true;
    # aliases = {};
    enableDefaultBindings = true; # true::
    extraConfig = # qute config.py file
      /*python*/''
        import os
        from urllib.request import urlopen

        # load your autoconfig, use this, if the rest of your config is empty!
        config.load_autoconfig()

        if not os.path.exists(config.configdir / "theme.py"):
            theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
            with urlopen(theme) as themehtml:
                with open(config.configdir / "theme.py", "a") as file:
                    file.writelines(themehtml.read().decode("utf-8"))

        if os.path.exists(config.configdir / "theme.py"):
            import theme
            theme.setup(c, 'mocha', True)

    '';
    loadAutoconfig = false; # false:: load config from GUI
    keyBindings = {
      normal = {
        "<ctrl-v>" = "spawn mpv {url}";
        ",p" = "spawn --userscript qute-pass";
        ",l" = ''config-cycle spellcheck.languages ["en-GB"] ["en-US"]'';
        "<f1>" = lib.mkMerge [
          "config-cycle tabs.show never always"
          "config-cycle statusbar.show in-mode always"
          "config-cycle scrolling.bar never always"
        ];
      };
      prompt = {
        "<ctrl-y>" = "prompt-yes";
      };
    };
  # </ctrl-y></f1></ctrl-v>
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      g = "https://www.google.com/search?hl=en&amp;q={}";
    };
    settings = {
      colors = {
        hints = {
          bg = "#000000";
          fg = "#ffffff";
        };
        tabs.bar.bg = "#000000";
      };
      # tabs.tabs_are_windows = true; #wack lol
    };
  };
}
