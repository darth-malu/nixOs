{
  vim.snippets = {
    luasnip = {
      enable = true;
      loaders = "require('luasnip.loaders.from_vscode').lazy_load()";
      providers = ["friendly-snippets"];
    };
  };
}
