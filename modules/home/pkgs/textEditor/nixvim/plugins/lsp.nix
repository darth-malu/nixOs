{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      # lazyLoad = true;
      servers = {
        bashls.enable = true; #TODO: on-attach?
        pyright.enable = true; # python
        pylsp.enable = true; # python
        #pylyzer.enable = true; # python - not good
        nil_ls.enable = true; # nix #TODO: try nixd
        # marksman.enable = true; # markdown
        # clangd.enable = false; # c++
        lua_ls = {
          enable = true;
          settings = {
            telemetry.enable = false;
          };#TODO: see more settings
          #onAttach = {
            #override = false;#TODO: see if its work
          #};
        };
      };
    };

    none-ls = {
      enable = true;
      settings = {
        debounce = 250; #default: 250 #reponse time to changes in files
        debug = false;
        defaultTimeout = 5000; #5000 default
        notify_format = "[null-ls] %s";
        # diagnostics_format = "[#{c}] #{m} (#{s})"; # m - msg, s - sourceName(null-ls if ambiguous), c - code if available, 
        #on_attach = '' #TODO: fix this
          #function(client, bufnr)
            #-- Integrate lsp-format with none-ls
            #require('lsp-format').on_attach(client, bufnr("%"))
          #end
        #'';
        #on_exit = ''
          #function()
            #print("Goodbye, cruel world!")
          #end
        #'';
        #on_init = ''
          #function(client, initialize_result)
            #print("Hello, world!")
          #end
        #'';
        cmd = [ "nvim" ]; # ["bash -c nvim"]; - link to absolute path if not in path
      };
      #TODO: bufname(), 
      sources = {
        code_actions = {
          statix.enable = true; #lints for nix language
          gitsigns.enable = false;
          refactoring.enable = true;
        }; #TODO: thin this
        diagnostics = {
          statix.enable = true; #TODO: check on if best
          deadnix.enable = true;
          pylint.enable = true;
          checkstyle.enable = true;
        };
        formatting = {
          alejandra.enable = true; # nix
          stylua.enable = true; #lua
          shfmt.enable = true; #shell formatter
          nixpkgs_fmt.enable = true; #nix
          prettier.enable = true; #can have args
          black = {
            enable = true;
            #withArgs = {}; #raw lua code
            #settings = ''
              #{
                #extra_args = { "--fast" },
              #}
            #'';
          };
        };
        completion = {
          luasnip.enable = false;
          spell.enable = true; #spell completion
        };
      };
    };

  };
}
