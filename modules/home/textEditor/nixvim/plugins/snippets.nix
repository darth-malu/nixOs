{
    programs.nixvim.plugins = {
      # Friendly Snippets 
      friendly-snippets = {
        enable = true;
      };

      luasnip = {
        enable = true;

        extraConfig = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };

        fromSnipmate = [
          #{
            #paths = ./vim-snippets/snippets/markdown.snippets;
            #include = [ "markdown" ];
          #}
          #{
            #paths = ./vim-snippets/snippets/html.snippets;#TODO: outside user space>>> better for rg health
            #include = [ "html" ];
          #}
          {
            paths = ~/Documents/vim-snippets/snippets/lua.snippets;
            include = [ "lua" ];
          }
          #{
            #paths = ~/Documents/vim-snippets/snippets/c.snippets;
            #include = [ "c" ];
          #}
          {
            paths = ~/Documents/vim-snippets/snippets/css.snippets;
            include = [ "css" ];
          }
          {
            paths = ~/Documents/vim-snippets/snippets/sh.snippets;
            include = [ "sh" ];
          }
          {
            paths = ~/Documents/vim-snippets/snippets/bash.snippets;
            include = [ "bash" ];
          }
          #{
            #paths = ./vim-snippets/snippets/zsh.snippets;
            #include = [ "zsh" ];
          #}
        ];
    };
    };
}
