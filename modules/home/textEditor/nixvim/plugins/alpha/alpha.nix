{
  programs.nixvim.plugins = let
    greet = import ./asciiAlpha.nix;#TODO: test if i can shorten this too direct use
    skullPiece = greet.onepisu;

    #NOTE: HIGHLIGHT / hl builtin groups
    # Constant, Statement(if), Identifier - var names,Comment - in code, Title
    #TODO: make custom hl groups
  in
    {
    alpha = {
      enable = true;
      #theme = "dashboard"; # must disable to use layout
      #iconsEnabled = true; # installs nvim-web-devicons # web dev not explicit
      #opts = null/ {} # set global opts
      layout = [
          {
            type = "padding";#NOTE: type: terminal, text, group, padding, button
            val = 2;
          }
          {
            type = "text";
            #val = siph;
            val = skullPiece;
            opts = {
              #hl = "Type";
              hl = "Constant"; #NOTE: highlight:hl split layout into sections
              position = "center";
            };
            #val = trafalgar;
          }
          {
            type = "padding";
            val = 2;
          }

          #{# center group 
            #type = "group";
            #val = [
#
              #{# new file
                #on_press = {
                  #__raw = "function() vim.cmd[[ene]] end";
                #};
                #opts = {
                  #shortcut = "n";
                  #position = "center";
                #};
                #type = "button";
                #val = "  New file";
              #}
#
              #{
                #on_press = {# Quit
                  #__raw = "function() vim.cmd[[qa]] end";
                #};
                #opts = {
                  #shortcut = "q";
                  #position = "center";
                #};
                #type = "button";
                ##val = " Quit Neovim";
                #val = " Quit Neovim";
              #}
            #];
          #}

          {
            type = "group";
            val =
              let
                # define button template#TODO: Add on press to these, see __raw
                mkButton = shortcut: cmd: val: hl: {
                  type = "button";
                  inherit val;
                  opts = {
                    inherit hl shortcut;
                    keymap = [
                      "n"
                      shortcut
                      cmd
                      {}
                    ];
                    position = "center";
                    cursor = 0;
                    width = 35;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                };
              in 
              [
                (
                  mkButton
                  "f"
                  "<CMD>lua require('telescope.builtin').find_files({hidden = true})<CR>"
                  "🔍 Find File"
                  "Operator"
                )
                (
                  mkButton
                  "n"
                  "<CMD>ene <BAR> startinsert <CR>"
                  "📂 New file"
                  #"🗒️ New file"
                  "Operator"
                )#TODO: add recent files screen
                (
                  mkButton
                  "o"
                  "<CMD>Telescope oldfiles<CR>"
                  "⌛ Recent files"
                  "Operator"
                )#TODO: add recent files screen
                (
                  mkButton
                  "g"
                  "<CMD>Telescope live_grep<CR>"
                  #"  Quit Neovim"
                  "🔭 Live grep"
                  "Operator"
                )
                (
                  mkButton
                  "q"
                  "<CMD>qa<CR>"
                  #"💣 Quit Neovim"
                  "❌ Quit Neovim"
                  "String"
                )
            ];
          }
          {
            type = "padding";
            val = 4;
          }
          {
            opts = {
              hl = "Keyword";
              position = "center";
            };
            type = "text";
            val = "Akili Nyingi Huondoa maarifa...🇰🇪";
            # val = "It's not about how much nix can do ... it's about how much you know to do";
          }
      ];
    };
  };
}

#https://nix-community.github.io/nixvim/stable/plugins/alpha/layout.html
