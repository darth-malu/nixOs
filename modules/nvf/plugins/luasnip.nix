{
  vim.snippets = {
    luasnip = {
      enable = true;
      loaders = "require('luasnip.loaders.from_vscode').lazy_load()";
      providers = ["friendly-snippets"];
      setupOpts = {
        enable_autosnippets = true; # false:: , automatic snippet expansion
      };
    };
  };
}
