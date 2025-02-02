{
  programs.nixvim.plugins.harpoon = {
    enable = true;
    # lazyLoad = true;
    enableTelescope = true;
    tmuxAutocloseWindows = true;
    keymapsSilent = true;
    saveOnToggle = true; # no need :w to save TG
    menu = {
      height = 15; # def: 10
      width = 70; #def :60
      borderChars = 
      [
        "─"
        "│"
        "─"
        "│"
        "╭"
        "╮"
        "╯"
        "╰"
      ];
    };
    keymaps = {
      cmdToggleQuickMenu = "<C-b>";
      toggleQuickMenu = "<C-e>";
      # gotoTerminal = ''{ 1 = “<C-j>”; 2 = “<C-k>”; 3 = “<C-l>”; 4 = “<C-m>”; }'';
      navNext = "<M-S-l>";
      navPrev = "<M-S-h>";

      # addFile = "<C-a>";
      addFile = "<leader>a";
    };
  };

}
