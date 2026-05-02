{ nixvim, ... }:

{
  imports = [
    #./plugins.nix
    ./keymappings.nix
    ./theming.nix
    ./options.nix
    ./plugins
    ./autoCmd.nix
    nixvim.homeModules.nixvim # hM module for nixvim
  ];

  programs.nixvim = {
    enable = false;
    # defaultEditor = true;
    globals.mapleader = " ";

    extraConfigLua = ''
      --require("telescope").load_extension("lazygit")
      --luasnip = require("luasnip")

      kind_icons = {
        Text = "󰊄",
        Method = "",
        Function = "󰡱",
        Constructor = "",
        Field = "",
        Variable = "󱀍",
        Class = "",
        Interface = "",
        Module = "󰕳",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }
    '';

  };
}
