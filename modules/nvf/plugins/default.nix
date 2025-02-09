{
  imports = [
    ./telescope.nix
    ./todo.nix
    ./extraPlugins.nix
    ./luasnip.nix
    # ./lualine
    ./mini.nix
    ./notify.nix
    # ./lazy.nix
    ./obsidian.nix
  ];
  vim.autopairs.nvim-autopairs.enable = true;
  #tabline.nvimBufferline.enable = true;
}
