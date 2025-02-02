# {lib,...}:

{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      # lazyLoad = true;
      settings = {
        completion = {
          #completeopt = "menu,menuone,noinsert,preview";
          completeopt = "menu,menuone,noinsert";
        };
        autoEnableSources = true;
        # experimental = { ghost_text = true; };
        performance = {
          debounce = 60;
          fetchingTimeout = 120; # default 200
          maxViewEntries = 30;
        };
        # snippet = { 
        #   expand = ''
        #     function(args)
        #       require('luasnip').lsp_expand(args.body)
        #     end
        #   '';
        # };
        formatting = { fields = [ "kind" "abbr" "menu" ]; };
        sources = [
          { name = "nvim-lsp"; }
          # { name = "blink-cmp"; }
          { name = "treesitter"; }
          #{ name = "emoji"; }
          {
            name = "buffer"; # text within current buffer
            # option.get_bufnrs.__raw = "vim.api.nvim_list_bufs"; # FIXME: buf
            keywordLength = 3;
          }
          # { name = "copilot"; } # enable/disable copilot
          {
            name = "path"; # file system paths
            keywordLength = 3;
          }
          #{
            #name = "luasnip"; # snippets
              #keywordLength = 3;
          #}
        ];

        window = {
          completion = { border = "solid"; };
          documentation = { border = "solid"; };
        };#TODO: investigate doings?

        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          "<C-l>" = ''
            cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' })
          '';
          "<C-h>" = ''
            cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' })
          '';
        };
      };
    };

    cmp-nvim-lsp = {
      #enable = lib.mkForce false; # LSP
      enable = true; # LSP
    };

    # blink-cmp = {
    #   enable = true;
    # };

    cmp-buffer = {#NOTE: is this buffer=0?
      enable = true;
    };

    cmp-path = {
      enable = true;
    };

    cmp-treesitter = {
      enable = true;
    };

    # cmp-tmux = {
    #   enable = true;
    # };

    cmp_luasnip = {
      enable = false;
    };

    cmp-cmdline = {
      enable = true; # autocomplete for cmdline
    }; 

    lspkind = { # pictograms on completion items
      enable = false;
      #mode = "text_symbol"; # default: sysmbol_text, text
      cmp = {
        enable = false;
      };
      #symbolMap = {# override preset symbols
        #Copilot = "";
      #};
      extraOptions = {
        maxwidth = 10; # number of char on popup
        ellipsis_char = "..."; # for when popup exceeds width
      };
    };

  };
}
